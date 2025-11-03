// import 'package:flutter/material.dart';
// import '../../../core/theme_controller.dart';
// import '../profile/profile_screen.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class AddFEVendorScreen extends StatefulWidget {
//   const AddFEVendorScreen({super.key});

//   @override
//   State<AddFEVendorScreen> createState() => _AddFEVendorScreenState();
// }

// class _AddFEVendorScreenState extends State<AddFEVendorScreen> {
//   // --- dropdown data (sample) ---
//   final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
//   final _sites = const ['Site 001', 'Site 002', 'Site 003'];
//   final _zones = const ['North', 'East', 'South', 'West'];
//   final _states = const ['Maharashtra', 'Gujarat', 'Karnataka'];
//   final _districts = const ['Thane', 'Pune', 'Ahmedabad', 'Bengaluru Urban'];

//   // --- selections ---
//   String? _project;
//   String? _site;
//   String? _zone;
//   String? _state;
//   String? _district;

//   // --- text controllers ---
//   final _fullNameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _contactCtrl = TextEditingController();

//   final _bankNameCtrl = TextEditingController();
//   final _bankAccCtrl = TextEditingController();
//   final _bankIfscCtrl = TextEditingController();
//   final _panCtrl = TextEditingController();
//   final _vendorNameCtrl = TextEditingController();

//   final _roleCtrl = TextEditingController(text: 'Field Engineer / Vendor');

//   @override
//   void dispose() {
//     _fullNameCtrl.dispose();
//     _emailCtrl.dispose();
//     _contactCtrl.dispose();
//     _bankNameCtrl.dispose();
//     _bankAccCtrl.dispose();
//     _bankIfscCtrl.dispose();
//     _panCtrl.dispose();
//     _vendorNameCtrl.dispose();
//     _roleCtrl.dispose();
//     super.dispose();
//   }

//   void _clearAll() {
//     setState(() {
//       _fullNameCtrl.clear();
//       _emailCtrl.clear();
//       _contactCtrl.clear();
//       _bankNameCtrl.clear();
//       _bankAccCtrl.clear();
//       _bankIfscCtrl.clear();
//       _panCtrl.clear();
//       _vendorNameCtrl.clear();
//       _project = null;
//       _site = null;
//       _zone = null;
//       _state = null;
//       _district = null;
//     });
//   }

//   final int _selectedTab = 0;

// void _handleTabChange(int i) {
//   if (i == _selectedTab) return;
//   late final Widget target;
//   switch (i) {
//     case 0: target = const DashboardScreen(); break;
//     case 1: target = const AddProjectScreen(); break;
//     case 2: target = const AddActivityScreen(); break;
//     case 3: target = const AnalyticsScreen(); break;
//     case 4: target = const ViewUsersScreen(); break;
//     default: return;
//   }
//   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
// }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     // return MainLayout(
//     //   title: 'Add Field Engineer',
//     //   centerTitle: true,
//     //   currentIndex: 0,
//     //   onTabChanged: (_) {},
//     //   safeArea: false,
//     //   reserveBottomPadding: true,
//     //   body: ListView(
//     return MainLayout(
//       title: 'Add Field Engineer',
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
//           // icon: ClipOval(
//           //   child: Image.asset(
//           //     'assets/User_profile.png',
//           //     width: 36,
//           //     height: 36,
//           //     fit: BoxFit.cover,
//           //   ),
//           // ),
//           icon: const ProfileAvatar(size: 36),

//         ),
//         const SizedBox(width: 8),
//       ],
//       // currentIndex: 0,
//       // onTabChanged: (_) {},
//       currentIndex: _selectedTab,
// onTabChanged: (i) => _handleTabChange(i),
//       safeArea: false,
//       reserveBottomPadding: true,
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
//                   // Header row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Create Field Engineer / Vendor',
//                           style: Theme.of(
//                             context,
//                           ).textTheme.titleLarge?.copyWith(
//                             color: cs.onSurface,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                       TextButton(
//                         onPressed: _clearAll,
//                         child: const Text('Clear'),
//                       ),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   // ===== Top section: Identity / Assignment =====
//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final isWide = c.maxWidth >= 640;
//                       final gap = isWide ? 12.0 : 0.0;

//                       final left = [
//                         _TextField(
//                           label: 'Full Name *',
//                           controller: _fullNameCtrl,
//                         ),
//                         _TextField(
//                           label: 'Email *',
//                           controller: _emailCtrl,
//                           keyboardType: TextInputType.emailAddress,
//                         ),
//                         _TextField(
//                           label: 'Contact No *',
//                           controller: _contactCtrl,
//                           keyboardType: TextInputType.phone,
//                         ),
//                       ];

//                       final right = [
//                         _ROText('Role', _roleCtrl),
//                         _Dropdown<String>(
//                           label: 'Project Working *',
//                           value: _project,
//                           items: _projects,
//                           onChanged: (v) => setState(() => _project = v),
//                         ),
//                         _Dropdown<String>(
//                           label: 'Site *',
//                           value: _site,
//                           items: _sites,
//                           onChanged: (v) => setState(() => _site = v),
//                         ),
//                       ];

//                       if (!isWide) {
//                         return Column(children: [...left, ...right]);
//                       }
//                       return Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(child: Column(children: left)),
//                           SizedBox(width: gap),
//                           Expanded(child: Column(children: right)),
//                         ],
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 14),
//                   Divider(color: cs.outlineVariant),
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 6, top: 2),
//                     child: Text(
//                       'Bank Details',
//                       style: TextStyle(
//                         color: cs.onSurfaceVariant,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),

