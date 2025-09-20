// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';

// class AddActivityScreen extends StatelessWidget {
//   const AddActivityScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add Activity',
//       centerTitle: true,
//       // We’re opening this as a separate page; keep the nav visible but don’t switch tabs here.
//       currentIndex: 0,
//       onTabChanged: (_) {},

//       // SafeArea is handled by the AppBar; turning it off avoids extra top padding.
//       safeArea: false,
//       reserveBottomPadding: true,

//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           Card(
//             color: cs.surfaceVariant,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),

//             ),
//             child: const SizedBox(height: 180), // empty card placeholder
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  // --- Controllers (readonly fields are still controllers so Clear works) ---
  final _ticketNoCtrl = TextEditingController(text: 'npci-001'); // example
  final _stateCtrl = TextEditingController(text: 'Maharashtra');
  final _districtCtrl = TextEditingController(text: 'Thane');
  final _cityCtrl = TextEditingController(text: 'Panvel');
  final _addressCtrl = TextEditingController(text: 'XYZ');
  final _siteIdCtrl = TextEditingController(text: '001');
  final _pmCtrl = TextEditingController(text: 'Amey');
  final _vendorCtrl = TextEditingController(text: '—');
  final _feMobileCtrl = TextEditingController(text: '—');
  final _remarksCtrl = TextEditingController();
  final _statusCtrl = TextEditingController(text: 'Open');

  // dropdowns
  String? _project;
  String? _siteName;
  String? _feName;
  String? _nocEngineer;
  String? _activityCategory;

  // dates
  DateTime _date = DateTime.now();
  DateTime? _completionDate;

  // sample dropdown data
  final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
  final _siteNames = const ['ABCS', 'ABCD', 'HQ-01'];
  final _feNames = const ['Rahul', 'Priya', 'Meera'];
  final _nocEngineers = const ['Nikhil', 'Shreya', 'Aman'];
  final _activityCategories = const [
    'Breakdown',
    'Install',
    'Audit',
    'Maintenance',
  ];

  @override
  void dispose() {
    _ticketNoCtrl.dispose();
    _stateCtrl.dispose();
    _districtCtrl.dispose();
    _cityCtrl.dispose();
    _addressCtrl.dispose();
    _siteIdCtrl.dispose();
    _pmCtrl.dispose();
    _vendorCtrl.dispose();
    _feMobileCtrl.dispose();
    _remarksCtrl.dispose();
    _statusCtrl.dispose();
    super.dispose();
  }

  void _clearAll() {
    setState(() {
      _ticketNoCtrl.text = '';
      _stateCtrl.text = '';
      _districtCtrl.text = '';
      _cityCtrl.text = '';
      _addressCtrl.text = '';
      _siteIdCtrl.text = '';
      _pmCtrl.text = '';
      _vendorCtrl.text = '';
      _feMobileCtrl.text = '';
      _remarksCtrl.clear();
      _statusCtrl.text = 'Open';

      _project = null;
      _siteName = null;
      _feName = null;
      _nocEngineer = null;
      _activityCategory = null;

      _date = DateTime.now();
      _completionDate = null;
    });
  }

  Future<void> _pickDate({required bool isCompletion}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isCompletion ? (_completionDate ?? DateTime.now()) : _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (ctx, child) {
        // Keep picker on-brand
        return Theme(data: Theme.of(context), child: child!);
      },
    );
    if (picked != null) {
      setState(() {
        if (isCompletion) {
          _completionDate = picked;
        } else {
          _date = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: '',
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
          onPressed: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
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
          Card(
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header row
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Create New Activity',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _clearAll,
                        child: const Text('CLEAR'),
                      ),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  // Fields (responsive two columns)
                  LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 640; // break point
                      final columnGap = isWide ? 12.0 : 0.0;

                      final left = [
                        _ROText('Ticket No *', _ticketNoCtrl),
                        _Dropdown<String>(
                          label: 'Project *',
                          value: _project,
                          items: _projects,
                          onChanged: (v) => setState(() => _project = v),
                        ),
                        _ROText('State *', _stateCtrl),
                        _ROText('City *', _cityCtrl),
                        _Dropdown<String>(
                          label: 'Site Name *',
                          value: _siteName,
                          items: _siteNames,
                          onChanged: (v) => setState(() => _siteName = v),
                        ),
                        _ROText('Project Manager *', _pmCtrl),
                        _Dropdown<String>(
                          label: 'FE Name',
                          value: _feName,
                          items: _feNames,
                          onChanged: (v) => setState(() => _feName = v),
                        ),
                        _Dropdown<String>(
                          label: 'NOC Engineer',
                          value: _nocEngineer,
                          items: _nocEngineers,
                          onChanged: (v) => setState(() => _nocEngineer = v),
                        ),
                        _DateField(
                          label: 'Completion Date',
                          date: _completionDate,
                          onTap: () => _pickDate(isCompletion: true),
                        ),
                      ];

                      final right = [
                        _DateField(
                          label: 'Date *',
                          date: _date,
                          onTap: () => _pickDate(isCompletion: false),
                        ),
                        _Dropdown<String>(
                          label: 'Activity Category *',
                          value: _activityCategory,
                          items: _activityCategories,
                          onChanged:
                              (v) => setState(() => _activityCategory = v),
                        ),
                        _ROText('District *', _districtCtrl),
                        _ROText('Address *', _addressCtrl),
                        _ROText('Site Id *', _siteIdCtrl),
                        _ROText('Vendor', _vendorCtrl),
                        _ROText('FE Mobile', _feMobileCtrl),
                        _Multiline(label: 'Remarks', controller: _remarksCtrl),
                        _ROText('Status', _statusCtrl), // defaults to Open
                      ];

                      if (!isWide) {
                        return Column(
                          children: [
                            ...left,
                            ...right,
                            const SizedBox(height: 12),
                          ],
                        );
                      }

                      // Two columns on wide
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Column(children: left)),
                          SizedBox(width: columnGap),
                          Expanded(child: Column(children: right)),
                        ],
                      );
                    },
                  ),

                  // const SizedBox(height: 12),
                  const SizedBox(height: 12),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [_CreateButton(onPressed: _onCreate)],
                  // ),
                  _CreateButton(onPressed: _onCreate),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onCreate() {
    // TODO: Add submit logic / validation / API call
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Create tapped')));
  }
}

// === Small UI helpers ========================================================

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

class _ROText extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _ROText(this.label, this.controller);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        enabled: false,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          hintText: 'Read-only',
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
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
  final ValueChanged<T?> onChanged;
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            iconEnabledColor: cs.onSurfaceVariant,
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            style: TextStyle(color: cs.onSurface, fontSize: 14),
            items:
                items
                    .map(
                      (e) => DropdownMenuItem<T>(value: e, child: Text('$e')),
                    )
                    .toList(),
            hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  const _DateField({
    required this.label,
    required this.date,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text =
        date == null
            ? 'Select date'
            : '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}';
    return _FieldShell(
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: date == null ? cs.onSurfaceVariant : cs.onSurface,
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

class _Multiline extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _Multiline({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          hintText: 'Enter $label',
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.accentColor),
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

// class _CreateButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   const _CreateButton({required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppTheme.accentColor,
//         foregroundColor: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       child: const Text(
//         'CREATE',
//         style: TextStyle(fontWeight: FontWeight.w800),
//       ),
//     );
//   }
// }

class _CreateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _CreateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // full width like Save/Add
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'CREATE',
          style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5),
        ),
      ),
    );
  }
}
