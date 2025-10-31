// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../utils/responsive.dart';
// import '../../widgets/custom_text_field.dart';
// import '../../widgets/gradient_button.dart';

// // Shared layout + root-tab targets
// import '../../widgets/layout/main_layout.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';
// import '../../../core/theme_controller.dart';

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

//   // ----- BottomNav routing to the 5 root tabs -----
//   void _handleTabChange(BuildContext context, int i) {
//     late final Widget target;
//     switch (i) {
//       case 0: target = const DashboardScreen();    break; // Dashboard
//       case 1: target = const AddProjectScreen();   break; // Add Project
//       case 2: target = const AddActivityScreen();  break; // Add Activity
//       case 3: target = const AnalyticsScreen();    break; // Analytics
//       case 4: target = const ViewUsersScreen();    break; // View Users
//       default: return;
//     }
//     Navigator.of(context).pushReplacement(
//       MaterialPageRoute(builder: (_) => target),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final pad = responsivePadding(context);
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Profile',
//       centerTitle: true,

//       // Profile is *not* one of the 5 root tabs, so show the bar but don't
//       // select any item. (-1 is supported by CustomBottomNavBar logic you have)
//       currentIndex: -1,
//       onTabChanged: (i) => _handleTabChange(context, i),

//       // keep consistent feel with other pages
//       safeArea: true,
//       reserveBottomPadding: true,
//       drawerEnabled: false,

//       // optional: theme toggle in actions for consistency
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
//       ],

//       body: AntiOverflowScroll(
//         child: MaxWidth(
//           child: Padding(
//             padding: pad,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Avatar
//                 Center(
//                   child: GestureDetector(
//                     onTap: _pickAvatar,
//                     child: CircleAvatar(
//                       radius: context.w < 360 ? 48 : 54,
//                       backgroundColor: cs.surfaceContainerHighest,
//                       child: CircleAvatar(
//                         radius: context.w < 360 ? 46 : 52,
//                         backgroundImage: _avatarFile != null
//                             ? FileImage(_avatarFile!)
//                             : const AssetImage('assets/User_profile.png') as ImageProvider,
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 12),

//                 // Name
//                 CustomTextField(
//                   label: 'Name',
//                   controller: _nameCtrl,
//                   readOnly: !_editingName,
//                   showAction: true,
//                   actionLabel: _editingName ? 'SAVE' : 'EDIT',
//                   onActionTap: () {
//                     setState(() => _editingName = !_editingName);
//                     // TODO: persist name
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Contact
//                 CustomTextField(
//                   label: 'Contact No',
//                   controller: _contactCtrl,
//                   readOnly: !_editingContact,
//                   keyboardType: TextInputType.phone,
//                   showAction: true,
//                   actionLabel: _editingContact ? 'SAVE' : 'EDIT',
//                   onActionTap: () {
//                     setState(() => _editingContact = !_editingContact);
//                     // TODO: persist contact
//                   },
//                 ),
//                 const SizedBox(height: 24),

//                 // Username & Designation (stack on narrow, row on wider)
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     final isNarrow = constraints.maxWidth < 420;
//                     final gap = 12.0;

//                     final username = CustomTextField(
//                       label: 'Username',
//                       controller: _usernameCtrl,
//                       readOnly: true,
//                     );

//                     final designation = _DropdownField<String>(
//                       label: 'Designation',
//                       value: _designation,
//                       items: _designations,
//                       onChanged: (v) => setState(() => _designation = v ?? _designation),
//                     );

//                     if (isNarrow) {
//                       return Column(
//                         children: [
//                           username,
//                           SizedBox(height: gap),
//                           designation,
//                         ],
//                       );
//                     } else {
//                       return Row(
//                         children: [
//                           Expanded(child: username),
//                           SizedBox(width: gap),
//                           Expanded(child: designation),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Role & Projects (stack on narrow)
//                 LayoutBuilder(
//                   builder: (context, constraints) {
//                     final isNarrow = constraints.maxWidth < 420;
//                     final gap = 12.0;

//                     final role = CustomTextField(
//                       label: 'Role',
//                       controller: _roleCtrl,
//                       readOnly: true,
//                     );

//                     final projects = _DropdownField<String>(
//                       label: 'Projects',
//                       value: _project,
//                       items: const ['Select Project', ...[
//                         'Telstra', 'CBI', 'Airtel', 'BPCL'
//                       ]],
//                       onChanged: (v) => setState(() => _project = v ?? _project),
//                     );

//                     if (isNarrow) {
//                       return Column(
//                         children: [
//                           role,
//                           SizedBox(height: gap),
//                           projects,
//                         ],
//                       );
//                     } else {
//                       return Row(
//                         children: [
//                           Expanded(child: role),
//                           SizedBox(width: gap),
//                           Expanded(child: projects),
//                         ],
//                       );
//                     }
//                   },
//                 ),
//                 const SizedBox(height: 16),

