// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';


// class AddProjectScreen extends StatefulWidget {
//   const AddProjectScreen({super.key});

//   @override
//   State<AddProjectScreen> createState() => _AddProjectScreenState();
// }

// class _AddProjectScreenState extends State<AddProjectScreen> {
//   // --- Controllers ---
//   final _projectCodeCtrl = TextEditingController(text: 'AUTO-001'); // readonly
//   final _projectNameCtrl = TextEditingController();

//   DateTime? _startDate;
//   DateTime? _endDate;

//   // dropdown values
//   String? _customer;
//   String? _projectType;
//   String? _projectManager;
//   String? _bdm;
//   String? _amcYear;
//   String? _amcMonths;

//   // sample dropdown data (replace with real data)
//   final _customers = const ['ACME Corp', 'Globex', 'Initech', 'Umbrella'];
//   final _types = const ['Implementation', 'AMC', 'Upgrade', 'POC'];
//   final _managers = const ['Amey', 'Priya', 'Nikhil', 'Shreya'];
//   final _bdms = const ['Rahul', 'Meera', 'Aman'];
//   final _years = const ['1', '2', '3', '4', '5'];
//   final _months = const ['0', '3', '6', '9', '12'];

//   @override
//   void dispose() {
//     _projectCodeCtrl.dispose();
//     _projectNameCtrl.dispose();
//     super.dispose();
//   }

//   void _clearAll() {
//     setState(() {
//       _customer = null;
//       _projectType = null;
//       _projectManager = null;
//       _bdm = null;
//       _amcYear = null;
//       _amcMonths = null;

//       _projectNameCtrl.clear();
//       _projectCodeCtrl.text = 'AUTO-001';
//       _startDate = null;
//       _endDate = null;
//     });
//   }

//   Future<void> _pickDate({required bool isStart}) async {
//     final now = DateTime.now();
//     final init = isStart ? (_startDate ?? now) : (_endDate ?? now);
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: init,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStart) {
//           _startDate = picked;
//           if (_endDate != null && _endDate!.isBefore(_startDate!)) {
//             _endDate = _startDate;
//           }
//         } else {
//           _endDate = picked;
//         }
//       });
//     }
//   }

//   void _handleTabChange(BuildContext context, int i) {
//   if (i == 1) return; // already on Add Project
//   late final Widget target;
//   switch (i) {
//     case 0: target = const DashboardScreen();    break;
//     case 2: target = const AddActivityScreen();  break;
//     case 3: target = const AnalyticsScreen();    break;
//     case 4: target = const ViewUsersScreen();    break;
//     default: return;
//   }
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (_) => target),
//   );
// }


//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add Project',
//       centerTitle: true,
//       // currentIndex: 0,
//       // onTabChanged: (_) {},
//       currentIndex: 1,                                  
//       onTabChanged: (i) => _handleTabChange(context, i), 
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
//           Card(
//             color: cs.surfaceContainerHighest,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Header
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Add New Project',
//                           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 color: cs.onSurface,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                         ),
//                       ),
//                       TextButton(onPressed: _clearAll, child: const Text('Clear')),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   // Fields (responsive)
//                   LayoutBuilder(builder: (context, c) {
//                     final isWide = c.maxWidth >= 640;
//                     final gap = isWide ? 12.0 : 0.0;

//                     final left = <Widget>[
//                       _Dropdown<String>(
//                         label: 'Customer Name*',
//                         value: _customer,
//                         items: _customers,
//                         onChanged: (v) => setState(() => _customer = v),
//                       ),
//                       _TextOneLine(label: 'Project Name*', controller: _projectNameCtrl),
//                       _Dropdown<String>(
//                         label: 'Project Manager*',
//                         value: _projectManager,
//                         items: _managers,
//                         onChanged: (v) => setState(() => _projectManager = v),
//                       ),
//                       _DateField(
//                         label: 'Start Date*',
//                         date: _startDate,
//                         onTap: () => _pickDate(isStart: true),
//                       ),
//                       _Dropdown<String>(
//                         label: 'AMC Year',
//                         value: _amcYear,
//                         items: _years,
//                         onChanged: (v) => setState(() => _amcYear = v),
//                       ),
//                     ];

