// // lib/ui/screens/reminders/reminders_screen.dart
// import 'package:flutter/material.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';
// // Bottom-nav root screens for routing
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// // ---------- Enum ----------
// enum ReminderType { team, personal }

// String _typeLabel(ReminderType t) =>
//     t == ReminderType.team ? 'Team' : 'Personal';

// // ---------- Screen ----------
// class RemindersScreen extends StatefulWidget {
//   const RemindersScreen({super.key});

//   @override
//   State<RemindersScreen> createState() => _RemindersScreenState();
// }

// class _RemindersScreenState extends State<RemindersScreen> {
//   int _modeIndex = 0;
//   // Create form fields
//   DateTime? _date;
//   TimeOfDay? _time;
//   String? _project;
//   ReminderType _createType = ReminderType.team;
//   final _descCtrl = TextEditingController();
//   // View filter toggle
//   ReminderType _viewType = ReminderType.team;

//   // Demo data (NOTICE: uses enum, not Strings)
//   final List<_Reminder> _reminders = [
//     _Reminder(
//       date: '23/07/2025',
//       time: '10:00',
//       project: 'NPCI',
//       description: 'Kick-off call with team',
//       type: ReminderType.team,
//     ),
//     _Reminder(
//       date: '24/07/2025',
//       time: '17:30',
//       project: 'BPCL Aruba WIFI',
//       description: 'Follow up with vendor',
//       type: ReminderType.personal,
//     ),
//   ];

//   final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];

//   @override
//   void dispose() {
//     _descCtrl.dispose();
//     super.dispose();
//   }

//   void _clearCreate() {
//     setState(() {
//       _date = null;
//       _time = null;
//       _project = null;
//       _createType = ReminderType.team;
//       _descCtrl.clear();
//     });
//   }

//   Future<void> _pickDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _date ?? now,
//       firstDate: DateTime(now.year - 1),
//       lastDate: DateTime(now.year + 3),
//     );
//     if (picked != null) {
//       setState(() => _date = picked);
//     }
//   }

//   Future<void> _pickTime() async {
//     final picked = await showTimePicker(
//       context: context,
//       initialTime: _time ?? TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() => _time = picked);
//     }
//   }

//   void _createReminder() {
//     if (_date == null ||
//         _time == null ||
//         _project == null ||
//         _descCtrl.text.trim().isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return;
//     }
//     final d =
//         '${_date!.day.toString().padLeft(2, '0')}/'
//         '${_date!.month.toString().padLeft(2, '0')}/'
//         '${_date!.year}';
//     final t = _time!.format(context);

//     setState(() {
//       _reminders.add(
//         _Reminder(
//           date: d,
//           time: t,
//           project: _project!,
//           description: _descCtrl.text.trim(),
//           type: _createType, // <-- enum
//         ),
//       );
//       _modeIndex = 1; // jump to View all
//     });

//     _clearCreate();
//   }

//   final int _selectedTab =
//       0; // 0 Dashboard, 1 Projects, 2 Add Activity, 3 Analytics, 4 Users

//   void _handleTabChange(int i) {
//     if (i == _selectedTab) return;
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break;
//       case 1:
//         target = const AddProjectScreen();
//         break;
//       case 2:
//         target = const AddActivityScreen();
//         break;
//       case 3:
//         target = const AnalyticsScreen();
//         break;
//       case 4:
//         target = const ViewUsersScreen();
//         break;
//       default:
//         return;
//     }
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Reminders',
//       centerTitle: true,
//       safeArea: false,
//       reserveBottomPadding: true,
//       // AppBar actions (same look/feel as other pages)
//       actions: [
//         IconButton(
//           tooltip:
//               Theme.of(context).brightness == Brightness.dark
//                   ? 'Light mode'
//                   : 'Dark mode',
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
//             Navigator.of(
//               context,
//             ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
//           icon: const ProfileAvatar(size: 36),

//         ),
//         const SizedBox(width: 8),
//       ],

//       currentIndex: _selectedTab,
//       onTabChanged: (i) => _handleTabChange(i),

//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           // Top mode switch: Create | View all
//           Center(
//             child: ToggleButtons(
//               isSelected: [_modeIndex == 0, _modeIndex == 1],
//               borderRadius: BorderRadius.circular(8),
//               constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
//               onPressed: (i) => setState(() => _modeIndex = i),
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text('Create'),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text('View all'),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),

//           if (_modeIndex == 0)
//             _buildCreateCard(context)
//           else
//             _buildViewAll(context),
//         ],
//       ),
//     );
//   }

