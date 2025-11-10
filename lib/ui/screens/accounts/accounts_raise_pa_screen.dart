// import 'package:flutter/material.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';
// import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';
// import 'generate_pa_screen.dart';

// class AccountsRaisePaScreen extends StatefulWidget {
//   const AccountsRaisePaScreen({super.key});

//   @override
//   State<AccountsRaisePaScreen> createState() => _AccountsRaisePaScreenState();
// }

// class _AccountsRaisePaScreenState extends State<AccountsRaisePaScreen> {
//   String _query = '';

//   // Demo list of PA-eligible items.
//   final List<_PaItem> _items = const [
//     _PaItem(
//       project: 'TCL GSTN',
//       completionDate: '14/09/2026',
//       created: '12/09/2025',
//       activity: 'Implementation',
//       siteName: 'Aastha TV - Noida',
//       siteCode: '001',
//       city: 'Noida',
//       district: 'Gautam Buddha Nagar',
//       state: 'UP',
//       vendor: 'HS Services',
//       pm: 'Aniket Barne',
//       vendorFeName: 'Rahul Verma',
//       vendorFeMobile: '9876543210',
//       status: 'Completed',
//     ),
//     _PaItem(
//       project: 'NDSatcom SAMOFA',
//       completionDate: '31/03/2026',
//       created: '02/04/2025',
//       activity: 'Maintenance',
//       siteName: 'Samofa Site - Goa',
//       siteCode: 'S-100',
//       city: 'Panaji',
//       district: 'North Goa',
//       state: 'Goa',
//       vendor: 'Krypton',
//       pm: 'Kishor Kunal',
//       vendorFeName: 'Manish Kumar',
//       vendorFeMobile: '9988776655',
//       status: 'Completed',
//     ),
//   ];

//   void _handleTabChange(BuildContext context, int i) {
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break; // Dashboard
//       case 1:
//         target = const AddProjectScreen();
//         break; // Add Project
//       case 2:
//         target = const AddActivityScreen();
//         break; // Add Activity
//       case 3:
//         target = const AnalyticsScreen();
//         break; // Analytics
//       case 4:
//         target = const ViewUsersScreen();
//         break; // View Users
//       default:
//         return;
//     }
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   List<_PaItem> get _filtered {
//     final q = _query.trim().toLowerCase();
//     if (q.isEmpty) return _items;
//     return _items.where((e) {
//       return e.project.toLowerCase().contains(q) ||
//           e.activity.toLowerCase().contains(q) ||
//           e.siteName.toLowerCase().contains(q) ||
//           e.vendor.toLowerCase().contains(q) ||
//           e.pm.toLowerCase().contains(q) ||
//           e.vendorFeName.toLowerCase().contains(q) ||
//           e.status.toLowerCase().contains(q);
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Raise PA',
//       centerTitle: true,
//       drawerMode: DrawerMode.accounts,
//       // currentIndex: 0,
//       // onTabChanged: (_) {},
//       currentIndex: -1, // secondary page -> no tab highlighted
//       onTabChanged: (i) => _handleTabChange(context, i),
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
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
//         children: [
//           _SearchField(onChanged: (v) => setState(() => _query = v)),
//           const SizedBox(height: 12),

//           ..._filtered.map(
//             (e) => _PaCard(
//               item: e,
//               onGenerate: () {
//                 // Convert the private _PaItem to a public PaItem the Generate page uses
//                 final converted = PaItem.fromDynamic(e);
//                 Navigator.of(context).push(
//                   MaterialPageRoute(
//                     builder: (_) => GeneratePaScreen(item: converted),
//                   ),
//                 );
//               },
//             ),
//           ),

//           if (_filtered.isEmpty)
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 24),
//               child: Center(
//                 child: Text(
//                   'No items',
//                   style: TextStyle(color: cs.onSurfaceVariant),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

// // ---------- UI ----------

