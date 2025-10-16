// import 'package:flutter/material.dart';
// import 'package:csc_picker_plus/csc_picker_plus.dart';
// import '../../../core/theme.dart';
// import '../dashboard/dashboard_screen.dart' show Activity;

// class UpdateActivityModal extends StatefulWidget {
//   final Activity activity;

//   // Dynamic lists to feed dropdowns (bind your API data here)
//   final List<String> subProjects;
//   final List<String> siteNames;
//   final List<String> feNames;
//   final List<String> nocEngineers;

//   /// Callback when user taps UPDATE
//   final void Function(Activity updated) onSubmit;

//   /// Callback when user taps DELETE
//   final VoidCallback? onDelete;

//   const UpdateActivityModal({
//     super.key,
//     required this.activity,
//     required this.subProjects,
//     required this.siteNames,
//     required this.feNames,
//     required this.nocEngineers,
//     required this.onSubmit,
//     this.onDelete,
//   });

//   static Future<void> show(
//     BuildContext context, {
//     required Activity activity,
//     required List<String> subProjects,
//     required List<String> siteNames,
//     required List<String> feNames,
//     required List<String> nocEngineers,
//     required void Function(Activity updated) onSubmit,
//     VoidCallback? onDelete,
//   }) {
//     return showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder: (ctx) => Padding(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(ctx).viewInsets.bottom,
//         ),
//         child: UpdateActivityModal(
//           activity: activity,
//           subProjects: subProjects,
//           siteNames: siteNames,
//           feNames: feNames,
//           nocEngineers: nocEngineers,
//           onSubmit: onSubmit,
//           onDelete: onDelete,
//         ),
//       ),
//     );
//   }

//   @override
//   State<UpdateActivityModal> createState() => _UpdateActivityModalState();
// }

// class _UpdateActivityModalState extends State<UpdateActivityModal> {
//   final _formKey = GlobalKey<FormState>();

//   // Readonly / initial fields
//   late final TextEditingController _ticketNoCtrl;
//   late final TextEditingController _projectCtrl;
//   late final TextEditingController _siteIdCtrl; // maps to a.siteCode
//   late final TextEditingController _pmCtrl;
//   late final TextEditingController _vendorCtrl;
//   late final TextEditingController _addressCtrl;
//   late final TextEditingController _feMobileCtrl;

//   // Editable
//   late DateTime? _scheduledDate;
//   late DateTime? _completionDate;

//   String? _subProject;
//   String? _activityCategory;
//   String? _siteName;

//   // Country hierarchy
//   String? _country;
//   String? _state;
//   String? _city;
//   final TextEditingController _districtCtrl = TextEditingController();

//   String? _feName;
//   String? _nocEngineer;
//   String? _status;
//   final TextEditingController _remarksCtrl = TextEditingController();


//   // Fixed options
//   static const _activityCategories = <String>[
//     'Breakdown',
//     'New Installation',
//     'Upgrades',
//     'Corrective Maintenance',
//     'Preventive Maintenance',
//     'Revisit',
//     'Site Survey',
//   ];

//   static const _statusOptions = <String>[
//     'Open',
//     'Completed',
//     'Canceled',
//     'Pending',
//     'In Progress',
//     'Reschedule',
//   ];
  

//   @override
//   void initState() {
//     super.initState();

//     final a = widget.activity;

//     _ticketNoCtrl = TextEditingController(text: a.ticketNo ?? '');
//     _projectCtrl = TextEditingController(text: a.project ?? '');
//     _siteIdCtrl = TextEditingController(text: a.siteCode ?? '');
//     _pmCtrl = TextEditingController(text: a.projectManager ?? '');
//     _vendorCtrl = TextEditingController(text: a.vendorFe ?? '');
//     _addressCtrl = TextEditingController(text: a.address ?? '');
//     _feMobileCtrl = TextEditingController(text: a.feVendorMobile ?? '');

//     _scheduledDate = _parseDate(a.scheduledDate);
//     _completionDate = _parseDate(a.completionDate);