//                   // ===== Bank + Region section =====
//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final isWide = c.maxWidth >= 640;
//                       final gap = isWide ? 12.0 : 0.0;

//                       final left = [
//                         _TextField(
//                           label: 'Bank Name',
//                           controller: _bankNameCtrl,
//                         ),
//                         _TextField(
//                           label: 'Bank IFSC',
//                           controller: _bankIfscCtrl,
//                         ),
//                         _Dropdown<String>(
//                           label: 'Zone *',
//                           value: _zone,
//                           items: _zones,
//                           onChanged: (v) => setState(() => _zone = v),
//                         ),
//                         _Dropdown<String>(
//                           label: 'State *',
//                           value: _state,
//                           items: _states,
//                           onChanged: (v) => setState(() => _state = v),
//                         ),
//                       ];

//                       final right = [
//                         _TextField(
//                           label: 'Bank Account No',
//                           controller: _bankAccCtrl,
//                           keyboardType: TextInputType.number,
//                         ),
//                         _TextField(label: 'Pan No', controller: _panCtrl),
//                         _TextField(
//                           label: 'Vendor Name',
//                           controller: _vendorNameCtrl,
//                         ),
//                         _Dropdown<String>(
//                           label: 'District *',
//                           value: _district,
//                           items: _districts,
//                           onChanged: (v) => setState(() => _district = v),
//                         ),
//                       ];

//                       if (!isWide) {
//                         return Column(children: [...left, ...right]);
//                       }
//                       return Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(child: Column(children: left)),
//                           SizedBox(width: gap),
//                           Expanded(child: Column(children: right)),
//                         ],
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 16),
//                   // wide create button aligned to right (similar to Save on Add Project)
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ConstrainedBox(
//                       constraints: const BoxConstraints(minWidth: 220),
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // TODO: hook actual create
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('PM Created')),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 24,
//                             vertical: 12,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           'Create',
//                           style: TextStyle(fontWeight: FontWeight.w800),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// --- Small UI helpers (same as other forms) ---

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
//   final TextInputType? keyboardType;

//   const _TextField({
//     required this.label,
//     required this.controller,
//     this.maxLines = 1,        // <-- default so it's always initialized
//     this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
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
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
//           filled: true,
//           fillColor: cs.surface,
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
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

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/theme_controller.dart';
// import '../profile/profile_screen.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// import 'package:pmgt/core/api_client.dart';

// import 'package:csc_picker_plus/csc_picker_plus.dart';

// class AddFEVendorScreen extends StatefulWidget {
//   const AddFEVendorScreen({super.key});
//   @override
//   State<AddFEVendorScreen> createState() => _AddFEVendorScreenState();
// }

// /* ---------- lightweight models ---------- */
// class _ProjectOption {
//   final String code; // project_code or id
//   final String name; // project_name
//   _ProjectOption({required this.code, required this.name});
// }

// class _ProjectSiteRaw {
//   final String? projectName; // may be null in some backends
//   final String siteName;
//   _ProjectSiteRaw({required this.projectName, required this.siteName});

//   factory _ProjectSiteRaw.fromJson(Map<String, dynamic> m) => _ProjectSiteRaw(
//     projectName: (m['project_name'] ?? m['project'] ?? '')?.toString(),
//     siteName: (m['site_name'] ?? '').toString(),
//   );
// }

// class _AddFEVendorScreenState extends State<AddFEVendorScreen> {
//   // services
//   ApiClient get _api => context.read<ApiClient>();

//   // --- form state ---
//   final _fullNameCtrl = TextEditingController();
//   final _emailCtrl = TextEditingController();
//   final _contactCtrl = TextEditingController();
//   final _bankNameCtrl = TextEditingController();
//   final _bankAccCtrl = TextEditingController();
//   final _bankIfscCtrl = TextEditingController();
//   final _panCtrl = TextEditingController();
//   final _vendorNameCtrl = TextEditingController();

//   String _roleValue = 'Field Engineer'; // dropdown

//   // projects & sites (multi-select)
//   List<_ProjectOption> _projectOptions = [];
//   List<String> _selectedProjectCodes = [];
//   List<_ProjectSiteRaw> _projectSites = [];
//   List<String> _selectedSiteNames = [];

//   // location (from csc_picker_plus)
//   String _state = '';
//   String _district = '';

//   // ui
//   bool _busy = false;

//   // bottom nav
//   final int _selectedTab = 0;
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
//   void initState() {
//     super.initState();
//     _bootstrap();
//   }

//   @override
//   void dispose() {
//     _fullNameCtrl.dispose();
//     _emailCtrl.dispose();
//     _contactCtrl.dispose();
//     _bankNameCtrl.dispose();
//     _bankAccCtrl.dispose();
//     _bankIfscCtrl.dispose();
//     _panCtrl.dispose();
//     _vendorNameCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _bootstrap() async {
//     await Future.wait([_loadProjects(), _loadProjectSites()]);
//   }

//   Future<void> _loadProjects() async {
//     try {
//       final res = await _api.get('/api/projects');
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         final arr = jsonDecode(res.body) as List;
//         final mapped =
//             arr
//                 .map((p) {
//                   final mp = p as Map<String, dynamic>;
//                   final code =
//                       (mp['project_code'] ?? mp['id'] ?? '').toString();
//                   final name = (mp['project_name'] ?? '').toString();
//                   return _ProjectOption(code: code, name: name);
//                 })
//                 .where((e) => e.code.isNotEmpty && e.name.isNotEmpty)
//                 .toList();
//         setState(() => _projectOptions = mapped);
//       }
//     } catch (_) {
//       setState(() => _projectOptions = []);
//     }
//   }