//                 // Email
//                 CustomTextField(
//                   label: 'Email',
//                   controller: _emailCtrl,
//                   readOnly: true,
//                 ),

//                 const SizedBox(height: 28),

//                 // Save All button (shrinks on narrow)
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxWidth: context.w < 360 ? 120 : 160,
//                     ),
//                     child: GradientButton(
//                       text: 'Save',
//                       onPressed: () {
//                         // TODO: persist all changes
//                       },
//                     ),
//                   ),
//                 ),
//               ],
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
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../core/api_client.dart';
import '../../../state/user_session.dart';
import '../../../core/theme_controller.dart';

import '../../utils/responsive.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/gradient_button.dart';
import '../../widgets/layout/main_layout.dart';

// Root tabs
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

/* ------------------------------ DTO ------------------------------ */
class _ProjectOption {
  final String code;
  final String name;
  _ProjectOption({required this.code, required this.name});
}

/* ------------------------------ UI ------------------------------ */
class _ProfileScreenState extends State<ProfileScreen> {
  // Controllers
  final _nameCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();
  final _usernameCtrl = TextEditingController(); // read-only
  final _roleCtrl = TextEditingController(); // read-only
  final _emailCtrl = TextEditingController(); // read-only

  // Toggles
  bool _editingName = false;
  bool _editingContact = false;

  // Designation & Projects (multi)
  String _designation = 'Project Manager';
  final _designationOptions = const ['Project Manager', 'NOC Engineer', 'SCM'];
  List<_ProjectOption> _projectOptions = [];
  final List<String> _selectedProjectCodes = []; // project_code list

  // Avatar
  File? _avatarFile; // local picked file
  String? _avatarNetwork; // server-hosted URL
  final ImagePicker _picker = ImagePicker();

  // State
  bool _loading = true;
  bool _busy = false;
  bool _isNewProfile = false;

  // Shortcuts
  ApiClient get _api => context.read<ApiClient>();
  UserSession get _session => context.read<UserSession>();