//     _subProject = a.subProject;
//     _activityCategory = a.activity; // map activity to category
//     _siteName = a.siteName;

//     _country = a.country;
//     _state = a.state;
//     _city = a.city;
//     _districtCtrl.text = a.district ?? '';

//     _feName = a.feVendorName;
//     _nocEngineer = a.nocEngineer;
//     _status = a.status;
//     _remarksCtrl.text = a.remarks ?? '';
//   }

//   DateTime? _parseDate(String? ddmmyyyyOrDashes) {
//     if (ddmmyyyyOrDashes == null || ddmmyyyyOrDashes.trim().isEmpty) return null;
//     final s = ddmmyyyyOrDashes.replaceAll('-', '/');
//     final parts = s.split('/');
//     if (parts.length != 3) return null;
//     // Heuristics: if first part > 12 we assume dd/mm/yyyy
//     try {
//       int p0 = int.parse(parts[0]);
//       int p1 = int.parse(parts[1]);
//       int p2 = int.parse(parts[2]);
//       if (p0 > 12) {
//         // dd/mm/yyyy
//         return DateTime(p2, p1, p0);
//       } else {
//         // mm/dd/yyyy or dd/mm/yyyy – assume dd/mm/yyyy like your UI
//         return DateTime(p2, p1, p0);
//       }
//     } catch (_) {
//       return null;
//     }
//   }

//   String _fmt(DateTime? d) {
//     if (d == null) return '';
//     final dd = d.day.toString().padLeft(2, '0');
//     final mm = d.month.toString().padLeft(2, '0');
//     final yyyy = d.year.toString();
//     return '$dd/$mm/$yyyy';
//   }

//   @override
//   void dispose() {
//     _ticketNoCtrl.dispose();
//     _projectCtrl.dispose();
//     _siteIdCtrl.dispose();
//     _pmCtrl.dispose();
//     _vendorCtrl.dispose();
//     _addressCtrl.dispose();
//     _feMobileCtrl.dispose();
//     _districtCtrl.dispose();
//     _remarksCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _pickDate({
//     required DateTime? initial,
//     required ValueChanged<DateTime?> onPicked,
//   }) async {
//     final now = DateTime.now();
//     final first = DateTime(now.year - 10);
//     final last = DateTime(now.year + 10);
//     final result = await showDatePicker(
//       context: context,
//       initialDate: initial ?? now,
//       firstDate: first,
//       lastDate: last,
//     );
//     if (result != null) onPicked(result);
//   }

//   // InputDecoration _dec(String label, {bool readOnly = false}) {
//   //   final cs = Theme.of(context).colorScheme;
//   //   return InputDecoration(
//   //     labelText: label,
//   //     filled: true,
//   //     fillColor: readOnly ? cs.surfaceContainerHigh : cs.surfaceContainerHighest,
//   //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//   //     contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//   //   );
//   // }

//   InputDecoration _dec(String label, {bool readOnly = false}) {
//   final cs = Theme.of(context).colorScheme;
//   return InputDecoration(
//     labelText: label,
//     filled: true,
//     fillColor: readOnly ? cs.surfaceContainerHigh : cs.surfaceContainerHighest,
//     border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)), // was 8
//     // NEW: more vertical padding -> taller fields, labels won’t look clipped
//     contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14), // was 10
//   );
// }


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
//                     'Update Activity',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w800,
//                       fontSize: 18,
//                       color: cs.onSurface,
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//               ],
//             ),
//             // const SizedBox(height: 8),

