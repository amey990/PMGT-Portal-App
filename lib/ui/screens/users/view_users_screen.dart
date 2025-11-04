// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class ViewUsersScreen extends StatefulWidget {
//   const ViewUsersScreen({super.key});
//   @override
//   State<ViewUsersScreen> createState() => _ViewUsersScreenState();
// }

// class _ViewUsersScreenState extends State<ViewUsersScreen> {
//   // int _selectedTab = 0; // bottom nav

//   // ------- Toggle (scrollable) -------
//   final List<String> _segments = const [
//     'PM',
//     'BDM',
//     'NOC',
//     'SCM',
//     'FE/Vendor',
//     'Users',
//     'Customer',
//   ];
//   late final List<bool> _isSelected = List<bool>.generate(
//     _segments.length,
//     (i) => i == 0,
//   );
//   UserKind _currentKind = UserKind.pm;

//   void _selectKind(int idx) {
//     setState(() {
//       for (var i = 0; i < _isSelected.length; i++) {
//         _isSelected[i] = i == idx;
//       }
//       _currentKind = UserKind.values[idx];
//     });
//   }

//   void _handleTabChange(BuildContext context, int i) {
//     if (i == 4) return; // already on Users
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
//       default:
//         return;
//     }
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   // ---------------- Sample data ----------------
//   final List<PM> pmList = List<PM>.generate(
//     16,
//     (i) => PM(
//       'PM #$i',
//       'pm$i@atlas.com',
//       '98xxx${i.toString().padLeft(3, '0')}',
//       'NPCI',
//       'Site ${i.toString().padLeft(3, '0')}',
//     ),
//   );

//   final List<BDM> bdmList = List<BDM>.generate(
//     14,
//     (i) => BDM('BDM #$i', 'bdm$i@atlas.com', '98xxx${(100 + i)}', 'NPCI'),
//   );

//   final List<NOC> nocList = List<NOC>.generate(
//     12,
//     (i) => NOC('NOC #$i', 'noc$i@atlas.com', '98xxx${(200 + i)}', 'NPCI'),
//   );

//   final List<SCM> scmList = List<SCM>.generate(
//     10,
//     (i) => SCM('SCM #$i', 'scm$i@atlas.com', '98xxx${(300 + i)}', 'NPCI'),
//   );

//   final List<FEVendor> feList = List<FEVendor>.generate(
//     18,
//     (i) => FEVendor(
//       'FE/Vendor #$i',
//       'fe$i@atlas.com',
//       '98xxx${(400 + i)}',
//       'NPCI',
//       'Site ${i.toString().padLeft(3, '0')}',
//       ['North', 'East', 'South', 'West'][i % 4],
//       'Vendor ${String.fromCharCode(65 + (i % 26))}',
//       'Maharashtra',
//       ['Thane', 'Pune', 'Mumbai', 'Nagpur'][i % 4],
//     ),
//   );

//   final List<UserAcc> userList = List<UserAcc>.generate(
//     8,
//     (i) => UserAcc(
//       'user$i',
//       ['Admin', 'Project Manager', 'Viewer'][i % 3],
//       'user$i@atlas.com',
//     ),
//   );

//   final List<Customer> customerList = List<Customer>.generate(
//     6,
//     (i) => Customer('Customer #$i', 'customer$i@atlas.com'),
//   );

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'All Users',
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

