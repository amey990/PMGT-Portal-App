// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:csc_picker_plus/csc_picker_plus.dart';

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';

// class AddSiteScreen extends StatefulWidget {
//   const AddSiteScreen({super.key});

//   @override
//   State<AddSiteScreen> createState() => _AddSiteScreenState();
// }

// class _AddSiteScreenState extends State<AddSiteScreen> {
//   // --- sample dropdown data (swap with API data) ---
//   final _projects     = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
//   final _subProjects  = const ['—', 'SP-1', 'SP-2', 'Rollout-West', 'Child A'];

//   final _statusList   = const [
//     'Completed',
//     'In Progress',
//     'Pending',
//     'Hold',
//     'Scheduled',
//     'Abortive',
//   ];

//   // --- bulk upload ---
//   String? _bulkProject;
//   String? _bulkSubProject;
//   String? _bulkFileName;

//   // --- single site values ---
//   String? _project;
//   String? _subProject;

//   final _siteNameCtrl = TextEditingController();
//   final _siteIdCtrl   = TextEditingController(text: 'AUTO-SITE-001'); // read-only placeholder
//   final _addressCtrl  = TextEditingController();
//   final _pincodeCtrl  = TextEditingController();
//   final _pocCtrl      = TextEditingController();
//   final _districtCtrl = TextEditingController();
//   final _remarksCtrl  = TextEditingController();

//   // Country / State / City via CSCPickerPlus
//   String? _country;
//   String? _state;
//   String? _city;

//   // Status + Completion date
//   String? _status;
//   DateTime? _completionDate;

//   @override
//   void dispose() {
//     _siteNameCtrl.dispose();
//     _siteIdCtrl.dispose();
//     _addressCtrl.dispose();
//     _pincodeCtrl.dispose();
//     _pocCtrl.dispose();
//     _districtCtrl.dispose();
//     _remarksCtrl.dispose();
//     super.dispose();
//   }

//   void _clearBulk() {
//     setState(() {
//       _bulkProject = null;
//       _bulkSubProject = null;
//       _bulkFileName = null;
//     });
//   }

//   void _clearSingle() {
//     setState(() {
//       _project = null;
//       _subProject = null;
//       _siteNameCtrl.clear();
//       _siteIdCtrl.text = 'AUTO-SITE-001';
//       _addressCtrl.clear();
//       _pincodeCtrl.clear();
//       _pocCtrl.clear();

//       _country = null;
//       _state = null;
//       _city = null;
//       _districtCtrl.clear();

//       _status = null;
//       _completionDate = null;
//       _remarksCtrl.clear();
//     });
//   }

//   Future<void> _pickFile() async {
//     final res = await FilePicker.platform.pickFiles(
//       type: FileType.custom,
//       allowedExtensions: ['xlsx', 'xls', 'csv'],
//       withData: false,
//     );
//     if (res != null && res.files.isNotEmpty) {
//       setState(() => _bulkFileName = res.files.single.name);
//     }
//   }

//   Future<void> _pickCompletionDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _completionDate ?? now,
//       firstDate: DateTime(now.year - 10),
//       lastDate: DateTime(now.year + 10),
//       builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
//     );
//     if (picked != null) setState(() => _completionDate = picked);
//   }