//             // Form
//             Flexible(
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                        const SizedBox(height: 20),
//                       // Row 1
//                       _row2(
//                         TextFormField(
//                           controller: _ticketNoCtrl,
//                           readOnly: true,
//                           decoration: _dec('Ticket No (read-only)', readOnly: true),
//                         ),
//                         _dateField(
//                           label: 'Scheduled Date',
//                           valueText: _fmt(_scheduledDate),
//                           onTap: () => _pickDate(
//                             initial: _scheduledDate,
//                             onPicked: (d) => setState(() => _scheduledDate = d),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       _row2(
//                         _dateField(
//                           label: 'Completion Date',
//                           valueText: _fmt(_completionDate),
//                           onTap: () => _pickDate(
//                             initial: _completionDate,
//                             onPicked: (d) => setState(() => _completionDate = d),
//                           ),
//                         ),
//                         TextFormField(
//                           controller: _projectCtrl,
//                           readOnly: true,
//                           decoration: _dec('Project (read-only)', readOnly: true),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       _row2(
//                         _drop(
//                           label: 'Sub Project',
//                           value: _subProject,
//                           items: widget.subProjects,
//                           onChanged: (v) => setState(() => _subProject = v),
//                         ),
                        
//                         _drop(
//                           label: 'Activity Category',
//                           value: _activityCategory,
//                           items: _activityCategories,
//                           onChanged: (v) => setState(() => _activityCategory = v),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       _row2(
//                         _drop(
//                           label: 'Site Name',
//                           value: _siteName,
//                           items: widget.siteNames,
//                           onChanged: (v) => setState(() => _siteName = v),
//                         ),
//                         TextFormField(
//                           controller: _siteIdCtrl,
//                           readOnly: true,
//                           decoration: _dec('Site ID (read-only)', readOnly: true),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       _row2(
//                         TextFormField(
//                           controller: _pmCtrl,
//                           readOnly: true,
//                           decoration: _dec('PM (read-only)', readOnly: true),
//                         ),
//                         TextFormField(
//                           controller: _vendorCtrl,
//                           readOnly: true,
//                           decoration: _dec('Vendor (read-only)', readOnly: true),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       // Country / State / City (with free-text District)
//                       _buildLocationPicker(cs),
//                       const SizedBox(height: 15),

//                       _row2(
//                         TextFormField(
//                           controller: _addressCtrl,
//                           readOnly: true,
//                           maxLines: 1,
//                           decoration: _dec('Address (read-only)', readOnly: true),
//                         ),
//                         _drop(
//                           label: 'FE Name',
//                           value: _feName,
//                           items: widget.feNames,
//                           onChanged: (v) => setState(() => _feName = v),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       _row2(
//                         TextFormField(
//                           controller: _feMobileCtrl,
//                           readOnly: true,
//                           decoration:
//                               _dec('FE Mobile (read-only)', readOnly: true),
//                         ),
//                         _drop(
//                           label: 'NOC Engineer',
//                           value: _nocEngineer,
//                           items: widget.nocEngineers,
//                           onChanged: (v) => setState(() => _nocEngineer = v),
//                         ),
//                       ),
//                       const SizedBox(height: 15),

//                       _row2(
//                         _drop(
//                           label: 'Status',
//                           value: _status,
//                           items: _statusOptions,
//                           onChanged: (v) => setState(() => _status = v),
//                         ),
//                         TextFormField(
//                           controller: _remarksCtrl,
//                           decoration: _dec('Remarks / Issue'),
//                           maxLines: 1,
//                         ),
//                       ),
//                       const SizedBox(height: 16),

//                       // Buttons
//                       Row(
//                         children: [
//                           if (widget.onDelete != null)
//                             OutlinedButton(
//                               style: OutlinedButton.styleFrom(
//                                 foregroundColor: Colors.redAccent,
//                                 side: const BorderSide(color: Colors.redAccent),
//                               ),
//                               onPressed: widget.onDelete,
//                               child: const Text('DELETE'),
//                             ),
//                           const Spacer(),
//                           TextButton(
//                             onPressed: () => Navigator.pop(context),
//                             child: const Text('CANCEL'),
//                           ),
//                           const SizedBox(width: 8),
//                           FilledButton(
//                             style: FilledButton.styleFrom(
//                               backgroundColor: AppTheme.accentColor,
//                               foregroundColor: Colors.black,
//                             ),
//                             onPressed: _handleSubmit,
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