//   Future<void> _loadProjectSites() async {
//     try {
//       final res = await _api.get('/api/project-sites');
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         final arr = jsonDecode(res.body) as List;
//         final mapped =
//             arr
//                 .map((e) => _ProjectSiteRaw.fromJson(e as Map<String, dynamic>))
//                 .toList();
//         setState(() => _projectSites = mapped);
//       }
//     } catch (_) {
//       setState(() => _projectSites = []);
//     }
//   }

//   // sites filtered by selected project names
//   List<String> get _filteredSiteOptions {
//     final selectedNames =
//         _selectedProjectCodes
//             .map(
//               (c) =>
//                   _projectOptions
//                       .firstWhere(
//                         (p) => p.code == c,
//                         orElse: () => _ProjectOption(code: '', name: ''),
//                       )
//                       .name,
//             )
//             .where((n) => n.isNotEmpty)
//             .toSet();

//     final names =
//         _projectSites
//             .where(
//               (ps) =>
//                   ps.projectName == null ||
//                   selectedNames.contains(ps.projectName),
//             )
//             .map((ps) => ps.siteName)
//             .toSet()
//             .toList()
//           ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
//     return names;
//   }

//   void _clearAll() {
//     setState(() {
//       _fullNameCtrl.clear();
//       _emailCtrl.clear();
//       _contactCtrl.clear();
//       _bankNameCtrl.clear();
//       _bankAccCtrl.clear();
//       _bankIfscCtrl.clear();
//       _panCtrl.clear();
//       _vendorNameCtrl.clear();
//       _roleValue = 'Field Engineer';
//       _selectedProjectCodes = [];
//       _selectedSiteNames = [];
//       _state = '';
//       _district = '';
//     });
//   }

//   bool get _canSubmit =>
//       _fullNameCtrl.text.trim().length > 1 &&
//       _contactCtrl.text.trim().length >= 7 &&
//       _selectedProjectCodes.isNotEmpty &&
//       _selectedSiteNames.isNotEmpty &&
//       _state.isNotEmpty &&
//       _district.isNotEmpty;

//   Future<void> _create() async {
//     if (!_canSubmit) {
//       _toast('Please fill all required fields');
//       return;
//     }
//     setState(() => _busy = true);
//     try {
//       final payload = {
//         'full_name': _fullNameCtrl.text.trim(),
//         'role': _roleValue, // 'Field Engineer' | 'Vendor'
//         'email': _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
//         'contact_no': _contactCtrl.text.trim(),
//         'project_codes': _selectedProjectCodes, // list of codes
//         'site_names': _selectedSiteNames, // list of names
//         'bank_info':
//             _bankNameCtrl.text.trim().isEmpty
//                 ? null
//                 : _bankNameCtrl.text.trim(),
//         'bank_account':
//             _bankAccCtrl.text.trim().isEmpty ? null : _bankAccCtrl.text.trim(),
//         'ifsc':
//             _bankIfscCtrl.text.trim().isEmpty
//                 ? null
//                 : _bankIfscCtrl.text.trim(),
//         'pan': _panCtrl.text.trim().isEmpty ? null : _panCtrl.text.trim(),
//         'zone': null, // optional; add a dropdown if you want to enforce
//         'contact_person':
//             _vendorNameCtrl.text.trim().isEmpty
//                 ? null
//                 : _vendorNameCtrl.text.trim(),
//         'state': _state,
//         'district': _district,
//       };

//       final res = await _api.post('/api/field-engineers', body: payload);
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         _toast('Field Engineer / Vendor created', success: true);
//         _clearAll();
//       } else if (res.statusCode == 409) {
//         _toast('A Field Engineer with that email already exists');
//       } else {
//         _toast('Failed to create Field Engineer / Vendor');
//       }
//     } catch (_) {
//       _toast('Failed to create Field Engineer / Vendor');
//     } finally {
//       if (mounted) setState(() => _busy = false);
//     }
//   }