// class _PaCard extends StatelessWidget {
//   final _PaItem item;
//   final VoidCallback onGenerate;
//   const _PaCard({required this.item, required this.onGenerate});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final label =
//         Theme.of(context).brightness == Brightness.light
//             ? Colors.black54
//             : cs.onSurfaceVariant;
//     final value =
//         Theme.of(context).brightness == Brightness.light
//             ? Colors.black
//             : cs.onSurface;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Header: Project | Completion date
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   item.project,
//                   style: TextStyle(
//                     color: value,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 14,
//                   ),
//                 ),
//               ),
//               Text(
//                 item.completionDate,
//                 style: TextStyle(
//                   color: value,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Left column
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Created Date', item.created, label, value),
//                     _kv('Activity', item.activity, label, value),
//                     _kv('Site Name', item.siteName, label, value),
//                     _kv('Site Code', item.siteCode, label, value),
//                     _kv('City', item.city, label, value),
//                     _kv('District', item.district, label, value),
//                     _kv('State', item.state, label, value),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               // Right column
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Vendor', item.vendor, label, value),
//                     _kv('PM', item.pm, label, value),
//                     _kv('Vendor/FE Name', item.vendorFeName, label, value),
//                     _kv('FE/Vendor Mobile', item.vendorFeMobile, label, value),
//                     _kv('Status', item.status, label, value),
//                     const SizedBox(height: 8),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 10,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         onPressed: onGenerate,
//                         child: const Text(
//                           'Generate PA',
//                           style: TextStyle(fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _kv(String k, String v, Color kColor, Color vColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$k: ',
//           style: TextStyle(color: kColor, fontSize: 12),
//           children: [
//             TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 12)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SearchField extends StatelessWidget {
//   final ValueChanged<String>? onChanged;
//   const _SearchField({this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return SizedBox(
//       height: 34,
//       child: TextField(
//         onChanged: onChanged,
//         style: TextStyle(color: cs.onSurface, fontSize: 12),
//         decoration: InputDecoration(
//           hintText: 'Search...',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//           prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 12,
//             vertical: 8,
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ---------- Private list item model used on this page ----------

// class _PaItem {
//   final String project;
//   final String completionDate;

//   final String created;
//   final String activity;
//   final String siteName;
//   final String siteCode;
//   final String city;
//   final String district;
//   final String state;

//   final String vendor;
//   final String pm;
//   final String vendorFeName;
//   final String vendorFeMobile;
//   final String status;

//   const _PaItem({
//     required this.project,
//     required this.completionDate,
//     required this.created,
//     required this.activity,
//     required this.siteName,
//     required this.siteCode,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.vendor,
//     required this.pm,
//     required this.vendorFeName,
//     required this.vendorFeMobile,
//     required this.status,
//   });
// }



//p2//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';
// import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';
// import 'generate_pa_screen.dart';

// // 🔧 Set this to your server base (same as web VITE_API_BASE)
// const String API_BASE = 'https://pmgt.commedialabs.com';


// // Toggle like web
// enum PaMode { single, bulk }

// class AccountsRaisePaScreen extends StatefulWidget {
//   const AccountsRaisePaScreen({
//     super.key,
//     this.projectId,
//     this.subProjectId,
//     this.projectName,
//     this.childProjectName,
//   });

//   final String? projectId;
//   final String? subProjectId;
//   final String? projectName;
//   final String? childProjectName;

//   @override
//   State<AccountsRaisePaScreen> createState() => _AccountsRaisePaScreenState();
// }

// class _AccountsRaisePaScreenState extends State<AccountsRaisePaScreen> {
//   String _query = '';
//   PaMode _mode = PaMode.single;

//   bool _loading = true;
//   String? _error;
//   List<_PaItem> _items = [];

//   // lookups for FE and site names (to match web)
//   Map<String, String> _feMap = {};
//   Map<String, String> _siteNameMap = {}; // key: projectId::siteId::subProjectId

//   @override
//   void initState() {
//     super.initState();
//     _loadAll();
//   }

//   Future<void> _loadAll() async {
//     setState(() {
//       _loading = true;
//       _error = null;
//     });

//     try {
//       // FE map
//       try {
//         final r = await http.get(Uri.parse('$API_BASE/api/field-engineers'));
//         if (r.statusCode == 200) {
//           final body = jsonDecode(r.body);
//           final list = body is List
//               ? body
//               : (body is Map && body['field_engineers'] is List)
//                   ? body['field_engineers']
//                   : const [];
//           _feMap = {
//             for (final f in list) '${f['id']}': '${f['full_name']}',
//           };
//         }
//       } catch (_) {}

//       // Sites map
//       try {
//         final r = await http.get(Uri.parse('$API_BASE/api/project-sites'));
//         if (r.statusCode == 200) {
//           final list = (jsonDecode(r.body) as List).cast<Map>();
//           for (final s in list) {
//             final k =
//                 '${s['project_id']}::${s['site_id']}::${(s['sub_project_id'] ?? '').toString()}';
//             _siteNameMap[k] = '${s['site_name']}';
//           }
//         }
//       } catch (_) {}

//       // Activities (completed) for given project/sub-project
//       final qp = {
//         'page': '1',
//         'limit': '1000',
//         if ((widget.projectId ?? '').isNotEmpty) 'projectId': widget.projectId!,
//         if ((widget.subProjectId ?? '').isNotEmpty) 'subProjectId': widget.subProjectId!,
//       };
//       final uri = Uri.parse('$API_BASE/api/activities').replace(queryParameters: qp);
//       final r = await http.get(uri);
//       if (r.statusCode != 200) throw 'Activities ${r.statusCode}';
//       final body = jsonDecode(r.body);
//       final raw = body is List
//           ? body
//           : (body is Map && body['activities'] is List)
//               ? body['activities']
//               : const [];

