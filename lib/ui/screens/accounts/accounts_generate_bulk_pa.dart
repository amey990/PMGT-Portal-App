import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:pmgt/core/api_client.dart';
import 'package:pmgt/core/theme.dart';
import 'package:pmgt/core/theme_controller.dart';
import 'package:pmgt/ui/utils/responsive.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';
import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;
import 'package:pmgt/ui/widgets/profile_avatar.dart';
import 'package:pmgt/ui/screens/profile/profile_screen.dart';

import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';

const String API_BASE = 'https://pmgt.commedialabs.com';

class GeneratePaBulkScreen extends StatefulWidget {
  const GeneratePaBulkScreen({super.key});

  @override
  State<GeneratePaBulkScreen> createState() => _GeneratePaBulkScreenState();
}

class _GeneratePaBulkScreenState extends State<GeneratePaBulkScreen> {
  // ---- incoming args ----
  List<String> _activityIds = const [];
  String? _projectId;
  String? _subProjectId;
  String _projectName = '';
  String _childProjectName = '';
  Map<String, dynamic> _preByActivity = const {};

  bool _loading = true;
  String? _error;

  // Key per site: `${project_id}::${site_id}::${activity_id}`
  final Map<String, _SiteMeta> _sites = {};
  final Map<String, List<_RowControllers>> _rowsBySite = {};