//   // ---------------- Create card ----------------
//   Widget _buildCreateCard(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Create Reminder',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       color: cs.onSurface,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 TextButton(onPressed: _clearCreate, child: const Text('CLEAR')),
//               ],
//             ),
//             Divider(color: cs.outlineVariant),

//             // Two columns (responsive)
//             LayoutBuilder(
//               builder: (context, c) {
//                 final isWide = c.maxWidth >= 640;
//                 final gap = isWide ? 12.0 : 0.0;

//                 final left = [
//                   _FieldShell(
//                     label: 'Date *',
//                     child: _DateBox(
//                       text:
//                           _date == null
//                               ? 'Select date'
//                               : '${_date!.day.toString().padLeft(2, '0')}/'
//                                   '${_date!.month.toString().padLeft(2, '0')}/'
//                                   '${_date!.year}',
//                       icon: Icons.event,
//                       onTap: _pickDate,
//                     ),
//                   ),
//                   _FieldShell(
//                     label: 'Time *',
//                     child: _DateBox(
//                       text:
//                           _time == null
//                               ? 'Select time'
//                               : _time!.format(context),
//                       icon: Icons.access_time,
//                       onTap: _pickTime,
//                     ),
//                   ),
//                 ];

//                 final right = [
//                   _Dropdown<String>(
//                     label: 'Project *',
//                     value: _project,
//                     items: _projects,
//                     onChanged: (v) => setState(() => _project = v),
//                   ),
//                   _Dropdown<ReminderType>(
//                     label: 'Type *',
//                     value: _createType,
//                     items: const [ReminderType.team, ReminderType.personal],
//                     // IMPORTANT: the dropdown returns the enum
//                     onChanged:
//                         (v) => setState(
//                           () => _createType = v ?? ReminderType.team,
//                         ),
//                     itemLabel: _typeLabel,
//                   ),
//                 ];

//                 if (!isWide) {
//                   return Column(children: [...left, ...right]);
//                 }
//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(child: Column(children: left)),
//                     SizedBox(width: gap),
//                     Expanded(child: Column(children: right)),
//                   ],
//                 );
//               },
//             ),

//             _TextField(
//               label: 'Description *',
//               controller: _descCtrl,
//               maxLines: 3,
//             ),
//             const SizedBox(height: 8),

//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: _createReminder,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Create',
//                   style: TextStyle(fontWeight: FontWeight.w800),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- View all ----------------
//   Widget _buildViewAll(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     final list = _reminders.where((r) => r.type == _viewType).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Team / Personal toggle
//         Center(
//           child: ToggleButtons(
//             isSelected: [
//               _viewType == ReminderType.team,
//               _viewType == ReminderType.personal,
//             ],
//             borderRadius: BorderRadius.circular(20),
//             constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
//             onPressed:
//                 (i) => setState(() {
//                   _viewType =
//                       i == 0 ? ReminderType.team : ReminderType.personal;
//                 }),
//             children: const [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 child: Text('Team'),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 12),
//                 child: Text('Personal'),
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 12),