//       List<_PaItem> items = [];
//       for (final a in raw) {
//         final status = (a['status'] ?? '').toString().toLowerCase();
//         if (status != 'completed') continue;

//         final projectId = '${a['project_id']}';
//         final siteId = '${a['site_id']}';
//         final subId = (a['sub_project_id'] ?? '').toString();

//         final key = '$projectId::$siteId::$subId';
//         final siteName = (a['site_name'] ?? '').toString().isNotEmpty
//             ? '${a['site_name']}'
//             : (_siteNameMap[key] ?? siteId);

//         final feName =
//             _feMap[(a['field_engineer_id'] ?? '').toString()] ?? (a['vendor'] ?? '');

//         String date10(String? s) => (s ?? '').length >= 10 ? s!.substring(0, 10) : (s ?? '');

//         items.add(_PaItem(
//           project: widget.projectName ?? '',
//           completionDate: date10(
//               (a['completion_date'] ?? a['completed_at'] ?? a['end_date'])?.toString()),
//           created: date10(a['activity_date']?.toString()),
//           activity: (a['activity_category'] ?? a['activity'] ?? '').toString(),
//           siteName: siteName,
//           siteCode: siteId,
//           city: (a['city'] ?? '').toString(),
//           district: (a['district'] ?? '').toString(),
//           state: (a['state'] ?? '').toString(),
//           vendor: (a['vendor'] ?? '').toString(),
//           pm: (a['project_manager'] ?? '').toString(),
//           vendorFeName: feName,
//           vendorFeMobile: (a['fe_mobile'] ?? '').toString(),
//           status: (a['status'] ?? '').toString(),
//         ));
//       }

//       // de-dup by id if present
//       // (not strictly needed for cards but keeps parity with web)
//       // keep as-is

//       setState(() => _items = items);
//     } catch (e) {
//       setState(() => _error = e.toString());
//     } finally {
//       setState(() => _loading = false);
//     }
//   }

//   List<_PaItem> get _filtered {
//     final q = _query.trim().toLowerCase();
//     if (q.isEmpty) return _items;
//     return _items.where((e) {
//       return e.project.toLowerCase().contains(q) ||
//           e.activity.toLowerCase().contains(q) ||
//           e.siteName.toLowerCase().contains(q) ||
//           e.vendor.toLowerCase().contains(q) ||
//           e.pm.toLowerCase().contains(q) ||
//           e.vendorFeName.toLowerCase().contains(q) ||
//           e.status.toLowerCase().contains(q) ||
//           e.city.toLowerCase().contains(q) ||
//           e.district.toLowerCase().contains(q) ||
//           e.state.toLowerCase().contains(q);
//     }).toList();
//   }