//   // Reusable two-column row that collapses on small screens
//   Widget _row2(Widget left, Widget right) {
//     return LayoutBuilder(builder: (context, c) {
//       if (c.maxWidth < 560) {
//         return Column(
//           children: [
//             left,
//             const SizedBox(height: 10),
//             right,
//           ],
//         );
//       }
//       return Row(
//         children: [
//           Expanded(child: left),
//           const SizedBox(width: 12),
//           Expanded(child: right),
//         ],
//       );
//     });
//   }

//   Widget _drop({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     return DropdownButtonFormField<String>(
//       value: (value != null && items.contains(value)) ? value : null,
//       decoration: _dec(label),
//       items: items
//           .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
//           .toList(),
//       onChanged: onChanged,
//       validator: (v) => (v == null || v.isEmpty) ? 'Select $label' : null,
//     );
//   }

//   Widget _dateField({
//     required String label,
//     required String valueText,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: InputDecorator(
//         decoration: _dec(label),
//         child: Row(
//           children: [
//             Expanded(child: Text(valueText.isEmpty ? 'dd/mm/yyyy' : valueText)),
//             const Icon(Icons.calendar_today, size: 18),
//           ],
//         ),
//       ),
//     );
//   }

  
//  Widget _buildLocationPicker(ColorScheme cs) {
//   return Column(
//     children: [
//       const SizedBox(height: 10),
//       CSCPickerPlus(
//         layout: Layout.vertical,
//         showStates: true,
//         showCities: true,
//         flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,

//         dropdownDecoration: BoxDecoration(
//           color: cs.surfaceContainerHighest,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         disabledDropdownDecoration: BoxDecoration(
//           color: cs.surfaceContainerHigh,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),

//         countryDropdownLabel: "Country",
//         stateDropdownLabel: "State / Region",
//         cityDropdownLabel: "City",

//         currentCountry: _country,
//         currentState: _state,
//         currentCity: _city,

//         onCountryChanged: (v) => setState(() {
//           _country = v;
//           _state = null;
//           _city = null;
//         }),
//         onStateChanged: (v) => setState(() {
//           _state = v;
//           _city = null;
//         }),
//         onCityChanged: (v) => setState(() => _city = v),
//       ),
//       const SizedBox(height: 10),
//       TextFormField(
//         controller: _districtCtrl,
//         decoration: _dec('District (optional)'),
//       ),
//     ],
//   );
// }
//   void _handleSubmit() {
//     if (!_formKey.currentState!.validate()) return;

//     final updated = Activity(
//       ticketNo: _ticketNoCtrl.text,
//       scheduledDate: _fmt(_scheduledDate),
//       status: _status ?? widget.activity.status,
//       project: _projectCtrl.text,
//       subProject: _subProject ?? widget.activity.subProject,
//       siteName: _siteName ?? widget.activity.siteName,
//       siteCode: _siteIdCtrl.text, // Site ID (readonly)
//       activity: _activityCategory ?? widget.activity.activity,
//       projectManager: _pmCtrl.text,
//       vendorFe: _vendorCtrl.text,
//       feVendorName: _feName ?? widget.activity.feVendorName,
//       feVendorMobile: _feMobileCtrl.text,
//       nocEngineer: _nocEngineer ?? widget.activity.nocEngineer,
//       country: _country ?? widget.activity.country,
//       state: _state ?? widget.activity.state,
//       district: _districtCtrl.text.isEmpty
//           ? widget.activity.district
//           : _districtCtrl.text,
//       city: _city ?? widget.activity.city,
//       address: _addressCtrl.text,
//       completionDate: _fmt(_completionDate),
//       remarks: _remarksCtrl.text,
//     );

//     widget.onSubmit(updated);
//     Navigator.pop(context);
//   }
// }



import 'package:flutter/material.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';

import '../../../core/theme.dart';
import '../dashboard/dashboard_screen.dart' show Activity;

