// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/api_client.dart';

// /// Pass your FEVendor item from the list.
// class FeVendorData {
//   final String id;
//   final String role; // from API (shown in header)
//   final String name;
//   final String email;
//   final String contact;

//   final List<String> projectCodes; // from your list model (we preserved codes)
//   final List<String> sites;

//   final String zone;
//   final String state;
//   final String district;

//   final String bankName;
//   final String bankAccount;
//   final String ifsc;
//   final String pan;
//   final String poc;

//   FeVendorData({
//     required this.id,
//     required this.role,
//     required this.name,
//     required this.email,
//     required this.contact,
//     required this.projectCodes,
//     required this.sites,
//     required this.zone,
//     required this.state,
//     required this.district,
//     required this.bankName,
//     required this.bankAccount,
//     required this.ifsc,
//     required this.pan,
//     required this.poc,
//   });
// }

// class UpdateFeModal extends StatefulWidget {
//   final FeVendorData fe;

//   const UpdateFeModal({super.key, required this.fe});

//   static Future<bool?> show(BuildContext context, {required FeVendorData fe}) {
//     return showModalBottomSheet<bool>(
//       context: context,
//       useSafeArea: true,
//       isScrollControlled: true,
//       showDragHandle: true,
//       builder:
//           (_) => Padding(
//             padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom,
//             ),
//             child: UpdateFeModal(fe: fe),
//           ),
//     );
//   }

//   @override
//   State<UpdateFeModal> createState() => _UpdateFeModalState();
// }

// class _UpdateFeModalState extends State<UpdateFeModal> {
//   final _formKey = GlobalKey<FormState>();

//   late final TextEditingController _nameCtrl;
//   late final TextEditingController _emailCtrl;
//   late final TextEditingController _contactCtrl;

//   late final TextEditingController _zoneCtrl;
//   late final TextEditingController _stateCtrl;
//   late final TextEditingController _districtCtrl;

//   late final TextEditingController _bankNameCtrl;
//   late final TextEditingController _bankAccCtrl;
//   late final TextEditingController _ifscCtrl;
//   late final TextEditingController _panCtrl;
//   late final TextEditingController _pocCtrl;

//   // Options
//   final Map<String, String> _projectMap = {}; // code->name
//   final List<_ProjectSite> _projectSites = [];
//   final Set<String> _selectedCodes = {};
//   final Set<String> _selectedSites = {};

//   bool _loadingOptions = false;
//   bool _saving = false;

//   @override
//   void initState() {
//     super.initState();
//     final fe = widget.fe;
//     _nameCtrl = TextEditingController(text: fe.name);
//     _emailCtrl = TextEditingController(text: fe.email);
//     _contactCtrl = TextEditingController(text: fe.contact);

//     _zoneCtrl = TextEditingController(text: fe.zone);
//     _stateCtrl = TextEditingController(text: fe.state);
//     _districtCtrl = TextEditingController(text: fe.district);

//     _bankNameCtrl = TextEditingController(text: fe.bankName);
//     _bankAccCtrl = TextEditingController(text: fe.bankAccount);
//     _ifscCtrl = TextEditingController(text: fe.ifsc);
//     _panCtrl = TextEditingController(text: fe.pan);
//     _pocCtrl = TextEditingController(text: fe.poc);

//     _selectedCodes.addAll(fe.projectCodes);
//     _selectedSites.addAll(fe.sites);

//     _loadOptions();
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _emailCtrl.dispose();
//     _contactCtrl.dispose();
//     _zoneCtrl.dispose();
//     _stateCtrl.dispose();
//     _districtCtrl.dispose();
//     _bankNameCtrl.dispose();
//     _bankAccCtrl.dispose();
//     _ifscCtrl.dispose();
//     _panCtrl.dispose();
//     _pocCtrl.dispose();
//     super.dispose();
//   }

//   ApiClient get _api => context.read<ApiClient>();

//   Future<void> _loadOptions() async {
//     setState(() => _loadingOptions = true);
//     try {
//       // projects
//       final pRes = await _api.get('/api/projects');
//       if (pRes.statusCode >= 200 && pRes.statusCode < 300) {
//         final list = jsonDecode(utf8.decode(pRes.bodyBytes)) as List;
//         _projectMap
//           ..clear()
//           ..addEntries(
//             list.map(
//               (p) => MapEntry(
//                 (p['project_code'] ?? '').toString(),
//                 (p['project_name'] ?? '').toString(),
//               ),
//             ),
//           );
//       }