//   void _handleTabChange(BuildContext context, int i) {
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break; // Dashboard
//       case 1:
//         target = const AddProjectScreen();
//         break; // Add Project
//       case 2:
//         target = const AddActivityScreen();
//         break; // Add Activity
//       case 3:
//         target = const AnalyticsScreen();
//         break; // Analytics
//       case 4:
//         target = const ViewUsersScreen();
//         break; // View Users
//       default:
//         return;
//     }
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     final projLabel = [
//       if ((widget.projectName ?? '').isNotEmpty) widget.projectName!,
//       if ((widget.childProjectName ?? '').isNotEmpty) '— ${widget.childProjectName!}',
//     ].join(' ');

//     return MainLayout(
//       title: 'Raise PA',
//       centerTitle: true,
//       drawerMode: DrawerMode.accounts,
//       currentIndex: -1,
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       actions: [
//         IconButton(
//           tooltip: Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
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
//           onPressed: () =>
//               Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
//           icon: const ProfileAvatar(size: 36),
//         ),
//         const SizedBox(width: 8),
//       ],
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _error != null
//               ? Center(
//                   child: Text('Failed to load activities\n$_error',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: cs.error)),
//                 )
//               : ListView(
//                   padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(child: _SearchField(onChanged: (v) => setState(() => _query = v))),
//                         const SizedBox(width: 8),
//                         _ModeToggle(mode: _mode, onChanged: (m) => setState(() => _mode = m)),
//                       ],
//                     ),
//                     if (projLabel.isNotEmpty) ...[
//                       const SizedBox(height: 6),
//                       Text(
//                         projLabel,
//                         style: TextStyle(
//                           color: cs.onSurfaceVariant,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                     const SizedBox(height: 12),

//                     ..._filtered.map(
//                       (e) => _PaCard(
//                         item: e,
//                         mode: _mode,
//                         onGenerate: () {
//                           final converted = PaItem.fromDynamic(e);
//                           Navigator.of(context).push(
//                             MaterialPageRoute(
//                               builder: (_) => GeneratePaScreen(item: converted),
//                             ),
//                           );
//                         },
//                       ),
//                     ),

//                     if (_filtered.isEmpty)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 24),
//                         child: Center(
//                           child:
//                               Text('No completed activities found', style: TextStyle(color: cs.onSurfaceVariant)),
//                         ),
//                       ),
//                   ],
//                 ),
//     );
//   }
// }

// // ---------- Models / UI ----------

// class PaItem {
//   final String project;
//   final String completionDate;
//   final String created;
//   final String activity;
//   final String siteName;
//   final String siteCode;
//   final String city;
//   final String district;
//   final String state;
//   final String vendor;
//   final String pm;
//   final String vendorFeName;
//   final String vendorFeMobile;
//   final String status;

//   const PaItem({
//     required this.project,
//     required this.completionDate,
//     required this.created,
//     required this.activity,
//     required this.siteName,
//     required this.siteCode,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.vendor,
//     required this.pm,
//     required this.vendorFeName,
//     required this.vendorFeMobile,
//     required this.status,
//   });

//   factory PaItem.fromDynamic(_PaItem e) => PaItem(
//         project: e.project,
//         completionDate: e.completionDate,
//         created: e.created,
//         activity: e.activity,
//         siteName: e.siteName,
//         siteCode: e.siteCode,
//         city: e.city,
//         district: e.district,
//         state: e.state,
//         vendor: e.vendor,
//         pm: e.pm,
//         vendorFeName: e.vendorFeName,
//         vendorFeMobile: e.vendorFeMobile,
//         status: e.status,
//       );
// }

// class _PaItem {
//   final String project;
//   final String completionDate;
//   final String created;
//   final String activity;
//   final String siteName;
//   final String siteCode;
//   final String city;
//   final String district;
//   final String state;
//   final String vendor;
//   final String pm;
//   final String vendorFeName;
//   final String vendorFeMobile;
//   final String status;

//   const _PaItem({
//     required this.project,
//     required this.completionDate,
//     required this.created,
//     required this.activity,
//     required this.siteName,
//     required this.siteCode,
//     required this.city,
//     required this.district,
//     required this.state,
//     required this.vendor,
//     required this.pm,
//     required this.vendorFeName,
//     required this.vendorFeMobile,
//     required this.status,
//   });
// }

// class _PaCard extends StatelessWidget {
//   final _PaItem item;
//   final PaMode mode;
//   final VoidCallback onGenerate;
//   const _PaCard({required this.item, required this.mode, required this.onGenerate});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final label = Theme.of(context).brightness == Brightness.light ? Colors.black54 : cs.onSurfaceVariant;
//     final value = Theme.of(context).brightness == Brightness.light ? Colors.black : cs.onSurface;

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(item.project,
//                     style: TextStyle(color: value, fontWeight: FontWeight.w800, fontSize: 14)),
//               ),
//               Text(item.completionDate,
//                   style: TextStyle(color: value, fontWeight: FontWeight.w700, fontSize: 14)),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Created Date', item.created, label, value),
//                     _kv('Activity', item.activity, label, value),
//                     _kv('Site Name', item.siteName, label, value),
//                     _kv('Site Code', item.siteCode, label, value),
//                     _kv('City', item.city, label, value),
//                     _kv('District', item.district, label, value),
//                     _kv('State', item.state, label, value),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Vendor', item.vendor, label, value),
//                     _kv('PM', item.pm, label, value),
//                     _kv('Vendor/FE Name', item.vendorFeName, label, value),
//                     _kv('FE/Vendor Mobile', item.vendorFeMobile, label, value),
//                     _kv('Status', item.status, label, value),
//                     const SizedBox(height: 8),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                         ),
//                         onPressed: onGenerate,
//                         child: Text(
//                           mode == PaMode.single ? 'Generate PA' : 'Generate Bulk',
//                           style: const TextStyle(fontWeight: FontWeight.w700),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _kv(String k, String v, Color kColor, Color vColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$k: ',
//           style: TextStyle(color: kColor, fontSize: 12),
//           children: [TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 12))],
//         ),
//       ),
//     );
//   }
// }

// class _SearchField extends StatelessWidget {
//   final ValueChanged<String>? onChanged;
//   const _SearchField({this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return SizedBox(
//       height: 34,
//       child: TextField(
//         onChanged: onChanged,
//         style: TextStyle(color: cs.onSurface, fontSize: 12),
//         decoration: InputDecoration(
//           hintText: 'Search...',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//           prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(8),
//             borderSide: BorderSide.none,
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         ),
//       ),
//     );
//   }
// }

// class _ModeToggle extends StatelessWidget {
//   final PaMode mode;
//   final ValueChanged<PaMode> onChanged;
//   const _ModeToggle({required this.mode, required this.onChanged});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       height: 34,
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: cs.outlineVariant),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           _seg(ctx: context, text: 'Single', selected: mode == PaMode.single, onTap: () => onChanged(PaMode.single), first: true),
//           _seg(ctx: context, text: 'Bulk', selected: mode == PaMode.bulk, onTap: () => onChanged(PaMode.bulk), last: true),
//         ],
//       ),
//     );
//   }

//   Widget _seg({required BuildContext ctx, required String text, required bool selected, required VoidCallback onTap, bool first = false, bool last = false}) {
//     final cs = Theme.of(ctx).colorScheme;
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.horizontal(
//         left: first ? const Radius.circular(8) : Radius.zero,
//         right: last ? const Radius.circular(8) : Radius.zero,
//       ),
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: selected ? AppTheme.accentColor.withOpacity(0.25) : Colors.transparent,
//           borderRadius: BorderRadius.horizontal(
//             left: first ? const Radius.circular(8) : Radius.zero,
//             right: last ? const Radius.circular(8) : Radius.zero,
//           ),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             fontSize: 12,
//             fontWeight: FontWeight.w600,
//             color: selected ? cs.onSurface : cs.onSurfaceVariant,
//           ),
//         ),
//       ),
//     );
//   }
// }



//p3//
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:pmgt/core/theme.dart';
import 'package:pmgt/core/theme_controller.dart';
import 'package:pmgt/ui/utils/responsive.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';
import 'package:pmgt/ui/screens/profile/profile_screen.dart';
import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';
import 'generate_pa_screen.dart';
import 'package:pmgt/ui/screens/accounts/accounts_generate_bulk_pa.dart';


// 🔧 Same as web VITE_API_BASE
const String API_BASE = 'https://pmgt.commedialabs.com';

// Toggle like web
enum PaMode { single, bulk }

class AccountsRaisePaScreen extends StatefulWidget {
  const AccountsRaisePaScreen({
    super.key,
    this.projectId,
    this.subProjectId,
    this.projectName,
    this.childProjectName,
  });

  final String? projectId;
  final String? subProjectId;
  final String? projectName;
  final String? childProjectName;

  @override
  State<AccountsRaisePaScreen> createState() => _AccountsRaisePaScreenState();
}

class _AccountsRaisePaScreenState extends State<AccountsRaisePaScreen> {
  String _query = '';
  PaMode _mode = PaMode.single;

  bool _loading = true;
  String? _error;
  List<_PaItem> _items = [];

  // lookups for FE and site names (to match web)
  Map<String, String> _feMap = {};
  Map<String, String> _siteNameMap = {}; // key: projectId::siteId::subProjectId

  // ── Pagination (30 / page)
  static const int _rowsPerPage = 30;
  int _page = 0;

  // ── Bulk selection
  final Set<String> _selected = <String>{};

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  Future<void> _loadAll() async {
    setState(() {
      _loading = true;
      _error = null;
      _selected.clear();
      _page = 0;
    });

    try {
      // FE map
      try {
        final r = await http.get(Uri.parse('$API_BASE/api/field-engineers'));
        if (r.statusCode == 200) {
          final body = jsonDecode(r.body);
          final list = body is List
              ? body
              : (body is Map && body['field_engineers'] is List)
                  ? body['field_engineers']
                  : const [];
          _feMap = {
            for (final f in list) '${f['id']}': '${f['full_name']}',
          };
        }
      } catch (_) {}

      // Sites map
      try {
        final r = await http.get(Uri.parse('$API_BASE/api/project-sites'));
        if (r.statusCode == 200) {
          final raw = jsonDecode(r.body);
          final list = (raw is List ? raw : const []) as List;
          for (final e in list) {
            final s = e as Map;
            final k =
                '${s['project_id']}::${s['site_id']}::${(s['sub_project_id'] ?? '').toString()}';
            _siteNameMap[k] = '${s['site_name']}';
          }
        }
      } catch (_) {}

      // Activities (completed) for given project/sub-project
      final qp = {
        'page': '1',
        'limit': '1000',
        if ((widget.projectId ?? '').isNotEmpty) 'projectId': widget.projectId!,
        if ((widget.subProjectId ?? '').isNotEmpty) 'subProjectId': widget.subProjectId!,
      };
      final uri = Uri.parse('$API_BASE/api/activities').replace(queryParameters: qp);
      final r = await http.get(uri);
      if (r.statusCode != 200) throw 'Activities ${r.statusCode}';
      final body = jsonDecode(r.body);
      final raw = body is List
          ? body
          : (body is Map && body['activities'] is List)
              ? body['activities']
              : const [];

      List<_PaItem> items = [];
      for (final a0 in raw) {
        final a = a0 as Map;
        final status = (a['status'] ?? '').toString().toLowerCase();
        if (status != 'completed') continue;

        final id = '${a['id']}';
        final projectId = '${a['project_id']}';
        final siteId = '${a['site_id']}';
        final subId = (a['sub_project_id'] ?? '').toString();

        final key = '$projectId::$siteId::$subId';
        final siteName = (a['site_name'] ?? '').toString().isNotEmpty
            ? '${a['site_name']}'
            : (_siteNameMap[key] ?? siteId);

        final feName =
            _feMap[(a['field_engineer_id'] ?? '').toString()] ?? (a['vendor'] ?? '');

        String date10(String? s) => (s ?? '').length >= 10 ? s!.substring(0, 10) : (s ?? '');

        items.add(_PaItem(
          id: id,
          project: widget.projectName ?? '',
          completionDate: date10(
              (a['completion_date'] ?? a['completed_at'] ?? a['end_date'])?.toString()),
          created: date10(a['activity_date']?.toString()),
          activity: (a['activity_category'] ?? a['activity'] ?? '').toString(),
          siteName: siteName,
          siteCode: siteId,
          city: (a['city'] ?? '').toString(),
          district: (a['district'] ?? '').toString(),
          state: (a['state'] ?? '').toString(),
          vendor: (a['vendor'] ?? '').toString(),
          pm: (a['project_manager'] ?? '').toString(),
          vendorFeName: feName,
          vendorFeMobile: (a['fe_mobile'] ?? '').toString(),
          status: (a['status'] ?? '').toString(),
        ));
      }

      setState(() => _items = items);
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _loading = false);
    }
  }

  // ── Search
  List<_PaItem> get _filtered {
    final q = _query.trim().toLowerCase();
    if (q.isEmpty) return _items;
    return _items.where((e) {
      return e.project.toLowerCase().contains(q) ||
          e.activity.toLowerCase().contains(q) ||
          e.siteName.toLowerCase().contains(q) ||
          e.vendor.toLowerCase().contains(q) ||
          e.pm.toLowerCase().contains(q) ||
          e.vendorFeName.toLowerCase().contains(q) ||
          e.status.toLowerCase().contains(q) ||
          e.city.toLowerCase().contains(q) ||
          e.district.toLowerCase().contains(q) ||
          e.state.toLowerCase().contains(q) ||
          e.siteCode.toLowerCase().contains(q);
    }).toList();
  }

  // ── Pagination helpers
  List<_PaItem> get _paginated {
    final list = _filtered;
    final start = _page * _rowsPerPage;
    if (start >= list.length) return const [];
    final end = (start + _rowsPerPage).clamp(0, list.length);
    return list.sublist(start, end);
  }

  int get _totalPages =>
      _filtered.isEmpty ? 1 : ((_filtered.length - 1) ~/ _rowsPerPage) + 1;

  // ── Bulk select helpers
  bool get _isAllFilteredSelected =>
      _filtered.isNotEmpty && _filtered.every((e) => _selected.contains(e.id));

  void _toggleSelectAllFiltered(bool checked) {
    setState(() {
      if (checked) {
        _selected.addAll(_filtered.map((e) => e.id));
      } else {
        _selected.removeWhere((id) => _filtered.any((e) => e.id == id));
      }
    });
  }

  void _toggleOne(String id, bool checked) {
    setState(() {
      checked ? _selected.add(id) : _selected.remove(id);
    });
  }

  void _clearSelection() => setState(_selected.clear);

//   void _onGenerateBulk() {
//     if (_selected.isEmpty) return;
//     // Build small pre-lookup (optional)
//     final preByActivity = <String, Map<String, String>>{};
//     for (final it in _items) {
//       if (_selected.contains(it.id)) {
//         preByActivity[it.id] = {
//           'siteName': it.siteName,
//           'siteCode': it.siteCode,
//         };
//       }
//     }
  
//     Navigator.of(context).push(
//   MaterialPageRoute(
//     builder: (_) => const GeneratePaBulkScreen(),
//     settings: RouteSettings(arguments: {
//       'activityIds': _selected.toList(),
//       'projectId': widget.projectId,
//       'sub_project_id': widget.subProjectId,
//       'projectName': widget.projectName,
//       'childProjectName': widget.childProjectName,
//       'preByActivity': preByActivity,
//     }),
//   ),
// );
// }


void _onGenerateBulk() {
  if (_selected.isEmpty) return;

  final preByActivity = <String, Map<String, String>>{};
  for (final it in _items) {
    if (_selected.contains(it.id)) {
      preByActivity[it.id] = {
        'siteName': it.siteName,
        'siteCode': it.siteCode,
      };
    }
  }

  // ✅ push after this frame to avoid dependOnInheritedWidget errors
  WidgetsBinding.instance.addPostFrameCallback((_) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const GeneratePaBulkScreen(),
        settings: RouteSettings(arguments: {
          'activityIds': _selected.toList(),
          'projectId': widget.projectId,
          'sub_project_id': widget.subProjectId,
          'projectName': widget.projectName,
          'childProjectName': widget.childProjectName,
          'preByActivity': preByActivity,
        }),
      ),
    );
  });
}


  // ── Bottom nav tabs
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
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    // Guard page bounds if filter changed
    if (_page > _totalPages - 1) _page = _totalPages - 1;

    final projLabel = [
      if ((widget.projectName ?? '').isNotEmpty) widget.projectName!,
      if ((widget.childProjectName ?? '').isNotEmpty) '— ${widget.childProjectName!}',
    ].join(' ');

    final pageStart = _filtered.isEmpty ? 0 : _page * _rowsPerPage + 1;
    final pageEnd = (_page * _rowsPerPage + _paginated.length);

    return MainLayout(
      title: 'Raise PA',
      centerTitle: true,
      drawerMode: DrawerMode.accounts,
      currentIndex: -1,
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
          onPressed: () =>
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Text(
                    'Failed to load activities\n$_error',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: cs.error),
                  ),
                )
              : ListView(
                  padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
                  children: [
                    // Search + mode toggle
                    Row(
                      children: [
                        Expanded(
                          child: _SearchField(onChanged: (v) {
                            setState(() {
                              _query = v;
                              _page = 0;
                            });
                          }),
                        ),
                        const SizedBox(width: 8),
                        _ModeToggle(
                          mode: _mode,
                          onChanged: (m) {
                            setState(() {
                              _mode = m;
                              _selected.clear();
                            });
                          },
                        ),
                      ],
                    ),

                    if (projLabel.isNotEmpty) ...[
                      const SizedBox(height: 6),
                      Text(
                        projLabel,
                        style: TextStyle(
                          color: cs.onSurfaceVariant,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],

                    // Bulk controls row
                    if (_mode == PaMode.bulk) ...[
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          InkWell(
                            borderRadius: BorderRadius.circular(6),
                            onTap: () => _toggleSelectAllFiltered(!_isAllFilteredSelected),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: _isAllFilteredSelected,
                                  onChanged: (v) => _toggleSelectAllFiltered(v ?? false),
                                  visualDensity: VisualDensity.compact,
                                ),
                                Text(
                                  'Select all',
                                  style: TextStyle(
                                    color: cs.onSurface,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          OutlinedButton(
                            onPressed: _selected.isEmpty ? null : _clearSelection,
                            style: OutlinedButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                            ),
                            child: const Text('Clear Selection'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _selected.isEmpty ? null : _onGenerateBulk,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.success,
                              foregroundColor: Colors.black,
                              visualDensity: VisualDensity.compact,
                            ),
                            child: const Text('Generate Bulk'),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 12),

                    // Cards (paginated)
                    ..._paginated.map(
                      (e) => _PaCard(
                        item: e,
                        mode: _mode,
                        checked: _selected.contains(e.id),
                        onToggle: (v) => _toggleOne(e.id, v),
                        // onGenerate: () {
                        //   final converted = PaItem.fromDynamic(e);
                        //   Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //       builder: (_) => GeneratePaScreen(item: converted),
                        //     ),
                        //   );
                        // },
                        onGenerate: () {
  // Pass a payload with the exact keys GeneratePaScreen expects.
  final payload = {
    'projectName'   : e.project,
    'activity'      : e.activity,
    'siteName'      : e.siteName,
    'siteCode'      : e.siteCode,     // string is fine
    'state'         : e.state,
    'vendor'        : e.vendor,
    'feVendorName'  : e.vendorFeName,
    'completionDate': e.completionDate,

    // (Optional, handy later when wiring PDF upload)
    'activityId'    : e.id,
    'projectId'     : widget.projectId ?? '',
    'siteId'        : e.siteCode,
    'feMobile'      : e.vendorFeMobile,
  };

  Navigator.of(context).push(
    MaterialPageRoute(builder: (_) => GeneratePaScreen(item: payload)),
  );
},
                      ),
                    ),

                    if (_paginated.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: Text('No completed activities found',
                              style: TextStyle(color: cs.onSurfaceVariant)),
                        ),
                      ),

                    // Footer: selected + pagination
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Selected: ${_selected.length}',
                          style: TextStyle(
                              color: cs.onSurface, fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          _filtered.isEmpty ? '0 of 0' : '$pageStart–$pageEnd of ${_filtered.length}',
                          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: _page <= 0 ? null : () => setState(() => _page -= 1),
                          icon: const Icon(Icons.chevron_left),
                        ),
                        Text(
                          'Page ${_page + 1} of $_totalPages',
                          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
                        ),
                        IconButton(
                          visualDensity: VisualDensity.compact,
                          onPressed: _page >= _totalPages - 1
                              ? null
                              : () => setState(() => _page += 1),
                          icon: const Icon(Icons.chevron_right),
                        ),
                      ],
                    ),
                  ],
                ),
    );
  }
}

