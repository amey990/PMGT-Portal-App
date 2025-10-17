// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/custom_text_field.dart';
// import '../../widgets/gradient_button.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';


// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   // Controllers
//   final _nameCtrl     = TextEditingController();
//   final _contactCtrl  = TextEditingController();
//   final _usernameCtrl = TextEditingController(); // read-only
//   final _roleCtrl     = TextEditingController(); // read-only
//   final _emailCtrl    = TextEditingController(); // read-only

//   // Edit state
//   bool _editingName = false;
//   bool _editingContact = false;

//   // Dropdown selections
//   String _designation = 'Project Manager';
//   String _project     = 'Select Project';
//   final _designations = const [
//     'Project Manager',
//     'Site Engineer',
//     'Technical Lead',
//   ];
//   final _projectsList = const [
//     'Telstra',
//     'CBI',
//     'Airtel',
//     'BPCL',
//   ];

//   // Avatar
//   File? _avatarFile;
//   final ImagePicker _picker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     // Pre-fill read-only fields
//     _usernameCtrl.text = 'Admin';
//     _roleCtrl.text     = 'Admin';
//     _emailCtrl.text    = 'commedia9900@gmail.com';
//   }

//   @override
//   void dispose() {
//     _nameCtrl.dispose();
//     _contactCtrl.dispose();
//     _usernameCtrl.dispose();
//     _roleCtrl.dispose();
//     _emailCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _pickAvatar() async {
//     final picked = await _picker.pickImage(source: ImageSource.gallery);
//     if (picked != null) {
//       setState(() {
//         _avatarFile = File(picked.path);
//       });
//     }
//   }

//   void _handleTabChange(BuildContext context, int i) {
//   late final Widget target;
//   switch (i) {
//     case 0: target = const DashboardScreen();    break; // Dashboard
//     case 1: target = const AddProjectScreen();   break; // Add Project
//     case 2: target = const AddActivityScreen();  break; // Add Activity
//     case 3: target = const AnalyticsScreen();    break; // Analytics
//     case 4: target = const ViewUsersScreen();    break; // View Users
//     default: return;
//   }
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (_) => target),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     final pad = responsivePadding(context);
//     final cs = Theme.of(context).colorScheme;

//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
//         title: Text('Profile', style: AppTheme.heading2.copyWith(color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? cs.onSurface)),
//       ),
//       body: SafeArea(
//         child: AntiOverflowScroll(
//           child: MaxWidth(
//             child: Padding(
//               padding: pad,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Avatar
//                   Center(
//                     child: GestureDetector(
//                       onTap: _pickAvatar,
//                       child: CircleAvatar(
//                         radius: context.w < 360 ? 48 : 54,
//                         backgroundColor: cs.surfaceContainerHighest,
//                         child: CircleAvatar(
//                           radius: context.w < 360 ? 46 : 52,
//                           backgroundImage: _avatarFile != null
//                               ? FileImage(_avatarFile!)
//                               : const AssetImage('assets/User_profile.png') as ImageProvider,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 12),

//                   // Name
//                   CustomTextField(
//                     label: 'Name',
//                     controller: _nameCtrl,
//                     readOnly: !_editingName,
//                     showAction: true,
//                     actionLabel: _editingName ? 'SAVE' : 'EDIT',
//                     onActionTap: () {
//                       setState(() => _editingName = !_editingName);
//                       // TODO: persist name
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   // Contact
//                   CustomTextField(
//                     label: 'Contact No',
//                     controller: _contactCtrl,
//                     readOnly: !_editingContact,
//                     keyboardType: TextInputType.phone,
//                     showAction: true,
//                     actionLabel: _editingContact ? 'SAVE' : 'EDIT',
//                     onActionTap: () {
//                       setState(() => _editingContact = !_editingContact);
//                       // TODO: persist contact
//                     },
//                   ),
//                   const SizedBox(height: 24),

//                   // Username & Designation (stack on narrow, row on wider)
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       final isNarrow = constraints.maxWidth < 420;
//                       final gap = 12.0;

//                       final username = CustomTextField(
//                         label: 'Username',
//                         controller: _usernameCtrl,
//                         readOnly: true,
//                       );

//                       final designation = _DropdownField<String>(
//                         label: 'Designation',
//                         value: _designation,
//                         items: _designations,
//                         onChanged: (v) => setState(() => _designation = v ?? _designation),
//                       );