/// ---------------------------------------------------------------------------
/// Update Activity – styled to match your Projects modal.
/// Logic and field wiring are preserved; only presentation & open behavior
/// (bottom sheet, spacing, paddings, borders) were adjusted.
/// ---------------------------------------------------------------------------
class UpdateActivityModal extends StatefulWidget {
  final Activity activity;

  // Dynamic lists to feed dropdowns (bind your API data here)
  final List<String> subProjects;
  final List<String> siteNames;
  final List<String> feNames;
  final List<String> nocEngineers;

  /// Callback when user taps UPDATE
  final void Function(Activity updated) onSubmit;

  /// Callback when user taps DELETE
  final VoidCallback? onDelete;

  const UpdateActivityModal({
    super.key,
    required this.activity,
    required this.subProjects,
    required this.siteNames,
    required this.feNames,
    required this.nocEngineers,
    required this.onSubmit,
    this.onDelete,
  });

  /// Use this to open the modal with the Projects-style bottom sheet look.
  static Future<void> show(
    BuildContext context, {
    required Activity activity,
    required List<String> subProjects,
    required List<String> siteNames,
    required List<String> feNames,
    required List<String> nocEngineers,
    required void Function(Activity updated) onSubmit,
    VoidCallback? onDelete,
  }) {
    final cs = Theme.of(context).colorScheme;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => Padding(
        // lets the sheet float above the keyboard
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: UpdateActivityModal(
          activity: activity,
          subProjects: subProjects,
          siteNames: siteNames,
          feNames: feNames,
          nocEngineers: nocEngineers,
          onSubmit: onSubmit,
          onDelete: onDelete,
        ),
      ),
    );
  }

  @override
  State<UpdateActivityModal> createState() => _UpdateActivityModalState();
}

class _UpdateActivityModalState extends State<UpdateActivityModal> {
  final _formKey = GlobalKey<FormState>();

  // Read-only / initial fields
  late final TextEditingController _ticketNoCtrl;
  late final TextEditingController _projectCtrl;
  late final TextEditingController _siteIdCtrl; // maps to a.siteCode
  late final TextEditingController _pmCtrl;
  late final TextEditingController _vendorCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _feMobileCtrl;

  // Editable
  DateTime? _scheduledDate;
  DateTime? _completionDate;

  String? _subProject;
  String? _activityCategory;
  String? _siteName;

  // Country hierarchy
  String? _country;
  String? _state;
  String? _city;
  final TextEditingController _districtCtrl = TextEditingController();

  String? _feName;
  String? _nocEngineer;
  String? _status;
  final TextEditingController _remarksCtrl = TextEditingController();

  // Fixed options
  static const _activityCategories = <String>[
    'Breakdown',
    'New Installation',
    'Upgrades',
    'Corrective Maintenance',
    'Preventive Maintenance',
    'Revisit',
    'Site Survey',
  ];

  static const _statusOptions = <String>[
    'Open',
    'Completed',
    'Canceled',
    'Pending',
    'In Progress',
    'Reschedule',
  ];

  @override
  void initState() {
    super.initState();
    final a = widget.activity;

    _ticketNoCtrl = TextEditingController(text: a.ticketNo ?? '');
    _projectCtrl = TextEditingController(text: a.project ?? '');
    _siteIdCtrl = TextEditingController(text: a.siteCode ?? '');
    _pmCtrl = TextEditingController(text: a.projectManager ?? '');
    _vendorCtrl = TextEditingController(text: a.vendorFe ?? '');
    _addressCtrl = TextEditingController(text: a.address ?? '');
    _feMobileCtrl = TextEditingController(text: a.feVendorMobile ?? '');

    _scheduledDate = _parseDate(a.scheduledDate);
    _completionDate = _parseDate(a.completionDate);

    _subProject = a.subProject;
    _activityCategory = a.activity; // map activity to category
    _siteName = a.siteName;

    _country = a.country;
    _state = a.state;
    _city = a.city;
    _districtCtrl.text = a.district ?? '';

    _feName = a.feVendorName;
    _nocEngineer = a.nocEngineer;
    _status = a.status;
    _remarksCtrl.text = a.remarks ?? '';
  }

