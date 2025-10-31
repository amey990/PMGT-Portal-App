// // lib/ui/screens/sites/update_site_modal.dart
// import 'package:flutter/material.dart';
// import 'package:csc_picker_plus/csc_picker_plus.dart';
// import 'package:pmgt/core/theme.dart';
// // Import the public Site model
// import '../Sites/view_sites_screen.dart' show Site;

// class UpdateSiteModal extends StatefulWidget {
//   final Site site;
//   final List<String> subProjects;
//   final List<String> statusOptions;

//   const UpdateSiteModal({
//     super.key,
//     required this.site,
//     required this.subProjects,
//     required this.statusOptions,
//   });

//   static Future<Site?> show(
//     BuildContext context, {
//     required Site site,
//     required List<String> subProjects,
//     required List<String> statusOptions,
//   }) {
//     return showModalBottomSheet<Site?>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (ctx) => Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
//         child: UpdateSiteModal(
//           site: site,
//           subProjects: subProjects,
//           statusOptions: statusOptions,
//         ),
//       ),
//     );
//   }

//   @override
//   State<UpdateSiteModal> createState() => _UpdateSiteModalState();
// }

// class _UpdateSiteModalState extends State<UpdateSiteModal> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   late final TextEditingController _siteNameCtrl;
//   late final TextEditingController _siteIdCtrl;
//   late final TextEditingController _addressCtrl;
//   late final TextEditingController _pincodeCtrl;
//   late final TextEditingController _pocCtrl;
//   late final TextEditingController _districtCtrl;
//   late final TextEditingController _remarksCtrl;

//   String? _subProject;
//   String? _status;
//   String? _country;
//   String? _state;
//   String? _city;
//   DateTime? _completion;

//   @override
//   void initState() {
//     super.initState();
//     final s = widget.site;
//     _siteNameCtrl = TextEditingController(text: s.siteName);
//     _siteIdCtrl = TextEditingController(text: s.siteId);
//     _addressCtrl = TextEditingController(text: s.address);
//     _pincodeCtrl = TextEditingController(text: s.pincode);
//     _pocCtrl = TextEditingController(text: s.poc);
//     _districtCtrl = TextEditingController(text: s.district);
//     _remarksCtrl = TextEditingController(text: s.remarks);

//     _subProject = s.subProject;
//     _status = s.status;
//     _country = s.country;
//     _state = s.state;
//     _city = s.city;
//     _completion = _parseDate(s.completionDate);
//   }

//   DateTime? _parseDate(String? ddmmyyyy) {
//     if (ddmmyyyy == null || ddmmyyyy.isEmpty) return null;
//     final p = ddmmyyyy.split('/');
//     if (p.length != 3) return null;
//     return DateTime(int.parse(p[2]), int.parse(p[1]), int.parse(p[0]));
//     // dd/mm/yyyy
//   }

//   String _fmt(DateTime? d) {
//     if (d == null) return 'Select date';
//     final dd = d.day.toString().padLeft(2, '0');
//     final mm = d.month.toString().padLeft(2, '0');
//     final yy = d.year.toString();
//     return '$dd/$mm/$yy';
//   }

//   Future<void> _pickCompletion() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _completion ?? now,
//       firstDate: DateTime(now.year - 10),
//       lastDate: DateTime(now.year + 10),
//     );
//     if (picked != null) setState(() => _completion = picked);
//   }

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

