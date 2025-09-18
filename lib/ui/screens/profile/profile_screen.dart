// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../core/theme.dart';
// import '../../widgets/custom_text_field.dart';
// import '../../widgets/gradient_button.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   // Controllers
//   final _nameCtrl    = TextEditingController();
//   final _contactCtrl = TextEditingController();
//   final _usernameCtrl = TextEditingController(); // read-only
//   final _roleCtrl     = TextEditingController(); // read-only
//   final _emailCtrl    = TextEditingController(); // read-only

//   // Edit state
//   bool _editingName = false;
//   bool _editingContact = false;

//   // Dropdown selections
//   String _designation = 'Project Manager';
//   String _project     = 'Select Project';
//   final _designations = [
//     'Project Manager',
//     'Site Engineer',
//     'Technical Lead',
//   ];
//   final _projectsList = [
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppTheme.backgroundColor,
//         elevation: 0,
//         leading: BackButton(color: Colors.white),
//         title: const Text('Profile', style: AppTheme.heading2),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//           child: Column(
//             children: [
//               // Avatar
//               GestureDetector(
//                 onTap: _pickAvatar,
//                 child: CircleAvatar(
//                   radius: 54,
//                   backgroundColor: Colors.white,
//                   child: CircleAvatar(
//                     radius: 52,
//                     backgroundImage: _avatarFile != null
//                         ? FileImage(_avatarFile!)
//                         : const AssetImage('assets/User_profile.png')
//                             as ImageProvider,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),

//               // Name field
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       label: 'Name',
//                       controller: _nameCtrl,
//                       readOnly: !_editingName,
//                       showAction: true,
//                       actionLabel: _editingName ? 'SAVE' : 'EDIT',
//                       onActionTap: () {
//                         setState(() => _editingName = !_editingName);
//                         // TODO: persist name
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Contact field
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       label: 'Contact No',
//                       controller: _contactCtrl,
//                       readOnly: !_editingContact,
//                       keyboardType: TextInputType.phone,
//                       showAction: true,
//                       actionLabel: _editingContact ? 'SAVE' : 'EDIT',
//                       onActionTap: () {
//                         setState(() => _editingContact = !_editingContact);
//                         // TODO: persist contact
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 24),

//               // Username & Designation
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       label: 'Username',
//                       controller: _usernameCtrl,
//                       readOnly: true,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Designation',
//                             style:
//                                 TextStyle(color: Colors.white70, fontSize: 14)),
//                         const SizedBox(height: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           decoration: BoxDecoration(
//                             color: Colors.white12,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               value: _designation,
//                               isExpanded: true,
//                               dropdownColor: AppTheme.backgroundColor,
//                               iconEnabledColor: Colors.white54,
//                               items: _designations
//                                   .map((d) => DropdownMenuItem(
//                                         value: d,
//                                         child: Text(d,
//                                             style: const TextStyle(
//                                                 color: Colors.white)),
//                                       ))
//                                   .toList(),
//                               onChanged: (v) {
//                                 setState(() => _designation = v!);
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Role & Projects
//               Row(
//                 children: [
//                   Expanded(
//                     child: CustomTextField(
//                       label: 'Role',
//                       controller: _roleCtrl,
//                       readOnly: true,
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text('Projects',
//                             style:
//                                 TextStyle(color: Colors.white70, fontSize: 14)),
//                         const SizedBox(height: 8),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 16),
//                           decoration: BoxDecoration(
//                             color: Colors.white12,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<String>(
//                               value: _project,
//                               isExpanded: true,
//                               dropdownColor: AppTheme.backgroundColor,
//                               iconEnabledColor: Colors.white54,
//                               items: [
//                                 DropdownMenuItem(
//                                   value: 'Select Project',
//                                   child: Text('Select Project',
//                                       style: TextStyle(
//                                           color: Colors.white54)),
//                                 ),
//                                 ..._projectsList.map((p) =>
//                                     DropdownMenuItem(
//                                       value: p,
//                                       child: Text(p,
//                                           style: const TextStyle(
//                                               color: Colors.white)),
//                                     )),
//                               ],
//                               onChanged: (v) {
//                                 setState(() => _project = v!);
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),

//               // Email
//               CustomTextField(
//                 label: 'Email',
//                 controller: _emailCtrl,
//                 readOnly: true,
//               ),

//               const SizedBox(height: 32),

//               // Save All button
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: SizedBox(
//                   width: 140,
//                   child: GradientButton(
//                     text: 'Save',
//                     onPressed: () {
//                       // TODO: persist all changes
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

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

  @override
  Widget build(BuildContext context) {
    final pad = responsivePadding(context);
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        leading: BackButton(color: Theme.of(context).appBarTheme.iconTheme?.color ?? cs.onSurface),
        title: Text('Profile', style: AppTheme.heading2.copyWith(color: Theme.of(context).appBarTheme.titleTextStyle?.color ?? cs.onSurface)),
      ),
      body: SafeArea(
        child: AntiOverflowScroll(
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