// ---------- Models / UI ----------

class PaItem {
  final String id;
  final String project;
  final String completionDate;
  final String created;
  final String activity;
  final String siteName;
  final String siteCode;
  final String city;
  final String district;
  final String state;
  final String vendor;
  final String pm;
  final String vendorFeName;
  final String vendorFeMobile;
  final String status;

  const PaItem({
    required this.id,
    required this.project,
    required this.completionDate,
    required this.created,
    required this.activity,
    required this.siteName,
    required this.siteCode,
    required this.city,
    required this.district,
    required this.state,
    required this.vendor,
    required this.pm,
    required this.vendorFeName,
    required this.vendorFeMobile,
    required this.status,
  });

  factory PaItem.fromDynamic(_PaItem e) => PaItem(
        id: e.id,
        project: e.project,
        completionDate: e.completionDate,
        created: e.created,
        activity: e.activity,
        siteName: e.siteName,
        siteCode: e.siteCode,
        city: e.city,
        district: e.district,
        state: e.state,
        vendor: e.vendor,
        pm: e.pm,
        vendorFeName: e.vendorFeName,
        vendorFeMobile: e.vendorFeMobile,
        status: e.status,
      );
}

class _PaItem {
  final String id;
  final String project;
  final String completionDate;
  final String created;
  final String activity;
  final String siteName;
  final String siteCode;
  final String city;
  final String district;
  final String state;
  final String vendor;
  final String pm;
  final String vendorFeName;
  final String vendorFeMobile;
  final String status;