  @override
  void initState() {
    super.initState();
    _bootstrap();
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

  Future<void> _bootstrap() async {
    setState(() => _loading = true);
    try {
      // Ensure session is loaded
      if (_session.token == null) {
        await _session.restore();
      }
      final email = _session.email;
      if ((email ?? '').isEmpty) {
        _toast('You are not logged in');
        setState(() => _loading = false);
        return;
      }
      _emailCtrl.text = email!;

      // /auth/me → username, role
      final me = await _api.get('/api/auth/me');
      if (me.statusCode >= 200 && me.statusCode < 300) {
        final m = jsonDecode(me.body) as Map<String, dynamic>;
        final user = (m['user'] as Map?) ?? {};
        _usernameCtrl.text = (user['name'] ?? '').toString();
        _roleCtrl.text = (user['role'] ?? (_session.role ?? '')).toString();

        // if API returns email here, prefer it
        final e2 = (user['email'] ?? '').toString();
        if (e2.isNotEmpty) _emailCtrl.text = e2;
      } else {
        _roleCtrl.text = _session.role ?? '';
      }

      // Projects list
      final p = await _api.get('/api/projects');
      if (p.statusCode >= 200 && p.statusCode < 300) {
        final list = (jsonDecode(p.body) as List?) ?? [];
        _projectOptions =
            list
                .map(
                  (e) => _ProjectOption(
                    code: (e['project_code'] ?? '').toString(),
                    name: (e['project_name'] ?? '').toString(),
                  ),
                )
                .where((x) => x.code.isNotEmpty && x.name.isNotEmpty)
                .toList();
      }

      // User profile
      final up = await _api.get(
        '/api/user-profile/${Uri.encodeComponent(_emailCtrl.text)}',
      );
      if (up.statusCode == 404) {
        _isNewProfile = true;
        _designation = _designationOptions.first;
        _avatarNetwork = null;
        _selectedProjectCodes.clear();
      } else if (up.statusCode >= 200 && up.statusCode < 300) {
        _isNewProfile = false;
        final body = jsonDecode(up.body) as Map<String, dynamic>;
        final prof = (body['user_profile'] as Map?) ?? {};
        _nameCtrl.text = (prof['full_name'] ?? '').toString();
        _contactCtrl.text = (prof['contact_no'] ?? '').toString();
        _designation = (prof['designation'] ?? '').toString();
        if (_designation.isEmpty) _designation = _designationOptions.first;

        // projects can be List or JSON string
        _selectedProjectCodes
          ..clear()
          ..addAll(_parseProjects(prof['projects']));

        final pic = (prof['profile_picture'] ?? '').toString();
        _avatarNetwork = pic.isEmpty ? null : (_api.baseUrl + pic);
      } else {
        _toast('Failed to load profile');
      }
    } catch (_) {
      _toast('Failed to load profile');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  List<String> _parseProjects(dynamic raw) {
    if (raw is List) return raw.map((e) => e.toString()).toList();
    if (raw is String && raw.trim().isNotEmpty) {
      try {
        final d = jsonDecode(raw);
        if (d is List) return d.map((e) => e.toString()).toList();
      } catch (_) {}
    }
    return <String>[];
  }

  Future<void> _pickAvatar() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final f = File(picked.path);
    final size = await f.length();
    if (size > 20 * 1024 * 1024) {
      _toast('Image is too big. Max size is 20 MB.');
      return;
    }
    setState(() {
      _avatarFile = f;
      _avatarNetwork = null; // show local preview
    });
  }

  Future<void> _save() async {
    if (_busy) return;
    final email = _emailCtrl.text.trim();
    if (email.isEmpty) {
      _toast('Missing email');
      return;
    }

    setState(() => _busy = true);
    try {
      final fields = <String, String>{
        'full_name': _nameCtrl.text.trim(),
        'username': _usernameCtrl.text.trim(),
        'email': email,
        'role': _roleCtrl.text.trim(),
        'contact_no': _contactCtrl.text.trim(),
        'designation': _designation,
        'projects': jsonEncode(_selectedProjectCodes),
      };

      final files = <http.MultipartFile>[];
      if (_avatarFile != null) {
        files.add(
          await http.MultipartFile.fromPath(
            'profile_picture',
            _avatarFile!.path,
          ),
        );
      }

      final path =
          _isNewProfile
              ? '/api/user-profile'
              : '/api/user-profile/${Uri.encodeComponent(email)}';

      final method = _isNewProfile ? 'POST' : 'PUT';

      final streamed = await _api.multipart(
        path,
        method: method,
        fields: fields,
        files: files.isEmpty ? null : files,
      );

      final res = await http.Response.fromStream(streamed);
      if (res.statusCode < 200 || res.statusCode >= 300) {
        String msg = 'Save failed (HTTP ${res.statusCode})';
        try {
          final body = jsonDecode(res.body);
          msg = (body['error'] ?? body['message'] ?? msg).toString();
        } catch (_) {}
        _toast(msg);
        return;
      }

      final data = jsonDecode(res.body) as Map<String, dynamic>;
      final up = (data['user_profile'] as Map?) ?? {};

      _nameCtrl.text = (up['full_name'] ?? _nameCtrl.text).toString();
      _contactCtrl.text = (up['contact_no'] ?? _contactCtrl.text).toString();
      final des = (up['designation'] ?? _designation).toString();
      _designation = des.isEmpty ? _designationOptions.first : des;

      _selectedProjectCodes
        ..clear()
        ..addAll(_parseProjects(up['projects']));

      final pic = (up['profile_picture'] ?? '').toString();
      if (pic.isNotEmpty) {
        _avatarNetwork = _api.baseUrl + pic;
        _avatarFile = null;
      }

      _isNewProfile = false;
      _editingName = false;
      _editingContact = false;
      _toast('User profile updated successfully', success: true);
    } catch (_) {
      _toast('Error saving profile');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String msg, {bool success = false}) {
    final cs = Theme.of(context).colorScheme;
    final bg =
        success
            ? const Color(0xFF2E7D32)
            : (Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF5E2A2A)
                : const Color(0xFFFFE9E9));
    final fg = success ? Colors.white : cs.onSurface;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: TextStyle(color: fg)),
        backgroundColor: bg,
      ),
    );
  }

  void _handleTabChange(BuildContext context, int i) {
    late final Widget target;
    switch (i) {
      case 0:
        target = const DashboardScreen();
        break;
      case 1:
        target = const AddProjectScreen();
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
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  @override
  Widget build(BuildContext context) {
    final pad = responsivePadding(context);
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Profile',
      centerTitle: true,
      currentIndex: -1,
      onTabChanged: (i) => _handleTabChange(context, i),
      safeArea: true,
      reserveBottomPadding: true,
      drawerEnabled: false,
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
      ],
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  AntiOverflowScroll(
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
                                    backgroundImage:
                                        _avatarFile != null
                                            ? FileImage(_avatarFile!)
                                            : (_avatarNetwork != null
                                                ? NetworkImage(_avatarNetwork!)
                                                    as ImageProvider
                                                : const AssetImage(
                                                  'assets/User_profile.png',
                                                )),
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
                              onActionTap:
                                  () => setState(
                                    () => _editingName = !_editingName,
                                  ),
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
                              onActionTap:
                                  () => setState(
                                    () => _editingContact = !_editingContact,
                                  ),
                            ),
                            const SizedBox(height: 24),

                            // Username + Designation
                            LayoutBuilder(
                              builder: (context, c) {
                                final narrow = c.maxWidth < 420;
                                final gap = 12.0;
                                final username = CustomTextField(
                                  label: 'Username',
                                  controller: _usernameCtrl,
                                  readOnly: true,
                                );
                                final designation = _DesignationField(
                                  value: _designation,
                                  options: _designationOptions,
                                  onChanged:
                                      (v) => setState(() => _designation = v),
                                );
                                return narrow
                                    ? Column(
                                      children: [
                                        username,
                                        SizedBox(height: gap),
                                        designation,
                                      ],
                                    )
                                    : Row(
                                      children: [
                                        Expanded(child: username),
                                        SizedBox(width: gap),
                                        Expanded(child: designation),
                                      ],
                                    );
                              },
                            ),
                            const SizedBox(height: 16),

                            // Role + Projects (multi)
                            LayoutBuilder(
                              builder: (context, c) {
                                final narrow = c.maxWidth < 420;
                                final gap = 12.0;

                                final role = CustomTextField(
                                  label: 'Role',
                                  controller: _roleCtrl,
                                  readOnly: true,
                                );

                                final projects = _ProjectsPicker(
                                  pickedNames:
                                      _projectOptions
                                          .where(
                                            (p) => _selectedProjectCodes
                                                .contains(p.code),
                                          )
                                          .map((p) => p.name)
                                          .toList(),
                                  onTap: _pickProjects,
                                );

                                return narrow
                                    ? Column(
                                      children: [
                                        role,
                                        SizedBox(height: gap),
                                        projects,
                                      ],
                                    )
                                    : Row(
                                      children: [
                                        Expanded(child: role),
                                        SizedBox(width: gap),
                                        Expanded(child: projects),
                                      ],
                                    );
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

                            Align(
                              alignment: Alignment.centerRight,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  maxWidth: context.w < 360 ? 120 : 160,
                                ),
                                child:
                                //  GradientButton(
                                //   text: _busy ? 'Saving…' : 'Save',
                                //   onPressed: _busy ? null : _save,
                                // ),
                                GradientButton(
                                  text: _busy ? 'Saving…' : 'Save',
                                  onPressed:
                                      _busy
                                          ? () {}
                                          : () async {
                                            await _save();
                                          },
                                  // <- wrap the async call
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

  Future<void> _pickProjects() async {
    final selected = Set<String>.from(_selectedProjectCodes);
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final cs = Theme.of(ctx).colorScheme;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Select Projects',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                    color: cs.onSurface,
                  ),
                ),
                const SizedBox(height: 8),

                Flexible(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 360),
                    child: ListView.builder(
                      itemCount: _projectOptions.length,
                      itemBuilder: (_, i) {
                        final p = _projectOptions[i];
                        final checked = selected.contains(p.code);
                        return CheckboxListTile(
                          value: checked,
                          onChanged: (v) {
                            if (v == true) {
                              selected.add(p.code);
                            } else {
                              selected.remove(p.code);
                            }
                            (ctx as Element).markNeedsBuild();
                          },
                          title: Text(p.name),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Spacer(),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {
                        setState(() {
                          _selectedProjectCodes
                            ..clear()
                            ..addAll(selected);
                        });
                        Navigator.pop(ctx);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

/* ---------------------- Small reusable widgets ---------------------- */

class _DesignationField extends StatelessWidget {
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const _DesignationField({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Designation',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: value,
              iconEnabledColor: cs.onSurfaceVariant,
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              items:
                  options
                      .map(
                        (v) => DropdownMenuItem<String>(
                          value: v,
                          child: Text(v, style: TextStyle(color: cs.onSurface)),
                        ),
                      )
                      .toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }
}

// class _ProjectsPicker extends StatelessWidget {
//   final List<String> pickedNames; // display names only
//   final VoidCallback onTap;
//   const _ProjectsPicker({required this.pickedNames, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final names = pickedNames.isEmpty ? 'Select Projects' : pickedNames.join(', ');

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text('Projects',
//             style: Theme.of(context).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
//         const SizedBox(height: 8),
//         InkWell(
//           onTap: onTap,
//           borderRadius: BorderRadius.circular(8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
//             decoration: BoxDecoration(
//               color: Theme.of(context).colorScheme.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Text(
//               names,
//               style: TextStyle(color: cs.onSurface),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _ProjectsPicker extends StatelessWidget {
  final List<String> pickedNames; // display names only
  final VoidCallback onTap;
  const _ProjectsPicker({required this.pickedNames, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final names =
        pickedNames.isEmpty ? 'Select Projects' : pickedNames.join(', ');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
        const SizedBox(height: 8),

        // full width like other fields, text aligned to start
        SizedBox(
          width: double.infinity,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                names,
                style: TextStyle(color: cs.onSurface),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