//       // project-sites
//       final sRes = await _api.get('/api/project-sites');
//       if (sRes.statusCode >= 200 && sRes.statusCode < 300) {
//         final list = jsonDecode(utf8.decode(sRes.bodyBytes)) as List;
//         _projectSites
//           ..clear()
//           ..addAll(
//             list.map(
//               (e) => _ProjectSite(
//                 projectName: (e['project_name'] ?? '').toString(),
//                 siteName: (e['site_name'] ?? '').toString(),
//               ),
//             ),
//           );
//       }
//     } catch (_) {
//       // ignore
//     } finally {
//       if (mounted) setState(() => _loadingOptions = false);
//     }
//   }

//   List<String> get _filteredSites {
//     // Match selected project codes -> project names
//     final chosenNames = _selectedCodes.map((c) => _projectMap[c] ?? c).toSet();
//     final names =
//         _projectSites
//             .where((ps) => chosenNames.contains(ps.projectName))
//             .map((ps) => ps.siteName)
//             .toSet()
//             .toList()
//           ..sort();
//     return names;
//   }

//   Future<void> _save() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() => _saving = true);
//     try {
//       final res = await _api.put(
//         '/api/field-engineers/${widget.fe.id}',
//         body: {
//           'full_name': _nameCtrl.text.trim(),
//           'contact_no': _contactCtrl.text.trim(),
//           'project_codes': _selectedCodes.toList(),
//           'site_names': _selectedSites.toList(),
//           'bank_info':
//               _bankNameCtrl.text.trim().isEmpty
//                   ? null
//                   : _bankNameCtrl.text.trim(),
//           'bank_account':
//               _bankAccCtrl.text.trim().isEmpty
//                   ? null
//                   : _bankAccCtrl.text.trim(),
//           'ifsc': _ifscCtrl.text.trim().isEmpty ? null : _ifscCtrl.text.trim(),
//           'pan': _panCtrl.text.trim().isEmpty ? null : _panCtrl.text.trim(),
//           'zone': _zoneCtrl.text.trim().isEmpty ? null : _zoneCtrl.text.trim(),
//           'contact_person':
//               _pocCtrl.text.trim().isEmpty ? null : _pocCtrl.text.trim(),
//           'state':
//               _stateCtrl.text.trim().isEmpty ? null : _stateCtrl.text.trim(),
//           'district':
//               _districtCtrl.text.trim().isEmpty
//                   ? null
//                   : _districtCtrl.text.trim(),
//           'role': widget.fe.role, // keep current role
//         },
//       );
//       if (!mounted) return;
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         Navigator.pop(context, true);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Update failed (${res.statusCode})')),
//         );
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error: $e')));
//       }
//     } finally {
//       if (mounted) setState(() => _saving = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final roleLabel =
//         widget.fe.role.isEmpty ? 'Field Engineer' : widget.fe.role;

//     return SafeArea(
//       top: false,
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Update $roleLabel',
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//               const SizedBox(height: 16),

//               // Name + Email
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _nameCtrl,
//                       decoration: const InputDecoration(labelText: 'Name'),
//                       validator:
//                           (v) =>
//                               (v == null || v.trim().isEmpty)
//                                   ? 'Required'
//                                   : null,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _emailCtrl,
//                       decoration: const InputDecoration(labelText: 'Email'),
//                       readOnly: true,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Contact + Zone
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _contactCtrl,
//                       decoration: const InputDecoration(
//                         labelText: 'Contact No',
//                       ),
//                       keyboardType: TextInputType.phone,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _zoneCtrl,
//                       decoration: const InputDecoration(labelText: 'Zone'),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // State + District
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _stateCtrl,
//                       decoration: const InputDecoration(labelText: 'State'),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _districtCtrl,
//                       decoration: const InputDecoration(labelText: 'District'),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),