  DateTime? _parseDate(String? ddmmyyyyOrDashes) {
    if (ddmmyyyyOrDashes == null || ddmmyyyyOrDashes.trim().isEmpty) {
      return null;
    }
    final s = ddmmyyyyOrDashes.replaceAll('-', '/');
    final parts = s.split('/');
    if (parts.length != 3) return null;
    try {
      final d = int.parse(parts[0]);
      final m = int.parse(parts[1]);
      final y = int.parse(parts[2]);
      return DateTime(y, m, d);
    } catch (_) {
      return null;
    }
  }

  String _fmt(DateTime? d) {
    if (d == null) return '';
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd/$mm/$yyyy';
  }

  @override
  void dispose() {
    _ticketNoCtrl.dispose();
    _projectCtrl.dispose();
    _siteIdCtrl.dispose();
    _pmCtrl.dispose();
    _vendorCtrl.dispose();
    _addressCtrl.dispose();
    _feMobileCtrl.dispose();
    _districtCtrl.dispose();
    _remarksCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickDate({
    required DateTime? initial,
    required ValueChanged<DateTime?> onPicked,
  }) async {
    final now = DateTime.now();
    final first = DateTime(now.year - 10);
    final last = DateTime(now.year + 10);
    final result = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: first,
      lastDate: last,
    );
    if (result != null) onPicked(result);
  }

  // === Styling (kept consistent with Projects modal) ===
  InputDecoration _dec(String label, {bool readOnly = false}) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor: readOnly ? cs.surfaceContainerHigh : cs.surfaceContainerHighest,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
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
            // Header (matches Projects modal)
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Update Activity',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),