//         if (list.isEmpty)
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text(
//               'No reminders yet.',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: cs.onSurfaceVariant),
//             ),
//           )
//         else
//           ...list.map((r) => _ReminderCard(r: r)),
//       ],
//     );
//   }
// }

// // ---------- Model ----------
// class _Reminder {
//   final String date, time, project, description;
//   final ReminderType type; // <- enum

//   _Reminder({
//     required this.date,
//     required this.time,
//     required this.project,
//     required this.description,
//     required this.type,
//   });
// }

// // ---------- UI bits ----------
// class _ReminderCard extends StatelessWidget {
//   final _Reminder r;
//   const _ReminderCard({required this.r});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   r.date,
//                   style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   r.time,
//                   style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//             Divider(color: cs.outlineVariant),
//             const SizedBox(height: 4),
//             _kv('Project', r.project, context),
//             const SizedBox(height: 2),
//             _kv('Description', r.description, context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _kv(String k, String v, BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return RichText(
//       text: TextSpan(
//         text: '$k: ',
//         style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//         children: [
//           TextSpan(
//             text: v,
//             style: TextStyle(color: cs.onSurface, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

// class _DateBox extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   final VoidCallback onTap;
//   const _DateBox({required this.text, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         height: 48,
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//           color: cs.surface,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color:
//                       text.startsWith('Select')
//                           ? cs.onSurfaceVariant
//                           : cs.onSurface,
//                 ),
//               ),
//             ),
//             Icon(icon, color: cs.onSurfaceVariant),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _TextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final int maxLines;
//   const _TextField({
//     required this.label,
//     required this.controller,
//     this.maxLines = 1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surface,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppTheme.accentColor),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 12,
//           ),
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
//   final String Function(T)? itemLabel;

//   const _Dropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.itemLabel,
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
//             items:
//                 items
//                     .map(
//                       (e) => DropdownMenuItem<T>(
//                         value: e,
//                         child: Text(itemLabel != null ? itemLabel!(e) : '$e'),
//                       ),
//                     )
//                     .toList(),
//             hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // lib/ui/screens/reminders/reminders_screen.dart
// import 'package:flutter/material.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';
// // Bottom-nav root screens for routing
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';
// import '../modals/update_reminder_modal.dart';

// // ---------- Enum ----------
// enum ReminderType { team, personal }

// String _typeLabel(ReminderType t) =>
//     t == ReminderType.team ? 'Team' : 'Personal';

// // ---------- Screen ----------
// class RemindersScreen extends StatefulWidget {
//   const RemindersScreen({super.key});

//   @override
//   State<RemindersScreen> createState() => _RemindersScreenState();
// }

// class _RemindersScreenState extends State<RemindersScreen> {
//   int _modeIndex = 0;

//   // Create form fields
//   DateTime? _date;
//   TimeOfDay? _time;
//   String? _project;
//   ReminderType _createType = ReminderType.team;
//   final _descCtrl = TextEditingController();

//   // View tab & search
//   ReminderType _viewType = ReminderType.team;
//   String _search = '';

//   // Demo data
//   final List<_Reminder> _reminders = [
//     _Reminder(
//       id: 1,
//       date: '23/07/2025',
//       time: '10:00 AM',
//       project: 'NPCI',
//       description: 'Kick-off call with team',
//       type: ReminderType.team,
//     ),
//     _Reminder(
//       id: 2,
//       date: '24/07/2025',
//       time: '05:30 PM',
//       project: 'BPCL Aruba WIFI',
//       description: 'Follow up with vendor',
//       type: ReminderType.personal,
//     ),
//   ];

//   // Projects list (for both create + modal)
//   final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];

//   @override
//   void dispose() {
//     _descCtrl.dispose();
//     super.dispose();
//   }

//   void _clearCreate() {
//     setState(() {
//       _date = null;
//       _time = null;
//       _project = null;
//       _createType = ReminderType.team;
//       _descCtrl.clear();
//     });
//   }

//   Future<void> _pickDate() async {
//     final now = DateTime.now();
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _date ?? now,
//       firstDate: DateTime(now.year - 1),
//       lastDate: DateTime(now.year + 3),
//     );
//     if (picked != null) setState(() => _date = picked);
//   }

//   Future<void> _pickTime() async {
//     final picked = await showTimePicker(
//       context: context,
//       initialTime: _time ?? TimeOfDay.now(),
//     );
//     if (picked != null) setState(() => _time = picked);
//   }

//   void _createReminder() {
//     if (_date == null ||
//         _time == null ||
//         _project == null ||
//         _descCtrl.text.trim().isEmpty) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
//       return;
//     }
//     final d =
//         '${_date!.day.toString().padLeft(2, '0')}/${_date!.month.toString().padLeft(2, '0')}/${_date!.year}';
//     final t = _time!.format(context);

//     setState(() {
//       _reminders.add(
//         _Reminder(
//           id: DateTime.now().millisecondsSinceEpoch,
//           date: d,
//           time: t,
//           project: _project!,
//           description: _descCtrl.text.trim(),
//           type: _createType,
//         ),
//       );
//       _modeIndex = 1; // jump to View all after create
//     });

//     _clearCreate();
//   }

//   final int _selectedTab = 0; // bottom nav

//   void _handleTabChange(int i) {
//     if (i == _selectedTab) return;
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break;
//       case 1:
//         target = const AddProjectScreen();
//         break;
//       case 2:
//         target = const AddActivityScreen();
//         break;
//       case 3:
//         target = const AnalyticsScreen();
//         break;
//       case 4:
//         target = const ViewUsersScreen();
//         break;
//       default:
//         return;
//     }
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   // ---- Update handlers (modal) ----
//   Future<void> _openUpdateModal(_Reminder r) async {
//     final updated = await showDialog<ModalReminderResult>(
//       context: context,
//       barrierDismissible: false,
//       builder:
//           (_) => UpdateReminderModal(
//             initial: ModalReminder(
//               id: r.id,
//               projectName: r.project,
//               type: _typeLabel(r.type),
//               dateDDMMYYYY: r.date,
//               timeHHMMAP: r.time,
//               description: r.description,
//             ),
//             projectOptions: _projects,
//           ),
//     );

//     if (updated == null) return;

//     if (updated.action == ModalAction.delete) {
//       setState(() => _reminders.removeWhere((x) => x.id == updated.data!.id));
//       return;
//     }

//     // update
//     final u = updated.data!;
//     setState(() {
//       final idx = _reminders.indexWhere((x) => x.id == u.id);
//       if (idx != -1) {
//         _reminders[idx] = _Reminder(
//           id: u.id,
//           date: u.dateDDMMYYYY,
//           time: u.timeHHMMAP,
//           project: u.projectName,
//           description: u.description,
//           type: u.type == 'Team' ? ReminderType.team : ReminderType.personal,
//         );
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Reminders',
//       centerTitle: true,
//       safeArea: false,
//       reserveBottomPadding: true,
//       actions: [
//         IconButton(
//           tooltip:
//               Theme.of(context).brightness == Brightness.dark
//                   ? 'Light mode'
//                   : 'Dark mode',
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
//           onPressed:
//               () => Navigator.of(
//                 context,
//               ).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
//           icon: const ProfileAvatar(size: 36),
//         ),
//         const SizedBox(width: 8),
//       ],
//       currentIndex: _selectedTab,
//       onTabChanged: (i) => _handleTabChange(i),

//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           // Top mode switch: Create | View all
//           Center(
//             child: ToggleButtons(
//               isSelected: [_modeIndex == 0, _modeIndex == 1],
//               borderRadius: BorderRadius.circular(8),
//               constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
//               onPressed: (i) => setState(() => _modeIndex = i),
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text('Create'),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 12),
//                   child: Text('View all'),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 12),