//           icon: const ProfileAvatar(size: 36),
//         ),
//         const SizedBox(width: 8),
//       ],
//       // currentIndex: _selectedTab,
//       // onTabChanged: (i) => setState(() => _selectedTab = i),
//       currentIndex: 4, // Users tab index
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Padding(
//         padding: responsivePadding(context).copyWith(top: 8, bottom: 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // ===== Scrollable toggle =====
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               child: ToggleButtons(
//                 isSelected: _isSelected,
//                 onPressed: _selectKind,
//                 borderRadius: BorderRadius.circular(10),
//                 constraints: const BoxConstraints(minHeight: 34, minWidth: 88),
//                 selectedBorderColor: AppTheme.accentColor,
//                 borderColor: cs.outlineVariant,
//                 fillColor:
//                     Theme.of(context).brightness == Brightness.light
//                         ? Colors.black12
//                         : AppTheme.accentColor.withOpacity(0.18),
//                 selectedColor:
//                     Theme.of(context).brightness == Brightness.light
//                         ? Colors.black
//                         : AppTheme.accentColor,
//                 color: cs.onSurfaceVariant,
//                 children:
//                     _segments
//                         .map(
//                           (s) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Text(
//                               s,
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ),
//                         )
//                         .toList(),
//               ),
//             ),
//             const SizedBox(height: 8),

//             // ===== List =====
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.only(bottom: 12 + 58),
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemCount: _currentItems.length,
//                 itemBuilder: (context, i) {
//                   final item = _currentItems[i];
//                   return _buildCardFor(item);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Returns the current list depending on the selected kind
//   List<dynamic> get _currentItems {
//     switch (_currentKind) {
//       case UserKind.pm:
//         return pmList;
//       case UserKind.bdm:
//         return bdmList;
//       case UserKind.noc:
//         return nocList;
//       case UserKind.scm:
//         return scmList;
//       case UserKind.fevendor:
//         return feList;
//       case UserKind.users:
//         return userList;
//       case UserKind.customer:
//         return customerList;
//     }
//   }

//   // ---------- aligned key/value line ----------
//   static const double _labelW = 92;

//   Widget _kv(String label, String value, Color labelColor, Color valueColor) {
//     final bool isEmail = label.toLowerCase() == 'email';
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: _labelW,
//             child: Text(
//               '$label:',
//               style: TextStyle(color: labelColor, fontSize: 11),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(color: valueColor, fontSize: 11),
//               maxLines: isEmail ? 1 : 3,
//               softWrap: !isEmail,
//               overflow: isEmail ? TextOverflow.clip : TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Dashboard-style card
//   Widget _buildCardFor(dynamic data) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     String titleLeft = '';
//     String titleRight = '';

//     List<Widget> left = [];
//     List<Widget> right = [];

//     if (data is PM) {
//       titleLeft = data.name;
//       titleRight = 'Project Manager';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Project', data.project, labelColor, valueColor),
//         _kv('Site', data.site, labelColor, valueColor),
//       ];
//       right = const [];
//     } else if (data is BDM) {
//       titleLeft = data.name;
//       titleRight = 'Business Development Manager';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Project', data.project, labelColor, valueColor),
//       ];
//       right = const [];
//     } else if (data is NOC) {
//       titleLeft = data.name;
//       titleRight = 'NOC Engineer';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Project', data.project, labelColor, valueColor),
//       ];
//       right = const [];
//     } else if (data is SCM) {
//       titleLeft = data.name;
//       titleRight = 'Supply Chain Manager';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Project', data.project, labelColor, valueColor),
//       ];
//       right = const [];
//     } else if (data is FEVendor) {
//       titleLeft = data.name;
//       titleRight = 'Field Engineer / Vendor';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Project', data.project, labelColor, valueColor),
//         _kv('Site', data.site, labelColor, valueColor),
//       ];
//       right = [
//         _kv('Zone', data.zone, labelColor, valueColor),
//         _kv('Vendor Name', data.vendorName, labelColor, valueColor),
//         _kv('State', data.state, labelColor, valueColor),
//         _kv('District', data.district, labelColor, valueColor),
//       ];
//     } else if (data is UserAcc) {
//       titleLeft = data.username;
//       titleRight = data.role;
//       left = [_kv('Email', data.email, labelColor, valueColor)];
//       right = const [];
//     } else if (data is Customer) {
//       titleLeft = data.name;
//       titleRight = 'Customer';
//       left = [_kv('Email', data.email, labelColor, valueColor)];
//       right = const [];
//     }

//     // Build columns: use single column when right is empty (so email gets full width)
//     final Widget columns =
//         right.isEmpty
//             ? Column(children: left)
//             : Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(child: Column(children: left)),
//                 const SizedBox(width: 16),
//                 Expanded(child: Column(children: right)),
//               ],
//             );

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 titleLeft,
//                 style: TextStyle(
//                   color: valueColor,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 14,
//                 ),
//               ),
//               Text(
//                 titleRight,
//                 style: TextStyle(
//                   color: valueColor,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           columns,

//           const SizedBox(height: 16),
//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppTheme.accentColor,
//                 side: const BorderSide(color: AppTheme.accentColor),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//               ),
//               onPressed: () {},
//               child: const Text(
//                 'Update',
//                 style: TextStyle(color: Color(0xFF000000), fontSize: 12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ---------- Models ----------
// enum UserKind { pm, bdm, noc, scm, fevendor, users, customer }

// class PM {
//   final String name, email, contact, project, site;
//   PM(this.name, this.email, this.contact, this.project, this.site);
// }

// class BDM {
//   final String name, email, contact, project;
//   BDM(this.name, this.email, this.contact, this.project);
// }

// class NOC {
//   final String name, email, contact, project;
//   NOC(this.name, this.email, this.contact, this.project);
// }

// class SCM {
//   final String name, email, contact, project;
//   SCM(this.name, this.email, this.contact, this.project);
// }

// class FEVendor {
//   final String name,
//       email,
//       contact,
//       project,
//       site,
//       zone,
//       vendorName,
//       state,
//       district;
//   FEVendor(
//     this.name,
//     this.email,
//     this.contact,
//     this.project,
//     this.site,
//     this.zone,
//     this.vendorName,
//     this.state,
//     this.district,
//   );
// }

// class UserAcc {
//   final String username, role, email;
//   UserAcc(this.username, this.role, this.email);
// }

// class Customer {
//   final String name, email;
//   Customer(this.name, this.email);
// }

//p2//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../../core/api_client.dart';

// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';

// // Bottom-nav screens
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../analytics/analytics_screen.dart';
// import 'package:http/http.dart' as http;

// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class ViewUsersScreen extends StatefulWidget {
//   const ViewUsersScreen({super.key});
//   @override
//   State<ViewUsersScreen> createState() => _ViewUsersScreenState();
// }

// class _ViewUsersScreenState extends State<ViewUsersScreen> {
//   // ------- Toggle (scrollable) -------
//   final List<String> _segments = const [
//     'PM',
//     'BDM',
//     'NOC',
//     'SCM',
//     'FE/Vendor',
//     'Users',
//     'Customer',
//   ];
//   late final List<bool> _isSelected = List<bool>.generate(
//     _segments.length,
//     (i) => i == 0,
//   );

//   UserKind _currentKind = UserKind.pm;

//   void _selectKind(int idx) {
//     setState(() {
//       for (var i = 0; i < _isSelected.length; i++) {
//         _isSelected[i] = i == idx;
//       }
//       _currentKind = UserKind.values[idx];
//     });
//     _loadFor(_currentKind);
//   }

//   void _handleTabChange(BuildContext context, int i) {
//     if (i == 4) return; // already on Users
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
//       default:
//         return;
//     }
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   // ─────────────────────────────── Data state ───────────────────────────────
//   final ValueNotifier<bool> _loading = ValueNotifier<bool>(false);
//   String? _error;

//   // project_code → project_name
//   final Map<String, String> _projectMap = {};

//   // role lists
//   final List<PM> _pmList = [];
//   final List<BDM> _bdmList = [];
//   final List<NOC> _nocList = [];
//   final List<SCM> _scmList = [];
//   final List<FEVendor> _feList = [];
//   final List<UserAcc> _userList = []; // placeholder (not in web API)
//   final List<Customer> _customerList = [];

//   @override
//   void initState() {
//     super.initState();
//     _prime();
//   }

//   @override
//   void dispose() {
//     _loading.dispose();
//     super.dispose();
//   }

//   Future<void> _prime() async {
//     await _loadProjects(); // map for code → name
//     await _loadFor(_currentKind);
//   }

//   ApiClient get _api => context.read<ApiClient>();

//   // GET /api/projects → [{ project_code, project_name }]
//   Future<void> _loadProjects() async {
//     try {
//       final res = await _api.get('/api/projects');
//       if (res.statusCode < 200 || res.statusCode >= 300) return;
//       final ct = (res.headers['content-type'] ?? '').toLowerCase();
//       if (!ct.contains('application/json')) return;

//       final data = jsonDecode(utf8.decode(res.bodyBytes));
//       if (data is List) {
//         _projectMap
//           ..clear()
//           ..addEntries(
//             data.map<MapEntry<String, String>>((p) {
//               final pc = (p['project_code'] ?? '').toString();
//               final pn = (p['project_name'] ?? pc).toString();
//               return MapEntry(pc, pn);
//             }),
//           );
//         setState(() {});
//       }
//     } catch (_) {
//       // ignore silently—project names will just show codes
//     }
//   }

//   Future<void> _loadFor(UserKind kind) async {
//     _error = null;
//     _loading.value = true;
//     try {
//       switch (kind) {
//         case UserKind.pm:
//           await _loadPMs();
//           break;
//         case UserKind.bdm:
//           await _loadBDMs();
//           break;
//         case UserKind.noc:
//           await _loadNOCs();
//           break;
//         case UserKind.scm:
//           await _loadSCMs();
//           break;
//         case UserKind.fevendor:
//           await _loadFEs();
//           break;
//         case UserKind.users:
//           // Not defined on web; keep empty list for now.
//           setState(() => _userList.clear());
//           break;
//         case UserKind.customer:
//           await _loadCustomers();
//           break;
//       }
//     } catch (e) {
//       _error = e.toString();
//       if (mounted) {
//         ScaffoldMessenger.of(
//           context,
//         ).showSnackBar(SnackBar(content: Text('Error: $_error')));
//       }
//     } finally {
//       _loading.value = false;
//     }
//   }

//   // PMs: GET /api/project-managers → { project_managers: [...] }
//   Future<void> _loadPMs() async {
//     final res = await _api.get('/api/project-managers');
//     _ensureJson(res);
//     final body = jsonDecode(utf8.decode(res.bodyBytes));
//     final list =
//         (body is Map && body['project_managers'] is List)
//             ? body['project_managers'] as List
//             : (body is List ? body : const []);
//     _pmList
//       ..clear()
//       ..addAll(
//         list.map((pm) {
//           final codes =
//               (pm['project_codes'] as List?)?.cast<dynamic>() ?? const [];
//           return PM(
//             (pm['full_name'] ?? '').toString(),
//             (pm['email'] ?? '').toString(),
//             (pm['contact_no'] ?? '').toString(),
//             _mapCodesToNames(codes),
//           );
//         }),
//       );
//     setState(() {});
//   }

//   // BDMs: GET /api/bdms → any[]
//   Future<void> _loadBDMs() async {
//     final res = await _api.get('/api/bdms');
//     _ensureJson(res);
//     final list = (jsonDecode(utf8.decode(res.bodyBytes)) as List?) ?? const [];
//     _bdmList
//       ..clear()
//       ..addAll(
//         list.map((b) {
//           final codes =
//               (b['project_codes'] as List?)?.cast<dynamic>() ?? const [];
//           return BDM(
//             (b['full_name'] ?? '').toString(),
//             (b['email'] ?? '').toString(),
//             (b['contact_no'] ?? '').toString(),
//             _mapCodesToNames(codes),
//           );
//         }),
//       );
//     setState(() {});
//   }

//   // NOCs: GET /api/nocs → any[]
//   Future<void> _loadNOCs() async {
//     final res = await _api.get('/api/nocs');
//     _ensureJson(res);
//     final list = (jsonDecode(utf8.decode(res.bodyBytes)) as List?) ?? const [];
//     _nocList
//       ..clear()
//       ..addAll(
//         list.map((n) {
//           final codes =
//               (n['project_codes'] as List?)?.cast<dynamic>() ?? const [];
//           return NOC(
//             (n['full_name'] ?? '').toString(),
//             (n['email'] ?? '').toString(),
//             (n['contact_no'] ?? '').toString(),
//             _mapCodesToNames(codes),
//           );
//         }),
//       );
//     setState(() {});
//   }

//   // SCMs: GET /api/scms → any[]
//   Future<void> _loadSCMs() async {
//     final res = await _api.get('/api/scms');
//     _ensureJson(res);
//     final list = (jsonDecode(utf8.decode(res.bodyBytes)) as List?) ?? const [];
//     _scmList
//       ..clear()
//       ..addAll(
//         list.map((s) {
//           final codes =
//               (s['project_codes'] as List?)?.cast<dynamic>() ?? const [];
//           return SCM(
//             (s['full_name'] ?? '').toString(),
//             (s['email'] ?? '').toString(),
//             (s['contact_no'] ?? '').toString(),
//             _mapCodesToNames(codes),
//           );
//         }),
//       );
//     setState(() {});
//   }

//   // FEs: GET /api/field-engineers → { field_engineers: [...] } | []
//   Future<void> _loadFEs() async {
//     final res = await _api.get('/api/field-engineers');
//     _ensureJson(res);
//     final raw = jsonDecode(utf8.decode(res.bodyBytes));
//     final list =
//         (raw is Map && raw['field_engineers'] is List)
//             ? raw['field_engineers'] as List
//             : (raw is List ? raw : const []);
//     _feList
//       ..clear()
//       ..addAll(
//         list.map((fe) {
//           final codes =
//               (fe['project_codes'] as List?)?.cast<dynamic>() ?? const [];
//           final siteNames =
//               (fe['site_names'] as List?)?.cast<dynamic>() ?? const [];
//           return FEVendor(
//             (fe['full_name'] ?? '').toString(),
//             (fe['email'] ?? '').toString(),
//             (fe['contact_no'] ?? '').toString(),
//             _mapCodesToNames(codes),
//             siteNames.map((e) => e.toString()).toList(growable: false),
//             (fe['zone'] ?? '').toString(),
//             (fe['state'] ?? '').toString(),
//             (fe['district'] ?? '').toString(),
//             // id for future update/delete if needed
//             (fe['id'] ?? fe['_id'] ?? '').toString(),
//           );
//         }),
//       );
//     setState(() {});
//   }

//   // Customers: GET /api/customers → { customers: [...] }
//   Future<void> _loadCustomers() async {
//     final res = await _api.get('/api/customers');
//     _ensureJson(res);
//     final body = jsonDecode(utf8.decode(res.bodyBytes));
//     final list =
//         (body is Map && body['customers'] is List)
//             ? body['customers'] as List
//             : (body is List ? body : const []);
//     _customerList
//       ..clear()
//       ..addAll(
//         list.map((c) {
//           return Customer(
//             (c['company_name'] ?? '').toString(),
//             (c['email'] ?? '').toString(),
//           );
//         }),
//       );
//     setState(() {});
//   }

//   void _ensureJson(http.Response res) {
//     if (res.statusCode < 200 || res.statusCode >= 300) {
//       throw Exception('HTTP ${res.statusCode}');
//     }
//     final ct = (res.headers['content-type'] ?? '').toLowerCase();
//     if (!ct.contains('application/json')) {
//       final preview = res.body.substring(
//         0,
//         res.body.length > 120 ? 120 : res.body.length,
//       );
//       throw FormatException('Non-JSON: $preview');
//     }
//   }

//   // project_codes → "Project A, Project B"
//   String _mapCodesToNames(List<dynamic> codes) {
//     final names =
//         codes
//             .map((c) => _projectMap[c.toString()] ?? c.toString())
//             .toSet()
//             .toList();
//     return names.join(', ');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'All Users',
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
//       currentIndex: 4, // Users tab index
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Padding(
//         padding: responsivePadding(context).copyWith(top: 8, bottom: 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // ===== Scrollable toggle =====
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               child: ToggleButtons(
//                 isSelected: _isSelected,
//                 onPressed: _selectKind,
//                 borderRadius: BorderRadius.circular(10),
//                 constraints: const BoxConstraints(minHeight: 34, minWidth: 88),
//                 selectedBorderColor: AppTheme.accentColor,
//                 borderColor: cs.outlineVariant,
//                 fillColor:
//                     Theme.of(context).brightness == Brightness.light
//                         ? Colors.black12
//                         : AppTheme.accentColor.withOpacity(0.18),
//                 selectedColor:
//                     Theme.of(context).brightness == Brightness.light
//                         ? Colors.black
//                         : AppTheme.accentColor,
//                 color: cs.onSurfaceVariant,
//                 children:
//                     _segments
//                         .map(
//                           (s) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 12),
//                             child: Text(
//                               s,
//                               style: const TextStyle(fontSize: 12),
//                             ),
//                           ),
//                         )
//                         .toList(),
//               ),
//             ),
//             const SizedBox(height: 8),

//             // ===== List =====
//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: () => _loadFor(_currentKind),
//                 child: ValueListenableBuilder<bool>(
//                   valueListenable: _loading,
//                   builder: (_, loading, __) {
//                     final items = _currentItems;
//                     if (loading && items.isEmpty) {
//                       return const Center(child: CircularProgressIndicator());
//                     }
//                     if (_error != null && items.isEmpty) {
//                       return Center(
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Text(_error!, textAlign: TextAlign.center),
//                         ),
//                       );
//                     }
//                     if (items.isEmpty) {
//                       return const Center(child: Text('No users found'));
//                     }
//                     return ListView.separated(
//                       padding: const EdgeInsets.only(bottom: 12 + 58),
//                       separatorBuilder: (_, __) => const SizedBox(height: 12),
//                       itemCount: items.length,
//                       itemBuilder: (context, i) {
//                         final item = items[i];
//                         return _buildCardFor(item);
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Returns the current list depending on the selected kind
//   List<dynamic> get _currentItems {
//     switch (_currentKind) {
//       case UserKind.pm:
//         return _pmList;
//       case UserKind.bdm:
//         return _bdmList;
//       case UserKind.noc:
//         return _nocList;
//       case UserKind.scm:
//         return _scmList;
//       case UserKind.fevendor:
//         return _feList;
//       case UserKind.users:
//         return _userList;
//       case UserKind.customer:
//         return _customerList;
//     }
//   }

//   // ---------- aligned key/value line ----------
//   static const double _labelW = 92;

//   Widget _kv(String label, String value, Color labelColor, Color valueColor) {
//     final bool isEmail = label.toLowerCase() == 'email';
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             width: _labelW,
//             child: Text(
//               '$label:',
//               style: TextStyle(color: labelColor, fontSize: 11),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               value,
//               style: TextStyle(color: valueColor, fontSize: 11),
//               maxLines: isEmail ? 1 : 4,
//               softWrap: !isEmail,
//               overflow: isEmail ? TextOverflow.ellipsis : TextOverflow.fade,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Dashboard-style card
//   Widget _buildCardFor(dynamic data) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     String titleLeft = '';
//     String titleRight = '';

//     List<Widget> left = [];
//     List<Widget> right = [];

//     if (data is PM) {
//       titleLeft = data.name;
//       titleRight = 'Project Manager';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Projects', data.projects, labelColor, valueColor),
//       ];
//     } else if (data is BDM) {
//       titleLeft = data.name;
//       titleRight = 'Business Development Manager';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Projects', data.projects, labelColor, valueColor),
//       ];
//     } else if (data is NOC) {
//       titleLeft = data.name;
//       titleRight = 'NOC Engineer';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Projects', data.projects, labelColor, valueColor),
//       ];
//     } else if (data is SCM) {
//       titleLeft = data.name;
//       titleRight = 'Supply Chain Manager';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Projects', data.projects, labelColor, valueColor),
//       ];
//     } else if (data is FEVendor) {
//       titleLeft = data.name;
//       titleRight = 'Field Engineer / Vendor';
//       left = [
//         _kv('Email', data.email, labelColor, valueColor),
//         _kv('Contact', data.contact, labelColor, valueColor),
//         _kv('Projects', data.projects.join(', '), labelColor, valueColor),
//         _kv('Sites', data.sites.join(', '), labelColor, valueColor),
//       ];
//       right = [
//         if (data.zone.isNotEmpty)
//           _kv('Zone', data.zone, labelColor, valueColor),
//         if (data.state.isNotEmpty)
//           _kv('State', data.state, labelColor, valueColor),
//         if (data.district.isNotEmpty)
//           _kv('District', data.district, labelColor, valueColor),
//       ];
//     } else if (data is UserAcc) {
//       titleLeft = data.username;
//       titleRight = data.role;
//       left = [_kv('Email', data.email, labelColor, valueColor)];
//     } else if (data is Customer) {
//       titleLeft = data.name;
//       titleRight = 'Customer';
//       left = [_kv('Email', data.email, labelColor, valueColor)];
//     }

//     final Widget columns =
//         right.isEmpty
//             ? Column(children: left)
//             : Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(child: Column(children: left)),
//                 const SizedBox(width: 16),
//                 Expanded(child: Column(children: right)),
//               ],
//             );

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 titleLeft,
//                 style: TextStyle(
//                   color: valueColor,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 14,
//                 ),
//               ),
//               Text(
//                 titleRight,
//                 style: TextStyle(
//                   color: valueColor,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           columns,

//           const SizedBox(height: 16),
//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppTheme.accentColor,
//                 side: const BorderSide(color: AppTheme.accentColor),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(6),
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 16,
//                   vertical: 8,
//                 ),
//               ),
//               onPressed: () {
//                 // We’ll wire this to the modals next—keeping it active with a toast for now.
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Update modal coming next')),
//                 );
//               },
//               child: const Text(
//                 'Update',
//                 style: TextStyle(color: Color(0xFF000000), fontSize: 12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ---------- Models ----------
// enum UserKind { pm, bdm, noc, scm, fevendor, users, customer }

// class PM {
//   final String name, email, contact, projects;
//   PM(this.name, this.email, this.contact, this.projects);
// }

// class BDM {
//   final String name, email, contact, projects;
//   BDM(this.name, this.email, this.contact, this.projects);
// }

// class NOC {
//   final String name, email, contact, projects;
//   NOC(this.name, this.email, this.contact, this.projects);
// }

// class SCM {
//   final String name, email, contact, projects;
//   SCM(this.name, this.email, this.contact, this.projects);
// }

// class FEVendor {
//   final String name, email, contact, projectsStr, zone, state, district, id;
//   final List<String> projects;
//   final List<String> sites;
//   FEVendor(
//     this.name,
//     this.email,
//     this.contact,
//     this.projectsStr,
//     this.sites,
//     this.zone,
//     this.state,
//     this.district,
//     this.id,
//   ) : projects = projectsStr.split(', ').where((e) => e.isNotEmpty).toList();
// }

// class UserAcc {
//   final String username, role, email;
//   UserAcc(this.username, this.role, this.email);
// }

// class Customer {
//   final String name, email;
//   Customer(this.name, this.email);
// }

//p3//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../../core/api_client.dart';

import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

// Bottom-nav screens
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';

import '../modals/update_user_modal.dart';
import '../modals/update_fe_modal.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({super.key});
  @override
  State<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  // ------- Toggle (scrollable) -------
  final List<String> _segments = const [
    'PM',
    'BDM',
    'NOC',
    'SCM',
    'FE/Vendor',
    'Users',
    'Customer',
  ];
  late final List<bool> _isSelected = List<bool>.generate(
    _segments.length,
    (i) => i == 0,
  );

  UserKind _currentKind = UserKind.pm;

  void _selectKind(int idx) {
    setState(() {
      for (var i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == idx;
      }
      _currentKind = UserKind.values[idx];
    });
    _loadFor(_currentKind);
  }

  void _handleTabChange(BuildContext context, int i) {
    if (i == 4) return; // already on Users
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
      default:
        return;
    }
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  // ─────────────────────────────── Data state ───────────────────────────────
  final ValueNotifier<bool> _loading = ValueNotifier<bool>(false);
  String? _error;

  // project_code → project_name
  final Map<String, String> _projectMap = {};

  // role lists
  final List<PM> _pmList = [];
  final List<BDM> _bdmList = [];
  final List<NOC> _nocList = [];
  final List<SCM> _scmList = [];
  final List<FEVendor> _feList = [];
  final List<UserAcc> _userList = []; // placeholder
  final List<Customer> _customerList = [];

  @override
  void initState() {
    super.initState();
    _prime();
  }

  @override
  void dispose() {
    _loading.dispose();
    super.dispose();
  }

  Future<void> _prime() async {
    await _loadProjects(); // map for code → name
    await _loadFor(_currentKind);
  }

  ApiClient get _api => context.read<ApiClient>();

  // GET /api/projects → [{ project_code, project_name }]
  Future<void> _loadProjects() async {
    try {
      final res = await _api.get('/api/projects');
      if (res.statusCode < 200 || res.statusCode >= 300) return;
      final ct = (res.headers['content-type'] ?? '').toLowerCase();
      if (!ct.contains('application/json')) return;

      final data = jsonDecode(utf8.decode(res.bodyBytes));
      if (data is List) {
        _projectMap
          ..clear()
          ..addEntries(
            data.map<MapEntry<String, String>>((p) {
              final pc = (p['project_code'] ?? '').toString();
              final pn = (p['project_name'] ?? pc).toString();
              return MapEntry(pc, pn);
            }),
          );
        setState(() {});
      }
    } catch (_) {
      // ignore silently—project names will just show codes
    }
  }

  Future<void> _loadFor(UserKind kind) async {
    _error = null;
    _loading.value = true;
    try {
      switch (kind) {
        case UserKind.pm:
          await _loadPMs();
          break;
        case UserKind.bdm:
          await _loadBDMs();
          break;
        case UserKind.noc:
          await _loadNOCs();
          break;
        case UserKind.scm:
          await _loadSCMs();
          break;
        case UserKind.fevendor:
          await _loadFEs();
          break;
        case UserKind.users:
          setState(() => _userList.clear());
          break;
        case UserKind.customer:
          await _loadCustomers();
          break;
      }
    } catch (e) {
      _error = e.toString();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $_error')));
      }
    } finally {
      _loading.value = false;
    }
  }

  // PMs: GET /api/project-managers → { project_managers: [...] }
  Future<void> _loadPMs() async {
    final res = await _api.get('/api/project-managers');
    _ensureJson(res);
    final body = jsonDecode(utf8.decode(res.bodyBytes));
    final list =
        (body is Map && body['project_managers'] is List)
            ? body['project_managers'] as List
            : (body is List ? body : const []);
    _pmList
      ..clear()
      ..addAll(
        list.map((pm) {
          final codes =
              (pm['project_codes'] as List?)?.cast<dynamic>() ?? const [];
          return PM(
            (pm['full_name'] ?? '').toString(),
            (pm['email'] ?? '').toString(),
            (pm['contact_no'] ?? '').toString(),
            _mapCodesToNames(codes),
          );
        }),
      );
    setState(() {});
  }

  // BDMs: GET /api/bdms → any[]
  Future<void> _loadBDMs() async {
    final res = await _api.get('/api/bdms');
    _ensureJson(res);
    final list = (jsonDecode(utf8.decode(res.bodyBytes)) as List?) ?? const [];
    _bdmList
      ..clear()
      ..addAll(
        list.map((b) {
          final codes =
              (b['project_codes'] as List?)?.cast<dynamic>() ?? const [];
          return BDM(
            (b['full_name'] ?? '').toString(),
            (b['email'] ?? '').toString(),
            (b['contact_no'] ?? '').toString(),
            _mapCodesToNames(codes),
          );
        }),
      );
    setState(() {});
  }

  // NOCs: GET /api/nocs → any[]
  Future<void> _loadNOCs() async {
    final res = await _api.get('/api/nocs');
    _ensureJson(res);
    final list = (jsonDecode(utf8.decode(res.bodyBytes)) as List?) ?? const [];
    _nocList
      ..clear()
      ..addAll(
        list.map((n) {
          final codes =
              (n['project_codes'] as List?)?.cast<dynamic>() ?? const [];
          return NOC(
            (n['full_name'] ?? '').toString(),
            (n['email'] ?? '').toString(),
            (n['contact_no'] ?? '').toString(),
            _mapCodesToNames(codes),
          );
        }),
      );
    setState(() {});
  }

  // SCMs: GET /api/scms → any[]
  Future<void> _loadSCMs() async {
    final res = await _api.get('/api/scms');
    _ensureJson(res);
    final list = (jsonDecode(utf8.decode(res.bodyBytes)) as List?) ?? const [];
    _scmList
      ..clear()
      ..addAll(
        list.map((s) {
          final codes =
              (s['project_codes'] as List?)?.cast<dynamic>() ?? const [];
          return SCM(
            (s['full_name'] ?? '').toString(),
            (s['email'] ?? '').toString(),
            (s['contact_no'] ?? '').toString(),
            _mapCodesToNames(codes),
          );
        }),
      );
    setState(() {});
  }

  // FEs: GET /api/field-engineers → { field_engineers: [...] } | []
  Future<void> _loadFEs() async {
    final res = await _api.get('/api/field-engineers');
    _ensureJson(res);
    final raw = jsonDecode(utf8.decode(res.bodyBytes));
    final list =
        (raw is Map && raw['field_engineers'] is List)
            ? raw['field_engineers'] as List
            : (raw is List ? raw : const []);
    _feList
      ..clear()
      ..addAll(
        list.map((fe) {
          final codes =
              (fe['project_codes'] as List?)?.cast<dynamic>() ?? const [];
          final siteNames =
              (fe['site_names'] as List?)?.cast<dynamic>() ?? const [];
          return FEVendor(
            name: (fe['full_name'] ?? '').toString(),
            email: (fe['email'] ?? '').toString(),
            contact: (fe['contact_no'] ?? '').toString(),
            projectsStr: _mapCodesToNames(codes),
            projects: codes.map((e) => e.toString()).toList(growable: false),
            sites: siteNames.map((e) => e.toString()).toList(growable: false),
            zone: (fe['zone'] ?? '').toString(),
            state: (fe['state'] ?? '').toString(),
            district: (fe['district'] ?? '').toString(),
            id: (fe['id'] ?? fe['_id'] ?? '').toString(),
            role: (fe['role'] ?? 'Field Engineer').toString(),
            bankName: (fe['bank_info'] ?? '').toString(),
            bankAccount: (fe['bank_account'] ?? '').toString(),
            ifsc: (fe['ifsc'] ?? '').toString(),
            pan: (fe['pan'] ?? '').toString(),
            poc: (fe['contact_person'] ?? '').toString(),
          );
        }),
      );
    setState(() {});
  }

  // Customers: GET /api/customers → { customers: [...] }
  Future<void> _loadCustomers() async {
    final res = await _api.get('/api/customers');
    _ensureJson(res);
    final body = jsonDecode(utf8.decode(res.bodyBytes));
    final list =
        (body is Map && body['customers'] is List)
            ? body['customers'] as List
            : (body is List ? body : const []);
    _customerList
      ..clear()
      ..addAll(
        list.map((c) {
          return Customer(
            (c['company_name'] ?? '').toString(),
            (c['email'] ?? '').toString(),
          );
        }),
      );
    setState(() {});
  }

  void _ensureJson(http.Response res) {
    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('HTTP ${res.statusCode}');
    }
    final ct = (res.headers['content-type'] ?? '').toLowerCase();
    if (!ct.contains('application/json')) {
      final preview = res.body.substring(
        0,
        res.body.length > 120 ? 120 : res.body.length,
      );
      throw FormatException('Non-JSON: $preview');
    }
  }

  Future<void> _refreshCurrent() => _loadFor(_currentKind);

  Future<void> _openUpdate(dynamic data) async {
    bool? ok;

    if (data is PM) {
      ok = await UpdateUserModal.show(
        context,
        user: UpdateUserPayload(
          role: RoleKind.pm,
          name: data.name,
          email: data.email,
          contact: data.contact,
          projectsDisplay: data.projects, // names string shown in the list
        ),
      );
    } else if (data is BDM) {
      ok = await UpdateUserModal.show(
        context,
        user: UpdateUserPayload(
          role: RoleKind.bdm,
          name: data.name,
          email: data.email,
          contact: data.contact,
          projectsDisplay: data.projects,
        ),
      );
    } else if (data is NOC) {
      ok = await UpdateUserModal.show(
        context,
        user: UpdateUserPayload(
          role: RoleKind.noc,
          name: data.name,
          email: data.email,
          contact: data.contact,
          projectsDisplay: data.projects,
        ),
      );
    } else if (data is SCM) {
      ok = await UpdateUserModal.show(
        context,
        user: UpdateUserPayload(
          role: RoleKind.scm,
          name: data.name,
          email: data.email,
          contact: data.contact,
          projectsDisplay: data.projects,
        ),
      );
    } else if (data is FEVendor) {
      ok = await UpdateFeModal.show(
        context,
        fe: FeVendorData(
          id: data.id,
          role: data.role,
          name: data.name,
          email: data.email,
          contact: data.contact,
          projectCodes: data.projects, // codes list (you already store these)
          sites: data.sites,
          zone: data.zone,
          state: data.state,
          district: data.district,
          bankName: data.bankName,
          bankAccount: data.bankAccount,
          ifsc: data.ifsc,
          pan: data.pan,
          poc: data.poc,
        ),
      );
    }

    // If a modal returned true, reload the current tab
    if (ok == true && mounted) {
      await _refreshCurrent();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Updated successfully')));
    }
  }

  // project_codes → "Project A, Project B"
  String _mapCodesToNames(List<dynamic> codes) {
    final names =
        codes
            .map((c) => _projectMap[c.toString()] ?? c.toString())
            .toSet()
            .toList();
    return names.join(', ');
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'All Users',
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
      currentIndex: 4, // Users tab index
      onTabChanged: (i) => _handleTabChange(context, i),
      safeArea: false,
      reserveBottomPadding: true,
      body: Padding(
        padding: responsivePadding(context).copyWith(top: 8, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ===== Scrollable toggle =====
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: ToggleButtons(
                isSelected: _isSelected,
                onPressed: _selectKind,
                borderRadius: BorderRadius.circular(10),
                constraints: const BoxConstraints(minHeight: 34, minWidth: 88),
                selectedBorderColor: AppTheme.accentColor,
                borderColor: cs.outlineVariant,
                fillColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.black12
                        : AppTheme.accentColor.withOpacity(0.18),
                selectedColor:
                    Theme.of(context).brightness == Brightness.light
                        ? Colors.black
                        : AppTheme.accentColor,
                color: cs.onSurfaceVariant,
                children:
                    _segments
                        .map(
                          (s) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              s,
                              style: const TextStyle(fontSize: 12),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),
            const SizedBox(height: 8),

            // ===== List =====
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _loadFor(_currentKind),
                child: ValueListenableBuilder<bool>(
                  valueListenable: _loading,
                  builder: (_, loading, __) {
                    final items = _currentItems;
                    if (loading && items.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (_error != null && items.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(_error!, textAlign: TextAlign.center),
                        ),
                      );
                    }
                    if (items.isEmpty) {
                      return const Center(child: Text('No users found'));
                    }
                    return ListView.separated(
                      padding: const EdgeInsets.only(bottom: 12 + 58),
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemCount: items.length,
                      itemBuilder: (context, i) {
                        final item = items[i];
                        return _buildCardFor(item);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Returns the current list depending on the selected kind
  List<dynamic> get _currentItems {
    switch (_currentKind) {
      case UserKind.pm:
        return _pmList;
      case UserKind.bdm:
        return _bdmList;
      case UserKind.noc:
        return _nocList;
      case UserKind.scm:
        return _scmList;
      case UserKind.fevendor:
        return _feList;
      case UserKind.users:
        return _userList;
      case UserKind.customer:
        return _customerList;
    }
  }

  // ---------- aligned key/value line ----------
  static const double _labelW = 98;

  Widget _kv(String label, String value, Color labelColor, Color valueColor) {
    final bool isEmail = label.toLowerCase() == 'email';
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _labelW,
            child: Text(
              '$label:',
              style: TextStyle(color: labelColor, fontSize: 11),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? '—' : value,
              style: TextStyle(color: valueColor, fontSize: 11),
              maxLines: isEmail ? 1 : 4,
              softWrap: !isEmail,
              overflow: isEmail ? TextOverflow.ellipsis : TextOverflow.fade,
            ),
          ),
        ],
      ),
    );
  }

  // Dashboard-style card
  Widget _buildCardFor(dynamic data) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
    final valueColor = isLight ? Colors.black : cs.onSurface;

    String titleLeft = '';
    String titleRight = '';

    List<Widget> left = [];
    List<Widget> right = [];

    if (data is PM) {
      titleLeft = data.name;
      titleRight = 'Project Manager';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
        _kv('Projects', data.projects, labelColor, valueColor),
      ];
    } else if (data is BDM) {
      titleLeft = data.name;
      titleRight = 'Business Development Manager';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
        _kv('Projects', data.projects, labelColor, valueColor),
      ];
    } else if (data is NOC) {
      titleLeft = data.name;
      titleRight = 'NOC Engineer';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
        _kv('Projects', data.projects, labelColor, valueColor),
      ];
    } else if (data is SCM) {
      titleLeft = data.name;
      titleRight = 'Supply Chain Manager';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
        _kv('Projects', data.projects, labelColor, valueColor),
      ];
    } else if (data is FEVendor) {
      titleLeft = data.name;
      titleRight = data.role.isEmpty ? 'Field Engineer / Vendor' : data.role;
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
        _kv('Projects', data.projectsStr, labelColor, valueColor),
        _kv('Sites', data.sites.join(', '), labelColor, valueColor),
      ];
      right = [
        if (data.zone.isNotEmpty)
          _kv('Zone', data.zone, labelColor, valueColor),
        if (data.state.isNotEmpty)
          _kv('State', data.state, labelColor, valueColor),
        if (data.district.isNotEmpty)
          _kv('District', data.district, labelColor, valueColor),
        if (data.bankName.isNotEmpty)
          _kv('Bank Name', data.bankName, labelColor, valueColor),
        if (data.bankAccount.isNotEmpty)
          _kv('Bank Account No', data.bankAccount, labelColor, valueColor),
        if (data.ifsc.isNotEmpty)
          _kv('Bank IFSC', data.ifsc, labelColor, valueColor),
        if (data.pan.isNotEmpty)
          _kv('PAN No', data.pan, labelColor, valueColor),
        if (data.poc.isNotEmpty) _kv('POC', data.poc, labelColor, valueColor),
      ];
    } else if (data is UserAcc) {
      titleLeft = data.username;
      titleRight = data.role;
      left = [_kv('Email', data.email, labelColor, valueColor)];
    } else if (data is Customer) {
      titleLeft = data.name;
      titleRight = 'Customer';
      left = [_kv('Email', data.email, labelColor, valueColor)];
    }

    final Widget columns =
        right.isEmpty
            ? Column(children: left)
            : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Column(children: left)),
                const SizedBox(width: 16),
                Expanded(child: Column(children: right)),
              ],
            );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titleLeft,
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                titleRight,
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 12),

          columns,

          const SizedBox(height: 16),
          
         
          if (data is! Customer)
  Align(
    alignment: Alignment.centerRight,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppTheme.accentColor,
        side: const BorderSide(color: AppTheme.accentColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      onPressed: () => _openUpdate(data),
      child: const Text('Update', style: TextStyle(color: Color(0xFF000000), fontSize: 12)),
    ),
  ),
        ],
      ),
    );
  }
}