//   InputDecoration _dec(String label) {
//     final cs = Theme.of(context).colorScheme;
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: cs.surfaceContainerHighest,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return SafeArea(
//       minimum: const EdgeInsets.only(top: 17),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Update Site',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       fontSize: 18,
//                       color: cs.onSurface,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => Navigator.pop(context, null),
//                 ),
//               ],
//             ),

//             Flexible(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 20),

//                       // Project (read-only)
//                       TextFormField(
//                         initialValue: widget.site.project,
//                         readOnly: true,
//                         decoration: _dec('Project (read-only)'),
//                       ),
//                       const SizedBox(height: 12),

//                       // DropdownButtonFormField<String>(
//                       //   initialValue: widget.subProjects.contains(_subProject) ? _subProject : null,
//                       //   items: widget.subProjects
//                       //       .map((sp) => DropdownMenuItem(value: sp, child: Text(sp)))
//                       //       .toList(),
//                       //   onChanged: (v) => setState(() => _subProject = v),
//                       //   decoration: _dec('Sub Project'),
//                       // ),
//                       DropdownButtonFormField<String>(
//   initialValue: widget.subProjects.contains(_subProject) ? _subProject : null,
//   items: widget.subProjects
//       .map((sp) => DropdownMenuItem<String>(value: sp, child: Text(sp)))
//       .toList(),
//   onChanged: (v) => setState(() => _subProject = v),
//   decoration: _dec('Sub Project'),
// ),
//                       const SizedBox(height: 12),

//                       TextFormField(controller: _siteNameCtrl, decoration: _dec('Site Name *')),
//                       const SizedBox(height: 12),

//                       TextFormField(
//                         controller: _siteIdCtrl,
//                         readOnly: true,
//                         decoration: _dec('Site ID (read-only)'),
//                       ),
//                       const SizedBox(height: 12),

//                       TextFormField(controller: _addressCtrl, decoration: _dec('Address *'), maxLines: 2),
//                       const SizedBox(height: 12),

//                       TextFormField(controller: _pincodeCtrl, decoration: _dec('Pincode *')),
//                       const SizedBox(height: 12),

//                       TextFormField(controller: _pocCtrl, decoration: _dec('POC *')),
//                       const SizedBox(height: 12),

//                       // Country / State / City (+ District)
//                       CSCPickerPlus(
//                         layout: Layout.vertical,
//                         showStates: true,
//                         showCities: true,
//                         flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
//                         dropdownDecoration: BoxDecoration(
//                           color: cs.surfaceContainerHighest,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: cs.outlineVariant),
//                         ),
//                         disabledDropdownDecoration: BoxDecoration(
//                           color: cs.surfaceContainerHigh,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: cs.outlineVariant),
//                         ),
//                         countryDropdownLabel: "Country",
//                         stateDropdownLabel: "State / Region",
//                         cityDropdownLabel: "City",
//                         currentCountry: _country,
//                         currentState: _state,
//                         currentCity: _city,
//                         onCountryChanged: (v) => setState(() {
//                           _country = v;
//                           _state = null;
//                           _city = null;
//                         }),
//                         onStateChanged: (v) => setState(() {
//                           _state = v;
//                           _city = null;
//                         }),
//                         onCityChanged: (v) => setState(() => _city = v),
//                       ),
//                       const SizedBox(height: 10),

//                       TextFormField(controller: _districtCtrl, decoration: _dec('District *')),
//                       const SizedBox(height: 12),

//                       // DropdownButtonFormField<String>(
//                       //   initialValue: widget.statusOptions.contains(_status) ? _status : null,
//                       //   items: widget.statusOptions
//                       //       .map((s) => DropdownMenuItem(value: s, child: Text(s)))
//                       //       .toList(),
//                       //   onChanged: (v) => setState(() => _status = v),
//                       //   decoration: _dec('Status *'),
//                       // ),
//                       // Status
// DropdownButtonFormField<String>(
//   initialValue: widget.statusOptions.contains(_status) ? _status : null,
//   items: widget.statusOptions
//       .map((s) => DropdownMenuItem<String>(value: s, child: Text(s)))
//       .toList(),
//   onChanged: (v) => setState(() => _status = v),
//   decoration: _dec('Status *'),
// ),

//                       const SizedBox(height: 12),

//                       InkWell(
//                         onTap: _pickCompletion,
//                         child: InputDecorator(
//                           decoration: _dec('Completion Date'),
//                           child: Row(
//                             children: [
//                               Expanded(child: Text(_fmt(_completion))),
//                               const Icon(Icons.calendar_today, size: 18),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       TextFormField(controller: _remarksCtrl, decoration: _dec('Remarks'), maxLines: 2),

//                       const SizedBox(height: 16),
//                       Row(
//                         children: [
//                           const Spacer(),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, null),
//                             child: const Text('CANCEL'),
//                           ),
//                           const SizedBox(width: 8),
//                           FilledButton(
//                             style: FilledButton.styleFrom(
//                               backgroundColor: AppTheme.accentColor,
//                               foregroundColor: Colors.black,
//                             ),
//                             onPressed: () {
//                               if (!_formKey.currentState!.validate()) return;
//                               final updated = widget.site.copyWith(
//                                 subProject: _subProject ?? widget.site.subProject,
//                                 siteName: _siteNameCtrl.text,
//                                 address: _addressCtrl.text,
//                                 pincode: _pincodeCtrl.text,
//                                 poc: _pocCtrl.text,
//                                 country: _country ?? widget.site.country,
//                                 state: _state ?? widget.site.state,
//                                 district: _districtCtrl.text,
//                                 city: _city ?? widget.site.city,
//                                 status: _status ?? widget.site.status,
//                                 completionDate: _fmt(_completion) == 'Select date'
//                                     ? widget.site.completionDate
//                                     : _fmt(_completion),
//                                 remarks: _remarksCtrl.text,
//                               );
//                               Navigator.pop(context, updated);
//                             },
//                             child: const Text('UPDATE'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


//p3//
// import 'package:flutter/material.dart';
// import 'package:csc_picker_plus/csc_picker_plus.dart';
// import 'package:pmgt/core/theme.dart';
// // Public Site model coming from the view page
// import '../Sites/view_sites_screen.dart' show Site;

// class UpdateSiteModal extends StatefulWidget {
//   final Site site;
//   final List<String> subProjects; // kept for parity; unused (read-only shown)
//   final List<String> statusOptions;

//   const UpdateSiteModal({
//     super.key,
//     required this.site,
//     required this.subProjects,
//     required this.statusOptions,
//   });

//   static Future<Site?> show(
//     BuildContext context, {
//     required Site site,
//     required List<String> subProjects,
//     required List<String> statusOptions,
//   }) {
//     return showModalBottomSheet<Site?>(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (ctx) => Padding(
//         padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
//         child: UpdateSiteModal(
//           site: site,
//           subProjects: subProjects,
//           statusOptions: statusOptions,
//         ),
//       ),
//     );
//   }

//   @override
//   State<UpdateSiteModal> createState() => _UpdateSiteModalState();
// }

// class _UpdateSiteModalState extends State<UpdateSiteModal> {
//   final _formKey = GlobalKey<FormState>();

//   // Editable controllers
//   late final TextEditingController _addressCtrl;
//   late final TextEditingController _pincodeCtrl;
//   late final TextEditingController _pocCtrl;
//   late final TextEditingController _districtCtrl;
//   late final TextEditingController _remarksCtrl;

//   // Select state
//   String? _status;
//   String? _country;
//   String? _state;
//   String? _city;
//   DateTime? _completion;

//   bool get _isIndia => (_country ?? '').trim().toLowerCase() == 'india';

//   @override
//   void initState() {
//     super.initState();
//     final s = widget.site;
//     _addressCtrl = TextEditingController(text: s.address);
//     _pincodeCtrl = TextEditingController(text: s.pincode);
//     _pocCtrl = TextEditingController(text: s.poc);
//     _districtCtrl = TextEditingController(text: s.district);
//     _remarksCtrl = TextEditingController(text: s.remarks == '—' ? '' : s.remarks);

//     _status = s.status;
//     _country = s.country;
//     _state = s.state;
//     _city = s.city;
//     _completion = _parseDdmmyyyy(s.completionDate);
//   }

//   // ---- Dates ----
//   DateTime? _parseDdmmyyyy(String? ddmmyyyy) {
//     if (ddmmyyyy == null || ddmmyyyy.trim().isEmpty || ddmmyyyy == '—') return null;
//     final sep = ddmmyyyy.contains('/') ? '/' : '-';
//     final p = ddmmyyyy.split(sep);
//     if (p.length != 3) return null;
//     final d = int.tryParse(p[0]), m = int.tryParse(p[1]), y = int.tryParse(p[2]);
//     if (d == null || m == null || y == null) return null;
//     return DateTime(y, m, d);
//   }

//   String _fmt(DateTime? d) {
//     if (d == null) return 'Select date';
//     final dd = d.day.toString().padLeft(2, '0');
//     final mm = d.month.toString().padLeft(2, '0');
//     final yy = d.year.toString();
//     return '$dd/$mm/$yy';
//   }

//   Future<void> _pickCompletion() async {
//     if (_status != 'Completed') return;
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _completion ?? now,
//       firstDate: DateTime(now.year - 10),
//       lastDate: DateTime(now.year + 10),
//       builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
//     );
//     if (picked != null) setState(() => _completion = picked);
//   }

//   // ---- UI helpers ----
//   InputDecoration _dec(String label) {
//     final cs = Theme.of(context).colorScheme;
//     return InputDecoration(
//       labelText: label,
//       filled: true,
//       fillColor: cs.surfaceContainerHighest,
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//     );
//   }

//   Widget _readOnlyField(String label, String value) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   value.isEmpty ? '—' : value,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(color: cs.onSurface),
//                 ),
//               ),
//               Text('Read-only', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontStyle: FontStyle.italic)),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   void _onStatusChanged(String? v) {
//     setState(() {
//       _status = v;
//       if (_status == 'Completed') {
//         _completion ??= DateTime.now();
//       } else {
//         _completion = null;
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _addressCtrl.dispose();
//     _pincodeCtrl.dispose();
//     _pocCtrl.dispose();
//     _districtCtrl.dispose();
//     _remarksCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return SafeArea(
//       minimum: const EdgeInsets.only(top: 17),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Header
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Update Site',
//                     style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: cs.onSurface),
//                   ),
//                 ),
//                 IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context, null)),
//               ],
//             ),

//             Flexible(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       const SizedBox(height: 20),

//                       // ---- Read-only (same UX as Update Project) ----
//                       _readOnlyField('Project (read-only)', widget.site.project),
//                       const SizedBox(height: 12),
//                       _readOnlyField('Sub Project (read-only)', widget.site.subProject),
//                       const SizedBox(height: 12),
//                       _readOnlyField('Site Name (read-only)', widget.site.siteName),
//                       const SizedBox(height: 12),
//                       _readOnlyField('Site ID (read-only)', widget.site.siteId),
//                       const SizedBox(height: 12),

//                       // ---- Editable ----
//                       TextFormField(
//                         controller: _addressCtrl,
//                         decoration: _dec('Address *'),
//                         maxLines: 2,
//                         validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
//                       ),
//                       const SizedBox(height: 12),

//                       TextFormField(
//                         controller: _pincodeCtrl,
//                         decoration: _dec('Pincode *'),
//                         validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
//                       ),
//                       const SizedBox(height: 12),

//                       TextFormField(
//                         controller: _pocCtrl,
//                         decoration: _dec('POC *'),
//                         validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
//                       ),
//                       const SizedBox(height: 12),

//                       // Country / State / City
//                       CSCPickerPlus(
//                         layout: Layout.vertical,
//                         showStates: true,
//                         showCities: true,
//                         flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
//                         dropdownDecoration: BoxDecoration(
//                           color: cs.surfaceContainerHighest,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: cs.outlineVariant),
//                         ),
//                         disabledDropdownDecoration: BoxDecoration(
//                           color: cs.surfaceContainerHigh,
//                           borderRadius: BorderRadius.circular(8),
//                           border: Border.all(color: cs.outlineVariant),
//                         ),
//                         countryDropdownLabel: "Country",
//                         stateDropdownLabel: "State / Region",
//                         cityDropdownLabel: "City",
//                         currentCountry: _country,
//                         currentState: _state,
//                         currentCity: _city,
//                         onCountryChanged: (v) => setState(() {
//                           _country = v;
//                           _state = null;
//                           _city = null;
//                           if (!_isIndia) _districtCtrl.clear();
//                         }),
//                         onStateChanged: (v) => setState(() {
//                           _state = v;
//                           _city = null;
//                           if (_isIndia) _districtCtrl.clear();
//                         }),
//                         onCityChanged: (v) => setState(() => _city = v),
//                       ),
//                       const SizedBox(height: 10),

//                       TextFormField(
//                         controller: _districtCtrl,
//                         decoration: _dec(_isIndia ? 'District *' : 'District (optional)'),
//                         validator: (v) {
//                           if (_isIndia && (v == null || v.trim().isEmpty)) {
//                             return 'District is required for India';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 12),

//                       DropdownButtonFormField<String>(
//                         value: widget.statusOptions.contains(_status) ? _status : null,
//                         items: widget.statusOptions
//                             .map((s) => DropdownMenuItem<String>(value: s, child: Text(s)))
//                             .toList(),
//                         onChanged: _onStatusChanged,
//                         decoration: _dec('Status *'),
//                         validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
//                       ),
//                       const SizedBox(height: 12),

//                       InkWell(
//                         onTap: _status == 'Completed' ? _pickCompletion : null,
//                         borderRadius: BorderRadius.circular(10),
//                         child: InputDecorator(
//                           decoration: _dec('Completion Date').copyWith(enabled: _status == 'Completed'),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   _fmt(_completion),
//                                   style: TextStyle(
//                                     color: _status == 'Completed'
//                                         ? cs.onSurface
//                                         : cs.onSurfaceVariant,
//                                   ),
//                                 ),
//                               ),
//                               Icon(
//                                 Icons.calendar_today,
//                                 size: 18,
//                                 color: _status == 'Completed'
//                                     ? cs.onSurfaceVariant
//                                     : cs.onSurfaceVariant.withOpacity(0.6),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),

//                       TextFormField(
//                         controller: _remarksCtrl,
//                         decoration: _dec('Remarks'),
//                         maxLines: 2,
//                       ),

//                       const SizedBox(height: 16),
//                       Row(
//                         children: [
//                           const Spacer(),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context, null),
//                             child: const Text('CANCEL'),
//                           ),
//                           const SizedBox(width: 8),
//                           FilledButton(
//                             style: FilledButton.styleFrom(
//                               backgroundColor: AppTheme.accentColor,
//                               foregroundColor: Colors.black,
//                             ),
//                             onPressed: () {
//                               if (!_formKey.currentState!.validate()) return;

//                               if (_status == 'Completed' && _completion == null) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(
//                                     content: Text('Completion Date is required when Status is Completed.'),
//                                   ),
//                                 );
//                                 return;
//                               }

//                               final updated = widget.site.copyWith(
//                                 address: _addressCtrl.text.trim(),
//                                 pincode: _pincodeCtrl.text.trim(),
//                                 poc: _pocCtrl.text.trim(),
//                                 country: _country ?? widget.site.country,
//                                 state: _state ?? widget.site.state,
//                                 district: _districtCtrl.text.trim(),
//                                 city: _city ?? widget.site.city,
//                                 status: _status ?? widget.site.status,
//                                 completionDate: (_completion == null) ? '' : _fmt(_completion),
//                                 remarks: _remarksCtrl.text.trim(),
//                               );
//                               Navigator.pop(context, updated);
//                             },
//                             child: const Text('UPDATE'),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




////
import 'package:flutter/material.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:pmgt/core/theme.dart';
import '../Sites/view_sites_screen.dart' show Site;

class UpdateSiteModal extends StatefulWidget {
  final Site site;
  final List<String> subProjects;
  final List<String> statusOptions;

  const UpdateSiteModal({
    super.key,
    required this.site,
    required this.subProjects,
    required this.statusOptions,
  });

  static Future<Site?> show(
    BuildContext context, {
    required Site site,
    required List<String> subProjects,
    required List<String> statusOptions,
  }) {
    return showModalBottomSheet<Site?>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: UpdateSiteModal(
          site: site,
          subProjects: subProjects,
          statusOptions: statusOptions,
        ),
      ),
    );
  }

  @override
  State<UpdateSiteModal> createState() => _UpdateSiteModalState();
}

