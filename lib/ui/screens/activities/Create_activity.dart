// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../core/theme.dart'; // for AppTheme.accentColor (optional)

// // ========== PAGE WITHOUT APP BAR / BOTTOM BAR ==========
// // You can embed this page anywhere; it only shows the card.

// class CreateTicketPage extends StatefulWidget {
//   const CreateTicketPage({super.key});
//   @override
//   State<CreateTicketPage> createState() => _CreateTicketPageState();
// }

// class _CreateTicketPageState extends State<CreateTicketPage> {
//   @override
//   Widget build(BuildContext context) {
//     final bottomGap = 16.0 + MediaQuery.of(context).padding.bottom;
//     return SafeArea(
//       child: ListView(
//         padding: EdgeInsets.fromLTRB(16, 16, 16, bottomGap),
//         children: const [
//           CreateTicketCard(),
//         ],
//       ),
//     );
//   }
// }

// // ========== THE CARD (all logic lives here) ==========

// class CreateTicketCard extends StatefulWidget {
//   const CreateTicketCard({super.key});
//   @override
//   State<CreateTicketCard> createState() => _CreateTicketCardState();
// }

// class _CreateTicketCardState extends State<CreateTicketCard> {
//   final _formKey = GlobalKey<FormState>();

//   // controllers
//   final _ticketNoC = TextEditingController();
//   final _dateC = TextEditingController();
//   final _stateC = TextEditingController();
//   final _districtC = TextEditingController();
//   final _cityC = TextEditingController();
//   final _addressC = TextEditingController();
//   final _siteIdC = TextEditingController();
//   final _pmC = TextEditingController();
//   final _vendorC = TextEditingController();
//   final _feMobileC = TextEditingController();
//   final _remarksC = TextEditingController();
//   final _completionDateC = TextEditingController();
//   final _statusC = TextEditingController(text: 'Open');

//   DateTime? _date;
//   DateTime? _completionDate;

//   // dropdown selections
//   String? _project;
//   String? _activityCat;
//   String? _siteName;
//   String? _feName;
//   String? _nocEngineer;

//   // sample data
//   final _rng = Random();
//   final List<String> _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
//   final List<String> _activityCats = const ['Breakdown', 'Installation', 'Maintenance', 'Audit'];
//   final List<String> _feNames = const ['Amit Shah', 'Riya Kulkarni', 'Sameer Patil', 'Priya Mehta'];
//   final List<String> _nocEngineers = const ['Amey', 'Dev', 'Kavya', 'NoC Team A'];

//   final Map<String, Map<String, String>> _siteMeta = const {
//     'ABCS': {
//       'siteId': '001',
//       'state': 'Maharashtra',
//       'district': 'Thane',
//       'city': 'Panvel',
//       'address': 'XYZ',
//       'project': 'NPCI',
//       'pm': 'Amey',
//       'vendor': 'hshsh',
//     },
//     'EON': {
//       'siteId': '042',
//       'state': 'Maharashtra',
//       'district': 'Pune',
//       'city': 'Kharadi',
//       'address': 'Eon IT Park',
//       'project': 'BPCL Aruba WIFI',
//       'pm': 'Mukund',
//       'vendor': 'Acenet',
//     },
//     'HLT-7': {
//       'siteId': '219',
//       'state': 'Karnataka',
//       'district': 'Bengaluru Urban',
//       'city': 'Bengaluru',
//       'address': 'HSR Layout',
//       'project': 'TelstraApari',
//       'pm': 'Rachit',
//       'vendor': 'NetServe',
//     },
//   };

//   final Map<String, String> _feMobiles = const {
//     'Amit Shah': '9820000001',
//     'Riya Kulkarni': '9820000002',
//     'Sameer Patil': '9820000003',
//     'Priya Mehta': '9820000004',
//   };

//   @override
//   void initState() {
//     super.initState();
//     _generateTicketNo();
//     _setDate(DateTime.now());
//   }