//           if (_modeIndex == 0)
//             _buildCreateCard(context)
//           else
//             _buildViewAll(context),
//         ],
//       ),
//     );
//   }

//   // ---------------- Create card ----------------
//   Widget _buildCreateCard(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     'Create Reminder',
//                     style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                       color: cs.onSurface,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                 ),
//                 TextButton(onPressed: _clearCreate, child: const Text('CLEAR')),
//               ],
//             ),
//             Divider(color: cs.outlineVariant),

//             // Two columns (responsive)
//             LayoutBuilder(
//               builder: (context, c) {
//                 final isWide = c.maxWidth >= 640;
//                 final gap = isWide ? 12.0 : 0.0;

//                 final left = [
//                   _FieldShell(
//                     label: 'Date *',
//                     child: _DateBox(
//                       text:
//                           _date == null
//                               ? 'Select date'
//                               : '${_date!.day.toString().padLeft(2, '0')}/${_date!.month.toString().padLeft(2, '0')}/${_date!.year}',
//                       icon: Icons.event,
//                       onTap: _pickDate,
//                     ),
//                   ),
//                   _FieldShell(
//                     label: 'Time *',
//                     child: _DateBox(
//                       text:
//                           _time == null
//                               ? 'Select time'
//                               : _time!.format(context),
//                       icon: Icons.access_time,
//                       onTap: _pickTime,
//                     ),
//                   ),
//                 ];

//                 final right = [
//                   _Dropdown<String>(
//                     label: 'Project *',
//                     value: _project,
//                     items: _projects,
//                     onChanged: (v) => setState(() => _project = v),
//                   ),
//                   _Dropdown<ReminderType>(
//                     label: 'Type *',
//                     value: _createType,
//                     items: const [ReminderType.team, ReminderType.personal],
//                     onChanged:
//                         (v) => setState(
//                           () => _createType = v ?? ReminderType.team,
//                         ),
//                     itemLabel: _typeLabel,
//                   ),
//                 ];

//                 if (!isWide) return Column(children: [...left, ...right]);

//                 return Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(child: Column(children: left)),
//                     SizedBox(width: gap),
//                     Expanded(child: Column(children: right)),
//                   ],
//                 );
//               },
//             ),

//             _TextField(
//               label: 'Description *',
//               controller: _descCtrl,
//               maxLines: 3,
//             ),
//             const SizedBox(height: 8),