//   String _fmt(DateTime? d) {
//     if (d == null) return 'Select date';
//     final dd = d.day.toString().padLeft(2, '0');
//     final mm = d.month.toString().padLeft(2, '0');
//     final yyyy = d.year.toString();
//     return '$dd/$mm/$yyyy';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add Site',
//       centerTitle: true,
//       currentIndex: 0,
//       onTabChanged: (_) {},
//       safeArea: false,
//       reserveBottomPadding: true,
//       actions: [
//         IconButton(
//           tooltip: Theme.of(context).brightness == Brightness.dark
//               ? 'Light mode'
//               : 'Dark mode',
//           icon: Icon(
//             Theme.of(context).brightness == Brightness.dark
//                 ? Icons.light_mode_outlined
//                 : Icons.dark_mode_outlined,
//             color: cs.onSurface,
//           ),
//           onPressed: () => ThemeScope.of(context).toggle(),
//         ),
//         IconButton(
//           tooltip: 'Profile',
//           onPressed: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
//           icon: ClipOval(
//             child: Image.asset(
//               'assets/User_profile.png',
//               width: 36,
//               height: 36,
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//       ],
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           // ===== Card 1: Bulk upload =====
//           Card(
//             color: cs.surfaceContainerHighest,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Add Sites in Bulk',
//                           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 color: cs.onSurface,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                         ),
//                       ),
//                       TextButton(onPressed: _clearBulk, child: const Text('Clear')),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   _Dropdown<String>(
//                     label: 'Project *',
//                     value: _bulkProject,
//                     items: _projects,
//                     onChanged: (v) => setState(() => _bulkProject = v),
//                   ),
//                   _Dropdown<String>(
//                     label: 'Sub Project',
//                     value: _bulkSubProject,
//                     items: _subProjects,
//                     onChanged: (v) => setState(() => _bulkSubProject = v),
//                   ),

//                   _FieldShell(
//                     label: 'Choose File',
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             height: 48,
//                             alignment: Alignment.centerLeft,
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             decoration: BoxDecoration(
//                               color: cs.surface,
//                               border: Border.all(color: cs.outlineVariant),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               _bulkFileName ?? 'No file selected',
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                 color: _bulkFileName == null
//                                     ? cs.onSurfaceVariant
//                                     : cs.onSurface,
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 8),
//                         OutlinedButton(
//                           onPressed: _pickFile,
//                           style: OutlinedButton.styleFrom(
//                             side: BorderSide(color: cs.outlineVariant),
//                           ),
//                           child: const Text('Choose File'),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 8),

//                   Row(
//                     children: [
//                       OutlinedButton(
//                         onPressed: () {
//                           // TODO: hook template download
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Downloading template...')),
//                           );
//                         },
//                         style: OutlinedButton.styleFrom(
//                           side: const BorderSide(color: AppTheme.accentColor),
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                         ),
//                         child: const Text('Download Template'),
//                       ),
//                       const Spacer(),
//                       ElevatedButton(
//                         onPressed: () {
//                           // TODO: bulk upload handler
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Upload started...')),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                         ),
//                         child: const Text('Upload', style: TextStyle(fontWeight: FontWeight.w800)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 12),

//           // ===== Card 2: Single site (ordered fields) =====
//           Card(
//             color: cs.surfaceContainerHighest,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Add Site',
//                           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 color: cs.onSurface,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                         ),
//                       ),
//                       TextButton(onPressed: _clearSingle, child: const Text('Clear')),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   // --- Project & Sub Project ---
//                   _Dropdown<String>(
//                     label: 'Project *',
//                     value: _project,
//                     items: _projects,
//                     onChanged: (v) => setState(() => _project = v),
//                   ),
//                   _Dropdown<String>(
//                     label: 'Sub Project',
//                     value: _subProject,
//                     items: _subProjects,
//                     onChanged: (v) => setState(() => _subProject = v),
//                   ),

//                   // --- Basic site info ---
//                   _TextField(label: 'Site Name *', controller: _siteNameCtrl),
//                   _ROText('Site ID *', _siteIdCtrl),
//                   _TextField(label: 'Address *', controller: _addressCtrl, maxLines: 3),
//                   _TextField(
//                     label: 'Pincode *',
//                     controller: _pincodeCtrl,
//                     keyboardType: TextInputType.number,
//                   ),
//                   _TextField(label: 'POC *', controller: _pocCtrl),