//   @override
//   void dispose() {
//     _ticketNoC.dispose();
//     _dateC.dispose();
//     _stateC.dispose();
//     _districtC.dispose();
//     _cityC.dispose();
//     _addressC.dispose();
//     _siteIdC.dispose();
//     _pmC.dispose();
//     _vendorC.dispose();
//     _feMobileC.dispose();
//     _remarksC.dispose();
//     _completionDateC.dispose();
//     _statusC.dispose();
//     super.dispose();
//   }

//   // helpers
//   void _generateTicketNo() => _ticketNoC.text = 'npci-${100 + _rng.nextInt(900)}';
//   void _setDate(DateTime d) => _dateC.text = DateFormat('dd/MM/yyyy').format(_date = d);
//   void _setCompletionDate(DateTime d) =>
//       _completionDateC.text = DateFormat('dd/MM/yyyy').format(_completionDate = d);

//   Future<void> _pickDate({required bool isCompletion}) async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: isCompletion ? (_completionDate ?? now) : (_date ?? now),
//       firstDate: DateTime(now.year - 5),
//       lastDate: DateTime(now.year + 5),
//       helpText: isCompletion ? 'Select Completion Date' : 'Select Date',
//     );
//     if (picked != null) {
//       setState(() => isCompletion ? _setCompletionDate(picked) : _setDate(picked));
//     }
//   }

//   void _onSiteChanged(String? site) {
//     setState(() {
//       _siteName = site;
//       if (site != null && _siteMeta.containsKey(site)) {
//         final m = _siteMeta[site]!;
//         _siteIdC.text = m['siteId'] ?? '';
//         _stateC.text = m['state'] ?? '';
//         _districtC.text = m['district'] ?? '';
//         _cityC.text = m['city'] ?? '';
//         _addressC.text = m['address'] ?? '';
//         _project = m['project'];
//         _pmC.text = m['pm'] ?? '';
//         _vendorC.text = m['vendor'] ?? '';
//       } else {
//         _siteIdC.clear();
//         _stateC.clear();
//         _districtC.clear();
//         _cityC.clear();
//         _addressC.clear();
//       }
//     });
//   }

//   void _onFeChanged(String? fe) {
//     setState(() {
//       _feName = fe;
//       _feMobileC.text = fe != null ? (_feMobiles[fe] ?? '') : '';
//     });
//   }

//   void _clearAll() {
//     _formKey.currentState?.reset();
//     _project = null;
//     _activityCat = null;
//     _siteName = null;
//     _feName = null;
//     _nocEngineer = null;

//     for (final c in [
//       _stateC,
//       _districtC,
//       _cityC,
//       _addressC,
//       _siteIdC,
//       _pmC,
//       _vendorC,
//       _feMobileC,
//       _remarksC,
//       _completionDateC,
//     ]) {
//       c.clear();
//     }
//     _statusC.text = 'Open';
//     _setDate(DateTime.now());
//     _completionDate = null;
//     _generateTicketNo();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     OutlineInputBorder _b(Color c, [double w = 1]) =>
//         OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

//     InputDecoration _decoration(String label) => InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           enabledBorder: _b(cs.outline),
//           disabledBorder: _b(cs.outlineVariant),
//           focusedBorder: _b(AppTheme.accentColor, 1.4),
//           border: _b(cs.outline),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         );

//     Widget _textField({
//       required String label,
//       required TextEditingController controller,
//       int maxLines = 1,
//       String? Function(String?)? validator,
//       bool readOnly = false,
//       VoidCallback? onTap,
//     }) {
//       return TextFormField(
//         controller: controller,
//         maxLines: maxLines,
//         readOnly: readOnly,
//         onTap: onTap,
//         validator: validator,
//         style: TextStyle(color: cs.onSurface, fontSize: 13),
//         decoration: _decoration(label),
//       );
//     }

//     Widget _roField(String label, TextEditingController c) =>
//         _textField(label: label, controller: c, readOnly: true);

//     Widget _dateField(String label, TextEditingController c, VoidCallback pick) {
//       return TextFormField(
//         controller: c,
//         readOnly: true,
//         style: TextStyle(color: cs.onSurface, fontSize: 13),
//         decoration: _decoration(label).copyWith(
//           suffixIcon: Icon(Icons.calendar_today_outlined, color: cs.onSurfaceVariant, size: 18),
//         ),
//         onTap: pick,
//         validator: (v) => (label.contains('*') && (v == null || v.isEmpty)) ? 'Select date' : null,
//       );
//     }