//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: _createReminder,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 24,
//                     vertical: 12,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Create',
//                   style: TextStyle(fontWeight: FontWeight.w800),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ---------------- View all ----------------
//   Widget _buildViewAll(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     // filter by tab + search (project/description match)
//     final list =
//         _reminders.where((r) => r.type == _viewType).where((r) {
//           if (_search.trim().isEmpty) return true;
//           final s = _search.toLowerCase();
//           return r.description.toLowerCase().contains(s) ||
//               r.project.toLowerCase().contains(s);
//         }).toList();

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // Row: search on left, toggle on right (wrap on small)
//         LayoutBuilder(
//           builder: (context, c) {
//             final narrow = c.maxWidth < 520;
//             final toggle = ToggleButtons(
//               isSelected: [
//                 _viewType == ReminderType.team,
//                 _viewType == ReminderType.personal,
//               ],
//               borderRadius: BorderRadius.circular(20),
//               constraints: const BoxConstraints(minHeight: 32, minWidth: 96),
//               onPressed:
//                   (i) => setState(
//                     () =>
//                         _viewType =
//                             i == 0 ? ReminderType.team : ReminderType.personal,
//                   ),
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text('Team'),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Text('Personal'),
//                 ),
//               ],
//             );

//             final search = SizedBox(
//               height: 40,
//               child: TextField(
//                 onChanged: (v) => setState(() => _search = v),
//                 decoration: InputDecoration(
//                   hintText: 'Search…',
//                   prefixIcon: const Icon(Icons.search),
//                   isDense: true,
//                   contentPadding: const EdgeInsets.symmetric(
//                     horizontal: 12,
//                     vertical: 10,
//                   ),
//                   filled: true,
//                   fillColor: cs.surface,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: cs.outlineVariant),
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12),
//                     borderSide: BorderSide(color: cs.outlineVariant),
//                   ),
//                 ),
//               ),
//             );

//             if (narrow) {
//               return Column(
//                 children: [
//                   search,
//                   const SizedBox(height: 10),
//                   Center(child: toggle),
//                 ],
//               );
//             }
//             return Row(
//               children: [
//                 Expanded(child: search),
//                 const SizedBox(width: 12),
//                 toggle,
//               ],
//             );
//           },
//         ),
//         const SizedBox(height: 12),