//   void _toast(String msg, {bool success = false}) {
//     final cs = Theme.of(context).colorScheme;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           msg,
//           style: TextStyle(color: success ? Colors.white : cs.onSurface),
//         ),
//         backgroundColor:
//             success
//                 ? const Color(0xFF2E7D32)
//                 : (Theme.of(context).brightness == Brightness.dark
//                     ? const Color(0xFF5E2A2A)
//                     : const Color(0xFFFFE9E9)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add Field Engineer',
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
//           onPressed:
//               () => Navigator.of(
//                 context,
//               ).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
//           icon: const ProfileAvatar(size: 36),
//         ),
//         const SizedBox(width: 8),
//       ],
//       currentIndex: _selectedTab,
//       onTabChanged: _handleTabChange,
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Stack(
//         children: [
//           ListView(
//             padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//             children: [
//               Card(
//                 color: cs.surfaceContainerHighest,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(14),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       // Header
//                       Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               'Create Field Engineer / Vendor',
//                               style: Theme.of(
//                                 context,
//                               ).textTheme.titleLarge?.copyWith(
//                                 color: cs.onSurface,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                           ),
//                           TextButton(
//                             onPressed: _clearAll,
//                             child: const Text('Clear'),
//                           ),
//                         ],
//                       ),
//                       Divider(color: cs.outlineVariant),

//                       // Identity + assignment
//                       LayoutBuilder(
//                         builder: (context, c) {
//                           final isWide = c.maxWidth >= 640;
//                           final gap = isWide ? 12.0 : 0.0;

//                           final left = [
//                             _TextField(
//                               label: 'Full Name *',
//                               controller: _fullNameCtrl,
//                             ),
//                             _TextField(
//                               label: 'Email',
//                               controller: _emailCtrl,
//                               keyboardType: TextInputType.emailAddress,
//                             ),
//                             _TextField(
//                               label: 'Contact No *',
//                               controller: _contactCtrl,
//                               keyboardType: TextInputType.phone,
//                             ),
//                           ];

//                           final right = [
//                             _Dropdown<String>(
//                               label: 'Role *',
//                               value: _roleValue,
//                               items: const ['Field Engineer', 'Vendor'],
//                               onChanged:
//                                   (v) => setState(
//                                     () => _roleValue = v ?? 'Field Engineer',
//                                   ),
//                             ),
//                             _SearchMultiSelect<String>(
//                               label: 'Project Working *',
//                               hint: 'Search projects…',
//                               // show project names but store project codes
//                               options:
//                                   _projectOptions
//                                       .map((p) => '${p.code}|||${p.name}')
//                                       .toList(),
//                               optionLabel: (raw) => raw.split('|||').last,
//                               optionKey: (raw) => raw.split('|||').first,
//                               selectedKeys: _selectedProjectCodes,
//                               onChanged: (codes) {
//                                 setState(() {
//                                   _selectedProjectCodes = codes;
//                                   // reset sites when projects change
//                                   _selectedSiteNames = [];
//                                 });
//                               },
//                             ),
//                             _SearchMultiSelect<String>(
//                               label: 'Sites *',
//                               hint: 'Search sites…',
//                               options: _filteredSiteOptions,
//                               optionLabel: (s) => s,
//                               optionKey: (s) => s,
//                               selectedKeys: _selectedSiteNames,
//                               onChanged:
//                                   (names) => setState(
//                                     () => _selectedSiteNames = names,
//                                   ),
//                               emptyText:
//                                   _selectedProjectCodes.isEmpty
//                                       ? 'Select at least one project to see its sites'
//                                       : 'No sites found for selected projects',
//                             ),
//                           ];

//                           if (!isWide)
//                             return Column(children: [...left, ...right]);
//                           return Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(child: Column(children: left)),
//                               SizedBox(width: gap),
//                               Expanded(child: Column(children: right)),
//                             ],
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 14),
//                       Divider(color: cs.outlineVariant),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 6, top: 2),
//                         child: Text(
//                           'Bank Details',
//                           style: TextStyle(
//                             color: cs.onSurfaceVariant,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ),

//                       // Bank + Vendor info
//                       LayoutBuilder(
//                         builder: (context, c) {
//                           final isWide = c.maxWidth >= 640;
//                           final gap = isWide ? 12.0 : 0.0;

//                           final left = [
//                             _TextField(
//                               label: 'Bank Name',
//                               controller: _bankNameCtrl,
//                             ),
//                             _TextField(
//                               label: 'Bank IFSC',
//                               controller: _bankIfscCtrl,
//                             ),
//                             _TextField(
//                               label: 'Vendor Name',
//                               controller: _vendorNameCtrl,
//                             ),
//                           ];
//                           final right = [
//                             _TextField(
//                               label: 'Bank Account No',
//                               controller: _bankAccCtrl,
//                               keyboardType: TextInputType.number,
//                             ),
//                             _TextField(label: 'Pan No', controller: _panCtrl),
//                           ];

//                           if (!isWide)
//                             return Column(children: [...left, ...right]);
//                           return Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(child: Column(children: left)),
//                               SizedBox(width: gap),
//                               Expanded(child: Column(children: right)),
//                             ],
//                           );
//                         },
//                       ),

//                       const SizedBox(height: 14),
//                       Divider(color: cs.outlineVariant),
//                       Padding(
//                         padding: const EdgeInsets.only(bottom: 6, top: 2),
//                         child: Text(
//                           'Location',
//                           style: TextStyle(
//                             color: cs.onSurfaceVariant,
//                             fontWeight: FontWeight.w700,
//                             fontSize: 13,
//                           ),
//                         ),
//                       ),

//                       // CSCPickerPlus(

//                       //   showCities: true,
//                       //   showCountries: false,

//                       //   flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
//                       //   dropdownDecoration: BoxDecoration(
//                       //     color: cs.surface,
//                       //     borderRadius: BorderRadius.circular(8),
//                       //     border: Border.all(color: cs.outlineVariant),
//                       //   ),

//                       //   onStateChanged: (v) {
//                       //     setState(() => _state = (v ?? '').toString());
//                       //   },

//                       //   // was: onDistrictChanged: (v) => setState(() => _district = (v ?? '').toString()),
//                       //   onCityChanged:
//                       //       (v) => setState(
//                       //         () => _district = (v ?? '').toString(),
//                       //       ),
//                       // ),

//                       // LOCATION — India only: State + District (no Country)
//                       Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: CSCPickerPlus(
//                           // no showCountries prop
//                           defaultCountry: CscCountry.India, // preselect India
//                           showStates: true, // enable state dropdown
//                           showCities: true, // use as District
//                           // (keep your styling and callbacks)
//                           onStateChanged:
//                               (v) => setState(() => _state = v ?? ''),
//                           onCityChanged:
//                               (v) => setState(() => _district = v ?? ''),

