// import 'package:flutter/material.dart';
// import 'dart:math';

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';

// class RemindersScreen extends StatefulWidget {
//   const RemindersScreen({super.key});
//   @override
//   State<RemindersScreen> createState() => _RemindersScreenState();
// }

// class _RemindersScreenState extends State<RemindersScreen> {
//   // form state
//   DateTime? _date;
//   TimeOfDay? _time;
//   String? _project;
//   String _remType = 'Team'; // dropdown choice for create form
//   final _descCtrl = TextEditingController();

//   // filter toggle (Team | Personal)
//   final List<bool> _tabSel = [true, false];

//   // sample data
//   final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];

//   final List<_Reminder> _reminders = [
//     _Reminder(
//       date: DateTime.now(),
//       time: const TimeOfDay(hour: 10, minute: 30),
//       project: 'NPCI',
//       type: 'Team',
//       description: 'Morning sync with field team',
//     ),
//     _Reminder(
//       date: DateTime.now().add(const Duration(days: 1)),
//       time: const TimeOfDay(hour: 16, minute: 0),
//       project: 'TelstraApari',
//       type: 'Personal',
//       description: 'Follow up with vendor',
//     ),
//   ];

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
//       _remType = 'Team';
//       _descCtrl.clear();
//     });
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
//     setState(() {
//       _reminders.add(
//         _Reminder(
//           date: _date!,
//           time: _time!,
//           project: _project!,
//           type: _remType,
//           description: _descCtrl.text.trim(),
//         ),
//       );
//       _clearCreate();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     // Which list to show under the toggle
//     final showType = _tabSel[0] ? 'Team' : 'Personal';
//     final items =
//         _reminders.where((r) => r.type == showType).toList()
//           ..sort((a, b) => a.date.compareTo(b.date));

//     return MainLayout(
//       title: 'Reminders',
//       centerTitle: true,
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
//       currentIndex: 0,
//       onTabChanged: (_) {},
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           // ============ Card 1: Create Reminder ============
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
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Create Reminder',
//                           style: Theme.of(
//                             context,
//                           ).textTheme.titleLarge?.copyWith(
//                             color: cs.onSurface,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: _clearCreate,
//                         child: const Text('CLEAR'),
//                       ),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final isWide = c.maxWidth >= 640;
//                       final gap = isWide ? 12.0 : 0.0;

//                       final left = [
//                         _DateField(
//                           label: 'Date *',
//                           value: _date,
//                           onPick: (d) => setState(() => _date = d),
//                         ),
//                         _TimeField(
//                           label: 'Time *',
//                           value: _time,
//                           onPick: (t) => setState(() => _time = t),
//                         ),
//                       ];

//                       final right = [
//                         _Dropdown<String>(
//                           label: 'Project *',
//                           value: _project,
//                           items: _projects,
//                           onChanged: (v) => setState(() => _project = v),
//                         ),
//                         _Dropdown<String>(
//                           label: 'Type *',
//                           value: _remType,
//                           items: const ['Team', 'Personal'],
//                           onChanged:
//                               (v) => setState(() => _remType = v ?? 'Team'),
//                         ),
//                       ];

//                       final descField = _TextField(
//                         label: 'Description *',
//                         controller: _descCtrl,
//                         maxLines: 3,
//                       );

//                       if (!isWide) {
//                         return Column(children: [...left, ...right, descField]);
//                       }

//                       return Column(
//                         children: [
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(child: Column(children: left)),
//                               SizedBox(width: gap),
//                               Expanded(child: Column(children: right)),
//                             ],
//                           ),
//                           descField,
//                         ],
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 12),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       onPressed: _createReminder,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.accentColor,
//                         foregroundColor: Colors.black,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       child: const Text(
//                         'Create',
//                         style: TextStyle(fontWeight: FontWeight.w800),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 12),

//           // ============ Team | Personal toggle ============
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
//             decoration: BoxDecoration(
//               color: cs.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Center(
//               child: ToggleButtons(
//                 isSelected: _tabSel,
//                 onPressed:
//                     (i) => setState(() {
//                       for (var x = 0; x < _tabSel.length; x++) {
//                         _tabSel[x] = x == i;
//                       }
//                     }),
//                 borderRadius: BorderRadius.circular(20),
//                 selectedColor: Colors.black,
//                 color: cs.onSurfaceVariant,
//                 fillColor: AppTheme.accentColor,
//                 constraints: const BoxConstraints(minHeight: 36, minWidth: 100),
//                 children: const [Text('Team'), Text('Personal')],
//               ),
//             ),
//           ),

//           const SizedBox(height: 12),

//           // ============ Reminders list ============
//           ...items.map((r) => _ReminderCard(r: r)).toList(),
//           if (items.isEmpty)
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 'No reminders',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(color: cs.onSurfaceVariant),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// /* --------------------------- Models & Widgets --------------------------- */

// class _Reminder {
//   final DateTime date;
//   final TimeOfDay time;
//   final String project;
//   final String type; // Team | Personal
//   final String description;