//                     final right = <Widget>[
//                       _ROText('Project Code*', _projectCodeCtrl),
//                       _Dropdown<String>(
//                         label: 'Project Type*',
//                         value: _projectType,
//                         items: _types,
//                         onChanged: (v) => setState(() => _projectType = v),
//                       ),
//                       _Dropdown<String>(
//                         label: 'BDM',
//                         value: _bdm,
//                         items: _bdms,
//                         onChanged: (v) => setState(() => _bdm = v),
//                       ),
//                       _DateField(
//                         label: 'End Date*',
//                         date: _endDate,
//                         onTap: () => _pickDate(isStart: false),
//                       ),
//                       _Dropdown<String>(
//                         label: 'AMC Months',
//                         value: _amcMonths,
//                         items: _months,
//                         onChanged: (v) => setState(() => _amcMonths = v),
//                       ),
//                     ];

//                     if (!isWide) {
//                       return Column(children: [...left, ...right]);
//                     }

//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(child: Column(children: left)),
//                         SizedBox(width: gap),
//                         Expanded(child: Column(children: right)),
//                       ],
//                     );
//                   }),

//                   const SizedBox(height: 12),

//                   // Save button: right on wide, full-width on narrow
//                   LayoutBuilder(
//                     builder: (context, c) => c.maxWidth >= 640
//                         ? Align(
//                             alignment: Alignment.centerRight,
//                             child: _SaveButton(onPressed: _onSave),
//                           )
//                         : _SaveButton(onPressed: _onSave),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onSave() {
//     // TODO: validate + send to backend
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Project saved')),
//     );
//   }
// }

// /// ---------- Small UI helpers (same style as Add Activity) ----------

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

// class _TextOneLine extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _TextOneLine({required this.label, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           hintText: 'Enter $label',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppTheme.accentColor),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
//           hintText: 'Read-only',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
//           color: cs.surfaceContainerHighest,
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
//                 .map((e) =>
//                     DropdownMenuItem<T>(value: e, child: Text('$e')))
//                 .toList(),
//             hint:
//                 Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DateField extends StatelessWidget {
//   final String label;
//   final DateTime? date;
//   final VoidCallback onTap;
//   const _DateField({required this.label, required this.date, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final text = date == null
//         ? 'Select date'
//         : '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}';
//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   text,
//                   style: TextStyle(
//                     color: date == null ? cs.onSurfaceVariant : cs.onSurface,
//                   ),
//                 ),
//               ),
//               Icon(Icons.calendar_today_rounded,
//                   size: 18, color: cs.onSurfaceVariant),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SaveButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   const _SaveButton({required this.onPressed});

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
//       child: const Text('SAVE', style: TextStyle(fontWeight: FontWeight.w800)),
//     );
//   }
// }
  

  import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';

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

  // Sub-projects
  final List<String> _subProjects = [];

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
      _subProjects.clear();

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

  void _handleTabChange(BuildContext context, int i) {
    if (i == 1) return; // already on Add Project
    late final Widget target;
    switch (i) {
      case 0:
        target = const DashboardScreen();
        break;
      case 2:
        target = const AddActivityScreen();
        break;
      case 3:
        target = const AnalyticsScreen();
        break;
      case 4:
        target = const ViewUsersScreen();
        break;
      default:
        return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add Project',
      centerTitle: true,
      currentIndex: 1,
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
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
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

                  // === ORDERED FIELDS ===

                  _Dropdown<String>(
                    label: 'Customer Name*',
                    value: _customer,
                    items: _customers,
                    onChanged: (v) => setState(() => _customer = v),
                  ),

                  _TextOneLine(label: 'Project Name*', controller: _projectNameCtrl),

                  _ROText('Project Code*', _projectCodeCtrl),

                  // ---- Sub Projects section ----
                  _SubProjectsSection(
                    projects: _subProjects,
                    onAdd: _addOrEditSubProject,
                    onEdit: (i) => _addOrEditSubProject(editIndex: i),
                    onRemove: (i) => setState(() => _subProjects.removeAt(i)),
                  ),

                  _Dropdown<String>(
                    label: 'Project Manager*',
                    value: _projectManager,
                    items: _managers,
                    onChanged: (v) => setState(() => _projectManager = v),
                  ),

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

                  // Dates side-by-side on wide screens
                  // LayoutBuilder(builder: (context, c) {
                  //   final wide = c.maxWidth > 560;
                  //   final children = [
                  //     Expanded(
                  //       child: _DateField(
                  //         label: 'Start Date*',
                  //         date: _startDate,
                  //         onTap: () => _pickDate(isStart: true),
                  //       ),
                  //     ),
                  //     if (wide) const SizedBox(width: 12) else const SizedBox(height: 0),
                  //     Expanded(
                  //       child: _DateField(
                  //         label: 'End Date*',
                  //         date: _endDate,
                  //         onTap: () => _pickDate(isStart: false),
                  //       ),
                  //     ),
                  //   ];
                  //   return wide ? Row(crossAxisAlignment: CrossAxisAlignment.start, children: children)
                  //               : Column(children: children);
                  // }),

  LayoutBuilder(builder: (context, c) {
  final wide = c.maxWidth > 560;

  final start = _DateField(
    label: 'Start Date*',
    date: _startDate,
    onTap: () => _pickDate(isStart: true),
  );
  final end = _DateField(
    label: 'End Date*',
    date: _endDate,
    onTap: () => _pickDate(isStart: false),
  );

  if (wide) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: start),
        const SizedBox(width: 12),
        Expanded(child: end),
      ],
    );
  }

  // Narrow: no Expanded in a Column (avoids unbounded height error)
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      start,
      const SizedBox(height: 6),
      end,
    ],
  );
}),
                  _Dropdown<String>(
                    label: 'AMC Year',
                    value: _amcYear,
                    items: _years,
                    onChanged: (v) => setState(() => _amcYear = v),
                  ),

                  _Dropdown<String>(
                    label: 'AMC Months',
                    value: _amcMonths,
                    items: _months,
                    onChanged: (v) => setState(() => _amcMonths = v),
                  ),

                  const SizedBox(height: 12),

                  // Save button: right on wide, full-width on narrow
                  LayoutBuilder(
                    builder: (context, c) => c.maxWidth >= 640
                        ? Align(alignment: Alignment.centerRight, child: _SaveButton(onPressed: _onSave))
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

  // Add/Edit a single sub-project via dialog
  Future<void> _addOrEditSubProject({int? editIndex}) async {
    final controller = TextEditingController(text: editIndex != null ? _subProjects[editIndex] : '');
    final cs = Theme.of(context).colorScheme;

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Theme.of(ctx).colorScheme.surface,
        title: Text(editIndex == null ? 'Add Sub Project' : 'Edit Sub Project'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            labelText: 'Sub Project Name',
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppTheme.accentColor)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('CANCEL')),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.accentColor,
              foregroundColor: Colors.black,
            ),
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text(editIndex == null ? 'ADD' : 'SAVE'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      setState(() {
        if (editIndex == null) {
          _subProjects.add(result);
        } else {
          _subProjects[editIndex] = result;
        }
      });
    }
  }

  void _onSave() {
    // TODO: validate + send to backend (including _subProjects list)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Project saved')),
    );
  }
}