//         if (list.isEmpty)
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text(
//               'No reminders.',
//               textAlign: TextAlign.center,
//               style: TextStyle(color: cs.onSurfaceVariant),
//             ),
//           )
//         else
//           ...list.map(
//             (r) => _ReminderCard(r: r, onUpdateTap: () => _openUpdateModal(r)),
//           ),
//       ],
//     );
//   }
// }

// // ---------- Model ----------
// class _Reminder {
//   final int id;
//   final String date, time, project, description;
//   final ReminderType type;
//   _Reminder({
//     required this.id,
//     required this.date,
//     required this.time,
//     required this.project,
//     required this.description,
//     required this.type,
//   });
// }

// // ---------- UI bits ----------
// class _ReminderCard extends StatelessWidget {
//   final _Reminder r;
//   final VoidCallback onUpdateTap;
//   const _ReminderCard({required this.r, required this.onUpdateTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Text(
//                   r.date,
//                   style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   r.time,
//                   style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//             Divider(color: cs.outlineVariant),
//             const SizedBox(height: 4),
//             _kv('Project', r.project, context),
//             const SizedBox(height: 2),
//             _kv('Description', r.description, context),
//             const SizedBox(height: 10),
//             Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: onUpdateTap,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppTheme.accentColor,
//                   foregroundColor: Colors.black,
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 8,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: const Text(
//                   'Update',
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _kv(String k, String v, BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return RichText(
//       text: TextSpan(
//         text: '$k: ',
//         style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//         children: [
//           TextSpan(
//             text: v,
//             style: TextStyle(color: cs.onSurface, fontSize: 12),
//           ),
//         ],
//       ),
//     );
//   }
// }

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

// class _DateBox extends StatelessWidget {
//   final String text;
//   final IconData icon;
//   final VoidCallback onTap;
//   const _DateBox({required this.text, required this.icon, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Container(
//         height: 48,
//         padding: const EdgeInsets.symmetric(horizontal: 12),
//         decoration: BoxDecoration(
//           color: cs.surface,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color:
//                       text.startsWith('Select')
//                           ? cs.onSurfaceVariant
//                           : cs.onSurface,
//                 ),
//               ),
//             ),
//             Icon(icon, color: cs.onSurfaceVariant),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _TextField extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   final int maxLines;
//   const _TextField({
//     required this.label,
//     required this.controller,
//     this.maxLines = 1,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surface,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppTheme.accentColor),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 12,
//           ),
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
//   final String Function(T)? itemLabel;

//   const _Dropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.itemLabel,
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
//             items:
//                 items
//                     .map(
//                       (e) => DropdownMenuItem<T>(
//                         value: e,
//                         child: Text(itemLabel != null ? itemLabel!(e) : '$e'),
//                       ),
//                     )
//                     .toList(),
//             hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }

///p3//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pmgt/core/theme.dart';
import 'package:pmgt/core/theme_controller.dart';
import 'package:pmgt/ui/utils/responsive.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';
import 'package:pmgt/ui/screens/profile/profile_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

// bottom-nav targets
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';

// API & session
import 'package:pmgt/core/api_client.dart';
import 'package:pmgt/state/user_session.dart';

import '../modals/update_reminder_modal.dart';

enum ReminderType { team, personal }
String _typeLabel(ReminderType t) => t == ReminderType.team ? 'Team' : 'Personal';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});
  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  // mode: Create / View all
  int _modeIndex = 0;

  // Create form
  DateTime? _date;
  TimeOfDay? _time;
  String? _project;
  ReminderType _createType = ReminderType.team;
  final _descCtrl = TextEditingController();

  // View all
  ReminderType _viewType = ReminderType.team;
  String _search = '';

  // Data
  List<String> _projectOptions = [];
  List<_Reminder> _teamReminders = [];
  List<_Reminder> _personalReminders = [];

  // services
  ApiClient get _api => context.read<ApiClient>();
  UserSession get _session => context.read<UserSession>();

  // UI
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    await Future.wait([
      _loadProjects(),
      _loadTeamReminders(),
      _loadPersonalReminders(),
    ]);
  }

  Future<void> _loadProjects() async {
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final list = jsonDecode(res.body) as List;
        setState(() {
          _projectOptions = [
            for (final p in list) (p['project_name'] ?? '').toString()
          ]..removeWhere((e) => e.isEmpty);
        });
      }
    } catch (_) {}
  }

  Future<void> _loadTeamReminders() async {
    try {
      final res = await _api.get('/api/reminders', query: {'type': 'team'});
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final list = (jsonDecode(res.body) as List)
            .map((e) => _Reminder.fromJson(e as Map<String, dynamic>))
            .toList();
        setState(() => _teamReminders = list);
      }
    } catch (_) {}
  }

  Future<void> _loadPersonalReminders() async {
    final email = _session.email;
    if (email == null || email.isEmpty) {
      setState(() => _personalReminders = []);
      return;
    }
    try {
      final res = await _api.get('/api/reminders', query: {
        'type': 'personal',
        'owner_email': email,
      });
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final list = (jsonDecode(res.body) as List)
            .map((e) => _Reminder.fromJson(e as Map<String, dynamic>))
            .toList();
        setState(() => _personalReminders = list);
      }
    } catch (_) {}
  }


  // Put near the top of the file



  void _clearCreate() {
    setState(() {
      _date = null;
      _time = null;
      _project = null;
      _createType = ReminderType.team;
      _descCtrl.clear();
    });
  }

  String _fmtDateForApi(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _fmtTimeForApi(TimeOfDay t) {
    // “hh:mm AM/PM”
    final hour = t.hourOfPeriod == 0 ? 12 : t.hourOfPeriod;
    final mer = t.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')} $mer';
    }

  Future<void> _createReminder() async {
    if (_date == null || _time == null || _project == null || _descCtrl.text.trim().isEmpty) {
      _toast('Please fill all fields'); return;
    }

    setState(() => _busy = true);
    try {
      final payload = {
        'project_name': _project,
        'type': _createType == ReminderType.team ? 'team' : 'personal',
        'reminder_date': _fmtDateForApi(_date!),
        'reminder_time': _fmtTimeForApi(_time!),
        'description': _descCtrl.text.trim(),
        if (_createType == ReminderType.personal && (_session.email ?? '').isNotEmpty)
          'owner_email': _session.email,
      };

      final res = await _api.post('/api/reminders', body: payload);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final created = _Reminder.fromJson(jsonDecode(res.body));
        if (_createType == ReminderType.team) {
          setState(() => _teamReminders = [created, ..._teamReminders]);
        } else {
          setState(() => _personalReminders = [created, ..._personalReminders]);
        }
        _clearCreate();
        setState(() => _modeIndex = 1);
        _toast('Reminder created', success: true);
      } else {
        _toast('Failed to create reminder');
      }
    } catch (_) {
      _toast('Failed to create reminder');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String msg, {bool success = false}) {
    final cs = Theme.of(context).colorScheme;
    final bg = success ? const Color(0xFF2E7D32)
                       : (Theme.of(context).brightness == Brightness.dark ? const Color(0xFF5E2A2A) : const Color(0xFFFFE9E9));
    final fg = success ? Colors.white : cs.onSurface;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg, style: TextStyle(color: fg)), backgroundColor: bg));
  }

  // bottom-nav
  final int _selectedTab = 0;
  void _handleTabChange(int i) {
    if (i == _selectedTab) return;
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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Reminders',
      centerTitle: true,
      safeArea: false,
      reserveBottomPadding: true,
      actions: [
        IconButton(
          tooltip: Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
          icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode_outlined : Icons.dark_mode_outlined, color: cs.onSurface),
          onPressed: () => ThemeScope.of(context).toggle(),
        ),
        IconButton(
          tooltip: 'Profile',
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      currentIndex: _selectedTab,
      onTabChanged: _handleTabChange,
      body: Stack(
        children: [
          ListView(
            padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
            children: [
              // Create | View all
              Center(
                child: ToggleButtons(
                  isSelected: [_modeIndex == 0, _modeIndex == 1],
                  borderRadius: BorderRadius.circular(8),
                  constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
                  onPressed: (i) => setState(() => _modeIndex = i),
                  children: const [
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('Create')),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('View all')),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              if (_modeIndex == 0) _buildCreateCard(context) else _buildViewAll(context),
            ],
          ),
          if (_busy)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.25),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
        ],
      ),
    );
  }

  // ---------------- Create card ----------------
  Widget _buildCreateCard(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Create Reminder',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: cs.onSurface, fontWeight: FontWeight.w800,
                      )),
                ),
                TextButton(onPressed: _clearCreate, child: const Text('CLEAR')),
              ],
            ),
            Divider(color: cs.outlineVariant),

            // two columns responsive
            LayoutBuilder(
              builder: (context, c) {
                final isWide = c.maxWidth >= 640;
                final gap = isWide ? 12.0 : 0.0;

                final left = [
                  _FieldShell(
                    label: 'Date *',
                    child: _DateBox(
                      text: _date == null
                          ? 'Select date'
                          : '${_date!.day.toString().padLeft(2, '0')}/${_date!.month.toString().padLeft(2, '0')}/${_date!.year}',
                      icon: Icons.event,
                      onTap: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: _date ?? now,
                          firstDate: DateTime(now.year - 1),
                          lastDate: DateTime(now.year + 3),
                        );
                        if (picked != null) setState(() => _date = picked);
                      },
                    ),
                  ),
                  _FieldShell(
                    label: 'Time *',
                    child: _DateBox(
                      text: _time == null ? 'Select time' : _time!.format(context),
                      icon: Icons.access_time,
                      onTap: () async {
                        final picked = await showTimePicker(
                          context: context,
                          initialTime: _time ?? TimeOfDay.now(),
                        );
                        if (picked != null) setState(() => _time = picked);
                      },
                    ),
                  ),
                ];

                final right = [
                  _Dropdown<String>(
                    label: 'Project *',
                    value: _project,
                    items: _projectOptions,
                    onChanged: (v) => setState(() => _project = v),
                  ),
                  _Dropdown<ReminderType>(
                    label: 'Type *',
                    value: _createType,
                    items: const [ReminderType.team, ReminderType.personal],
                    onChanged: (v) => setState(() => _createType = v ?? ReminderType.team),
                    itemLabel: _typeLabel,
                  ),
                ];

                if (!isWide) return Column(children: [...left, ...right]);
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Column(children: left)),
                    SizedBox(width: gap),
                    Expanded(child: Column(children: right)),
                  ],
                );
              },
            ),

            _TextField(label: 'Description *', controller: _descCtrl, maxLines: 3),
            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _createReminder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Create', style: TextStyle(fontWeight: FontWeight.w800)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- View all (search + toggle + list) ----------------
  Widget _buildViewAll(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final source = _viewType == ReminderType.team ? _teamReminders : _personalReminders;
    final list = source.where((r) =>
      r.description.toLowerCase().contains(_search.toLowerCase()) ||
      r.projectName.toLowerCase().contains(_search.toLowerCase())
    ).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Search + toggle in one row
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search…',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: cs.surface,
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: cs.outlineVariant),
                  ),
                ),
                onChanged: (v) => setState(() => _search = v),
              ),
            ),
            const SizedBox(width: 12),
            ToggleButtons(
              isSelected: [_viewType == ReminderType.team, _viewType == ReminderType.personal],
              borderRadius: BorderRadius.circular(20),
              constraints: const BoxConstraints(minHeight: 32, minWidth: 92),
              onPressed: (i) => setState(() => _viewType = i == 0 ? ReminderType.team : ReminderType.personal),
              children: const [
                Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Team')),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text('Personal')),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),

        if (list.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('No reminders yet.', textAlign: TextAlign.center, style: TextStyle(color: cs.onSurfaceVariant)),
          )
        else
          ...list.map((r) => _ReminderCard(
                r: r,
                onUpdatePressed: () async {
                  await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (_) => UpdateReminderModal(
                      reminder: ModalReminder.fromReminder(r),
                      projectOptions: _projectOptions,
                      onUpdated: (fresh) async {
                        // refresh lists from API to stay accurate
                        await _loadTeamReminders();
                        await _loadPersonalReminders();
                      },
                      onDeleted: () async {
                        await _loadTeamReminders();
                        await _loadPersonalReminders();
                      },
                    ),
                  );
                },
              )),
      ],
    );
  }
}