  @override
  void initState() {
    super.initState();
    // Read route args AFTER first frame to avoid inherited-widget errors
   WidgetsBinding.instance.addPostFrameCallback((_) {
  final args = (ModalRoute.of(context)?.settings.arguments as Map?) ?? const {};

  _activityIds =
      (args['activityIds'] as List?)?.map((e) => e.toString()).toList() ?? const [];

  _projectId = (args['projectId']?.toString().isEmpty ?? true)
      ? null
      : args['projectId'].toString();

  _subProjectId = (args['sub_project_id']?.toString().isEmpty ?? true)
      ? null
      : args['sub_project_id'].toString();

  _projectName = (args['projectName'] ?? '').toString();
  _childProjectName = (args['childProjectName'] ?? '').toString();

  // ✅ Safe cast for preByActivity: Map<dynamic,dynamic> -> Map<String, Map<String, dynamic>>
  final pre = args['preByActivity'];
  if (pre is Map) {
    _preByActivity = Map<String, dynamic>.fromEntries(
      pre.entries.map((e) => MapEntry(
            e.key.toString(),
            Map<String, dynamic>.from((e.value as Map?) ?? const {}),
          )),
    );
  } else {
    _preByActivity = <String, dynamic>{};
  }

  _load();
});

  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
      _sites.clear();
      _rowsBySite.clear();
    });

    try {
      if (_activityIds.isEmpty) throw 'No activities selected';
      for (final id in _activityIds) {
        final r = await http.get(Uri.parse('$API_BASE/api/activities/$id'));
        if (r.statusCode != 200) {
          throw 'Failed to fetch activity $id (${r.statusCode})';
        }
        final a = jsonDecode(r.body) as Map<String, dynamic>;

        final actId = '${a['id']}';
        final projId = '${a['project_id']}';
        final siteId = '${a['site_id']}';
        final key = '$projId::$siteId::$actId';

        final pre = _preByActivity[actId] as Map<String, dynamic>?;

        final siteName = (pre?['siteName'] ?? a['site_name'] ?? siteId).toString();
        final siteCode = (pre?['siteCode'] ?? siteId).toString();

        _sites[key] = _SiteMeta(
          projectId: projId,
          activityId: actId,
          siteCode: siteCode,
          siteName: siteName,
          fieldEngineerId: (a['field_engineer_id'] ?? '').toString(),
          state: (a['state'] ?? '').toString(),
          completionDate: _date10(a['completion_date'] ?? a['completed_at'] ?? a['end_date']),
        );

        _rowsBySite[key] = [ _RowControllers() ];
      }

      setState(() {});
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  // ---- UI helpers ----
  String _date10(dynamic v) {
    final s = (v ?? '').toString();
    return s.length >= 10 ? s.substring(0, 10) : s;
  }

  void _addRow(String key) {
    setState(() => _rowsBySite[key] = [...?_rowsBySite[key], _RowControllers()]);
  }

  void _removeRow(String key, int idx) {
    final arr = [...?_rowsBySite[key]];
    if (arr.isEmpty) return;
    arr.removeAt(idx);
    if (arr.isEmpty) arr.add(_RowControllers());
    setState(() => _rowsBySite[key] = arr);
  }

  void _clearAll() {
    setState(() {
      for (final k in _rowsBySite.keys) {
        _rowsBySite[k] = [ _RowControllers() ];
      }
    });
  }

  // ---- PDF for multiple sites ----
  Future<Uint8List> _buildPdf() async {
    final pdf = pw.Document();
    final text = pw.TextStyle(fontSize: 11);
    final bold = pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold);

    double grand = 0.0;
    final projFull = [
      if (_projectName.isNotEmpty) _projectName,
      if (_childProjectName.isNotEmpty) '— $_childProjectName',
    ].join(' ');

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.symmetric(horizontal: 28, vertical: 28),
        build: (ctx) {
          final parts = <pw.Widget>[
            pw.Center(
              child: pw.Text('Payment Advice',
                  style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            ),
            pw.SizedBox(height: 8),
            pw.Divider(),
            pw.SizedBox(height: 8),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('From: CSPL-Accounts Team', style: text),
                      pw.Text('Project Name:', style: text),
                      pw.Text(projFull, style: bold),
                    ]),
                pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('To: CSPL-PMGT Team', style: text),
                      pw.Text('PA Date:', style: text),
                      pw.Text(_date10(DateTime.now().toIso8601String()), style: text),
                    ]),
              ],
            ),
            pw.SizedBox(height: 12),
            pw.Divider(),
            pw.SizedBox(height: 12),
          ];

          for (final key in _sites.keys) {
            final m = _sites[key]!;
            final rows = _rowsBySite[key] ?? const <_RowControllers>[];

            parts.add(pw.Text('Site: ${m.siteName} / ${m.siteCode}', style: bold));
            parts.add(
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(m.completionDate.isNotEmpty ? 'Completion: ${m.completionDate}' : '',
                      style: text),
                  pw.Text(m.state.isNotEmpty ? 'Location: ${m.state}' : '', style: text),
                ],
              ),
            );
            parts.add(pw.SizedBox(height: 6));
            parts.add(pw.Divider());

            double sub = 0.0;
            final data = <List<String>>[];

            for (var i = 0; i < rows.length; i++) {
              final rc = rows[i];
              final q = double.tryParse(rc.qtyCtrl.text.trim()) ?? 0;
              final p = double.tryParse(rc.priceCtrl.text.trim()) ?? 0;
              final t = q * p;
              sub += t;

              data.add([
                (i + 1).toString(),
                rc.descCtrl.text.trim().isEmpty ? '-' : rc.descCtrl.text.trim(),
                q.toStringAsFixed(0),
                p.toStringAsFixed(2),
                t.toStringAsFixed(2),
              ]);
            }

            grand += sub;

            parts.add(
              pw.Table.fromTextArray(
                headerStyle: bold,
                headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
                cellStyle: text,
                headers: const ['Sr No', 'Description', 'Qty', 'Unit Price', 'Total'],
                data: data,
                cellAlignment: pw.Alignment.centerLeft,
                columnWidths: {
                  0: const pw.FixedColumnWidth(40),
                  1: const pw.FlexColumnWidth(),
                  2: const pw.FixedColumnWidth(50),
                  3: const pw.FixedColumnWidth(70),
                  4: const pw.FixedColumnWidth(70),
                },
              ),
            );
            parts.add(pw.SizedBox(height: 6));
            parts.add(
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Total: ${sub.toStringAsFixed(2)}', style: bold),
              ),
            );
            parts.add(pw.SizedBox(height: 12));
          }

          parts.add(pw.Divider());
          parts.add(
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text('Grand Total: ${grand.toStringAsFixed(2)}',
                  style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
            ),
          );
          parts.add(pw.SizedBox(height: 14));
          parts.add(pw.Divider());
          parts.add(
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Prepared By: Commedia Admin', style: text),
                pw.Text('Authorized Signature', style: text),
              ],
            ),
          );

          return parts;
        },
      ),
    );

    return Uint8List.fromList(await pdf.save());
  }

  // ---- Generate + upload + open ----
  Future<void> _onGenerate() async {
    if (_sites.isEmpty) return;
    setState(() => _loading = true);

    try {
      final pdfBytes = await _buildPdf();

      // Use first site’s activity to create PA row (server associates project/site)
      final firstKey = _sites.keys.first;
      final meta = _sites[firstKey]!;

      final api = context.read<ApiClient>();
      final fileName =
          'PA-BULK-${_projectName.replaceAll(RegExp(r"\\s+"), "_")}-${DateTime.now().millisecondsSinceEpoch}.pdf';

      final body = {
        'activity_id': meta.activityId,
        'project_id': meta.projectId,
        'site_id': meta.siteCode,
        'field_engineer_id': meta.fieldEngineerId,
        'pa_date': _date10(DateTime.now().toIso8601String()),
        'fileName': fileName,
      };

      final create = await api.post('/api/payment_advices', body: body);
      if (create.statusCode < 200 || create.statusCode >= 300) {
        throw Exception(create.body.isNotEmpty ? create.body : 'Create PA failed');
      }
      final info = Map<String, dynamic>.from(jsonDecode(create.body) as Map);
      final uploadURL = (info['uploadURL'] ?? '').toString();
      final key = (info['key'] ?? '').toString();
      if (uploadURL.isEmpty || key.isEmpty) {
        throw Exception('Missing upload URL or key');
      }

      // PUT to S3
      final put = await http.put(
        Uri.parse(uploadURL),
        headers: {'Content-Type': 'application/pdf'},
        body: pdfBytes,
      );
      if (put.statusCode < 200 || put.statusCode >= 300) {
        throw Exception('S3 PUT failed: ${put.statusCode}');
      }

      // Find download URL
      final listRes = await api.get('/api/payment_advices');
      if (listRes.statusCode < 200 || listRes.statusCode >= 300) {
        throw Exception('List payment_advices failed');
      }
      final list = jsonDecode(listRes.body);
      String? dl;
      if (list is List) {
        for (final r in list) {
          if (r is Map && (r['file_key'] ?? '') == key) {
            dl = (r['downloadURL'] ?? '').toString();
            break;
          }
        }
      }
      if (dl == null || dl!.isEmpty) throw Exception('Download URL not found');

      await launchUrlString(dl!, mode: LaunchMode.externalApplication);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bulk PA generated')),
        );
      }

      // Optional: clear rows after success
      _clearAll();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to generate Bulk PA: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // ---- bottom nav handling ----
  void _handleTabChange(BuildContext context, int i) {
    late final Widget target;
    switch (i) {
      case 0: target = const DashboardScreen(); break;
      case 1: target = const AddProjectScreen(); break;
      case 2: target = const AddActivityScreen(); break;
      case 3: target = const AnalyticsScreen(); break;
      case 4: target = const ViewUsersScreen(); break;
      default: return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  // ---- UI ----
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final projLabel = [
      if (_projectName.isNotEmpty) _projectName,
      if (_childProjectName.isNotEmpty) '— $_childProjectName',
    ].join(' ');

    return MainLayout(
      title: 'Generate Bulk PA',
      centerTitle: true,
      drawerMode: DrawerMode.accounts,
      currentIndex: -1,
      onTabChanged: (i) => _handleTabChange(context, i),
      safeArea: false,
      reserveBottomPadding: true,
      actions: [
        IconButton(
          tooltip: Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
          icon: Icon(
            Theme.of(context).brightness == Brightness.dark
                ? Icons.light_mode_outlined
                : Icons.dark_mode_outlined,
            color: cs.onSurface,
          ),
          onPressed: () => ThemeScope.of(context).toggle(),
        ),
        IconButton(
          tooltip: 'Profile',
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(
                    'Failed to load activities\n$_error',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cs.error),
                  ),
                )
              : ListView(
                  padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            projLabel,
                            style: TextStyle(
                              color: cs.onSurfaceVariant,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        OutlinedButton(onPressed: _clearAll, child: const Text('Clear')),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _sites.isEmpty ? null : _onGenerate,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.success,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Generate Bulk PA'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Per-site cards
                    ..._sites.keys.map((key) {
                      final meta = _sites[key]!;
                      final rows = _rowsBySite[key] ?? const <_RowControllers>[];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${meta.siteName} — ${meta.siteCode}',
                              style: TextStyle(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ...rows.asMap().entries.map((e) {
                              final idx = e.key;
                              final r = e.value;
                              return Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: cs.surface,
                                  border: Border.all(color: cs.outlineVariant),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: r.descCtrl,
                                      style: TextStyle(color: cs.onSurface),
                                      decoration: _dec('Description'),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: TextField(
                                            controller: r.qtyCtrl,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: cs.onSurface),
                                            decoration: _dec('Quantity'),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: TextField(
                                            controller: r.priceCtrl,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(color: cs.onSurface),
                                            decoration: _dec('Unit Price'),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        IconButton(
                                          tooltip: 'Remove',
                                          onPressed: () => _removeRow(key, idx),
                                          icon: Icon(Icons.close, color: cs.onSurfaceVariant),
                                        ),
                                      ],
                                    ),
                                    if (idx == 0)
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                          onPressed: () => _addRow(key),
                                          child: const Text('Add'),
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
    );
  }

  InputDecoration _dec(String label) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
      filled: true,
      fillColor: cs.surface,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppTheme.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }
}

// ---- simple models ----
class _SiteMeta {
  final String projectId;
  final String activityId;
  final String siteCode;
  final String siteName;
  final String fieldEngineerId;
  final String state;
  final String completionDate;

  _SiteMeta({
    required this.projectId,
    required this.activityId,
    required this.siteCode,
    required this.siteName,
    required this.fieldEngineerId,
    required this.state,
    required this.completionDate,
  });
}

class _RowControllers {
  final TextEditingController descCtrl;
  final TextEditingController qtyCtrl;
  final TextEditingController priceCtrl;

  _RowControllers()
      : descCtrl = TextEditingController(),
        qtyCtrl = TextEditingController(text: '1'),
        priceCtrl = TextEditingController(text: '0');
}