//     Widget _dropdownField<T>({
//       required String label,
//       required List<T> items,
//       required ValueChanged<T?> onChanged,
//       T? value,
//       String? Function(T?)? validator,
//     }) {
//       return DropdownButtonFormField<T>(
//         value: value,
//         items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
//         onChanged: onChanged,
//         validator: validator,
//         style: TextStyle(color: cs.onSurface, fontSize: 13),
//         dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//         iconEnabledColor: cs.onSurfaceVariant,
//         decoration: _decoration(label),
//       );
//     }

//     return Card(
//       color: cs.surfaceContainerHighest,
//       elevation: 1,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: BorderSide(color: cs.outlineVariant),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // header
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       'Create New Activity',
//                       style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                             color: cs.onSurface,
//                             fontWeight: FontWeight.w800,
//                           ),
//                     ),
//                   ),
//                   TextButton(onPressed: _clearAll, child: const Text('CLEAR')),
//                 ],
//               ),
//               Divider(color: cs.outlineVariant),
//               const SizedBox(height: 8),

//               // two-column grid
//               LayoutBuilder(
//                 builder: (context, c) {
//                   final isTwoCol = c.maxWidth >= 520;
//                   const spacing = 10.0;
//                   final double itemW = isTwoCol ? (c.maxWidth - spacing) / 2 : c.maxWidth;

//                   Widget cell(Widget child) => SizedBox(width: itemW, child: child);

//                   return Wrap(
//                     spacing: spacing,
//                     runSpacing: 10,
//                     children: [
//                       cell(_roField('Ticket No *', _ticketNoC)),
//                       cell(_dateField('Date *', _dateC, () => _pickDate(isCompletion: false))),

//                       cell(_dropdownField<String>(
//                         label: 'Project *',
//                         value: _project,
//                         items: _projects,
//                         onChanged: (v) => setState(() => _project = v),
//                         validator: (v) => v == null ? 'Select project' : null,
//                       )),
//                       cell(_dropdownField<String>(
//                         label: 'Activity Category *',
//                         value: _activityCat,
//                         items: _activityCats,
//                         onChanged: (v) => setState(() => _activityCat = v),
//                         validator: (v) => v == null ? 'Select activity category' : null,
//                       )),

//                       cell(_roField('State *', _stateC)),
//                       cell(_roField('District *', _districtC)),

//                       cell(_roField('City *', _cityC)),
//                       cell(_roField('Address *', _addressC)),

//                       cell(_dropdownField<String>(
//                         label: 'Site Name *',
//                         value: _siteName,
//                         items: _siteMeta.keys.toList(),
//                         onChanged: _onSiteChanged,
//                         validator: (v) => v == null ? 'Select site' : null,
//                       )),
//                       cell(_roField('Site Id *', _siteIdC)),

//                       cell(_roField('Project Manager *', _pmC)),
//                       cell(_roField('Vendor', _vendorC)),

//                       cell(_dropdownField<String>(
//                         label: 'FE Name',
//                         value: _feName,
//                         items: _feNames,
//                         onChanged: _onFeChanged,
//                       )),
//                       cell(_roField('FE Mobile', _feMobileC)),

//                       cell(_dropdownField<String>(
//                         label: 'Noc Engineer',
//                         value: _nocEngineer,
//                         items: _nocEngineers,
//                         onChanged: (v) => setState(() => _nocEngineer = v),
//                       )),
//                       cell(_textField(label: 'Remarks', controller: _remarksC, maxLines: 3)),

//                       cell(_dateField('Completion Date', _completionDateC, () => _pickDate(isCompletion: true))),
//                       cell(_roField('Status', _statusC)),
//                     ],
//                   );
//                 },
//               ),

//               const SizedBox(height: 16),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.accentColor,
//                     foregroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                   ),
//                   onPressed: _onCreatePressed,
//                   child: const Text('CREATE', style: TextStyle(fontWeight: FontWeight.w700)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onCreatePressed() {
//     if (!_formKey.currentState!.validate()) return;