/* ---------------------- Models & small widgets ---------------------- */

String _fmtDate(String raw) {
  if (raw.isEmpty) return '';
  try {
    final dt = DateTime.parse(raw).toLocal(); // handles "...Z"
    final d  = dt.day.toString().padLeft(2, '0');
    final m  = dt.month.toString().padLeft(2, '0');
    return '$d/$m/${dt.year}';
  } catch (_) {
    // Fallback for "YYYY-MM-DD"
    final s = raw.split('T').first; // take date part if present
    final p = s.split('-');
    if (p.length == 3) return '${p[2].padLeft(2, '0')}/${p[1].padLeft(2, '0')}/${p[0]}';
    return raw; // last resort
  }
}

class _Reminder {
  final int id;
  final String projectName;
  final String type; // 'team' | 'personal'
  final String? ownerEmail;
  final String reminderDate; // YYYY-MM-DD
  final String reminderTime; // hh:mm AM/PM
  final String description;

  _Reminder({
    required this.id,
    required this.projectName,
    required this.type,
    required this.ownerEmail,
    required this.reminderDate,
    required this.reminderTime,
    required this.description,
  });

  factory _Reminder.fromJson(Map<String, dynamic> m) => _Reminder(
        id: (m['id'] ?? 0) is int ? m['id'] as int : int.tryParse('${m['id']}') ?? 0,
        projectName: (m['project_name'] ?? '').toString(),
        type: (m['type'] ?? 'team').toString(),
        ownerEmail: (m['owner_email'] as String?),
        reminderDate: (m['reminder_date'] ?? '').toString(),
        reminderTime: (m['reminder_time'] ?? '').toString(),
        description: (m['description'] ?? '').toString(),
      );