//   _Reminder({
//     required this.date,
//     required this.time,
//     required this.project,
//     required this.type,
//     required this.description,
//   });
// }

// class _ReminderCard extends StatelessWidget {
//   final _Reminder r;
//   const _ReminderCard({required this.r});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final dt =
//         '${r.date.day.toString().padLeft(2, '0')}/'
//         '${r.date.month.toString().padLeft(2, '0')}/'
//         '${r.date.year}';
//     final tm =
//         '${r.time.hourOfPeriod.toString().padLeft(2, '0')}:'
//         '${r.time.minute.toString().padLeft(2, '0')} '
//         '${r.time.period == DayPeriod.am ? 'AM' : 'PM'}';

//     return Card(
//       color: cs.surfaceContainerHighest,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       margin: const EdgeInsets.only(bottom: 12),
//       child: Padding(
//         padding: const EdgeInsets.all(14),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // header: Date | Time
//             Row(
//               children: [
//                 Text(
//                   dt,
//                   style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w800,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   tm,
//                   style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ],
//             ),
//             Divider(color: cs.outlineVariant),

//             // body
//             const SizedBox(height: 6),
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

// /* --------------------------- Reusable inputs --------------------------- */

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
//             items:
//                 items
//                     .map(
//                       (e) => DropdownMenuItem<T>(value: e, child: Text('$e')),
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

// class _DateField extends StatelessWidget {
//   final String label;
//   final DateTime? value;
//   final ValueChanged<DateTime?> onPick;
//   const _DateField({
//     required this.label,
//     required this.value,
//     required this.onPick,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     String display() {
//       if (value == null) return 'Select date';
//       return '${value!.day.toString().padLeft(2, '0')}/'
//           '${value!.month.toString().padLeft(2, '0')}/'
//           '${value!.year}';
//     }

//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: () async {
//           final now = DateTime.now();
//           final res = await showDatePicker(
//             context: context,
//             firstDate: DateTime(now.year - 5),
//             lastDate: DateTime(now.year + 5),
//             initialDate: value ?? now,
//           );
//           onPick(res);
//         },
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: cs.surface,
//             border: Border.all(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           alignment: Alignment.centerLeft,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   display(),
//                   style: TextStyle(
//                     color: value == null ? cs.onSurfaceVariant : cs.onSurface,
//                   ),
//                 ),
//               ),
//               Icon(Icons.calendar_today, size: 18, color: cs.onSurfaceVariant),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _TimeField extends StatelessWidget {
//   final String label;
//   final TimeOfDay? value;
//   final ValueChanged<TimeOfDay?> onPick;
//   const _TimeField({
//     required this.label,
//     required this.value,
//     required this.onPick,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     String display() {
//       if (value == null) return 'Select time';
//       final h = value!.hourOfPeriod.toString().padLeft(2, '0');
//       final m = value!.minute.toString().padLeft(2, '0');
//       final ap = value!.period == DayPeriod.am ? 'AM' : 'PM';
//       return '$h:$m $ap';
//     }

//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: () async {
//           final res = await showTimePicker(
//             context: context,
//             initialTime: value ?? const TimeOfDay(hour: 9, minute: 0),
//           );
//           onPick(res);
//         },
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: cs.surface,
//             border: Border.all(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           alignment: Alignment.centerLeft,
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   display(),
//                   style: TextStyle(
//                     color: value == null ? cs.onSurfaceVariant : cs.onSurface,
//                   ),
//                 ),
//               ),
//               Icon(Icons.schedule, size: 18, color: cs.onSurfaceVariant),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// lib/ui/screens/reminders/reminders_screen.dart
import 'package:flutter/material.dart';
import 'package:pmgt/core/theme.dart';
import 'package:pmgt/core/theme_controller.dart';
import 'package:pmgt/ui/utils/responsive.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';
import 'package:pmgt/ui/screens/profile/profile_screen.dart';

// ---------- Enum ----------
enum ReminderType { team, personal }

String _typeLabel(ReminderType t) =>
    t == ReminderType.team ? 'Team' : 'Personal';

