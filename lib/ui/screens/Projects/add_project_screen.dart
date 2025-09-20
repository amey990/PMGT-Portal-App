import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  // --- Controllers ---
  final _projectCodeCtrl = TextEditingController(text: 'AUTO-001'); // readonly
  final _projectNameCtrl = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;

  // dropdown values
  String? _customer;
  String? _projectType;
  String? _projectManager;
  String? _bdm;
  String? _amcYear;
  String? _amcMonths;

  // sample dropdown data (replace with real data)
  final _customers = const ['ACME Corp', 'Globex', 'Initech', 'Umbrella'];
  final _types = const ['Implementation', 'AMC', 'Upgrade', 'POC'];
  final _managers = const ['Amey', 'Priya', 'Nikhil', 'Shreya'];
  final _bdms = const ['Rahul', 'Meera', 'Aman'];
  final _years = const ['1', '2', '3', '4', '5'];
  final _months = const ['0', '3', '6', '9', '12'];

  @override
  void dispose() {
    _projectCodeCtrl.dispose();
    _projectNameCtrl.dispose();
    super.dispose();
  }

  void _clearAll() {
    setState(() {
      _customer = null;
      _projectType = null;
      _projectManager = null;
      _bdm = null;
      _amcYear = null;
      _amcMonths = null;

      _projectNameCtrl.clear();
      _projectCodeCtrl.text = 'AUTO-001';
      _startDate = null;
      _endDate = null;
    });
  }

  Future<void> _pickDate({required bool isStart}) async {
    final now = DateTime.now();
    final init = isStart ? (_startDate ?? now) : (_endDate ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(_startDate!)) {
            _endDate = _startDate;
          }
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add Project',
      centerTitle: true,
      currentIndex: 0,
      onTabChanged: (_) {},
      safeArea: false,
      reserveBottomPadding: true,
      actions: [
        IconButton(
          tooltip: Theme.of(context).brightness == Brightness.dark
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
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
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
            color: cs.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add New Project',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      TextButton(onPressed: _clearAll, child: const Text('Clear')),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  // Fields (responsive)
                  LayoutBuilder(builder: (context, c) {
                    final isWide = c.maxWidth >= 640;
                    final gap = isWide ? 12.0 : 0.0;

                    final left = <Widget>[
                      _Dropdown<String>(
                        label: 'Customer Name*',
                        value: _customer,
                        items: _customers,
                        onChanged: (v) => setState(() => _customer = v),
                      ),
                      _TextOneLine(label: 'Project Name*', controller: _projectNameCtrl),
                      _Dropdown<String>(
                        label: 'Project Manager*',
                        value: _projectManager,
                        items: _managers,
                        onChanged: (v) => setState(() => _projectManager = v),
                      ),
                      _DateField(
                        label: 'Start Date*',
                        date: _startDate,
                        onTap: () => _pickDate(isStart: true),
                      ),
                      _Dropdown<String>(
                        label: 'AMC Year',
                        value: _amcYear,
                        items: _years,
                        onChanged: (v) => setState(() => _amcYear = v),
                      ),
                    ];

                    final right = <Widget>[
                      _ROText('Project Code*', _projectCodeCtrl),
                      _Dropdown<String>(
                        label: 'Project Type*',
                        value: _projectType,
                        items: _types,
                        onChanged: (v) => setState(() => _projectType = v),
                      ),
                      _Dropdown<String>(
                        label: 'BDM',
                        value: _bdm,
                        items: _bdms,
                        onChanged: (v) => setState(() => _bdm = v),
                      ),
                      _DateField(
                        label: 'End Date*',
                        date: _endDate,
                        onTap: () => _pickDate(isStart: false),
                      ),
                      _Dropdown<String>(
                        label: 'AMC Months',
                        value: _amcMonths,
                        items: _months,
                        onChanged: (v) => setState(() => _amcMonths = v),
                      ),
                    ];

                    if (!isWide) {
                      return Column(children: [...left, ...right]);
                    }

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Column(children: left)),
                        SizedBox(width: gap),
                        Expanded(child: Column(children: right)),
                      ],
                    );
                  }),

                  const SizedBox(height: 12),

                  // Save button: right on wide, full-width on narrow
                  LayoutBuilder(
                    builder: (context, c) => c.maxWidth >= 640
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: _SaveButton(onPressed: _onSave),
                          )
                        : _SaveButton(onPressed: _onSave),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onSave() {
    // TODO: validate + send to backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project saved')),
    );
  }
}

/// ---------- Small UI helpers (same style as Add Activity) ----------

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

class _TextOneLine extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _TextOneLine({required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
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
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
            items: items
                .map((e) =>
                    DropdownMenuItem<T>(value: e, child: Text('$e')))
                .toList(),
            hint:
                Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
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
  const _DateField({required this.label, required this.date, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final text = date == null
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
              Icon(Icons.calendar_today_rounded,
                  size: 18, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _SaveButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.accentColor,
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.w800)),
    );
  }
}
  