//     final payload = {
//       'ticketNo': _ticketNoC.text,
//       'date': _dateC.text,
//       'project': _project,
//       'activityCategory': _activityCat,
//       'state': _stateC.text,
//       'district': _districtC.text,
//       'city': _cityC.text,
//       'address': _addressC.text,
//       'siteName': _siteName,
//       'siteId': _siteIdC.text,
//       'projectManager': _pmC.text,
//       'vendor': _vendorC.text,
//       'feName': _feName,
//       'feMobile': _feMobileC.text,
//       'nocEngineer': _nocEngineer,
//       'remarks': _remarksC.text,
//       'completionDate': _completionDateC.text,
//       'status': _statusC.text,
//     };

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text('Created: ${payload['ticketNo']}')),
//     );
//   }
// }


import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../../ui/widgets/app_appbar.dart';           // AppAppBar(title: ...)
import '../../widgets/app_drawer.dart';            // Drawer
import '../../widgets/custom_bottom_nav_bar.dart'; // Bottom nav

/// ================= PAGE (AppBar + Drawer + BottomNav) =================
class CreateActivityScreen extends StatefulWidget {
  const CreateActivityScreen({super.key});
  @override
  State<CreateActivityScreen> createState() => _CreateActivityScreenState();
}

class _CreateActivityScreenState extends State<CreateActivityScreen> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final pad = responsivePadding(context);
    final bottomGap = CustomBottomNavBar.barHeight +
        MediaQuery.of(context).padding.bottom +
        12;

    return Scaffold(
      extendBody: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const AppDrawer(),
      appBar: const AppAppBar(title: 'Add Ticket'),
      body: SafeArea(
        child: IndexedStack(
          index: _tabIndex,
          children: [
            // TAB 0 — Add Ticket (the card you want visible)
            AntiOverflowScroll(
              child: MaxWidth(
                child: Padding(
                  padding: pad.copyWith(bottom: bottomGap),
                  child: const _CreateTicketCard(),
                ),
              ),
            ),

            // The other tabs (placeholders so switching doesn't return SizedBox.shrink)
            Center(
              child: Text(
                'Projects',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                'Analytics',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Center(
              child: Text(
                'Users',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
      ),
    );
  }
}

/// ======================== THE CARD CONTENT ============================
class _CreateTicketCard extends StatefulWidget {
  const _CreateTicketCard();

  @override
  State<_CreateTicketCard> createState() => _CreateTicketCardState();
}

class _CreateTicketCardState extends State<_CreateTicketCard> {
  final _formKey = GlobalKey<FormState>();

  // controllers
  final _ticketNoC = TextEditingController();
  final _dateC = TextEditingController();
  final _stateC = TextEditingController();
  final _districtC = TextEditingController();
  final _cityC = TextEditingController();
  final _addressC = TextEditingController();
  final _siteIdC = TextEditingController();
  final _pmC = TextEditingController();
  final _vendorC = TextEditingController();
  final _feMobileC = TextEditingController();
  final _remarksC = TextEditingController();
  final _completionDateC = TextEditingController();
  final _statusC = TextEditingController(text: 'Open');

  DateTime? _date;
  DateTime? _completionDate;

  // dropdowns
  String? _project;
  String? _activityCat;
  String? _siteName;
  String? _feName;
  String? _nocEngineer;

  // sample data
  final _rng = Random();
  final List<String> _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
  final List<String> _activityCats = const ['Breakdown', 'Installation', 'Maintenance', 'Audit'];
  final List<String> _feNames = const ['Amit Shah', 'Riya Kulkarni', 'Sameer Patil', 'Priya Mehta'];
  final List<String> _nocEngineers = const ['Amey', 'Dev', 'Kavya', 'NoC Team A'];

  final Map<String, Map<String, String>> _siteMeta = const {
    'ABCS': {
      'siteId': '001',
      'state': 'Maharashtra',
      'district': 'Thane',
      'city': 'Panvel',
      'address': 'XYZ',
      'project': 'NPCI',
      'pm': 'Amey',
      'vendor': 'hshsh',
    },
    'EON': {
      'siteId': '042',
      'state': 'Maharashtra',
      'district': 'Pune',
      'city': 'Kharadi',
      'address': 'Eon IT Park',
      'project': 'BPCL Aruba WIFI',
      'pm': 'Mukund',
      'vendor': 'Acenet',
    },
    'HLT-7': {
      'siteId': '219',
      'state': 'Karnataka',
      'district': 'Bengaluru Urban',
      'city': 'Bengaluru',
      'address': 'HSR Layout',
      'project': 'TelstraApari',
      'pm': 'Rachit',
      'vendor': 'NetServe',
    },
  };

  final Map<String, String> _feMobiles = const {
    'Amit Shah': '9820000001',
    'Riya Kulkarni': '9820000002',
    'Sameer Patil': '9820000003',
    'Priya Mehta': '9820000004',
  };

  @override
  void initState() {
    super.initState();
    _generateTicketNo();
    _setDate(DateTime.now());
  }

  @override
  void dispose() {
    _ticketNoC.dispose();
    _dateC.dispose();
    _stateC.dispose();
    _districtC.dispose();
    _cityC.dispose();
    _addressC.dispose();
    _siteIdC.dispose();
    _pmC.dispose();
    _vendorC.dispose();
    _feMobileC.dispose();
    _remarksC.dispose();
    _completionDateC.dispose();
    _statusC.dispose();
    super.dispose();
  }

  // helpers
  void _generateTicketNo() => _ticketNoC.text = 'npci-${100 + _rng.nextInt(900)}';
  void _setDate(DateTime d) => _dateC.text = DateFormat('dd/MM/yyyy').format(_date = d);
  void _setCompletionDate(DateTime d) =>
      _completionDateC.text = DateFormat('dd/MM/yyyy').format(_completionDate = d);

  Future<void> _pickDate({required bool isCompletion}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: isCompletion ? (_completionDate ?? now) : (_date ?? now),
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
      helpText: isCompletion ? 'Select Completion Date' : 'Select Date',
    );
    if (picked != null) setState(() => isCompletion ? _setCompletionDate(picked) : _setDate(picked));
  }

  void _onSiteChanged(String? site) {
    setState(() {
      _siteName = site;
      if (site != null && _siteMeta.containsKey(site)) {
        final m = _siteMeta[site]!;
        _siteIdC.text = m['siteId'] ?? '';
        _stateC.text = m['state'] ?? '';
        _districtC.text = m['district'] ?? '';
        _cityC.text = m['city'] ?? '';
        _addressC.text = m['address'] ?? '';
        _project = m['project'];
        _pmC.text = m['pm'] ?? '';
        _vendorC.text = m['vendor'] ?? '';
      } else {
        _siteIdC.clear();
        _stateC.clear();
        _districtC.clear();
        _cityC.clear();
        _addressC.clear();
      }
    });
  }

  void _onFeChanged(String? fe) {
    setState(() {
      _feName = fe;
      _feMobileC.text = fe != null ? (_feMobiles[fe] ?? '') : '';
    });
  }

  void _clearAll() {
    _formKey.currentState?.reset();
    _project = null;
    _activityCat = null;
    _siteName = null;
    _feName = null;
    _nocEngineer = null;
    for (final c in [
      _stateC,
      _districtC,
      _cityC,
      _addressC,
      _siteIdC,
      _pmC,
      _vendorC,
      _feMobileC,
      _remarksC,
      _completionDateC,
    ]) {
      c.clear();
    }
    _statusC.text = 'Open';
    _setDate(DateTime.now());
    _completionDate = null;
    _generateTicketNo();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    OutlineInputBorder _b(Color c, [double w = 1]) =>
        OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: c, width: w));

    InputDecoration _decoration(String label) => InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          enabledBorder: _b(cs.outline),
          disabledBorder: _b(cs.outlineVariant),
          focusedBorder: _b(AppTheme.accentColor, 1.4),
          border: _b(cs.outline),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        );

    Widget _textField({
      required String label,
      required TextEditingController controller,
      int maxLines = 1,
      String? Function(String?)? validator,
      bool readOnly = false,
      VoidCallback? onTap,
    }) {
      return TextFormField(
        controller: controller,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
        style: TextStyle(color: cs.onSurface, fontSize: 13),
        decoration: _decoration(label),
      );
    }

    Widget _roField(String label, TextEditingController c) =>
        _textField(label: label, controller: c, readOnly: true);

    Widget _dateField(String label, TextEditingController c, VoidCallback pick) {
      return TextFormField(
        controller: c,
        readOnly: true,
        style: TextStyle(color: cs.onSurface, fontSize: 13),
        decoration: _decoration(label).copyWith(
          suffixIcon: Icon(Icons.calendar_today_outlined, color: cs.onSurfaceVariant, size: 18),
        ),
        onTap: pick,
        validator: (v) => (label.contains('*') && (v == null || v.isEmpty)) ? 'Select date' : null,
      );
    }

    Widget _dropdownField<T>({
      required String label,
      required List<T> items,
      required ValueChanged<T?> onChanged,
      T? value,
      String? Function(T?)? validator,
    }) {
      return DropdownButtonFormField<T>(
        value: value,
        items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
        onChanged: onChanged,
        validator: validator,
        style: TextStyle(color: cs.onSurface, fontSize: 13),
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        iconEnabledColor: cs.onSurfaceVariant,
        decoration: _decoration(label),
      );
    }

    return Card(
      color: cs.surfaceContainerHighest,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Create New Activity',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  ),
                  TextButton(onPressed: _clearAll, child: const Text('CLEAR')),
                ],
              ),
              Divider(color: cs.outlineVariant),
              const SizedBox(height: 8),

              // responsive two-column layout
              LayoutBuilder(
                builder: (context, c) {
                  final isTwoCol = c.maxWidth >= 520;
                  const spacing = 10.0;
                  final double itemW = isTwoCol ? (c.maxWidth - spacing) / 2 : c.maxWidth;
                  Widget cell(Widget child) => SizedBox(width: itemW, child: child);

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 10,
                    children: [
                      cell(_roField('Ticket No *', _ticketNoC)),
                      cell(_dateField('Date *', _dateC, () => _pickDate(isCompletion: false))),
                      cell(_dropdownField<String>(
                        label: 'Project *',
                        value: _project,
                        items: _projects,
                        onChanged: (v) => setState(() => _project = v),
                        validator: (v) => v == null ? 'Select project' : null,
                      )),
                      cell(_dropdownField<String>(
                        label: 'Activity Category *',
                        value: _activityCat,
                        items: _activityCats,
                        onChanged: (v) => setState(() => _activityCat = v),
                        validator: (v) => v == null ? 'Select activity category' : null,
                      )),
                      cell(_roField('State *', _stateC)),
                      cell(_roField('District *', _districtC)),
                      cell(_roField('City *', _cityC)),
                      cell(_roField('Address *', _addressC)),
                      cell(_dropdownField<String>(
                        label: 'Site Name *',
                        value: _siteName,
                        items: _siteMeta.keys.toList(),
                        onChanged: _onSiteChanged,
                        validator: (v) => v == null ? 'Select site' : null,
                      )),
                      cell(_roField('Site Id *', _siteIdC)),
                      cell(_roField('Project Manager *', _pmC)),
                      cell(_roField('Vendor', _vendorC)),
                      cell(_dropdownField<String>(
                        label: 'FE Name',
                        value: _feName,
                        items: _feNames,
                        onChanged: _onFeChanged,
                      )),
                      cell(_roField('FE Mobile', _feMobileC)),
                      cell(_dropdownField<String>(
                        label: 'Noc Engineer',
                        value: _nocEngineer,
                        items: _nocEngineers,
                        onChanged: (v) => setState(() => _nocEngineer = v),
                      )),
                      cell(_textField(label: 'Remarks', controller: _remarksC, maxLines: 3)),
                      cell(_dateField('Completion Date', _completionDateC, () => _pickDate(isCompletion: true))),
                      cell(_roField('Status', _statusC)),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _onCreatePressed,
                  child: const Text('CREATE', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCreatePressed() {
    if (!_formKey.currentState!.validate()) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Created: ${_ticketNoC.text}')),
    );
  }
}