  const _PaItem({
    required this.id,
    required this.project,
    required this.completionDate,
    required this.created,
    required this.activity,
    required this.siteName,
    required this.siteCode,
    required this.city,
    required this.district,
    required this.state,
    required this.vendor,
    required this.pm,
    required this.vendorFeName,
    required this.vendorFeMobile,
    required this.status,
  });
}

class _PaCard extends StatelessWidget {
  final _PaItem item;
  final PaMode mode;
  final bool checked;
  final ValueChanged<bool> onToggle;
  final VoidCallback onGenerate;

  const _PaCard({
    required this.item,
    required this.mode,
    required this.checked,
    required this.onToggle,
    required this.onGenerate,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final label = isLight ? Colors.black54 : cs.onSurfaceVariant;
    final value = isLight ? Colors.black : cs.onSurface;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header row: [checkbox?] Project | completion date
          Row(
            children: [
              if (mode == PaMode.bulk) ...[
                Checkbox(
                  value: checked,
                  onChanged: (v) => onToggle(v ?? false),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(width: 4),
              ],
              Expanded(
                child: Text(
                  item.project,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: value, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              Text(item.completionDate,
                  style: TextStyle(color: value, fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('Created Date', item.created, label, value),
                    _kv('Activity', item.activity, label, value),
                    _kv('Site Name', item.siteName, label, value),
                    _kv('Site Code', item.siteCode, label, value),
                    _kv('City', item.city, label, value),
                    _kv('District', item.district, label, value),
                    _kv('State', item.state, label, value),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('Vendor', item.vendor, label, value),
                    _kv('PM', item.pm, label, value),
                    _kv('Vendor/FE Name', item.vendorFeName, label, value),
                    _kv('FE/Vendor Mobile', item.vendorFeMobile, label, value),
                    _kv('Status', item.status, label, value),
                    if (mode == PaMode.single) ...[
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.accentColor,
                            foregroundColor: Colors.black,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: onGenerate,
                          child: const Text(
                            'Generate PA',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v, Color kColor, Color vColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$k: ',
          style: TextStyle(color: kColor, fontSize: 12),
          children: [TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 12))],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  const _SearchField({this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 34,
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: cs.onSurface, fontSize: 12),
        decoration: InputDecoration(
          hintText: 'Search...',
          hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          prefixIcon: Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  final PaMode mode;
  final ValueChanged<PaMode> onChanged;
  const _ModeToggle({required this.mode, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 34,
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _seg(
            ctx: context,
            text: 'Single',
            selected: mode == PaMode.single,
            onTap: () => onChanged(PaMode.single),
            first: true,
          ),
          _seg(
            ctx: context,
            text: 'Bulk',
            selected: mode == PaMode.bulk,
            onTap: () => onChanged(PaMode.bulk),
            last: true,
          ),
        ],
      ),
    );
  }

  Widget _seg({
    required BuildContext ctx,
    required String text,
    required bool selected,
    required VoidCallback onTap,
    bool first = false,
    bool last = false,
  }) {
    final cs = Theme.of(ctx).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.horizontal(
        left: first ? const Radius.circular(8) : Radius.zero,
        right: last ? const Radius.circular(8) : Radius.zero,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppTheme.accentColor.withOpacity(0.25) : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: first ? const Radius.circular(8) : Radius.zero,
            right: last ? const Radius.circular(8) : Radius.zero,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: selected ? cs.onSurface : cs.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