//                           // styling so the fields aren’t white
//                           dropdownDecoration: BoxDecoration(
//                             color: cs.surface,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: cs.outlineVariant),
//                           ),
//                           disabledDropdownDecoration: BoxDecoration(
//                             color:
//                                 cs.surface, // same surface color so it blends with theme
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: cs.outlineVariant),
//                           ),
//                           selectedItemStyle: TextStyle(
//                             color: cs.onSurface,
//                             fontSize: 14,
//                           ),
//                           dropdownHeadingStyle: TextStyle(
//                             color: cs.onSurface,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w700,
//                           ),
//                           dropdownItemStyle: TextStyle(color: cs.onSurface),
//                         ),
//                       ),

//                       const SizedBox(height: 16),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: ConstrainedBox(
//                           constraints: const BoxConstraints(minWidth: 220),
//                           child: ElevatedButton(
//                             onPressed: _busy ? null : _create,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppTheme.accentColor,
//                               foregroundColor: Colors.black,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 24,
//                                 vertical: 12,
//                               ),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                             ),
//                             child: Text(
//                               _busy ? 'Creating…' : 'Create',
//                               style: const TextStyle(
//                                 fontWeight: FontWeight.w800,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           if (_busy)
//             Positioned.fill(
//               child: Container(
//                 color: Colors.black.withOpacity(0.25),
//                 child: const Center(child: CircularProgressIndicator()),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// /* --------------------- Small UI helpers --------------------- */

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
//   final TextInputType? keyboardType;
//   const _TextField({
//     required this.label,
//     required this.controller,
//     this.maxLines = 1,
//     this.keyboardType,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surface,
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: AppTheme.accentColor),
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

// /* ------------ Searchable Multi-select (checkbox list) ------------ */
// class _SearchMultiSelect<T> extends StatelessWidget {
//   final String label;
//   final String hint;
//   final List<T> options; // all options
//   final List<String> selectedKeys; // selected identifiers
//   final String Function(T) optionLabel; // how to show each option
//   final String Function(T) optionKey; // unique key for each option
//   final ValueChanged<List<String>> onChanged;
//   final String? emptyText;

