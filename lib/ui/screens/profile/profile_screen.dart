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
//               const SizedBox(height: 24),

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
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers
  final _nameCtrl    = TextEditingController();
  final _contactCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController(); // read-only
  final _roleCtrl     = TextEditingController(); // read-only
  final _emailCtrl    = TextEditingController(); // read-only

  // Edit state
  bool _editingName = false;
  bool _editingContact = false;

  // Dropdown selections
  String _designation = 'Project Manager';
  String _project     = 'Select Project';
  final _designations = [
    'Project Manager',
    'Site Engineer',
    'Technical Lead',
  ];
  final _projectsList = [
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
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundColor,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: const Text('Profile', style: AppTheme.heading2),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              // Avatar
              GestureDetector(
                onTap: _pickAvatar,
                child: CircleAvatar(
                  radius: 54,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 52,
                    backgroundImage: _avatarFile != null
                        ? FileImage(_avatarFile!)
                        : const AssetImage('assets/User_profile.png')
                            as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Name field
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
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
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Contact field
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
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
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Username & Designation
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Username',
                      controller: _usernameCtrl,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Designation',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _designation,
                              isExpanded: true,
                              dropdownColor: AppTheme.backgroundColor,
                              iconEnabledColor: Colors.white54,
                              items: _designations
                                  .map((d) => DropdownMenuItem(
                                        value: d,
                                        child: Text(d,
                                            style: const TextStyle(
                                                color: Colors.white)),
                                      ))
                                  .toList(),
                              onChanged: (v) {
                                setState(() => _designation = v!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Role & Projects
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'Role',
                      controller: _roleCtrl,
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Projects',
                            style:
                                TextStyle(color: Colors.white70, fontSize: 14)),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: _project,
                              isExpanded: true,
                              dropdownColor: AppTheme.backgroundColor,
                              iconEnabledColor: Colors.white54,
                              items: [
                                DropdownMenuItem(
                                  value: 'Select Project',
                                  child: Text('Select Project',
                                      style: TextStyle(
                                          color: Colors.white54)),
                                ),
                                ..._projectsList.map((p) =>
                                    DropdownMenuItem(
                                      value: p,
                                      child: Text(p,
                                          style: const TextStyle(
                                              color: Colors.white)),
                                    )),
                              ],
                              onChanged: (v) {
                                setState(() => _project = v!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Email
              CustomTextField(
                label: 'Email',
                controller: _emailCtrl,
                readOnly: true,
              ),

              const SizedBox(height: 32),

              // Save All button
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 140,
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
    );
  }
}