// ---------- Models ----------
enum UserKind { pm, bdm, noc, scm, fevendor, users, customer }

class PM {
  final String name, email, contact, projects;
  PM(this.name, this.email, this.contact, this.projects);
}

class BDM {
  final String name, email, contact, projects;
  BDM(this.name, this.email, this.contact, this.projects);
}

class NOC {
  final String name, email, contact, projects;
  NOC(this.name, this.email, this.contact, this.projects);
}

class SCM {
  final String name, email, contact, projects;
  SCM(this.name, this.email, this.contact, this.projects);
}

class FEVendor {
  final String name;
  final String email;
  final String contact;
  final String projectsStr;
  final List<String> projects;
  final List<String> sites;
  final String zone;
  final String state;
  final String district;
  final String id;
  final String role;
  final String bankName;
  final String bankAccount;
  final String ifsc;
  final String pan;
  final String poc;

  FEVendor({
    required this.name,
    required this.email,
    required this.contact,
    required this.projectsStr,
    required this.projects,
    required this.sites,
    required this.zone,
    required this.state,
    required this.district,
    required this.id,
    required this.role,
    required this.bankName,
    required this.bankAccount,
    required this.ifsc,
    required this.pan,
    required this.poc,
  });
}

class UserAcc {
  final String username, role, email;
  UserAcc(this.username, this.role, this.email);
}

class Customer {
  final String name, email;
  Customer(this.name, this.email);
}