// ---------- Screen ----------
class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  // Top switch: 0 = Create, 1 = View all
  int _modeIndex = 0;

  // Create form fields
  DateTime? _date;
  TimeOfDay? _time;
  String? _project;
  ReminderType _createType = ReminderType.team;
  final _descCtrl = TextEditingController();

  // View filter toggle
  ReminderType _viewType = ReminderType.team;

  // Demo data (NOTICE: uses enum, not Strings)
  final List<_Reminder> _reminders = [
    _Reminder(
      date: '23/07/2025',
      time: '10:00',
      project: 'NPCI',
      description: 'Kick-off call with team',
      type: ReminderType.team,
    ),
    _Reminder(
      date: '24/07/2025',
      time: '17:30',
      project: 'BPCL Aruba WIFI',
      description: 'Follow up with vendor',
      type: ReminderType.personal,
    ),
  ];

  final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  void _clearCreate() {
    setState(() {
      _date = null;
      _time = null;
      _project = null;
      _createType = ReminderType.team;
      _descCtrl.clear();
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
    );
    if (picked != null) {
      setState(() => _date = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() => _time = picked);
    }
  }

  void _createReminder() {
    if (_date == null ||
        _time == null ||
        _project == null ||
        _descCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please fill all fields')));
      return;
    }
    final d =
        '${_date!.day.toString().padLeft(2, '0')}/'
        '${_date!.month.toString().padLeft(2, '0')}/'
        '${_date!.year}';
    final t = _time!.format(context);

    setState(() {
      _reminders.add(
        _Reminder(
          date: d,
          time: t,
          project: _project!,
          description: _descCtrl.text.trim(),
          type: _createType, // <-- enum
        ),
      );
      _modeIndex = 1; // jump to View all
    });

    _clearCreate();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Reminders',
      centerTitle: true,
      safeArea: false,
      reserveBottomPadding: true,
      // AppBar actions (same look/feel as other pages)
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
      currentIndex: 0,
      onTabChanged: (_) {},
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          // Top mode switch: Create | View all
          Center(
            child: ToggleButtons(
              isSelected: [_modeIndex == 0, _modeIndex == 1],
              borderRadius: BorderRadius.circular(8),
              constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
              onPressed: (i) => setState(() => _modeIndex = i),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Create'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('View all'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          if (_modeIndex == 0)
            _buildCreateCard(context)
          else
            _buildViewAll(context),
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
                  child: Text(
                    'Create Reminder',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TextButton(onPressed: _clearCreate, child: const Text('CLEAR')),
              ],
            ),
            Divider(color: cs.outlineVariant),

            // Two columns (responsive)
            LayoutBuilder(
              builder: (context, c) {
                final isWide = c.maxWidth >= 640;
                final gap = isWide ? 12.0 : 0.0;

                final left = [
                  _FieldShell(
                    label: 'Date *',
                    child: _DateBox(
                      text:
                          _date == null
                              ? 'Select date'
                              : '${_date!.day.toString().padLeft(2, '0')}/'
                                  '${_date!.month.toString().padLeft(2, '0')}/'
                                  '${_date!.year}',
                      icon: Icons.event,
                      onTap: _pickDate,
                    ),
                  ),
                  _FieldShell(
                    label: 'Time *',
                    child: _DateBox(
                      text:
                          _time == null
                              ? 'Select time'
                              : _time!.format(context),
                      icon: Icons.access_time,
                      onTap: _pickTime,
                    ),
                  ),
                ];

                final right = [
                  _Dropdown<String>(
                    label: 'Project *',
                    value: _project,
                    items: _projects,
                    onChanged: (v) => setState(() => _project = v),
                  ),
                  _Dropdown<ReminderType>(
                    label: 'Type *',
                    value: _createType,
                    items: const [ReminderType.team, ReminderType.personal],
                    // IMPORTANT: the dropdown returns the enum
                    onChanged:
                        (v) => setState(
                          () => _createType = v ?? ReminderType.team,
                        ),
                    itemLabel: _typeLabel,
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
              },
            ),

            _TextField(
              label: 'Description *',
              controller: _descCtrl,
              maxLines: 3,
            ),
            const SizedBox(height: 8),

            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _createReminder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Create',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- View all ----------------
  Widget _buildViewAll(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final list = _reminders.where((r) => r.type == _viewType).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Team / Personal toggle
        Center(
          child: ToggleButtons(
            isSelected: [
              _viewType == ReminderType.team,
              _viewType == ReminderType.personal,
            ],
            borderRadius: BorderRadius.circular(20),
            constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
            onPressed:
                (i) => setState(() {
                  _viewType =
                      i == 0 ? ReminderType.team : ReminderType.personal;
                }),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Team'),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text('Personal'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        if (list.isEmpty)
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'No reminders yet.',
              textAlign: TextAlign.center,
              style: TextStyle(color: cs.onSurfaceVariant),
            ),
          )
        else
          ...list.map((r) => _ReminderCard(r: r)),
      ],
    );
  }
}

// ---------- Model ----------
class _Reminder {
  final String date, time, project, description;
  final ReminderType type; // <- enum

  _Reminder({
    required this.date,
    required this.time,
    required this.project,
    required this.description,
    required this.type,
  });
}

// ---------- UI bits ----------
class _ReminderCard extends StatelessWidget {
  final _Reminder r;
  const _ReminderCard({required this.r});

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
                Text(
                  r.date,
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Spacer(),
                Text(
                  r.time,
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Divider(color: cs.outlineVariant),
            const SizedBox(height: 4),
            _kv('Project', r.project, context),
            const SizedBox(height: 2),
            _kv('Description', r.description, context),
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
        children: [
          TextSpan(
            text: v,
            style: TextStyle(color: cs.onSurface, fontSize: 12),
          ),
        ],
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
                style: TextStyle(
                  color:
                      text.startsWith('Select')
                          ? cs.onSurfaceVariant
                          : cs.onSurface,
                ),
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
  const _TextField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

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
            items:
                items
                    .map(
                      (e) => DropdownMenuItem<T>(
                        value: e,
                        child: Text(itemLabel != null ? itemLabel!(e) : '$e'),
                      ),
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