/// ---------- Sub Projects Section ----------
class _SubProjectsSection extends StatelessWidget {
  final List<String> projects;
  final VoidCallback onAdd;
  final void Function(int index) onEdit;
  final void Function(int index) onRemove;

  const _SubProjectsSection({
    required this.projects,
    required this.onAdd,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Row header
          Row(
            children: [
              Expanded(
                child: Text(
                  'Sub Projects (optional)',
                  style: TextStyle(
                    fontSize: 12,
                    color: cs.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton.icon(
                onPressed: onAdd,
                icon: const Icon(Icons.add_circle_outline),
                label: const Text('Add Sub Project'),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cs.outlineVariant),
            ),
            child: projects.isEmpty
                ? Text('No sub projects added.',
                    style: TextStyle(color: cs.onSurfaceVariant))
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      for (int i = 0; i < projects.length; i++)
                        _SubProjectChip(
                          label: projects[i],
                          onEdit: () => onEdit(i),
                          onRemove: () => onRemove(i),
                        ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _SubProjectChip extends StatelessWidget {
  final String label;
  final VoidCallback onEdit;
  final VoidCallback onRemove;
  const _SubProjectChip({
    required this.label,
    required this.onEdit,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: cs.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: onEdit,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: TextStyle(color: cs.onSurface)),
              const SizedBox(width: 6),
              InkWell(
                onTap: onRemove,
                borderRadius: BorderRadius.circular(16),
                child: Icon(Icons.close, size: 16, color: cs.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
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
            borderSide: const BorderSide(color: AppTheme.accentColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
                .map((e) => DropdownMenuItem<T>(value: e, child: Text('$e')))
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
              Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
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