//                   // --- Country / State / City (+ District free text) ---
//                   _FieldShell(
//                     label: 'Location',
//                     child: Column(
//                       children: [
//                         CSCPickerPlus(
//                           layout: Layout.vertical,
//                           showStates: true,
//                           showCities: true,
//                           flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
//                           dropdownDecoration: BoxDecoration(
//                             color: cs.surface,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: cs.outlineVariant),
//                           ),
//                           disabledDropdownDecoration: BoxDecoration(
//                             color: cs.surface,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: cs.outlineVariant),
//                           ),
//                           countryDropdownLabel: "Country",
//                           stateDropdownLabel: "State / Region",
//                           cityDropdownLabel: "City",
//                           currentCountry: _country,
//                           currentState: _state,
//                           currentCity: _city,
//                           onCountryChanged: (v) => setState(() {
//                             _country = v;
//                             _state = null;
//                             _city = null;
//                           }),
//                           onStateChanged: (v) => setState(() {
//                             _state = v;
//                             _city = null;
//                           }),
//                           onCityChanged: (v) => setState(() => _city = v),
//                         ),
//                         const SizedBox(height: 10),
//                         TextField(
//                           controller: _districtCtrl,
//                           style: TextStyle(color: cs.onSurface),
//                           decoration: InputDecoration(
//                             hintText: 'District (optional)',
//                             hintStyle: TextStyle(color: cs.onSurfaceVariant),
//                             filled: true,
//                             fillColor: cs.surface,
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: cs.outlineVariant),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: const BorderSide(color: AppTheme.accentColor),
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             contentPadding:
//                                 const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   // --- Status, Completion Date, Remarks ---
//                   _Dropdown<String>(
//                     label: 'Status *',
//                     value: _status,
//                     items: _statusList,
//                     onChanged: (v) => setState(() => _status = v),
//                   ),
//                   _DateField(
//                     label: 'Completion Date',
//                     value: _fmt(_completionDate),
//                     onTap: _pickCompletionDate,
//                   ),
//                   _TextField(label: 'Remarks', controller: _remarksCtrl, maxLines: 3),

//                   const SizedBox(height: 12),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // TODO: Hook single add handler
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text('Site added')),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.accentColor,
//                         foregroundColor: Colors.black,
//                         padding: const EdgeInsets.symmetric(vertical: 14),
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       ),
//                       child: const Text(
//                         'ADD',
//                         style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// ----- Small UI helpers (consistent look) -----

// class _FieldShell extends StatelessWidget {
//   final String label;
//   final Widget child;
//   const _FieldShell({required this.label, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               color: cs.onSurfaceVariant,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 6),
//           child,
//         ],
//       ),
//     );
//   }
// }

// class _TextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final int maxLines;
//   final TextInputType? keyboardType;
//   const _TextField({
//     required this.label,
//     required this.controller,
//     this.maxLines = 1,
//     this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surface,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: AppTheme.accentColor),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         ),
//       ),
//     );
//   }
// }

// class _ROText extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _ROText(this.label, this.controller);

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         enabled: false,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surface,
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         ),
//       ),
//     );
//   }
// }

// class _Dropdown<T> extends StatelessWidget {
//   final String label;
//   final T? value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;
//   const _Dropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: Container(
//         decoration: BoxDecoration(
//           color: cs.surface,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<T>(
//             value: value,
//             isExpanded: true,
//             iconEnabledColor: cs.onSurfaceVariant,
//             dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//             style: TextStyle(color: cs.onSurface, fontSize: 14),
//             items: items
//                 .map((e) => DropdownMenuItem<T>(value: e, child: Text('$e')))
//                 .toList(),
//             hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DateField extends StatelessWidget {
//   final String label;
//   final String value;
//   final VoidCallback onTap;
//   const _DateField({required this.label, required this.value, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: cs.surface,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   value,
//                   style: TextStyle(
//                     color: value == 'Select date' ? cs.onSurfaceVariant : cs.onSurface,
//                   ),
//                 ),
//               ),
//               Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

//p2//
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';

import '../../../core/api_client.dart'; // your API client
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

// ─────────────────────────────────────────────────────────────
// Lightweight models
// ─────────────────────────────────────────────────────────────
class _Project {
  final String id;
  final String name;
  final String manager;
  _Project({required this.id, required this.name, required this.manager});
}