class _UpdateSiteModalState extends State<UpdateSiteModal> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _addressCtrl;
  late final TextEditingController _pincodeCtrl;
  late final TextEditingController _pocCtrl;
  late final TextEditingController _districtCtrl;
  late final TextEditingController _remarksCtrl;

  String? _status;
  String? _country;
  String? _state;
  String? _city;
  DateTime? _completion;

  bool get _isIndia => (_country ?? '').trim().toLowerCase() == 'india';

  @override
  void initState() {
    super.initState();
    final s = widget.site;
    _addressCtrl = TextEditingController(text: s.address);
    _pincodeCtrl = TextEditingController(text: s.pincode);
    _pocCtrl = TextEditingController(text: s.poc);
    _districtCtrl = TextEditingController(text: s.district);
    _remarksCtrl = TextEditingController(text: s.remarks == '—' ? '' : s.remarks);
    _status = s.status;
    _country = s.country;
    _state = s.state;
    _city = s.city;
    _completion = _parseDdmmyyyy(s.completionDate);
  }

  DateTime? _parseDdmmyyyy(String? ddmmyyyy) {
    if (ddmmyyyy == null || ddmmyyyy.trim().isEmpty || ddmmyyyy == '—') return null;
    final sep = ddmmyyyy.contains('/') ? '/' : '-';
    final p = ddmmyyyy.split(sep);
    if (p.length != 3) return null;
    final d = int.tryParse(p[0]), m = int.tryParse(p[1]), y = int.tryParse(p[2]);
    if (d == null || m == null || y == null) return null;
    return DateTime(y, m, d);
  }

  String _fmt(DateTime? d) {
    if (d == null) return 'Select date';
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yy = d.year.toString();
    return '$dd/$mm/$yy';
  }

  Future<void> _pickCompletion() async {
    if (_status != 'Completed') return;
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _completion ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
      builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
    );
    if (picked != null) setState(() => _completion = picked);
  }

  InputDecoration _dec(String label) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: cs.surfaceContainerHighest,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _readOnlyField(String label, String value) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  value.isEmpty ? '—' : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: cs.onSurface),
                ),
              ),
              Text('Read-only', style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontStyle: FontStyle.italic)),
            ],
          ),
        ),
      ],
    );
  }

  void _onStatusChanged(String? v) {
    setState(() {
      _status = v;
      if (_status == 'Completed') {
        _completion ??= DateTime.now();
      } else {
        _completion = null;
      }
    });
  }

  @override
  void dispose() {
    _addressCtrl.dispose();
    _pincodeCtrl.dispose();
    _pocCtrl.dispose();
    _districtCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      minimum: const EdgeInsets.only(top: 17),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Update Site',
                      style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: cs.onSurface)),
                ),
                IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context, null)),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      _readOnlyField('Project (read-only)', widget.site.project),
                      const SizedBox(height: 12),
                      _readOnlyField('Sub Project (read-only)', widget.site.subProject),
                      const SizedBox(height: 12),
                      _readOnlyField('Site Name (read-only)', widget.site.siteName),
                      const SizedBox(height: 12),
                      _readOnlyField('Site ID (read-only)', widget.site.siteId),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _addressCtrl,
                        decoration: _dec('Address *'),
                        maxLines: 2,
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _pincodeCtrl,
                        decoration: _dec('Pincode *'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _pocCtrl,
                        decoration: _dec('POC *'),
                        validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      CSCPickerPlus(
                        layout: Layout.vertical,
                        showStates: true,
                        showCities: true,
                        flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
                        dropdownDecoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: cs.outlineVariant),
                        ),
                        disabledDropdownDecoration: BoxDecoration(
                          color: cs.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: cs.outlineVariant),
                        ),
                        countryDropdownLabel: "Country",
                        stateDropdownLabel: "State / Region",
                        cityDropdownLabel: "City",
                        currentCountry: _country,
                        currentState: _state,
                        currentCity: _city,
                        onCountryChanged: (v) => setState(() {
                          _country = v;
                          _state = null;
                          _city = null;
                          if (!_isIndia) _districtCtrl.clear();
                        }),
                        onStateChanged: (v) => setState(() {
                          _state = v;
                          _city = null;
                          if (_isIndia) _districtCtrl.clear();
                        }),
                        onCityChanged: (v) => setState(() => _city = v),
                      ),
                      const SizedBox(height: 10),

                      TextFormField(
                        controller: _districtCtrl,
                        decoration: _dec(_isIndia ? 'District *' : 'District (optional)'),
                        validator: (v) {
                          if (_isIndia && (v == null || v.trim().isEmpty)) {
                            return 'District is required for India';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),

                      DropdownButtonFormField<String>(
                        value: widget.statusOptions.contains(_status) ? _status : null,
                        items: widget.statusOptions
                            .map((s) => DropdownMenuItem<String>(value: s, child: Text(s)))
                            .toList(),
                        onChanged: _onStatusChanged,
                        decoration: _dec('Status *'),
                        validator: (v) => (v == null || v.isEmpty) ? 'Required' : null,
                      ),
                      const SizedBox(height: 12),

                      InkWell(
                        onTap: _status == 'Completed' ? _pickCompletion : null,
                        borderRadius: BorderRadius.circular(10),
                        child: InputDecorator(
                          decoration: _dec('Completion Date').copyWith(enabled: _status == 'Completed'),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _fmt(_completion),
                                  style: TextStyle(
                                    color: _status == 'Completed' ? cs.onSurface : cs.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              Icon(Icons.calendar_today, size: 18,
                                  color: _status == 'Completed'
                                      ? cs.onSurfaceVariant
                                      : cs.onSurfaceVariant.withOpacity(0.6)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: _remarksCtrl,
                        decoration: _dec('Remarks'),
                        maxLines: 2,
                      ),

                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton(onPressed: () => Navigator.pop(context, null), child: const Text('CANCEL')),
                          const SizedBox(width: 8),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.accentColor,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) return;
                              if (_status == 'Completed' && _completion == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Completion Date is required when Status is Completed.')),
                                );
                                return;
                              }
                              final updated = widget.site.copyWith(
                                address: _addressCtrl.text.trim(),
                                pincode: _pincodeCtrl.text.trim(),
                                poc: _pocCtrl.text.trim(),
                                country: _country ?? widget.site.country,
                                state: _state ?? widget.site.state,
                                district: _districtCtrl.text.trim(),
                                city: _city ?? widget.site.city,
                                status: _status ?? widget.site.status,
                                completionDate: (_completion == null) ? '' : _fmt(_completion),
                                remarks: _remarksCtrl.text.trim(),
                              );
                              Navigator.pop(context, updated);
                            },
                            child: const Text('UPDATE'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