//               // Projects multiselect
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Projects',
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: cs.outlineVariant),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.all(8),
//                 child:
//                     _loadingOptions && _projectMap.isEmpty
//                         ? const SizedBox(
//                           height: 40,
//                           child: Center(
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           ),
//                         )
//                         : Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children:
//                               _projectMap.entries.map((e) {
//                                 final selected = _selectedCodes.contains(e.key);
//                                 return FilterChip(
//                                   label: Text(
//                                     e.value,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   selected: selected,
//                                   onSelected: (v) {
//                                     setState(() {
//                                       if (v) {
//                                         _selectedCodes.add(e.key);
//                                       } else {
//                                         _selectedCodes.remove(e.key);
//                                         // prune any sites that no longer belong
//                                         final allowed = _filteredSites.toSet();
//                                         _selectedSites.removeWhere(
//                                           (s) => !allowed.contains(s),
//                                         );
//                                       }
//                                     });
//                                   },
//                                 );
//                               }).toList(),
//                         ),
//               ),
//               const SizedBox(height: 12),

//               // Sites multiselect (filtered)
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Sites',
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//               ),
//               const SizedBox(height: 6),
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: cs.outlineVariant),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 padding: const EdgeInsets.all(8),
//                 child:
//                     _loadingOptions
//                         ? const SizedBox(
//                           height: 40,
//                           child: Center(
//                             child: CircularProgressIndicator(strokeWidth: 2),
//                           ),
//                         )
//                         : Wrap(
//                           spacing: 8,
//                           runSpacing: 8,
//                           children:
//                               _filteredSites.map((s) {
//                                 final selected = _selectedSites.contains(s);
//                                 return FilterChip(
//                                   label: Text(
//                                     s,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                   selected: selected,
//                                   onSelected: (v) {
//                                     setState(() {
//                                       if (v) {
//                                         _selectedSites.add(s);
//                                       } else {
//                                         _selectedSites.remove(s);
//                                       }
//                                     });
//                                   },
//                                 );
//                               }).toList(),
//                         ),
//               ),
//               const SizedBox(height: 12),

//               // Bank / POC
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _bankNameCtrl,
//                       decoration: const InputDecoration(labelText: 'Bank Name'),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _bankAccCtrl,
//                       decoration: const InputDecoration(
//                         labelText: 'Bank Account No',
//                       ),
//                       keyboardType: TextInputType.number,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextFormField(
//                       controller: _ifscCtrl,
//                       decoration: const InputDecoration(labelText: 'Bank IFSC'),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: TextFormField(
//                       controller: _panCtrl,
//                       decoration: const InputDecoration(labelText: 'PAN No'),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 12),
//               TextFormField(
//                 controller: _pocCtrl,
//                 decoration: const InputDecoration(labelText: 'POC'),
//               ),
//               const SizedBox(height: 16),

//               Row(
//                 children: [
//                   Expanded(
//                     child: FilledButton(
//                       onPressed: _saving ? null : _save,
//                       child:
//                           _saving
//                               ? const SizedBox(
//                                 height: 18,
//                                 width: 18,
//                                 child: CircularProgressIndicator(
//                                   strokeWidth: 2,
//                                 ),
//                               )
//                               : const Text('Update'),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _ProjectSite {
//   final String projectName;
//   final String siteName;
//   _ProjectSite({required this.projectName, required this.siteName});
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/api_client.dart';

class FeVendorData {
  final String id;
  final String role;
  final String name;
  final String email;
  final String contact;

  final List<String> projectCodes;
  final List<String> sites;

  final String zone;
  final String state;
  final String district;

  final String bankName;
  final String bankAccount;
  final String ifsc;
  final String pan;
  final String poc;

  FeVendorData({
    required this.id,
    required this.role,
    required this.name,
    required this.email,
    required this.contact,
    required this.projectCodes,
    required this.sites,
    required this.zone,
    required this.state,
    required this.district,
    required this.bankName,
    required this.bankAccount,
    required this.ifsc,
    required this.pan,
    required this.poc,
  });
}

class UpdateFeModal extends StatefulWidget {
  final FeVendorData fe;

  const UpdateFeModal({super.key, required this.fe});

  static Future<bool?> show(BuildContext context, {required FeVendorData fe}) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      builder:
          (_) => FractionallySizedBox(
            heightFactor: .92,
            child: UpdateFeModal(fe: fe),
          ),
    );
  }

  @override
  State<UpdateFeModal> createState() => _UpdateFeModalState();
}