  ReminderType get enumType => type.toLowerCase() == 'personal' ? ReminderType.personal : ReminderType.team;
  // String get displayDate {
  //   // show DD/MM/YYYY
  //   final parts = reminderDate.split('-'); // [YYYY, MM, DD]
  //   return parts.length == 3 ? '${parts[2]}/${parts[1]}/${parts[0]}' : reminderDate;
  // }
  String get displayDate => _fmtDate(reminderDate);

}

class _ReminderCard extends StatelessWidget {
  final _Reminder r;
  final VoidCallback onUpdatePressed;
  const _ReminderCard({required this.r, required this.onUpdatePressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Text(r.displayDate, style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800)),
                const Spacer(),
                Text(r.reminderTime, style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w700)),
              ],
            ),
            Divider(color: cs.outlineVariant),
            const SizedBox(height: 4),
            _kv('Project', r.projectName, context),
            const SizedBox(height: 2),
            _kv('Description', r.description, context),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton(
                onPressed: onUpdatePressed,
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Update'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _kv(String k, String v, BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return RichText(
      text: TextSpan(
        text: '$k: ',
        style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
        children: [TextSpan(text: v, style: TextStyle(color: cs.onSurface, fontSize: 12))],
      ),
    );
  }
}

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
          Text(label, style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;
  const _DateBox({required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: text.startsWith('Select') ? cs.onSurfaceVariant : cs.onSurface),
              ),
            ),
            Icon(icon, color: cs.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  const _TextField({required this.label, required this.controller, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surface,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.accentColor),
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
  final String Function(T)? itemLabel;

  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabel,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
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
                .map((e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(itemLabel != null ? itemLabel!(e) : '$e'),
                    ))
                .toList(),
            hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