            // Body
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Row 1
                      _row2(
                        TextFormField(
                          controller: _ticketNoCtrl,
                          readOnly: true,
                          decoration:
                              _dec('Ticket No (read-only)', readOnly: true),
                        ),
                        _dateField(
                          label: 'Scheduled Date',
                          valueText: _fmt(_scheduledDate),
                          onTap: () => _pickDate(
                            initial: _scheduledDate,
                            onPicked: (d) => setState(() => _scheduledDate = d),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Row 2
                      _row2(
                        _dateField(
                          label: 'Completion Date',
                          valueText: _fmt(_completionDate),
                          onTap: () => _pickDate(
                            initial: _completionDate,
                            onPicked: (d) =>
                                setState(() => _completionDate = d),
                          ),
                        ),
                        TextFormField(
                          controller: _projectCtrl,
                          readOnly: true,
                          decoration:
                              _dec('Project (read-only)', readOnly: true),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Row 3
                      _row2(
                        _drop(
                          label: 'Sub Project',
                          value: _subProject,
                          items: widget.subProjects,
                          onChanged: (v) => setState(() => _subProject = v),
                        ),
                        _drop(
                          label: 'Activity Category',
                          value: _activityCategory,
                          items: _activityCategories,
                          onChanged: (v) =>
                              setState(() => _activityCategory = v),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Row 4
                      _row2(
                        _drop(
                          label: 'Site Name',
                          value: _siteName,
                          items: widget.siteNames,
                          onChanged: (v) => setState(() => _siteName = v),
                        ),
                        TextFormField(
                          controller: _siteIdCtrl,
                          readOnly: true,
                          decoration:
                              _dec('Site ID (read-only)', readOnly: true),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Row 5
                      _row2(
                        TextFormField(
                          controller: _pmCtrl,
                          readOnly: true,
                          decoration: _dec('PM (read-only)', readOnly: true),
                        ),
                        TextFormField(
                          controller: _vendorCtrl,
                          readOnly: true,
                          decoration:
                              _dec('Vendor (read-only)', readOnly: true),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Location (Country/State/City) + District
                      _buildLocationPicker(cs),
                      const SizedBox(height: 15),

                      // Row 6
                      _row2(
                        TextFormField(
                          controller: _addressCtrl,
                          readOnly: true,
                          maxLines: 1,
                          decoration:
                              _dec('Address (read-only)', readOnly: true),
                        ),
                        _drop(
                          label: 'FE Name',
                          value: _feName,
                          items: widget.feNames,
                          onChanged: (v) => setState(() => _feName = v),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Row 7
                      _row2(
                        TextFormField(
                          controller: _feMobileCtrl,
                          readOnly: true,
                          decoration:
                              _dec('FE Mobile (read-only)', readOnly: true),
                        ),
                        _drop(
                          label: 'NOC Engineer',
                          value: _nocEngineer,
                          items: widget.nocEngineers,
                          onChanged: (v) => setState(() => _nocEngineer = v),
                        ),
                      ),
                      const SizedBox(height: 15),

                      // Row 8
                      _row2(
                        _drop(
                          label: 'Status',
                          value: _status,
                          items: _statusOptions,
                          onChanged: (v) => setState(() => _status = v),
                        ),
                        TextFormField(
                          controller: _remarksCtrl,
                          decoration: _dec('Remarks / Issue'),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Buttons (Delete | Cancel | Update)
                      Row(
                        children: [
                          if (widget.onDelete != null)
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.redAccent,
                                side: const BorderSide(color: Colors.redAccent),
                              ),
                              onPressed: widget.onDelete,
                              child: const Text('DELETE'),
                            ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('CANCEL'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.accentColor,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: _handleSubmit,
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

  // Reusable 2-column row that collapses on small widths
  Widget _row2(Widget left, Widget right) {
    return LayoutBuilder(builder: (context, c) {
      if (c.maxWidth < 560) {
        return Column(
          children: [
            left,
            const SizedBox(height: 10),
            right,
          ],
        );
      }
      return Row(
        children: [
          Expanded(child: left),
          const SizedBox(width: 12),
          Expanded(child: right),
        ],
      );
    });
  }

  Widget _drop({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: (value != null && items.contains(value)) ? value : null,
      decoration: _dec(label),
      items: items
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList(),
      onChanged: onChanged,
      validator: (v) => (v == null || v.isEmpty) ? 'Select $label' : null,
    );
  }

  Widget _dateField({
    required String label,
    required String valueText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: _dec(label),
        child: Row(
          children: [
            Expanded(
              child: Text(valueText.isEmpty ? 'dd/mm/yyyy' : valueText),
            ),
            const Icon(Icons.calendar_today, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPicker(ColorScheme cs) {
    return Column(
      children: [
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
          }),
          onStateChanged: (v) => setState(() {
            _state = v;
            _city = null;
          }),
          onCityChanged: (v) => setState(() => _city = v),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _districtCtrl,
          decoration: _dec('District (optional)'),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final updated = Activity(
      ticketNo: _ticketNoCtrl.text,
      scheduledDate: _fmt(_scheduledDate),
      status: _status ?? widget.activity.status,
      project: _projectCtrl.text,
      subProject: _subProject ?? widget.activity.subProject,
      siteName: _siteName ?? widget.activity.siteName,
      siteCode: _siteIdCtrl.text, // Site ID (readonly)
      activity: _activityCategory ?? widget.activity.activity,
      projectManager: _pmCtrl.text,
      vendorFe: _vendorCtrl.text,
      feVendorName: _feName ?? widget.activity.feVendorName,
      feVendorMobile: _feMobileCtrl.text,
      nocEngineer: _nocEngineer ?? widget.activity.nocEngineer,
      country: _country ?? widget.activity.country,
      state: _state ?? widget.activity.state,
      district: _districtCtrl.text.isEmpty
          ? widget.activity.district
          : _districtCtrl.text,
      city: _city ?? widget.activity.city,
      address: _addressCtrl.text,
      completionDate: _fmt(_completionDate),
      remarks: _remarksCtrl.text,
    );

    widget.onSubmit(updated);
    Navigator.pop(context);
  }
}