class _UpdateFeModalState extends State<UpdateFeModal> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _contactCtrl;

  late final TextEditingController _zoneCtrl;
  late final TextEditingController _stateCtrl;
  late final TextEditingController _districtCtrl;

  late final TextEditingController _bankNameCtrl;
  late final TextEditingController _bankAccCtrl;
  late final TextEditingController _ifscCtrl;
  late final TextEditingController _panCtrl;
  late final TextEditingController _pocCtrl;

  final Map<String, String> _projectMap = {}; // code->name
  final List<_ProjectSite> _projectSites = [];
  final Set<String> _selectedCodes = {};
  final Set<String> _selectedSites = {};

  bool _loadingOpts = false;
  bool _saving = false;

  ApiClient get _api => context.read<ApiClient>();

  @override
  void initState() {
    super.initState();
    final fe = widget.fe;
    _nameCtrl = TextEditingController(text: fe.name);
    _emailCtrl = TextEditingController(text: fe.email);
    _contactCtrl = TextEditingController(text: fe.contact);

    _zoneCtrl = TextEditingController(text: fe.zone);
    _stateCtrl = TextEditingController(text: fe.state);
    _districtCtrl = TextEditingController(text: fe.district);

    _bankNameCtrl = TextEditingController(text: fe.bankName);
    _bankAccCtrl = TextEditingController(text: fe.bankAccount);
    _ifscCtrl = TextEditingController(text: fe.ifsc);
    _panCtrl = TextEditingController(text: fe.pan);
    _pocCtrl = TextEditingController(text: fe.poc);

    _selectedCodes.addAll(fe.projectCodes);
    _selectedSites.addAll(fe.sites);

    _loadOptions();
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _contactCtrl.dispose();
    _zoneCtrl.dispose();
    _stateCtrl.dispose();
    _districtCtrl.dispose();
    _bankNameCtrl.dispose();
    _bankAccCtrl.dispose();
    _ifscCtrl.dispose();
    _panCtrl.dispose();
    _pocCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadOptions() async {
    setState(() => _loadingOpts = true);
    try {
      final pRes = await _api.get('/api/projects');
      if (pRes.statusCode >= 200 && pRes.statusCode < 300) {
        final list = jsonDecode(utf8.decode(pRes.bodyBytes)) as List;
        _projectMap
          ..clear()
          ..addEntries(
            list.map(
              (p) => MapEntry(
                (p['project_code'] ?? '').toString(),
                (p['project_name'] ?? '').toString(),
              ),
            ),
          );
      }

      final sRes = await _api.get('/api/project-sites');
      if (sRes.statusCode >= 200 && sRes.statusCode < 300) {
        final list = jsonDecode(utf8.decode(sRes.bodyBytes)) as List;
        _projectSites
          ..clear()
          ..addAll(
            list.map(
              (e) => _ProjectSite(
                projectName: (e['project_name'] ?? '').toString(),
                siteName: (e['site_name'] ?? '').toString(),
              ),
            ),
          );
      }
    } finally {
      if (mounted) setState(() => _loadingOpts = false);
    }
  }

  List<String> get _filteredSites {
    final chosenNames = _selectedCodes.map((c) => _projectMap[c] ?? c).toSet();
    final names =
        _projectSites
            .where((ps) => chosenNames.contains(ps.projectName))
            .map((ps) => ps.siteName)
            .toSet()
            .toList()
          ..sort();
    return names;
  }

  String _projectsLabel() {
    if (_selectedCodes.isEmpty) return 'Select projects';
    final names =
        _selectedCodes.map((c) => _projectMap[c] ?? c).toList()..sort();
    return names.join(', ');
  }

  String _sitesLabel() {
    if (_selectedSites.isEmpty) return 'Select sites';
    final list = _selectedSites.toList()..sort();
    return list.join(', ');
  }

  Future<void> _openMultiPicker({
    required String title,
    required List<_PickItem> items,
    required Set<String> selection,
  }) async {
    final temp = selection.toSet();
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      builder:
          (_) => SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Done'),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (_, i) {
                      final it = items[i];
                      final checked = temp.contains(it.value);
                      return CheckboxListTile(
                        value: checked,
                        onChanged: (v) {
                          setState(() {
                            if (v == true)
                              temp.add(it.value);
                            else
                              temp.remove(it.value);
                          });
                        },
                        title: Text(it.label),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
    );
    setState(() {
      selection
        ..clear()
        ..addAll(temp);
      // keep sites consistent with selected projects
      if (selection == _selectedCodes) {
        final allowed = _filteredSites.toSet();
        _selectedSites.removeWhere((s) => !allowed.contains(s));
      }
    });
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      final res = await _api.put(
        '/api/field-engineers/${widget.fe.id}',
        body: {
          'full_name': _nameCtrl.text.trim(),
          'contact_no': _contactCtrl.text.trim(),
          'project_codes': _selectedCodes.toList(),
          'site_names': _selectedSites.toList(),
          'bank_info':
              _bankNameCtrl.text.trim().isEmpty
                  ? null
                  : _bankNameCtrl.text.trim(),
          'bank_account':
              _bankAccCtrl.text.trim().isEmpty
                  ? null
                  : _bankAccCtrl.text.trim(),
          'ifsc': _ifscCtrl.text.trim().isEmpty ? null : _ifscCtrl.text.trim(),
          'pan': _panCtrl.text.trim().isEmpty ? null : _panCtrl.text.trim(),
          'zone': _zoneCtrl.text.trim().isEmpty ? null : _zoneCtrl.text.trim(),
          'contact_person':
              _pocCtrl.text.trim().isEmpty ? null : _pocCtrl.text.trim(),
          'state':
              _stateCtrl.text.trim().isEmpty ? null : _stateCtrl.text.trim(),
          'district':
              _districtCtrl.text.trim().isEmpty
                  ? null
                  : _districtCtrl.text.trim(),
          'role': widget.fe.role,
        },
      );
      if (!mounted) return;
      if (res.statusCode >= 200 && res.statusCode < 300) {
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update failed (${res.statusCode})')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleLabel =
        widget.fe.role.isEmpty ? 'Field Engineer' : widget.fe.role;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          top: 8,
        ),
        child: Column(
          children: [
            Text(
              'Update $roleLabel',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 12),

            // scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 5, bottom: 12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _nameCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Name',
                              ),
                              validator:
                                  (v) =>
                                      (v == null || v.trim().isEmpty)
                                          ? 'Required'
                                          : null,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _emailCtrl,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                // suffixText: 'Read-only',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _contactCtrl,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Contact No',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _zoneCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Zone',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _stateCtrl,
                              decoration: const InputDecoration(
                                labelText: 'State',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _districtCtrl,
                              decoration: const InputDecoration(
                                labelText: 'District',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Projects multi
                      GestureDetector(
                        onTap:
                            _loadingOpts
                                ? null
                                : () => _openMultiPicker(
                                  title: 'Select Projects',
                                  items:
                                      _projectMap.entries
                                          .map(
                                            (e) => _PickItem(
                                              value: e.key,
                                              label: e.value,
                                            ),
                                          )
                                          .toList()
                                        ..sort(
                                          (a, b) => a.label.compareTo(b.label),
                                        ),
                                  selection: _selectedCodes,
                                ),
                        child: AbsorbPointer(
                          absorbing: true,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Projects',
                              suffixIcon: Icon(Icons.arrow_drop_down),
                            ),
                            controller: TextEditingController(
                              text: _projectsLabel(),
                            ),
                            maxLines: 3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Sites multi (filtered by chosen projects)
                      GestureDetector(
                        onTap:
                            _loadingOpts
                                ? null
                                : () => _openMultiPicker(
                                  title: 'Select Sites',
                                  items:
                                      _filteredSites
                                          .map(
                                            (s) =>
                                                _PickItem(value: s, label: s),
                                          )
                                          .toList(),
                                  selection: _selectedSites,
                                ),
                        child: AbsorbPointer(
                          absorbing: true,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Sites',
                              suffixIcon: Icon(Icons.arrow_drop_down),
                            ),
                            controller: TextEditingController(
                              text: _sitesLabel(),
                            ),
                            maxLines: 4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _bankNameCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Bank Name',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _bankAccCtrl,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                labelText: 'Bank Account No',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _ifscCtrl,
                              decoration: const InputDecoration(
                                labelText: 'Bank IFSC',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextFormField(
                              controller: _panCtrl,
                              decoration: const InputDecoration(
                                labelText: 'PAN No',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _pocCtrl,
                        decoration: const InputDecoration(labelText: 'POC'),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // bottom button (inside padding, so no overflow)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _saving ? null : _save,
                child:
                    _saving
                        ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                        : const Text('Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectSite {
  final String projectName;
  final String siteName;
  _ProjectSite({required this.projectName, required this.siteName});
}

class _PickItem {
  final String value;
  final String label;
  _PickItem({required this.value, required this.label});
}