class _SubProject {
  final String id;
  final String name;
  _SubProject({required this.id, required this.name});
}

// ─────────────────────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────────────────────
class AddSiteScreen extends StatefulWidget {
  const AddSiteScreen({super.key});

  @override
  State<AddSiteScreen> createState() => _AddSiteScreenState();
}

class _AddSiteScreenState extends State<AddSiteScreen> {
  // Lookups
  final List<_Project> _projects = [];
  final List<_SubProject> _subs = [];
  bool _loadingProjects = false;
  bool _loadingSubs = false;

  // Bulk state
  String? _bulkProjectId;
  String? _bulkSubId;
  PlatformFile? _bulkFile;
  bool _uploading = false;

  int _locVersion = 0;

  // Single state
  String? _projectId;
  String? _subId;

  final _siteIdCtrl = TextEditingController();
  final _siteNameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();
  final _pocCtrl = TextEditingController();
  final _districtCtrl = TextEditingController();
  final _remarksCtrl = TextEditingController();

  String? _country; // names from CSCPickerPlus
  String? _state;
  String? _city;

  String _status = 'Pending';
  DateTime? _completionDate;
  bool _submitting = false;

  final List<String> _statusList = const [
    'Completed',
    'In progress',
    'Pending',
    'Hold',
    'Scheduled',
    'Abortive',
  ];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  @override
  void dispose() {
    _siteIdCtrl.dispose();
    _siteNameCtrl.dispose();
    _addressCtrl.dispose();
    _pincodeCtrl.dispose();
    _pocCtrl.dispose();
    _districtCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  // ───────────────── API calls ─────────────────
  Future<void> _loadProjects() async {
    setState(() => _loadingProjects = true);
    try {
      final api = context.read<ApiClient>();
      final res = await api.get('/api/projects');
      final list = (jsonDecode(res.body) as List?) ?? [];
      _projects
        ..clear()
        ..addAll(
          list.map(
            (e) => _Project(
              id: (e['id'] ?? '').toString(),
              name: (e['project_name'] ?? '').toString(),
              manager: (e['project_manager'] ?? '').toString(),
            ),
          ),
        );
      setState(() {});
    } catch (_) {
      _toast('Could not load projects', false);
    } finally {
      if (mounted) setState(() => _loadingProjects = false);
    }
  }

  Future<void> _loadSubs(String projectId) async {
    setState(() => _loadingSubs = true);
    try {
      final api = context.read<ApiClient>();
      final res = await api.get('/api/projects/$projectId/sub-projects');
      final list = (jsonDecode(res.body) as List?) ?? [];
      _subs
        ..clear()
        ..addAll(
          list.map(
            (e) => _SubProject(
              id: (e['id'] ?? '').toString(),
              name: (e['name'] ?? '').toString(),
            ),
          ),
        );
      setState(() {});
    } catch (_) {
      _subs.clear();
      setState(() {});
    } finally {
      if (mounted) setState(() => _loadingSubs = false);
    }
  }

  // ───────────────── Bulk upload ─────────────────
  Future<void> _pickBulkFile() async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: false, // we prefer a path for MultipartFile.fromPath
    );
    setState(
      () =>
          _bulkFile =
              (picked?.files.isNotEmpty ?? false) ? picked!.files.single : null,
    );
  }

  Future<String> _getTokenFromPrefs() async {
    final p = await SharedPreferences.getInstance();
    return p.getString('pmgt_token') ?? '';
    // mirror of web: sessionStorage/localStorage key 'pmgt_token'
  }

  Future<void> _uploadCsv() async {
    if ((_bulkProjectId ?? '').isEmpty) {
      _toast('Select a project first', false);
      return;
    }
    if (_bulkFile == null || (_bulkFile!.path ?? '').isEmpty) {
      _toast('Choose a CSV file', false);
      return;
    }

    try {
      setState(() => _uploading = true);

      final api = context.read<ApiClient>();
      // These two lines assume ApiClient exposes baseUrl & token.
      // If your property names differ, adjust here:
      final String baseUrl =
          (api as dynamic).baseUrl as String; // ← adjust if different
      final String bearer =
          ((api as dynamic).token as String?) // ← adjust if different
          ??
          await _getTokenFromPrefs();

      final uri = Uri.parse(
        _bulkSubId == null || _bulkSubId!.isEmpty
            ? '$baseUrl/api/project-sites/upload/$_bulkProjectId'
            : '$baseUrl/api/project-sites/upload/$_bulkProjectId?subProjectId=${Uri.encodeComponent(_bulkSubId!)}',
      );

      final req = http.MultipartRequest('POST', uri);
      if (bearer.isNotEmpty) req.headers['Authorization'] = 'Bearer $bearer';
      req.files.add(
        await http.MultipartFile.fromPath('file', _bulkFile!.path!),
      );

      final resp = await req.send();
      final body = await resp.stream.bytesToString();
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        final err =
            (jsonDecode(body) as Map?)?['error']?.toString() ??
            'Upload failed (${resp.statusCode})';
        throw Exception(err);
      }
      final json = jsonDecode(body) as Map<String, dynamic>? ?? {};
      final inserted = json['inserted'] ?? json['success'] ?? '';
      final total = json['totalRows'] ?? '';
      final errCount = (json['errors'] as List?)?.length ?? 0;
      _toast(
        'Upload finished: inserted $inserted/$total${errCount > 0 ? ", $errCount error(s)" : ""}',
      );
      setState(() {
        _bulkFile = null;
        _bulkSubId = null;
      });
    } catch (e) {
      _toast(e.toString(), false);
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  Future<void> _downloadTemplate() async {
    const headers =
        'site_name,site_id,address,pincode,poc,country,state,district,city,status,completion_date,remarks\n';
    try {
      final file = File(
        '${Directory.systemTemp.path}/site_upload_template.csv',
      );
      await file.writeAsString(headers, flush: true);
      _toast('Template saved: ${file.path}');
    } catch (_) {
      _toast('Could not save template', false);
    }
  }

  // ───────────────── Single create ─────────────────
  bool get _isIndia => (_country ?? '').trim().toLowerCase() == 'india';

  bool _validateSingle() {
    if ((_projectId ?? '').isEmpty) {
      _toast('Please select a project', false);
      return false;
    }
    if (_siteIdCtrl.text.trim().isEmpty ||
        _siteNameCtrl.text.trim().isEmpty ||
        _addressCtrl.text.trim().isEmpty ||
        _pincodeCtrl.text.trim().isEmpty ||
        _pocCtrl.text.trim().isEmpty ||
        (_country ?? '').isEmpty ||
        (_state ?? '').isEmpty ||
        (_city ?? '').isEmpty) {
      _toast('Please fill all required fields', false);
      return false;
    }
    if (_isIndia && _districtCtrl.text.trim().isEmpty) {
      _toast('District is required when Country is India', false);
      return false;
    }
    if (_status == 'Completed' && _completionDate == null) {
      _toast('Completion Date is required when Status is Completed', false);
      return false;
    }
    return true;
  }

  Future<void> _submitSingle() async {
    if (!_validateSingle()) return;

    final body = <String, dynamic>{
      'project_id': _projectId,
      'project_name': _projects.firstWhere((p) => p.id == _projectId!).name,
      'sub_project_id': (_subId ?? '').isEmpty ? null : _subId,
      'site_id': _siteIdCtrl.text.trim(),
      'site_name': _siteNameCtrl.text.trim(),
      'address': _addressCtrl.text.trim(),
      'pincode': _pincodeCtrl.text.trim(),
      'poc': _pocCtrl.text.trim(),
      'country': _country,
      'state': _state,
      'district': _isIndia ? _districtCtrl.text.trim() : null,
      'city': _city,
      'status': _status,
      'completion_date':
          _status == 'Completed'
              ? _completionDate!.toIso8601String().split('T').first
              : null,
      'remarks':
          _remarksCtrl.text.trim().isEmpty ? null : _remarksCtrl.text.trim(),
    };

    try {
      setState(() => _submitting = true);
      final api = context.read<ApiClient>();
      final res = await api.post('/api/project-sites', body: body);
      if (res.statusCode < 200 || res.statusCode >= 300) {
        final err =
            (jsonDecode(res.body) as Map?)?['error']?.toString() ??
            'Failed to add site.';
        throw Exception(err);
      }
      _toast('Site added!');
      _clearSingle();
    } catch (e) {
      _toast(e.toString(), false);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  // ───────────────── UI helpers ─────────────────
  void _toast(String msg, [bool success = true]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green.shade600 : Colors.red.shade700,
      ),
    );
  }

  void _clearBulk() {
    setState(() {
      _bulkProjectId = null;
      _bulkSubId = null;
      _bulkFile = null;
    });
  }

  // void _clearSingle() {
  //   setState(() {
  //     _projectId = null;
  //     _subId = null;
  //     _subs.clear();

  //     _siteIdCtrl.clear();
  //     _siteNameCtrl.clear();
  //     _addressCtrl.clear();
  //     _pincodeCtrl.clear();
  //     _pocCtrl.clear();

  //     _country = null;
  //     _state = null;
  //     _city = null;
  //     _districtCtrl.clear();

  //     _status = 'Pending';
  //     _completionDate = null;
  //     _remarksCtrl.clear();
  //   });
  // }


void _clearSingle() {
  setState(() {
    _projectId = null;
    _subId = null;
    _subs.clear();

    _siteIdCtrl.clear();
    _siteNameCtrl.clear();
    _addressCtrl.clear();
    _pincodeCtrl.clear();
    _pocCtrl.clear();

    // ↓ ensure picker fully resets
    _country = null;
    _state = null;
    _city = null;
    _districtCtrl.clear();
    _locVersion++; // ← force CSCPickerPlus to rebuild cleared

    _status = 'Pending';
    _completionDate = null;
    _remarksCtrl.clear();
  });
}

  Future<void> _pickCompletionDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _completionDate ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
      builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
    );
    if (picked != null) setState(() => _completionDate = picked);
  }

  String _fmt(DateTime? d) {
    if (d == null) return 'Select date';
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd/$mm/$yyyy';
  }

  // ───────────────── Build ─────────────────
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add Site',
      centerTitle: true,
      currentIndex: 0,
      onTabChanged: (_) {},
      safeArea: false,
      reserveBottomPadding: true,
      actions: [
        IconButton(
          tooltip:
              Theme.of(context).brightness == Brightness.dark
                  ? 'Light mode'
                  : 'Dark mode',
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
          onPressed:
              () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: ClipOval(
            child: Image.asset(
              'assets/User_profile.png',
              width: 36,
              height: 36,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          // ───────────── Bulk upload card ─────────────
          // Card(
          //   color: cs.surfaceContainerHighest,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.all(14),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         Row(
          //           children: [
          //             Expanded(
          //               child: Text(
          //                 'Add Sites in Bulk',
          //                 style: Theme.of(
          //                   context,
          //                 ).textTheme.titleLarge?.copyWith(
          //                   color: cs.onSurface,
          //                   fontWeight: FontWeight.w800,
          //                 ),
          //               ),
          //             ),
          //             TextButton(
          //               onPressed: _clearBulk,
          //               child: const Text('Clear'),
          //             ),
          //           ],
          //         ),
          //         Divider(color: cs.outlineVariant),

          //         _Dropdown<String>(
          //           label: 'Project *',
          //           value: _bulkProjectId,
          //           items: _projects.map((p) => p.id).toList(),
          //           itemLabel:
          //               (id) => _projects.firstWhere((p) => p.id == id).name,
          //           loading: _loadingProjects,
          //           onChanged: (v) async {
          //             setState(() {
          //               _bulkProjectId = v;
          //               _bulkSubId = null;
          //             });
          //             _subs.clear();
          //             if (v != null && v.isNotEmpty) await _loadSubs(v);
          //           },
          //         ),

          //         _Dropdown<String>(
          //           label: 'Sub Project',
          //           value: _bulkSubId,
          //           items: _subs.map((s) => s.id).toList(),
          //           itemLabel: (id) => _subs.firstWhere((s) => s.id == id).name,
          //           loading: _loadingSubs,
          //           enabled: _subs.isNotEmpty,
          //           onChanged: (v) => setState(() => _bulkSubId = v),
          //         ),

          //         _FieldShell(
          //           label: 'Choose File (.csv)',
          //           child: Row(
          //             children: [
          //               Expanded(
          //                 child: Container(
          //                   height: 48,
          //                   alignment: Alignment.centerLeft,
          //                   padding: const EdgeInsets.symmetric(horizontal: 12),
          //                   decoration: BoxDecoration(
          //                     color: cs.surface,
          //                     border: Border.all(color: cs.outlineVariant),
          //                     borderRadius: BorderRadius.circular(8),
          //                   ),
          //                   child: Text(
          //                     _bulkFile?.name ?? 'No file selected',
          //                     overflow: TextOverflow.ellipsis,
          //                     style: TextStyle(
          //                       color:
          //                           _bulkFile == null
          //                               ? cs.onSurfaceVariant
          //                               : cs.onSurface,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //               const SizedBox(width: 8),
          //               OutlinedButton(
          //                 onPressed: _pickBulkFile,
          //                 style: OutlinedButton.styleFrom(
          //                   side: BorderSide(color: cs.outlineVariant),
          //                 ),
          //                 child: const Text('Choose File'),
          //               ),
          //             ],
          //           ),
          //         ),

          //         const SizedBox(height: 8),

          //         Row(
          //           children: [
          //             OutlinedButton(
          //               onPressed: _downloadTemplate,
          //               style: OutlinedButton.styleFrom(
          //                 side: const BorderSide(color: AppTheme.accentColor),
          //                 backgroundColor: AppTheme.accentColor,
          //                 foregroundColor: Colors.black,
          //               ),
          //               child: const Text('Download Template'),
          //             ),
          //             const Spacer(),
          //             ElevatedButton(
          //               onPressed: _uploading ? null : _uploadCsv,
          //               style: ElevatedButton.styleFrom(
          //                 backgroundColor: AppTheme.accentColor,
          //                 foregroundColor: Colors.black,
          //                 padding: const EdgeInsets.symmetric(
          //                   horizontal: 20,
          //                   vertical: 12,
          //                 ),
          //               ),
          //               child: Text(
          //                 _uploading ? 'Uploading…' : 'Upload',
          //                 style: const TextStyle(fontWeight: FontWeight.w800),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // ),

          // const SizedBox(height: 12),

          // ───────────── Single site card ─────────────
          Card(
            color: cs.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add Site',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _clearSingle,
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  _Dropdown<String>(
                    label: 'Project *',
                    value: _projectId,
                    items: _projects.map((p) => p.id).toList(),
                    itemLabel:
                        (id) => _projects.firstWhere((p) => p.id == id).name,
                    loading: _loadingProjects,
                    onChanged: (v) async {
                      setState(() {
                        _projectId = v;
                        _subId = null;
                      });
                      _subs.clear();
                      if (v != null && v.isNotEmpty) await _loadSubs(v);
                    },
                  ),

                  _Dropdown<String>(
                    label: 'Sub Project',
                    value: _subId,
                    items: _subs.map((s) => s.id).toList(),
                    itemLabel: (id) => _subs.firstWhere((s) => s.id == id).name,
                    loading: _loadingSubs,
                    enabled: _subs.isNotEmpty,
                    onChanged: (v) => setState(() => _subId = v),
                  ),

                  _TextField(label: 'Site ID *', controller: _siteIdCtrl),
                  _TextField(label: 'Site Name *', controller: _siteNameCtrl),
                  _TextField(
                    label: 'Address *',
                    controller: _addressCtrl,
                    maxLines: 3,
                  ),
                  _TextField(
                    label: 'Pincode *',
                    controller: _pincodeCtrl,
                    keyboardType: TextInputType.number,
                  ),
                  _TextField(label: 'POC *', controller: _pocCtrl),

                  _FieldShell(
                    label: 'Location',
                    child: Column(
                      children: [
                        CSCPickerPlus(
                          key: ValueKey(_locVersion),
                          layout: Layout.vertical,
                          showStates: true,
                          showCities: true,
                          flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                          dropdownDecoration: BoxDecoration(
                            color: cs.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: cs.outlineVariant),
                          ),
                          disabledDropdownDecoration: BoxDecoration(
                            color: cs.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: cs.outlineVariant),
                          ),
                          countryDropdownLabel: "Country",
                          stateDropdownLabel: "State / Region",
                          cityDropdownLabel: "City",
                          currentCountry: _country,
                          currentState: _state,
                          currentCity: _city,
                          onCountryChanged:
                              (v) => setState(() {
                                _country = v;
                                _state = null;
                                _city = null;
                              }),
                          onStateChanged:
                              (v) => setState(() {
                                _state = v;
                                _city = null;
                              }),
                          onCityChanged: (v) => setState(() => _city = v),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _districtCtrl,
                          style: TextStyle(color: cs.onSurface),
                          decoration: InputDecoration(
                            hintText:
                                _isIndia ? 'District *' : 'District (optional)',
                            hintStyle: TextStyle(color: cs.onSurfaceVariant),
                            filled: true,
                            fillColor: cs.surface,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: cs.outlineVariant),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: AppTheme.accentColor,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  _Dropdown<String>(
                    label: 'Status *',
                    value: _status,
                    items: _statusList,
                    itemLabel: (s) => s,
                    onChanged: (v) {
                      setState(() {
                        _status = v ?? 'Pending';
                        if (_status != 'Completed') _completionDate = null;
                      });
                    },
                  ),

                  _DateField(
                    label: 'Completion Date',
                    value:
                        _status == 'Completed'
                            ? _fmt(_completionDate)
                            : 'Disabled',
                    onTap: _status == 'Completed' ? _pickCompletionDate : null,
                    enabled: _status == 'Completed',
                  ),

                  _TextField(
                    label: 'Remarks',
                    controller: _remarksCtrl,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitting ? null : _submitSingle,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        _submitting ? 'Saving…' : 'ADD',
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ───────────────── UI bits ─────────────────
class _FieldShell extends StatelessWidget {
  final String label;
  final Widget child;
  const _FieldShell({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  const _TextField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final String Function(T value)? itemLabel;
  final ValueChanged<T?> onChanged;
  final bool loading;
  final bool enabled;
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabel,
    this.loading = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: Container(
        decoration: BoxDecoration(
          color: enabled ? cs.surface : cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child:
              loading
                  ? SizedBox(
                    height: 48,
                    child: Center(
                      child: SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: cs.onSurfaceVariant,
                        ),
                      ),
                    ),
                  )
                  : DropdownButton<T>(
                    value: enabled ? value : null,
                    isExpanded: true,
                    iconEnabledColor: cs.onSurfaceVariant,
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    style: TextStyle(color: cs.onSurface, fontSize: 14),
                    items:
                        items
                            .map(
                              (e) => DropdownMenuItem<T>(
                                value: e,
                                child: Text(
                                  itemLabel != null ? itemLabel!(e) : '$e',
                                ),
                              ),
                            )
                            .toList(),
                    hint: Text(
                      'Select',
                      style: TextStyle(color: cs.onSurfaceVariant),
                    ),
                    onChanged: enabled ? onChanged : null,
                  ),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback? onTap;
  final bool enabled;
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: enabled ? cs.surface : cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    color:
                        enabled
                            ? (value == 'Select date'
                                ? cs.onSurfaceVariant
                                : cs.onSurface)
                            : cs.onSurfaceVariant,
                  ),
                ),
              ),
              Icon(
                Icons.calendar_today_rounded,
                size: 18,
                color: cs.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