//   const _SearchMultiSelect({
//     required this.label,
//     required this.hint,
//     required this.options,
//     required this.optionLabel,
//     required this.optionKey,
//     required this.selectedKeys,
//     required this.onChanged,
//     this.emptyText,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: () async {
//           final result = await showModalBottomSheet<List<String>>(
//             context: context,
//             isScrollControlled: true,
//             backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//             ),
//             builder:
//                 (_) => _SearchMultiSelectSheet<T>(
//                   title: label,
//                   hint: hint,
//                   options: options,
//                   initialSelected: selectedKeys.toSet(),
//                   optionLabel: optionLabel,
//                   optionKey: optionKey,
//                   emptyText: emptyText,
//                 ),
//           );
//           if (result != null) onChanged(result);
//         },
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           decoration: BoxDecoration(
//             color: cs.surface,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           alignment: Alignment.centerLeft,
//           child: Text(
//             selectedKeys.isEmpty ? 'Select' : selectedKeys.join(', '),
//             overflow: TextOverflow.ellipsis,
//             style: TextStyle(
//               color: selectedKeys.isEmpty ? cs.onSurfaceVariant : cs.onSurface,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SearchMultiSelectSheet<T> extends StatefulWidget {
//   final String title;
//   final String hint;
//   final List<T> options;
//   final Set<String> initialSelected;
//   final String Function(T) optionLabel;
//   final String Function(T) optionKey;
//   final String? emptyText;

//   const _SearchMultiSelectSheet({
//     required this.title,
//     required this.hint,
//     required this.options,
//     required this.initialSelected,
//     required this.optionLabel,
//     required this.optionKey,
//     this.emptyText,
//   });

//   @override
//   State<_SearchMultiSelectSheet<T>> createState() =>
//       _SearchMultiSelectSheetState<T>();
// }

// class _SearchMultiSelectSheetState<T>
//     extends State<_SearchMultiSelectSheet<T>> {
//   late Set<String> _selected;
//   String _query = '';

//   @override
//   void initState() {
//     super.initState();
//     _selected = {...widget.initialSelected};
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final filtered =
//         widget.options.where((o) {
//           final label = widget.optionLabel(o).toLowerCase();
//           return _query.isEmpty || label.contains(_query.toLowerCase());
//         }).toList();

//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         top: 12,
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Container(
//             width: 36,
//             height: 4,
//             decoration: BoxDecoration(
//               color: cs.outlineVariant,
//               borderRadius: BorderRadius.circular(4),
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             widget.title,
//             style: Theme.of(
//               context,
//             ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
//           ),
//           const SizedBox(height: 12),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: widget.hint,
//                 prefixIcon: const Icon(Icons.search),
//                 filled: true,
//                 fillColor: cs.surface,
//                 isDense: true,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide: BorderSide(color: cs.outlineVariant),
//                 ),
//               ),
//               onChanged: (v) => setState(() => _query = v),
//             ),
//           ),
//           const SizedBox(height: 8),
//           if (filtered.isEmpty)
//             Padding(
//               padding: const EdgeInsets.all(16),
//               child: Text(
//                 widget.emptyText ?? 'No results',
//                 style: TextStyle(color: cs.onSurfaceVariant),
//               ),
//             )
//           else
//             Flexible(
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: filtered.length,
//                 itemBuilder: (_, i) {
//                   final item = filtered[i];
//                   final key = widget.optionKey(item);
//                   final label = widget.optionLabel(item);
//                   final checked = _selected.contains(key);
//                   return CheckboxListTile(
//                     value: checked,
//                     onChanged:
//                         (v) => setState(() {
//                           if (checked) {
//                             _selected.remove(key);
//                           } else {
//                             _selected.add(key);
//                           }
//                         }),
//                     title: Text(label),
//                   );
//                 },
//               ),
//             ),
//           const SizedBox(height: 8),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//             child: Row(
//               children: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('Cancel'),
//                 ),
//                 const Spacer(),
//                 FilledButton(
//                   onPressed: () => Navigator.pop(context, _selected.toList()),
//                   style: FilledButton.styleFrom(
//                     backgroundColor: AppTheme.accentColor,
//                     foregroundColor: Colors.black,
//                   ),
//                   child: const Text('Done'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme_controller.dart';
import '../profile/profile_screen.dart';
import '../../../core/theme.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

import 'package:pmgt/core/api_client.dart';
// ❌ removed: csc_picker_plus (we're not using it anymore)

// India-only states & UTs
const List<String> _indiaStates = [
  // States
  'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar', 'Chhattisgarh',
  'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh', 'Jharkhand',
  'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra', 'Manipur',
  'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha', 'Punjab',
  'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana', 'Tripura',
  'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
  // Union Territories
  'Andaman and Nicobar Islands',
  'Chandigarh',
  'Dadra and Nagar Haveli and Daman and Diu',
  'Delhi', 'Jammu and Kashmir', 'Ladakh', 'Lakshadweep', 'Puducherry',
];

class AddFEVendorScreen extends StatefulWidget {
  const AddFEVendorScreen({super.key});
  @override
  State<AddFEVendorScreen> createState() => _AddFEVendorScreenState();
}

/* ---------- lightweight models ---------- */
class _ProjectOption {
  final String code; // project_code or id
  final String name; // project_name
  _ProjectOption({required this.code, required this.name});
}

class _ProjectSiteRaw {
  final String? projectName; // may be null in some backends
  final String siteName;
  _ProjectSiteRaw({required this.projectName, required this.siteName});

  factory _ProjectSiteRaw.fromJson(Map<String, dynamic> m) => _ProjectSiteRaw(
    projectName: (m['project_name'] ?? m['project'] ?? '')?.toString(),
    siteName: (m['site_name'] ?? '').toString(),
  );
}

class _AddFEVendorScreenState extends State<AddFEVendorScreen> {
  // services
  ApiClient get _api => context.read<ApiClient>();

  // --- form state ---
  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _contactCtrl = TextEditingController();
  final _bankNameCtrl = TextEditingController();
  final _bankAccCtrl = TextEditingController();
  final _bankIfscCtrl = TextEditingController();
  final _panCtrl = TextEditingController();
  final _vendorNameCtrl = TextEditingController();

  // district text field (new)
  final _districtCtrl = TextEditingController();

  String _roleValue = 'Field Engineer'; // dropdown

  // projects & sites (multi-select)
  List<_ProjectOption> _projectOptions = [];
  List<String> _selectedProjectCodes = [];
  List<_ProjectSiteRaw> _projectSites = [];
  List<String> _selectedSiteNames = [];

  // location
  String _state = '';
  String _district = '';

  // ui
  bool _busy = false;

  // bottom nav
  final int _selectedTab = 0;
  void _handleTabChange(int i) {
    if (i == _selectedTab) return;
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
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _contactCtrl.dispose();
    _bankNameCtrl.dispose();
    _bankAccCtrl.dispose();
    _bankIfscCtrl.dispose();
    _panCtrl.dispose();
    _vendorNameCtrl.dispose();
    _districtCtrl.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    await Future.wait([_loadProjects(), _loadProjectSites()]);
  }

  Future<void> _loadProjects() async {
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final arr = jsonDecode(res.body) as List;
        final mapped =
            arr
                .map((p) {
                  final mp = p as Map<String, dynamic>;
                  final code =
                      (mp['project_code'] ?? mp['id'] ?? '').toString();
                  final name = (mp['project_name'] ?? '').toString();
                  return _ProjectOption(code: code, name: name);
                })
                .where((e) => e.code.isNotEmpty && e.name.isNotEmpty)
                .toList();
        setState(() => _projectOptions = mapped);
      }
    } catch (_) {
      setState(() => _projectOptions = []);
    }
  }

  Future<void> _loadProjectSites() async {
    try {
      final res = await _api.get('/api/project-sites');
      if (res.statusCode >= 200 && res.statusCode < 300) {
        final arr = jsonDecode(res.body) as List;
        final mapped =
            arr
                .map((e) => _ProjectSiteRaw.fromJson(e as Map<String, dynamic>))
                .toList();
        setState(() => _projectSites = mapped);
      }
    } catch (_) {
      setState(() => _projectSites = []);
    }
  }

  // sites filtered by selected project names
  List<String> get _filteredSiteOptions {
    final selectedNames =
        _selectedProjectCodes
            .map(
              (c) =>
                  _projectOptions
                      .firstWhere(
                        (p) => p.code == c,
                        orElse: () => _ProjectOption(code: '', name: ''),
                      )
                      .name,
            )
            .where((n) => n.isNotEmpty)
            .toSet();

    final names =
        _projectSites
            .where(
              (ps) =>
                  ps.projectName == null ||
                  selectedNames.contains(ps.projectName),
            )
            .map((ps) => ps.siteName)
            .toSet()
            .toList()
          ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return names;
  }

  void _clearAll() {
    setState(() {
      _fullNameCtrl.clear();
      _emailCtrl.clear();
      _contactCtrl.clear();
      _bankNameCtrl.clear();
      _bankAccCtrl.clear();
      _bankIfscCtrl.clear();
      _panCtrl.clear();
      _vendorNameCtrl.clear();
      _districtCtrl.clear();
      _roleValue = 'Field Engineer';
      _selectedProjectCodes = [];
      _selectedSiteNames = [];
      _state = '';
      _district = '';
    });
  }

  bool get _canSubmit =>
      _fullNameCtrl.text.trim().length > 1 &&
      _contactCtrl.text.trim().length >= 7 &&
      _selectedProjectCodes.isNotEmpty &&
      _selectedSiteNames.isNotEmpty &&
      _state.isNotEmpty &&
      _district.isNotEmpty;

  Future<void> _create() async {
    if (!_canSubmit) {
      _toast('Please fill all required fields');
      return;
    }
    setState(() => _busy = true);
    try {
      final payload = {
        'full_name': _fullNameCtrl.text.trim(),
        'role': _roleValue, // 'Field Engineer' | 'Vendor'
        'email': _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
        'contact_no': _contactCtrl.text.trim(),
        'project_codes': _selectedProjectCodes, // list of codes
        'site_names': _selectedSiteNames, // list of names
        'bank_info':
            _bankNameCtrl.text.trim().isEmpty
                ? null
                : _bankNameCtrl.text.trim(),
        'bank_account':
            _bankAccCtrl.text.trim().isEmpty ? null : _bankAccCtrl.text.trim(),
        'ifsc':
            _bankIfscCtrl.text.trim().isEmpty
                ? null
                : _bankIfscCtrl.text.trim(),
        'pan': _panCtrl.text.trim().isEmpty ? null : _panCtrl.text.trim(),
        'zone': null,
        'contact_person':
            _vendorNameCtrl.text.trim().isEmpty
                ? null
                : _vendorNameCtrl.text.trim(),
        'state': _state,
        'district': _district,
      };

      final res = await _api.post('/api/field-engineers', body: payload);
      if (res.statusCode >= 200 && res.statusCode < 300) {
        _toast('Field Engineer / Vendor created', success: true);
        _clearAll();
      } else if (res.statusCode == 409) {
        _toast('A Field Engineer with that email already exists');
      } else {
        _toast('Failed to create Field Engineer / Vendor');
      }
    } catch (_) {
      _toast('Failed to create Field Engineer / Vendor');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _toast(String msg, {bool success = false}) {
    final cs = Theme.of(context).colorScheme;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: success ? Colors.white : cs.onSurface),
        ),
        backgroundColor:
            success
                ? const Color(0xFF2E7D32)
                : (Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFF5E2A2A)
                    : const Color(0xFFFFE9E9)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add Field Engineer',
      centerTitle: true,
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
          onPressed:
              () => Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      currentIndex: _selectedTab,
      onTabChanged: _handleTabChange,
      safeArea: false,
      reserveBottomPadding: true,
      body: Stack(
        children: [
          ListView(
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
                              'Create Field Engineer / Vendor',
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
                            child: const Text('Clear'),
                          ),
                        ],
                      ),
                      Divider(color: cs.outlineVariant),

                      // Identity + assignment
                      LayoutBuilder(
                        builder: (context, c) {
                          final isWide = c.maxWidth >= 640;
                          final gap = isWide ? 12.0 : 0.0;

                          final left = [
                            _TextField(
                              label: 'Full Name *',
                              controller: _fullNameCtrl,
                            ),
                            _TextField(
                              label: 'Email',
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            _TextField(
                              label: 'Contact No *',
                              controller: _contactCtrl,
                              keyboardType: TextInputType.phone,
                            ),
                          ];

                          final right = [
                            _Dropdown<String>(
                              label: 'Role *',
                              value: _roleValue,
                              items: const ['Field Engineer', 'Vendor'],
                              onChanged:
                                  (v) => setState(
                                    () => _roleValue = v ?? 'Field Engineer',
                                  ),
                            ),
                            _SearchMultiSelect<String>(
                              label: 'Project Working *',
                              hint: 'Search projects…',
                              // show project names but store project codes
                              options:
                                  _projectOptions
                                      .map((p) => '${p.code}|||${p.name}')
                                      .toList(),
                              optionLabel: (raw) => raw.split('|||').last,
                              optionKey: (raw) => raw.split('|||').first,
                              selectedKeys: _selectedProjectCodes,
                              onChanged: (codes) {
                                setState(() {
                                  _selectedProjectCodes = codes;
                                  _selectedSiteNames = [];
                                });
                              },
                            ),
                            _SearchMultiSelect<String>(
                              label: 'Sites *',
                              hint: 'Search sites…',
                              options: _filteredSiteOptions,
                              optionLabel: (s) => s,
                              optionKey: (s) => s,
                              selectedKeys: _selectedSiteNames,
                              onChanged:
                                  (names) => setState(
                                    () => _selectedSiteNames = names,
                                  ),
                              emptyText:
                                  _selectedProjectCodes.isEmpty
                                      ? 'Select at least one project to see its sites'
                                      : 'No sites found for selected projects',
                            ),
                          ];

                          if (!isWide)
                            return Column(children: [...left, ...right]);
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

                      const SizedBox(height: 14),
                      Divider(color: cs.outlineVariant),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6, top: 2),
                        child: Text(
                          'Bank Details',
                          style: TextStyle(
                            color: cs.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      // Bank + Vendor info
                      LayoutBuilder(
                        builder: (context, c) {
                          final isWide = c.maxWidth >= 640;
                          final gap = isWide ? 12.0 : 0.0;

                          final left = [
                            _TextField(
                              label: 'Bank Name',
                              controller: _bankNameCtrl,
                            ),
                            _TextField(
                              label: 'Bank IFSC',
                              controller: _bankIfscCtrl,
                            ),
                            _TextField(
                              label: 'Vendor Name',
                              controller: _vendorNameCtrl,
                            ),
                          ];
                          final right = [
                            _TextField(
                              label: 'Bank Account No',
                              controller: _bankAccCtrl,
                              keyboardType: TextInputType.number,
                            ),
                            _TextField(label: 'Pan No', controller: _panCtrl),
                          ];

                          if (!isWide)
                            return Column(children: [...left, ...right]);
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

                      const SizedBox(height: 14),
                      Divider(color: cs.outlineVariant),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6, top: 2),
                        child: Text(
                          'Location',
                          style: TextStyle(
                            color: cs.onSurfaceVariant,
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      // LOCATION — India only: State dropdown + District text field
                      LayoutBuilder(
                        builder: (context, c) {
                          final isWide = c.maxWidth >= 640;
                          final gap = isWide ? 12.0 : 0.0;

                          final left = [
                            _Dropdown<String>(
                              label: 'State *',
                              value: _state.isEmpty ? null : _state,
                              items: _indiaStates,
                              onChanged:
                                  (v) => setState(() => _state = (v ?? '')),
                            ),
                          ];
                          final right = [
                            _TextField(
                              label: 'District *',
                              controller: _districtCtrl,
                              keyboardType: TextInputType.text,
                            ),
                          ];

                          // keep _district in sync with controller
                          _district = _districtCtrl.text.trim();

                          if (!isWide)
                            return Column(children: [...left, ...right]);
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

                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 220),
                          child: ElevatedButton(
                            onPressed: _busy ? null : _create,
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
                            child: Text(
                              _busy ? 'Creating…' : 'Create',
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
}

/* --------------------- Small UI helpers --------------------- */

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

class _TextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  const _TextField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surface,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.accentColor),
            borderRadius: BorderRadius.all(Radius.circular(8)),
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

/* ------------ Searchable Multi-select (checkbox list) ------------ */
class _SearchMultiSelect<T> extends StatelessWidget {
  final String label;
  final String hint;
  final List<T> options; // all options
  final List<String> selectedKeys; // selected identifiers
  final String Function(T) optionLabel; // how to show each option
  final String Function(T) optionKey; // unique key for each option
  final ValueChanged<List<String>> onChanged;
  final String? emptyText;

  const _SearchMultiSelect({
    required this.label,
    required this.hint,
    required this.options,
    required this.optionLabel,
    required this.optionKey,
    required this.selectedKeys,
    required this.onChanged,
    this.emptyText,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return _FieldShell(
      label: label,
      child: InkWell(
        onTap: () async {
          final result = await showModalBottomSheet<List<String>>(
            context: context,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder:
                (_) => _SearchMultiSelectSheet<T>(
                  title: label,
                  hint: hint,
                  options: options,
                  initialSelected: selectedKeys.toSet(),
                  optionLabel: optionLabel,
                  optionKey: optionKey,
                  emptyText: emptyText,
                ),
          );
          if (result != null) onChanged(result);
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          alignment: Alignment.centerLeft,
          child: Text(
            selectedKeys.isEmpty ? 'Select' : selectedKeys.join(', '),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: selectedKeys.isEmpty ? cs.onSurfaceVariant : cs.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _SearchMultiSelectSheet<T> extends StatefulWidget {
  final String title;
  final String hint;
  final List<T> options;
  final Set<String> initialSelected;
  final String Function(T) optionLabel;
  final String Function(T) optionKey;
  final String? emptyText;

  const _SearchMultiSelectSheet({
    required this.title,
    required this.hint,
    required this.options,
    required this.initialSelected,
    required this.optionLabel,
    required this.optionKey,
    this.emptyText,
  });

  @override
  State<_SearchMultiSelectSheet<T>> createState() =>
      _SearchMultiSelectSheetState<T>();
}

class _SearchMultiSelectSheetState<T>
    extends State<_SearchMultiSelectSheet<T>> {
  late Set<String> _selected;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _selected = {...widget.initialSelected};
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final filtered =
        widget.options.where((o) {
          final label = widget.optionLabel(o).toLowerCase();
          return _query.isEmpty || label.contains(_query.toLowerCase());
        }).toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: cs.outlineVariant,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: widget.hint,
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: cs.surface,
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: cs.outlineVariant),
                ),
              ),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          const SizedBox(height: 8),
          if (filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                widget.emptyText ?? 'No results',
                style: TextStyle(color: cs.onSurfaceVariant),
              ),
            )
          else
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: filtered.length,
                itemBuilder: (_, i) {
                  final item = filtered[i];
                  final key = widget.optionKey(item);
                  final label = widget.optionLabel(item);
                  final checked = _selected.contains(key);
                  return CheckboxListTile(
                    value: checked,
                    onChanged:
                        (v) => setState(() {
                          if (checked) {
                            _selected.remove(key);
                          } else {
                            _selected.add(key);
                          }
                        }),
                    title: Text(label),
                  );
                },
              ),
            ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.pop(context, _selected.toList()),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