//                       if (isNarrow) {
//                         return Column(
//                           children: [
//                             username,
//                             SizedBox(height: gap),
//                             designation,
//                           ],
//                         );
//                       } else {
//                         return Row(
//                           children: [
//                             Expanded(child: username),
//                             SizedBox(width: gap),
//                             Expanded(child: designation),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   // Role & Projects (stack on narrow)
//                   LayoutBuilder(
//                     builder: (context, constraints) {
//                       final isNarrow = constraints.maxWidth < 420;
//                       final gap = 12.0;

//                       final role = CustomTextField(
//                         label: 'Role',
//                         controller: _roleCtrl,
//                         readOnly: true,
//                       );

//                       final projects = _DropdownField<String>(
//                         label: 'Projects',
//                         value: _project,
//                         items: const ['Select Project', ...[
//                           'Telstra', 'CBI', 'Airtel', 'BPCL'
//                         ]],
//                         onChanged: (v) => setState(() => _project = v ?? _project),
//                       );

//                       if (isNarrow) {
//                         return Column(
//                           children: [
//                             role,
//                             SizedBox(height: gap),
//                             projects,
//                           ],
//                         );
//                       } else {
//                         return Row(
//                           children: [
//                             Expanded(child: role),
//                             SizedBox(width: gap),
//                             Expanded(child: projects),
//                           ],
//                         );
//                       }
//                     },
//                   ),
//                   const SizedBox(height: 16),

//                   // Email
//                   CustomTextField(
//                     label: 'Email',
//                     controller: _emailCtrl,
//                     readOnly: true,
//                   ),

//                   const SizedBox(height: 28),

//                   // Save All button (shrinks on narrow)
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ConstrainedBox(
//                       constraints: BoxConstraints(
//                         maxWidth: context.w < 360 ? 120 : 160,
//                       ),
//                       child: GradientButton(
//                         text: 'Save',
//                         onPressed: () {
//                           // TODO: persist all changes
//                         },
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// /// Reusable dropdown styled to match theme and your text fields
// class _DropdownField<T> extends StatelessWidget {
//   final String label;
//   final T? value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;

//   const _DropdownField({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
//         const SizedBox(height: 8),
//         Container(
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<T>(
//               isExpanded: true,
//               value: value,
//               hint: Text('Select $label', style: TextStyle(color: cs.onSurfaceVariant)),
//               iconEnabledColor: cs.onSurfaceVariant,
//               dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//               items: items
//                   .map((v) => DropdownMenuItem<T>(
//                         value: v,
//                         child: Text(
//                           v.toString(),
//                           style: TextStyle(color: cs.onSurface),
//                         ),
//                       ))
//                   .toList(),
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../utils/responsive.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

// Shared layout + root-tab targets
import '../../widgets/layout/main_layout.dart';
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';
import '../../../core/theme_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers
  final _nameCtrl     = TextEditingController();
  final _contactCtrl  = TextEditingController();
  final _usernameCtrl = TextEditingController(); // read-only
  final _roleCtrl     = TextEditingController(); // read-only
  final _emailCtrl    = TextEditingController(); // read-only

  // Edit state
  bool _editingName = false;
  bool _editingContact = false;

  // Dropdown selections
  String _designation = 'Project Manager';
  String _project     = 'Select Project';
  final _designations = const [
    'Project Manager',
    'Site Engineer',
    'Technical Lead',
  ];
  final _projectsList = const [
    'Telstra',
    'CBI',
    'Airtel',
    'BPCL',
  ];

  // Avatar
  File? _avatarFile;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Pre-fill read-only fields
    _usernameCtrl.text = 'Admin';
    _roleCtrl.text     = 'Admin';
    _emailCtrl.text    = 'commedia9900@gmail.com';
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _contactCtrl.dispose();
    _usernameCtrl.dispose();
    _roleCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickAvatar() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _avatarFile = File(picked.path);
      });
    }
  }

  // ----- BottomNav routing to the 5 root tabs -----
  void _handleTabChange(BuildContext context, int i) {
    late final Widget target;
    switch (i) {
      case 0: target = const DashboardScreen();    break; // Dashboard
      case 1: target = const AddProjectScreen();   break; // Add Project
      case 2: target = const AddActivityScreen();  break; // Add Activity
      case 3: target = const AnalyticsScreen();    break; // Analytics
      case 4: target = const ViewUsersScreen();    break; // View Users
      default: return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => target),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pad = responsivePadding(context);
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Profile',
      centerTitle: true,

      // Profile is *not* one of the 5 root tabs, so show the bar but don't
      // select any item. (-1 is supported by CustomBottomNavBar logic you have)
      currentIndex: -1,
      onTabChanged: (i) => _handleTabChange(context, i),

      // keep consistent feel with other pages
      safeArea: true,
      reserveBottomPadding: true,
      drawerEnabled: false,

      // optional: theme toggle in actions for consistency
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
      ],

      body: AntiOverflowScroll(
        child: MaxWidth(
          child: Padding(
            padding: pad,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Avatar
                Center(
                  child: GestureDetector(
                    onTap: _pickAvatar,
                    child: CircleAvatar(
                      radius: context.w < 360 ? 48 : 54,
                      backgroundColor: cs.surfaceContainerHighest,
                      child: CircleAvatar(
                        radius: context.w < 360 ? 46 : 52,
                        backgroundImage: _avatarFile != null
                            ? FileImage(_avatarFile!)
                            : const AssetImage('assets/User_profile.png') as ImageProvider,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Name
                CustomTextField(
                  label: 'Name',
                  controller: _nameCtrl,
                  readOnly: !_editingName,
                  showAction: true,
                  actionLabel: _editingName ? 'SAVE' : 'EDIT',
                  onActionTap: () {
                    setState(() => _editingName = !_editingName);
                    // TODO: persist name
                  },
                ),
                const SizedBox(height: 16),

                // Contact
                CustomTextField(
                  label: 'Contact No',
                  controller: _contactCtrl,
                  readOnly: !_editingContact,
                  keyboardType: TextInputType.phone,
                  showAction: true,
                  actionLabel: _editingContact ? 'SAVE' : 'EDIT',
                  onActionTap: () {
                    setState(() => _editingContact = !_editingContact);
                    // TODO: persist contact
                  },
                ),
                const SizedBox(height: 24),

                // Username & Designation (stack on narrow, row on wider)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 420;
                    final gap = 12.0;

                    final username = CustomTextField(
                      label: 'Username',
                      controller: _usernameCtrl,
                      readOnly: true,
                    );

                    final designation = _DropdownField<String>(
                      label: 'Designation',
                      value: _designation,
                      items: _designations,
                      onChanged: (v) => setState(() => _designation = v ?? _designation),
                    );

                    if (isNarrow) {
                      return Column(
                        children: [
                          username,
                          SizedBox(height: gap),
                          designation,
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Expanded(child: username),
                          SizedBox(width: gap),
                          Expanded(child: designation),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Role & Projects (stack on narrow)
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isNarrow = constraints.maxWidth < 420;
                    final gap = 12.0;

                    final role = CustomTextField(
                      label: 'Role',
                      controller: _roleCtrl,
                      readOnly: true,
                    );

                    final projects = _DropdownField<String>(
                      label: 'Projects',
                      value: _project,
                      items: const ['Select Project', ...[
                        'Telstra', 'CBI', 'Airtel', 'BPCL'
                      ]],
                      onChanged: (v) => setState(() => _project = v ?? _project),
                    );

                    if (isNarrow) {
                      return Column(
                        children: [
                          role,
                          SizedBox(height: gap),
                          projects,
                        ],
                      );
                    } else {
                      return Row(
                        children: [
                          Expanded(child: role),
                          SizedBox(width: gap),
                          Expanded(child: projects),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),

                // Email
                CustomTextField(
                  label: 'Email',
                  controller: _emailCtrl,
                  readOnly: true,
                ),

                const SizedBox(height: 28),

                // Save All button (shrinks on narrow)
                Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: context.w < 360 ? 120 : 160,
                    ),
                    child: GradientButton(
                      text: 'Save',
                      onPressed: () {
                        // TODO: persist all changes
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Reusable dropdown styled to match theme and your text fields
class _DropdownField<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;

  const _DropdownField({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              hint: Text('Select $label', style: TextStyle(color: cs.onSurfaceVariant)),
              iconEnabledColor: cs.onSurfaceVariant,
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              items: items
                  .map((v) => DropdownMenuItem<T>(
                        value: v,
                        child: Text(
                          v.toString(),
                          style: TextStyle(color: cs.onSurface),
                        ),
                      ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
