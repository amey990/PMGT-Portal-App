// // lib/ui/screens/sites/all_sites_screen.dart
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';
// // Bottom-nav root screens
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';

// // Update modal
// import '../modals/update_site_modal.dart';

// class AllSitesScreen extends StatefulWidget {
//   const AllSitesScreen({super.key});

//   @override
//   State<AllSitesScreen> createState() => _AllSitesScreenState();
// }

// class _AllSitesScreenState extends State<AllSitesScreen> {
//   // --- filters/search/pagination ---
//   final List<String> _projects = const [
//     'All',
//     'NPCI',
//     'TelstraApari',
//     'BPCL Aruba WIFI',
//   ];
//   String _selectedProject = 'All';

//   final _searchCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _searchCtrl.text = _search;
//     _searchCtrl.addListener(() {
//       setState(() {
//         _search = _searchCtrl.text;
//         _currentPage = 1;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchCtrl.dispose();
//     super.dispose();
//   }

//   String _search = '';

//   int _currentPage = 1;
//   int _perPage = 10;
//   final List<int> _perPageOptions = const [5, 10, 15, 20];

//   // --- sample data (fake) ---
//   final List<Site> _sites = List.generate(
//     30,
//     (i) => Site(
//       project: i % 3 == 0 ? 'NPCI' : (i % 3 == 1 ? 'TelstraApari' : 'BPCL Aruba WIFI'),
//       subProject: i.isEven ? 'SP-1' : 'Child A',
//       status: i.isEven ? 'Active' : 'Inactive',
//       siteName: 'Site ${(i + 1).toString().padLeft(3, '0')}',
//       siteId: (i + 1).toString().padLeft(3, '0'),
//       address: 'XYZ Street, Some Area',
//       pincode: '400${(i % 10).toString().padLeft(2, '0')}',
//       poc: i.isEven ? 'Amey' : 'Priya',
//       country: 'India',
//       state: 'Maharashtra',
//       district: i.isEven ? 'Thane' : 'Pune',
//       city: i.isEven ? 'Panvel' : 'Pune',
//       completionDate: '21/12/2025',
//       remarks: '—',
//     ),
//   );

//   // --- helpers ---
//   List<Site> get _filtered {
//     final q = _search.trim().toLowerCase();
//     return _sites.where((s) {
//       final okProject = _selectedProject == 'All' || s.project == _selectedProject;
//       final okSearch = q.isEmpty ||
//           s.project.toLowerCase().contains(q) ||
//           s.siteName.toLowerCase().contains(q) ||
//           s.siteId.toLowerCase().contains(q) ||
//           s.city.toLowerCase().contains(q) ||
//           s.district.toLowerCase().contains(q) ||
//           s.subProject.toLowerCase().contains(q);
//       return okProject && okSearch;
//     }).toList();
//   }

//   int get _totalPages {
//     final len = _filtered.length;
//     if (len == 0) return 1;
//     return (len + _perPage - 1) ~/ _perPage;
//   }

//   List<Site> get _paged {
//     final items = _filtered;
//     if (items.isEmpty) return const [];
//     final start = (_currentPage - 1) * _perPage;
//     final end = min(start + _perPage, items.length);
//     if (start >= items.length) return const [];
//     return items.sublist(start, end);
//   }

//   void _goToPage(int p) => setState(() {
//         _currentPage = p.clamp(1, _totalPages);
//       });

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
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'All Sites',
//       centerTitle: true,
//       // AppBar actions (theme + profile)
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
//           onPressed: () {
//             Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
//           icon: ClipOval(
//             child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           ),
//         ),
//         const SizedBox(width: 8),
//       ],
//       currentIndex: _selectedTab,
//       onTabChanged: (i) => _handleTabChange(i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Padding(
//         padding: responsivePadding(context).copyWith(top: 6, bottom: 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Search
//             const SizedBox(height: 4),
//             _SearchField(controller: _searchCtrl),
//             const SizedBox(height: 8),
//             Divider(color: cs.outlineVariant),
//             const SizedBox(height: 8),

//             // Project dropdown + Export (aligned, same height)
//             Row(
//               children: [
//                 Expanded(
//                   child: _Dropdown<String>(
//                     hint: 'Select project',
//                     value: _selectedProject,
//                     items: _projects,
//                     onChanged: (v) => setState(() {
//                       _selectedProject = v ?? 'All';
//                       _currentPage = 1;
//                     }),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 SizedBox(
//                   height: 34,
//                   child: ElevatedButton.icon(
//                     onPressed: () {
//                       // TODO: Export handler
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         const SnackBar(content: Text('Export started...')),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppTheme.accentColor,
//                       foregroundColor: Colors.black,
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                       padding: const EdgeInsets.symmetric(horizontal: 14),
//                     ),
//                     icon: const Icon(Icons.download),
//                     label: const Text('Export', style: TextStyle(fontWeight: FontWeight.w800)),
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 12),

//             // List + pagination footer (like Dashboard)
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.only(bottom: 12 + 58),
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemCount: _paged.length + 1,
//                 itemBuilder: (context, i) {
//                   if (i < _paged.length) {
//                     final s = _paged[i];
//                     final globalIndex = _sites.indexOf(s);
//                     return _SiteCard(
//                       site: s,
//                       onUpdate: (updated) {
//                         setState(() => _sites[globalIndex] = updated);
//                       },
//                     );
//                   }
//                   // inline pagination row
//                   return _PaginationInline(
//                     currentPage: _currentPage,
//                     totalPages: _totalPages,
//                     onPageSelected: _goToPage,
//                     onPrev: () => _goToPage(_currentPage - 1),
//                     onNext: () => _goToPage(_currentPage + 1),
//                     perPage: _perPage,
//                     options: _perPageOptions,
//                     onPerPageChanged: (v) {
//                       setState(() {
//                         _perPage = v;
//                         _currentPage = 1;
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /* ------------------------ Widgets / helpers ------------------------ */

// class _SiteCard extends StatelessWidget {
//   final Site site;
//   final ValueChanged<Site> onUpdate;
//   const _SiteCard({required this.site, required this.onUpdate});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;
//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     return Container(
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 site.project,
//                 style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 14),
//               ),
//               Text(
//                 'Status : ${site.status}',
//                 style: TextStyle(color: valueColor, fontWeight: FontWeight.w700, fontSize: 14),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text('Sub Project: ${site.subProject}', style: TextStyle(color: labelColor, fontSize: 11)),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           // two columns
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Site Name', site.siteName, labelColor, valueColor),
//                     _kv('Site ID', site.siteId, labelColor, valueColor),
//                     _kv('Address', site.address, labelColor, valueColor),
//                     _kv('Pincode', site.pincode, labelColor, valueColor),
//                     _kv('Completion Date', site.completionDate, labelColor, valueColor),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('POC', site.poc, labelColor, valueColor),
//                     _kv('Country', site.country, labelColor, valueColor),
//                     _kv('State', site.state, labelColor, valueColor),
//                     _kv('District', site.district, labelColor, valueColor),
//                     _kv('City', site.city, labelColor, valueColor),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),
//           _kv('Remarks', site.remarks, labelColor, valueColor),

//           const SizedBox(height: 16),
//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppTheme.accentColor,
//                 side: const BorderSide(color: AppTheme.accentColor),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               ),
//               onPressed: () async {
//                 final updated = await UpdateSiteModal.show(
//                   context,
//                   site: site,
//                   subProjects: const ['SP-1', 'SP-2', 'Child A', '—'],
//                   statusOptions: const [

//                     'Completed',
//                     'In Progress',
//                     'Pending',
//                     'Hold',

//                   ],
//                 );
//                 if (updated != null) onUpdate(updated);
//               },
//               child: const Text('Update', style: TextStyle(color: Colors.black, fontSize: 12)),
//             ),
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
//           style: TextStyle(color: kColor, fontSize: 11),
//           children: [TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 11))],
//         ),
//       ),
//     );
//   }
// }

// class _SearchField extends StatelessWidget {
//   final TextEditingController controller;
//   const _SearchField({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return SizedBox(
//       height: 34,
//       child: TextField(
//         controller: controller,
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

// class _Dropdown<T> extends StatelessWidget {
//   final String hint;
//   final T value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;
//   const _Dropdown({
//     required this.hint,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       height: 34,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<T>(
//           value: value,
//           isExpanded: true,
//           dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//           iconEnabledColor: cs.onSurfaceVariant,
//           style: TextStyle(color: cs.onSurface, fontSize: 12),
//           hint: Text(hint, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
//           items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }
// }

// /* -------- Pagination (copied from Dashboard style) -------- */

// class _PaginationBar extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;
//   static const int _windowSize = 5;

//   const _PaginationBar({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     final int windowStart = ((currentPage - 1) ~/ _windowSize) * _windowSize + 1;
//     final int windowEnd = min(windowStart + _windowSize - 1, totalPages);

//     Widget pill({
//       required Widget child,
//       required bool selected,
//       VoidCallback? onTap,
//       double width = 40,
//     }) {
//       final bg = selected ? Colors.black : cs.surfaceContainerHighest;
//       final fg = selected ? Colors.white : cs.onSurface;

//       final content = Container(
//         width: width,
//         height: 36,
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: DefaultTextStyle(
//           style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 13),
//           child: IconTheme.merge(
//             data: IconThemeData(color: fg, size: 18),
//             child: child,
//           ),
//         ),
//       );

//       return onTap == null
//           ? Opacity(opacity: 0.5, child: content)
//           : InkWell(onTap: onTap, borderRadius: BorderRadius.circular(10), child: content);
//     }

//     final hasPrevWindow = windowStart > 1;
//     final hasNextWindow = windowEnd < totalPages;

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         pill(
//           child: const Icon(Icons.chevron_left),
//           selected: false,
//           onTap: hasPrevWindow ? () => onPageSelected(windowStart - 1) : null,
//         ),
//         for (int p = windowStart; p <= windowEnd; p++)
//           pill(
//             child: Text('$p'),
//             selected: p == currentPage,
//             onTap: () => onPageSelected(p),
//           ),
//         pill(
//           child: const Icon(Icons.chevron_right),
//           selected: false,
//           onTap: hasNextWindow ? () => onPageSelected(windowEnd + 1) : null,
//         ),
//       ],
//     );
//   }
// }

// class _PaginationInline extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;

//   final VoidCallback onPrev; // unused but kept for API parity
//   final VoidCallback onNext;

//   final int perPage;
//   final List<int> options;
//   final ValueChanged<int> onPerPageChanged;

//   const _PaginationInline({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageSelected,
//     required this.onPrev,
//     required this.onNext,
//     required this.perPage,
//     required this.options,
//     required this.onPerPageChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: SizedBox(
//         height: 40,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             _PaginationBar(
//               currentPage: currentPage,
//               totalPages: totalPages,
//               onPageSelected: onPageSelected,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 height: 36,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: cs.surfaceContainerHighest,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: cs.outlineVariant),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<int>(
//                     value: perPage,
//                     dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//                     style: TextStyle(fontSize: 13, color: cs.onSurface),
//                     items: options.map((n) => DropdownMenuItem(value: n, child: Text('$n'))).toList(),
//                     onChanged: (v) {
//                       if (v != null) onPerPageChanged(v);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// /* ------------------------ models ------------------------ */

// class Site {
//   final String project;
//   final String subProject;
//   final String status;
//   final String siteName;
//   final String siteId;
//   final String address;
//   final String pincode;
//   final String poc;
//   final String country;
//   final String state;
//   final String district;
//   final String city;
//   final String completionDate;
//   final String remarks;

//   Site({
//     required this.project,
//     required this.subProject,
//     required this.status,
//     required this.siteName,
//     required this.siteId,
//     required this.address,
//     required this.pincode,
//     required this.poc,
//     required this.country,
//     required this.state,
//     required this.district,
//     required this.city,
//     required this.completionDate,
//     required this.remarks,
//   });

//   Site copyWith({
//     String? project,
//     String? subProject,
//     String? status,
//     String? siteName,
//     String? siteId,
//     String? address,
//     String? pincode,
//     String? poc,
//     String? country,
//     String? state,
//     String? district,
//     String? city,
//     String? completionDate,
//     String? remarks,
//   }) {
//     return Site(
//       project: project ?? this.project,
//       subProject: subProject ?? this.subProject,
//       status: status ?? this.status,
//       siteName: siteName ?? this.siteName,
//       siteId: siteId ?? this.siteId,
//       address: address ?? this.address,
//       pincode: pincode ?? this.pincode,
//       poc: poc ?? this.poc,
//       country: country ?? this.country,
//       state: state ?? this.state,
//       district: district ?? this.district,
//       city: city ?? this.city,
//       completionDate: completionDate ?? this.completionDate,
//       remarks: remarks ?? this.remarks,
//     );
//   }
// }

// lib/ui/screens/sites/all_sites_screen.dart
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// import 'package:pmgt/core/api_client.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';

// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';

// // Update modal
// import '../modals/update_site_modal.dart';

// class AllSitesScreen extends StatefulWidget {
//   const AllSitesScreen({super.key});

//   @override
//   State<AllSitesScreen> createState() => _AllSitesScreenState();
// }

// /* ------------------------ DTOs ------------------------ */

// class _ProjectOption {
//   final String id;
//   final String name;
//   _ProjectOption({required this.id, required this.name});
// }

// class _Site {
//   final String projectId;
//   final String project;
//   final String subProject; // may be ''
//   final String status; // Completed | In progress | Pending | Hold | Abortive | Scheduled (etc.)
//   final String siteName;
//   final String siteId;
//   final String address;
//   final String pincode;
//   final String poc;
//   final String country;
//   final String state;
//   final String district;
//   final String city;
//   final String? completionDate; // yyyy-mm-dd or null
//   final String remarks;

//   // precomputed lower-case searchable string
//   final String _search;

//   _Site({
//     required this.projectId,
//     required this.project,
//     required this.subProject,
//     required this.status,
//     required this.siteName,
//     required this.siteId,
//     required this.address,
//     required this.pincode,
//     required this.poc,
//     required this.country,
//     required this.state,
//     required this.district,
//     required this.city,
//     required this.completionDate,
//     required this.remarks,
//     required String searchJoin,
//   }) : _search = searchJoin.toLowerCase();

//   _Site copyWith({
//     String? projectId,
//     String? project,
//     String? subProject,
//     String? status,
//     String? siteName,
//     String? siteId,
//     String? address,
//     String? pincode,
//     String? poc,
//     String? country,
//     String? state,
//     String? district,
//     String? city,
//     String? completionDate,
//     String? remarks,
//   }) {
//     final next = _Site(
//       projectId: projectId ?? this.projectId,
//       project: project ?? this.project,
//       subProject: subProject ?? this.subProject,
//       status: status ?? this.status,
//       siteName: siteName ?? this.siteName,
//       siteId: siteId ?? this.siteId,
//       address: address ?? this.address,
//       pincode: pincode ?? this.pincode,
//       poc: poc ?? this.poc,
//       country: country ?? this.country,
//       state: state ?? this.state,
//       district: district ?? this.district,
//       city: city ?? this.city,
//       completionDate: completionDate ?? this.completionDate,
//       remarks: remarks ?? this.remarks,
//       searchJoin: [
//         project ?? this.project,
//         subProject ?? this.subProject,
//         siteName ?? this.siteName,
//         siteId ?? this.siteId,
//         address ?? this.address,
//         pincode ?? this.pincode,
//         poc ?? this.poc,
//         country ?? this.country,
//         state ?? this.state,
//         district ?? this.district,
//         city ?? this.city,
//         status ?? this.status,
//         (completionDate ?? this.completionDate) ?? '',
//         remarks ?? this.remarks,
//       ].join('|'),
//     );
//     return next;
//   }
// }

// /* ------------------------ Screen ------------------------ */

// class _AllSitesScreenState extends State<AllSitesScreen> {
//   // navigation tab index from your app
//   final int _selectedTab = 0;

//   // API-backed state
//   final List<_ProjectOption> _projects = [];
//   bool _loadingProjects = false;

//   final List<_Site> _sites = [];
//   bool _loadingSites = false;

//   // Filters
//   String _selectedProjectName = 'All'; // stores project_name like web
//   String _selectedSubProject = 'All';

//   // derived: project-name list for dropdown
//   List<String> get _projectNames => ['All', ..._projects.map((p) => p.name)];

//   // Search (debounced)
//   final _searchCtrl = TextEditingController();
//   String _searchRaw = '';
//   String _search = '';
//   Timer? _debounce;

//   // Pagination (client-side)
//   int _currentPage = 1;
//   int _perPage = 30;
//   final List<int> _perPageOptions = const [15, 30, 50];

//   // Status options for modal
//   static const List<String> _statusOptions = [
//     'Completed',
//     'In progress',
//     'Pending',
//     'Hold',
//     'Scheduled',
//     'Abortive',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _searchCtrl.addListener(() {
//       _searchRaw = _searchCtrl.text;
//       _debounce?.cancel();
//       _debounce = Timer(const Duration(milliseconds: 120), () {
//         if (!mounted) return;
//         setState(() {
//           _search = _searchRaw.trim().toLowerCase();
//           _currentPage = 1;
//         });
//       });
//     });
//     _loadProjects();
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _searchCtrl.dispose();
//     super.dispose();
//   }

//   // ───────────────── API ─────────────────

//   Future<void> _loadProjects() async {
//     setState(() => _loadingProjects = true);
//     try {
//       final api = context.read<ApiClient>();
//       final res = await api.get('/api/projects');
//       final list = (jsonDecode(res.body) as List?) ?? [];
//       _projects
//         ..clear()
//         ..addAll(
//           list.map((e) => _ProjectOption(
//                 id: (e['id'] ?? '').toString(),
//                 name: (e['project_name'] ?? '').toString(),
//               )),
//         );
//       setState(() {});
//       // initial sites load
//       await _loadSites();
//     } catch (e) {
//       _toast('Failed to load projects', false);
//     } finally {
//       if (mounted) setState(() => _loadingProjects = false);
//     }
//   }

//   Future<List<dynamic>> _fetchSitesFor(String projectId) async {
//     final api = context.read<ApiClient>();
//     final res = await api.get('/api/project-sites/$projectId');
//     final list = (jsonDecode(res.body) as List?) ?? [];
//     return list;
//   }

//   Future<void> _loadSites() async {
//     if (_projects.isEmpty) {
//       setState(() {
//         _sites.clear();
//       });
//       return;
//     }
//     setState(() {
//       _loadingSites = true;
//       _currentPage = 1;
//     });
//     try {
//       List<dynamic> raw = [];
//       if (_selectedProjectName == 'All') {
//         final results = await Future.wait(_projects.map((p) => _fetchSitesFor(p.id)));
//         raw = results.expand((x) => x).toList();
//       } else {
//         final proj = _projects.firstWhere(
//           (p) => p.name == _selectedProjectName,
//           orElse: () => _projects.first,
//         );
//         raw = await _fetchSitesFor(proj.id);
//       }

//       final data = <_Site>[];
//       for (final x in raw) {
//         String lower(dynamic v) => (v ?? '').toString().toLowerCase();
//         final site = _Site(
//           projectId: (x['project_id'] ?? '').toString(),
//           project: (x['project_name'] ?? '').toString(),
//           subProject: (x['sub_project_name'] ?? '').toString(),
//           siteName: (x['site_name'] ?? '').toString(),
//           siteId: (x['site_id'] ?? '').toString(),
//           address: (x['address'] ?? '').toString(),
//           pincode: (x['pincode'] ?? '').toString(),
//           poc: (x['poc'] ?? '').toString(),
//           country: (x['country'] ?? '').toString(),
//           state: (x['state'] ?? '').toString(),
//           district: (x['district'] ?? '').toString(),
//           city: (x['city'] ?? '').toString(),
//           status: (x['status'] ?? '').toString(),
//           completionDate: (x['completion_date'] as String?) ?? null,
//           remarks: (x['remarks'] ?? '').toString(),
//           searchJoin: [
//             x['project_name'],
//             x['sub_project_name'],
//             x['site_name'],
//             x['site_id'],
//             x['address'],
//             x['pincode'],
//             x['poc'],
//             x['country'],
//             x['state'],
//             x['district'],
//             x['city'],
//             x['status'],
//             x['remarks'],
//             x['completion_date'],
//           ].map(lower).join('|'),
//         );
//         data.add(site);
//       }

//       setState(() {
//         _sites
//           ..clear()
//           ..addAll(data);
//         // when project changes, reset sub-project filter to 'All'
//         _selectedSubProject = 'All';
//       });
//     } catch (e) {
//       _toast('Failed to load sites', false);
//       setState(() => _sites.clear());
//     } finally {
//       if (mounted) setState(() => _loadingSites = false);
//     }
//   }

//   // Export to CSV (saves to temp path and shows it)
//   Future<void> _exportCsv() async {
//     try {
//       final api = context.read<ApiClient>();
//       // Use raw http to preserve bytes if your ApiClient modifies headers—adjust if needed.
//       final String baseUrl = (api as dynamic).baseUrl as String;
//       final String? token = (api as dynamic).token as String?;
//       final uri = Uri.parse('$baseUrl/api/project-sites/export');

//       final req = http.Request('GET', uri);
//       if ((token ?? '').isNotEmpty) {
//         req.headers['Authorization'] = 'Bearer $token';
//       }
//       final streamed = await req.send();
//       final bytes = await streamed.stream.toBytes();

//       if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
//         throw Exception('Export failed (${streamed.statusCode})');
//       }

//       final file = File('${Directory.systemTemp.path}/project_sites.csv');
//       await file.writeAsBytes(bytes, flush: true);

//       _toast('Sites exported → ${file.path}');
//     } catch (e) {
//       _toast('Export failed', false);
//     }
//   }

//   // Derived: filtered rows (by project/sub/search)
//   List<_Site> get _filtered {
//     final term = _search;
//     return _sites.where((r) {
//       final okProj = _selectedProjectName == 'All' || r.project == _selectedProjectName;
//       final okChild = _selectedSubProject == 'All' || r.subProject == _selectedSubProject;
//       final okSearch = term.isEmpty || r._search.contains(term);
//       return okProj && okChild && okSearch;
//     }).toList();
//   }

//   // Derived: sub-project options based on current project filter
//   List<String> get _childOptions {
//     final base = _selectedProjectName == 'All'
//         ? _sites
//         : _sites.where((r) => r.project == _selectedProjectName);
//     final unique = <String>{...base.map((r) => r.subProject).where((s) => s.isNotEmpty)};
//     final list = ['All', ...unique.toList()..sort()];
//     // keep selection valid
//     if (!list.contains(_selectedSubProject)) _selectedSubProject = 'All';
//     return list;
//   }

//   int get _totalPages {
//     final len = _filtered.length;
//     if (len == 0) return 1;
//     return (len + _perPage - 1) ~/ _perPage;
//   }

//   List<_Site> get _paged {
//     final items = _filtered;
//     if (items.isEmpty) return const [];
//     final start = (_currentPage - 1) * _perPage;
//     final end = min(start + _perPage, items.length);
//     if (start >= items.length) return const [];
//     return items.sublist(start, end);
//   }

//   // ───────────────── Helpers ─────────────────
//   void _goToPage(int p) => setState(() {
//         _currentPage = p.clamp(1, _totalPages);
//       });

//   void _toast(String msg, [bool success = true]) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(msg),
//         backgroundColor: success ? Colors.green.shade600 : Colors.red.shade700,
//       ),
//     );
//     // ignore: avoid_print
//     print(msg);
//   }

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
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   String _dmy(String? ymd) {
//     if (ymd == null || ymd.isEmpty) return '—';
//     final parts = ymd.split('-');
//     if (parts.length != 3) return ymd;
//     final y = parts[0], m = parts[1], d = parts[2];
//     return '$d-$m-$y';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'All Sites',
//       centerTitle: true,
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
//           icon: ClipOval(
//             child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           ),
//         ),
//         const SizedBox(width: 8),
//       ],
//       currentIndex: _selectedTab,
//       onTabChanged: (i) => _handleTabChange(i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Stack(
//         children: [
//           Padding(
//             padding: responsivePadding(context).copyWith(top: 6, bottom: 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Search + Export in same row
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Expanded(child: _SearchField(controller: _searchCtrl)),
//                     const SizedBox(width: 8),
//                     SizedBox(
//                       height: 34,
//                       child: ElevatedButton.icon(
//                         onPressed: _exportCsv,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                           padding: const EdgeInsets.symmetric(horizontal: 14),
//                         ),
//                         icon: const Icon(Icons.download),
//                         label: const Text('Export',
//                             style: TextStyle(fontWeight: FontWeight.w800)),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Divider(color: cs.outlineVariant),
//                 const SizedBox(height: 8),

//                 // Labeled Project + Sub Project dropdowns
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _LabeledDropdown<String>(
//                         label: 'Project',
//                         value: _selectedProjectName,
//                         items: _projectNames,
//                         enabled: !_loadingProjects,
//                         onChanged: (v) async {
//                           setState(() {
//                             _selectedProjectName = v ?? 'All';
//                             _selectedSubProject = 'All';
//                             _currentPage = 1;
//                           });
//                           await _loadSites();
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: _LabeledDropdown<String>(
//                         label: 'Sub Project',
//                         value: _selectedSubProject,
//                         items: _childOptions,
//                         onChanged: (v) {
//                           setState(() {
//                             _selectedSubProject = v ?? 'All';
//                             _currentPage = 1;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 // List + pagination footer
//                 Expanded(
//                   child: _paged.isEmpty
//                       ? Center(
//                           child: Text(
//                             _loadingSites ? '' : 'No records found.',
//                             style: TextStyle(color: cs.onSurfaceVariant),
//                           ),
//                         )
//                       : ListView.separated(
//                           padding: const EdgeInsets.only(bottom: 12 + 58),
//                           separatorBuilder: (_, __) => const SizedBox(height: 12),
//                           itemCount: _paged.length + 1,
//                           itemBuilder: (context, i) {
//                             if (i < _paged.length) {
//                               final s = _paged[i];
//                               final globalIndex = _sites.indexOf(s);
//                               return _SiteCard(
//                                 site: s,
//                                 onUpdate: (updated) async {
//                                   // call API then update local list
//                                   try {

//                                     final api = context.read<ApiClient>();
// final String baseUrl = (api as dynamic).baseUrl as String;
// final String? token   = (api as dynamic).token as String?;
// final uri = Uri.parse('$baseUrl/api/project-sites/${s.projectId}/${s.siteId}');

// final resp = await http.put(
//   uri,
//   headers: {
//     if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
//     'Content-Type': 'application/json',
//   },
//   body: jsonEncode({
//     'site_name':       updated.siteName,
//     'address':         updated.address,
//     'pincode':         updated.pincode,
//     'poc':             updated.poc,
//     'country':         updated.country,
//     'state':           updated.state,
//     'district':        updated.district,
//     'city':            updated.city,
//     'remarks':         updated.remarks.isEmpty ? null : updated.remarks,
//     'status':          updated.status,
//     'completion_date': updated.completionDate == null || updated.completionDate!.isEmpty
//         ? null
//         : updated.completionDate, // yyyy-mm-dd
//   }),
// );

// if (resp.statusCode < 200 || resp.statusCode >= 300) {
//   final msg = (jsonDecode(resp.body) as Map?)?['error']?.toString() ?? 'Update failed';
//   throw Exception(msg);
// }

// setState(() => _sites[globalIndex] = updated);
// _toast('Site updated');

//                                     setState(() => _sites[globalIndex] = updated);
//                                     _toast('Site updated');
//                                   } catch (e) {
//                                     _toast('Update failed', false);
//                                   }
//                                 },
//                                 dmy: _dmy,
//                                 subProjectOptions: _childOptions.where((e) => e != 'All').toList(),
//                                 statusOptions: _statusOptions,
//                               );
//                             }
//                             // inline pagination row
//                             return _PaginationInline(
//                               currentPage: _currentPage,
//                               totalPages: _totalPages,
//                               onPageSelected: _goToPage,
//                               onPrev: () => _goToPage(_currentPage - 1),
//                               onNext: () => _goToPage(_currentPage + 1),
//                               perPage: _perPage,
//                               options: _perPageOptions,
//                               onPerPageChanged: (v) {
//                                 setState(() {
//                                   _perPage = v;
//                                   _currentPage = 1;
//                                 });
//                               },
//                             );
//                           },
//                         ),
//                 ),
//               ],
//             ),
//           ),

//           // loading overlay (sites)
//           if (_loadingSites)
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

// /* ------------------------ Widgets / helpers ------------------------ */

// class _SiteCard extends StatelessWidget {
//   final _Site site;
//   final ValueChanged<_Site> onUpdate;
//   final String Function(String?) dmy;
//   final List<String> subProjectOptions;
//   final List<String> statusOptions;

//   const _SiteCard({
//     required this.site,
//     required this.onUpdate,
//     required this.dmy,
//     required this.subProjectOptions,
//     required this.statusOptions,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;
//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     return Container(
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 site.project,
//                 style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 14),
//               ),
//               Text(
//                 'Status : ${site.status.isEmpty ? '—' : site.status}',
//                 style: TextStyle(color: valueColor, fontWeight: FontWeight.w700, fontSize: 14),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text('Sub Project: ${site.subProject.isEmpty ? '—' : site.subProject}',
//               style: TextStyle(color: labelColor, fontSize: 11)),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           // two columns
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Site Name', site.siteName, labelColor, valueColor),
//                     _kv('Site ID', site.siteId, labelColor, valueColor),
//                     _kv('Address', site.address, labelColor, valueColor),
//                     _kv('Pincode', site.pincode, labelColor, valueColor),
//                     _kv('Completion Date', dmy(site.completionDate), labelColor, valueColor),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('POC', site.poc, labelColor, valueColor),
//                     _kv('Country', site.country, labelColor, valueColor),
//                     _kv('State', site.state, labelColor, valueColor),
//                     _kv('District', site.district, labelColor, valueColor),
//                     _kv('City', site.city, labelColor, valueColor),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),
//           _kv('Remarks', site.remarks.isEmpty ? '—' : site.remarks, labelColor, valueColor),

//           const SizedBox(height: 16),
//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppTheme.accentColor,
//                 side: const BorderSide(color: AppTheme.accentColor),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               ),
//               onPressed: () async {
//                 final updated = await UpdateSiteModal.show(
//                   context,

//                   site: siteToModal(site, dmy),
//                   subProjects: subProjectOptions.isEmpty ? const ['—'] : subProjectOptions,
//                   statusOptions: statusOptions,
//                 );
//                 if (updated != null) {
//                   // Map modal result back to _Site for PUT and UI
//                   onUpdate(modalToSite(updated, site));
//                 }
//               },
//               child: const Text('Update', style: TextStyle(color: Colors.black, fontSize: 12)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // adapters for your UpdateSiteModal (expects its own model)
//   static dynamic siteToModal(_Site s, String Function(String?) dmy) {
//     // The modal in your app previously took a `Site` class; if it differs,
//     // adjust these field names to match.
//     return Site(
//       project: s.project,
//       subProject: s.subProject.isEmpty ? '—' : s.subProject,
//       status: s.status.isEmpty ? 'Pending' : s.status,
//       siteName: s.siteName,
//       siteId: s.siteId,
//       address: s.address,
//       pincode: s.pincode,
//       poc: s.poc,
//       country: s.country,
//       state: s.state,
//       district: s.district,
//       city: s.city,
//       completionDate: dmy(s.completionDate),
//       remarks: s.remarks.isEmpty ? '—' : s.remarks,
//     );
//   }

//   static _Site modalToSite(dynamic modalSite, _Site base) {
//     // reverse mapping from modal values back to API shape
//     // (assumes modalSite has same getters as original Site class you shared)
//     String undmy(String v) {
//       // converts dd/mm/yyyy or dd-mm-yyyy to yyyy-mm-dd
//       if (v.trim().isEmpty || v == '—') return '';
//       final s = v.contains('/') ? v.split('/') : v.split('-');
//       if (s.length != 3) return v;
//       final dd = s[0].padLeft(2, '0');
//       final mm = s[1].padLeft(2, '0');
//       final yy = s[2];
//       return '$yy-$mm-$dd';
//     }

//     return base.copyWith(
//       subProject: (modalSite.subProject == '—') ? '' : modalSite.subProject,
//       status: modalSite.status,
//       siteName: modalSite.siteName,
//       siteId: modalSite.siteId,
//       address: modalSite.address,
//       pincode: modalSite.pincode,
//       poc: modalSite.poc,
//       country: modalSite.country,
//       state: modalSite.state,
//       district: modalSite.district,
//       city: modalSite.city,
//       completionDate: (() {
//         final x = undmy(modalSite.completionDate);
//         return x.isEmpty ? null : x;
//       })(),
//       remarks: (modalSite.remarks == '—') ? '' : modalSite.remarks,
//     );
//   }

//   Widget _kv(String k, String v, Color kColor, Color vColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$k: ',
//           style: TextStyle(color: kColor, fontSize: 11),
//           children: [TextSpan(text: v.isEmpty ? '—' : v, style: TextStyle(color: vColor, fontSize: 11))],
//         ),
//       ),
//     );
//   }
// }

// class _SearchField extends StatelessWidget {
//   final TextEditingController controller;
//   const _SearchField({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return SizedBox(
//       height: 34,
//       child: TextField(
//         controller: controller,
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

// // Labeled dropdown wrapper
// class _LabeledDropdown<T> extends StatelessWidget {
//   final String label;
//   final T value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;
//   final bool enabled;
//   const _LabeledDropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.enabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600),
//         ),
//         const SizedBox(height: 6),
//         Container(
//           height: 34,
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           decoration: BoxDecoration(
//             color: enabled ? cs.surfaceContainerHighest : cs.surfaceContainerHigh,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<T>(
//               value: value,
//               isExpanded: true,
//               dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//               iconEnabledColor: cs.onSurfaceVariant,
//               style: TextStyle(color: cs.onSurface, fontSize: 12),
//               items: items
//                   .map((e) => DropdownMenuItem<T>(
//                         value: e,
//                         child: Text('$e'),
//                       ))
//                   .toList(),
//               onChanged: enabled ? onChanged : null,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class Site {
//   final String project;
//   final String subProject;
//   final String status;
//   final String siteName;
//   final String siteId;
//   final String address;
//   final String pincode;
//   final String poc;
//   final String country;
//   final String state;
//   final String district;
//   final String city;
//   final String completionDate; // display string (dd/mm/yyyy or '—')
//   final String remarks;

//   Site({
//     required this.project,
//     required this.subProject,
//     required this.status,
//     required this.siteName,
//     required this.siteId,
//     required this.address,
//     required this.pincode,
//     required this.poc,
//     required this.country,
//     required this.state,
//     required this.district,
//     required this.city,
//     required this.completionDate,
//     required this.remarks,
//   });

//   Site copyWith({
//     String? project,
//     String? subProject,
//     String? status,
//     String? siteName,
//     String? siteId,
//     String? address,
//     String? pincode,
//     String? poc,
//     String? country,
//     String? state,
//     String? district,
//     String? city,
//     String? completionDate,
//     String? remarks,
//   }) {
//     return Site(
//       project: project ?? this.project,
//       subProject: subProject ?? this.subProject,
//       status: status ?? this.status,
//       siteName: siteName ?? this.siteName,
//       siteId: siteId ?? this.siteId,
//       address: address ?? this.address,
//       pincode: pincode ?? this.pincode,
//       poc: poc ?? this.poc,
//       country: country ?? this.country,
//       state: state ?? this.state,
//       district: district ?? this.district,
//       city: city ?? this.city,
//       completionDate: completionDate ?? this.completionDate,
//       remarks: remarks ?? this.remarks,
//     );
//   }
// }

// /* -------- Pagination (same style) -------- */

// class _PaginationBar extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;
//   static const int _windowSize = 5;

//   const _PaginationBar({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     final int windowStart = ((currentPage - 1) ~/ _windowSize) * _windowSize + 1;
//     final int windowEnd = min(windowStart + _windowSize - 1, totalPages);

//     Widget pill({
//       required Widget child,
//       required bool selected,
//       VoidCallback? onTap,
//       double width = 40,
//     }) {
//       final bg = selected ? Colors.black : cs.surfaceContainerHighest;
//       final fg = selected ? Colors.white : cs.onSurface;

//       final content = Container(
//         width: width,
//         height: 36,
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: DefaultTextStyle(
//           style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 13),
//           child: IconTheme.merge(
//             data: IconThemeData(color: fg, size: 18),
//             child: child,
//           ),
//         ),
//       );

//       return onTap == null
//           ? Opacity(opacity: 0.5, child: content)
//           : InkWell(onTap: onTap, borderRadius: BorderRadius.circular(10), child: content);
//     }

//     final hasPrevWindow = windowStart > 1;
//     final hasNextWindow = windowEnd < totalPages;

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         pill(
//           child: const Icon(Icons.chevron_left),
//           selected: false,
//           onTap: hasPrevWindow ? () => onPageSelected(windowStart - 1) : null,
//         ),
//         for (int p = windowStart; p <= windowEnd; p++)
//           pill(
//             child: Text('$p'),
//             selected: p == currentPage,
//             onTap: () => onPageSelected(p),
//           ),
//         pill(
//           child: const Icon(Icons.chevron_right),
//           selected: false,
//           onTap: hasNextWindow ? () => onPageSelected(windowEnd + 1) : null,
//         ),
//       ],
//     );
//   }
// }

// class _PaginationInline extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;

//   final VoidCallback onPrev;
//   final VoidCallback onNext;

//   final int perPage;
//   final List<int> options;
//   final ValueChanged<int> onPerPageChanged;

//   const _PaginationInline({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageSelected,
//     required this.onPrev,
//     required this.onNext,
//     required this.perPage,
//     required this.options,
//     required this.onPerPageChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: SizedBox(
//         height: 40,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             _PaginationBar(
//               currentPage: currentPage,
//               totalPages: totalPages,
//               onPageSelected: onPageSelected,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 height: 36,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: cs.surfaceContainerHighest,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: cs.outlineVariant),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<int>(
//                     value: perPage,
//                     dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//                     style: TextStyle(fontSize: 13, color: cs.onSurface),
//                     items: options.map((n) => DropdownMenuItem(value: n, child: Text('$n'))).toList(),
//                     onChanged: (v) {
//                       if (v != null) onPerPageChanged(v);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// p final //
// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;

// import 'package:pmgt/core/api_client.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';

// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';

// // Update modal
// import '../modals/update_site_modal.dart';

// class AllSitesScreen extends StatefulWidget {
//   const AllSitesScreen({super.key});

//   @override
//   State<AllSitesScreen> createState() => _AllSitesScreenState();
// }

// /* ------------------------ DTOs ------------------------ */

// class _ProjectOption {
//   final String id;
//   final String name;
//   _ProjectOption({required this.id, required this.name});
// }

// class _Site {
//   final String projectId;
//   final String project;
//   final String subProject; // may be ''
//   final String
//   status; // Completed | In progress | Pending | Hold | Abortive | Scheduled (etc.)
//   final String siteName;
//   final String siteId;
//   final String address;
//   final String pincode;
//   final String poc;
//   final String country;
//   final String state;
//   final String district;
//   final String city;
//   final String? completionDate; // yyyy-mm-dd or null
//   final String remarks;

//   // precomputed lower-case searchable string
//   final String _search;

//   _Site({
//     required this.projectId,
//     required this.project,
//     required this.subProject,
//     required this.status,
//     required this.siteName,
//     required this.siteId,
//     required this.address,
//     required this.pincode,
//     required this.poc,
//     required this.country,
//     required this.state,
//     required this.district,
//     required this.city,
//     required this.completionDate,
//     required this.remarks,
//     required String searchJoin,
//   }) : _search = searchJoin.toLowerCase();

//   _Site copyWith({
//     String? projectId,
//     String? project,
//     String? subProject,
//     String? status,
//     String? siteName,
//     String? siteId,
//     String? address,
//     String? pincode,
//     String? poc,
//     String? country,
//     String? state,
//     String? district,
//     String? city,
//     String? completionDate,
//     String? remarks,
//   }) {
//     final next = _Site(
//       projectId: projectId ?? this.projectId,
//       project: project ?? this.project,
//       subProject: subProject ?? this.subProject,
//       status: status ?? this.status,
//       siteName: siteName ?? this.siteName,
//       siteId: siteId ?? this.siteId,
//       address: address ?? this.address,
//       pincode: pincode ?? this.pincode,
//       poc: poc ?? this.poc,
//       country: country ?? this.country,
//       state: state ?? this.state,
//       district: district ?? this.district,
//       city: city ?? this.city,
//       completionDate: completionDate ?? this.completionDate,
//       remarks: remarks ?? this.remarks,
//       searchJoin: [
//         project ?? this.project,
//         subProject ?? this.subProject,
//         siteName ?? this.siteName,
//         siteId ?? this.siteId,
//         address ?? this.address,
//         pincode ?? this.pincode,
//         poc ?? this.poc,
//         country ?? this.country,
//         state ?? this.state,
//         district ?? this.district,
//         city ?? this.city,
//         status ?? this.status,
//         (completionDate ?? this.completionDate) ?? '',
//         remarks ?? this.remarks,
//       ].join('|'),
//     );
//     return next;
//   }
// }

// /* ------------------------ Screen ------------------------ */

// class _AllSitesScreenState extends State<AllSitesScreen> {
//   // navigation tab index from your app
//   final int _selectedTab = 0;

//   // API-backed state
//   final List<_ProjectOption> _projects = [];
//   bool _loadingProjects = false;

//   final List<_Site> _sites = [];
//   bool _loadingSites = false;

//   // Filters
//   String _selectedProjectName = 'All'; // stores project_name like web
//   String _selectedSubProject = 'All';

//   // derived: project-name list for dropdown
//   List<String> get _projectNames => ['All', ..._projects.map((p) => p.name)];

//   // Search (debounced)
//   final _searchCtrl = TextEditingController();
//   String _searchRaw = '';
//   String _search = '';
//   Timer? _debounce;

//   // Pagination (client-side)
//   int _currentPage = 1;
//   int _perPage = 30;
//   final List<int> _perPageOptions = const [15, 30, 50];

//   // Status options for modal
//   static const List<String> _statusOptions = [
//     'Completed',
//     'In progress',
//     'Pending',
//     'Hold',
//     'Scheduled',
//     'Abortive',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _searchCtrl.addListener(() {
//       _searchRaw = _searchCtrl.text;
//       _debounce?.cancel();
//       _debounce = Timer(const Duration(milliseconds: 120), () {
//         if (!mounted) return;
//         setState(() {
//           _search = _searchRaw.trim().toLowerCase();
//           _currentPage = 1;
//         });
//       });
//     });
//     _loadProjects();
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     _searchCtrl.dispose();
//     super.dispose();
//   }

//   // ───────────────── API ─────────────────

//   Future<void> _loadProjects() async {
//     setState(() => _loadingProjects = true);
//     try {
//       final api = context.read<ApiClient>();
//       final res = await api.get('/api/projects');
//       final list = (jsonDecode(res.body) as List?) ?? [];
//       _projects
//         ..clear()
//         ..addAll(
//           list.map(
//             (e) => _ProjectOption(
//               id: (e['id'] ?? '').toString(),
//               name: (e['project_name'] ?? '').toString(),
//             ),
//           ),
//         );
//       setState(() {});
//       // initial sites load
//       await _loadSites();
//     } catch (e) {
//       _toast('Failed to load projects', false);
//     } finally {
//       if (mounted) setState(() => _loadingProjects = false);
//     }
//   }

//   Future<List<dynamic>> _fetchSitesFor(String projectId) async {
//     final api = context.read<ApiClient>();
//     final res = await api.get('/api/project-sites/$projectId');
//     final list = (jsonDecode(res.body) as List?) ?? [];
//     return list;
//   }

//   Future<void> _loadSites() async {
//     if (_projects.isEmpty) {
//       setState(() {
//         _sites.clear();
//       });
//       return;
//     }
//     setState(() {
//       _loadingSites = true;
//       _currentPage = 1;
//     });
//     try {
//       List<dynamic> raw = [];
//       if (_selectedProjectName == 'All') {
//         final results = await Future.wait(
//           _projects.map((p) => _fetchSitesFor(p.id)),
//         );
//         raw = results.expand((x) => x).toList();
//       } else {
//         final proj = _projects.firstWhere(
//           (p) => p.name == _selectedProjectName,
//           orElse: () => _projects.first,
//         );
//         raw = await _fetchSitesFor(proj.id);
//       }

//       final data = <_Site>[];
//       for (final x in raw) {
//         String lower(dynamic v) => (v ?? '').toString().toLowerCase();
//         final site = _Site(
//           projectId: (x['project_id'] ?? '').toString(),
//           project: (x['project_name'] ?? '').toString(),
//           subProject: (x['sub_project_name'] ?? '').toString(),
//           siteName: (x['site_name'] ?? '').toString(),
//           siteId: (x['site_id'] ?? '').toString(),
//           address: (x['address'] ?? '').toString(),
//           pincode: (x['pincode'] ?? '').toString(),
//           poc: (x['poc'] ?? '').toString(),
//           country: (x['country'] ?? '').toString(),
//           state: (x['state'] ?? '').toString(),
//           district: (x['district'] ?? '').toString(),
//           city: (x['city'] ?? '').toString(),
//           status: (x['status'] ?? '').toString(),
//           completionDate: (x['completion_date'] as String?) ?? null,
//           remarks: (x['remarks'] ?? '').toString(),
//           searchJoin: [
//             x['project_name'],
//             x['sub_project_name'],
//             x['site_name'],
//             x['site_id'],
//             x['address'],
//             x['pincode'],
//             x['poc'],
//             x['country'],
//             x['state'],
//             x['district'],
//             x['city'],
//             x['status'],
//             x['remarks'],
//             x['completion_date'],
//           ].map(lower).join('|'),
//         );
//         data.add(site);
//       }

//       setState(() {
//         _sites
//           ..clear()
//           ..addAll(data);
//         // when project changes, reset sub-project filter to 'All'
//         _selectedSubProject = 'All';
//       });
//     } catch (e) {
//       _toast('Failed to load sites', false);
//       setState(() => _sites.clear());
//     } finally {
//       if (mounted) setState(() => _loadingSites = false);
//     }
//   }

//   // Export to CSV (saves to temp path and shows it)
//   Future<void> _exportCsv() async {
//     try {
//       final api = context.read<ApiClient>();
//       final String baseUrl = (api as dynamic).baseUrl as String;
//       final String? token = (api as dynamic).token as String?;
//       final uri = Uri.parse('$baseUrl/api/project-sites/export');

//       final req = http.Request('GET', uri);
//       if ((token ?? '').isNotEmpty) {
//         req.headers['Authorization'] = 'Bearer $token';
//       }
//       final streamed = await req.send();
//       final bytes = await streamed.stream.toBytes();

//       if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
//         throw Exception('Export failed (${streamed.statusCode})');
//       }

//       final file = File('${Directory.systemTemp.path}/project_sites.csv');
//       await file.writeAsBytes(bytes, flush: true);

//       _toast('Sites exported → ${file.path}');
//     } catch (e) {
//       _toast('Export failed', false);
//     }
//   }

//   // Derived: filtered rows (by project/sub/search)
//   List<_Site> get _filtered {
//     final term = _search;
//     return _sites.where((r) {
//       final okProj =
//           _selectedProjectName == 'All' || r.project == _selectedProjectName;
//       final okChild =
//           _selectedSubProject == 'All' || r.subProject == _selectedSubProject;
//       final okSearch = term.isEmpty || r._search.contains(term);
//       return okProj && okChild && okSearch;
//     }).toList();
//   }

//   // Derived: sub-project options based on current project filter
//   List<String> get _childOptions {
//     final base =
//         _selectedProjectName == 'All'
//             ? _sites
//             : _sites.where((r) => r.project == _selectedProjectName);
//     final unique = <String>{
//       ...base.map((r) => r.subProject).where((s) => s.isNotEmpty),
//     };
//     final list = ['All', ...unique.toList()..sort()];
//     if (!list.contains(_selectedSubProject)) _selectedSubProject = 'All';
//     return list;
//   }

//   int get _totalPages {
//     final len = _filtered.length;
//     if (len == 0) return 1;
//     return (len + _perPage - 1) ~/ _perPage;
//   }

//   List<_Site> get _paged {
//     final items = _filtered;
//     if (items.isEmpty) return const [];
//     final start = (_currentPage - 1) * _perPage;
//     final end = min(start + _perPage, items.length);
//     if (start >= items.length) return const [];
//     return items.sublist(start, end);
//   }

//   // ───────────────── Helpers ─────────────────
//   void _goToPage(int p) => setState(() {
//     _currentPage = p.clamp(1, _totalPages);
//   });

//   void _toast(String msg, [bool success = true]) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(msg),
//         backgroundColor: success ? Colors.green.shade600 : Colors.red.shade700,
//       ),
//     );
//     print(msg);
//   }

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

//   String _dmy(String? ymd) {
//     if (ymd == null || ymd.isEmpty) return '—';
//     final parts = ymd.split('-');
//     if (parts.length != 3) return ymd;
//     final y = parts[0], m = parts[1], d = parts[2];
//     return '$d-$m-$y';
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'All Sites',
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
//       currentIndex: _selectedTab,
//       onTabChanged: (i) => _handleTabChange(i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Stack(
//         children: [
//           Padding(
//             padding: responsivePadding(context).copyWith(top: 6, bottom: 0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Search + Export
//                 const SizedBox(height: 4),
//                 Row(
//                   children: [
//                     Expanded(child: _SearchField(controller: _searchCtrl)),
//                     const SizedBox(width: 8),
//                     SizedBox(
//                       height: 34,
//                       child: ElevatedButton.icon(
//                         onPressed: _exportCsv,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppTheme.accentColor,
//                           foregroundColor: Colors.black,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           padding: const EdgeInsets.symmetric(horizontal: 14),
//                         ),
//                         icon: const Icon(Icons.download),
//                         label: const Text(
//                           'Export',
//                           style: TextStyle(fontWeight: FontWeight.w800),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Divider(color: cs.outlineVariant),
//                 const SizedBox(height: 8),

//                 // Filters
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _LabeledDropdown<String>(
//                         label: 'Project',
//                         value: _selectedProjectName,
//                         items: _projectNames,
//                         enabled: !_loadingProjects,
//                         onChanged: (v) async {
//                           setState(() {
//                             _selectedProjectName = v ?? 'All';
//                             _selectedSubProject = 'All';
//                             _currentPage = 1;
//                           });
//                           await _loadSites();
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: _LabeledDropdown<String>(
//                         label: 'Sub Project',
//                         value: _selectedSubProject,
//                         items: _childOptions,
//                         onChanged: (v) {
//                           setState(() {
//                             _selectedSubProject = v ?? 'All';
//                             _currentPage = 1;
//                           });
//                         },
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 12),

//                 // List + pagination
//                 Expanded(
//                   child:
//                       _paged.isEmpty
//                           ? Center(
//                             child: Text(
//                               _loadingSites ? '' : 'No records found.',
//                               style: TextStyle(color: cs.onSurfaceVariant),
//                             ),
//                           )
//                           : ListView.separated(
//                             padding: const EdgeInsets.only(bottom: 12 + 58),
//                             separatorBuilder:
//                                 (_, __) => const SizedBox(height: 12),
//                             itemCount: _paged.length + 1,
//                             itemBuilder: (context, i) {
//                               if (i < _paged.length) {
//                                 final s = _paged[i];
//                                 final globalIndex = _sites.indexOf(s);
//                                 return _SiteCard(
//                                   site: s,
//                                   onUpdate: (updated) async {
//                                     try {
//                                       final api = context.read<ApiClient>();
//                                       final String baseUrl =
//                                           (api as dynamic).baseUrl as String;
//                                       final String? token =
//                                           (api as dynamic).token as String?;
//                                       final uri = Uri.parse(
//                                         '$baseUrl/api/project-sites/${s.projectId}/${s.siteId}',
//                                       );

//                                       final resp = await http.put(
//                                         uri,
//                                         headers: {
//                                           if (token != null && token.isNotEmpty)
//                                             'Authorization': 'Bearer $token',
//                                           'Content-Type': 'application/json',
//                                         },
//                                         body: jsonEncode({
//                                           'site_name': updated.siteName,
//                                           'address': updated.address,
//                                           'pincode': updated.pincode,
//                                           'poc': updated.poc,
//                                           'country': updated.country,
//                                           'state': updated.state,
//                                           'district': updated.district,
//                                           'city': updated.city,
//                                           'remarks':
//                                               updated.remarks.isEmpty
//                                                   ? null
//                                                   : updated.remarks,
//                                           'status': updated.status,
//                                           'completion_date':
//                                               updated.completionDate == null ||
//                                                       updated
//                                                           .completionDate!
//                                                           .isEmpty
//                                                   ? null
//                                                   : updated.completionDate,
//                                         }),
//                                       );

//                                       if (resp.statusCode < 200 ||
//                                           resp.statusCode >= 300) {
//                                         final msg =
//                                             (jsonDecode(resp.body)
//                                                     as Map?)?['error']
//                                                 ?.toString() ??
//                                             'Update failed';
//                                         throw Exception(msg);
//                                       }

//                                       setState(
//                                         () => _sites[globalIndex] = updated,
//                                       );
//                                       _toast('Site updated');
//                                     } catch (e) {
//                                       _toast('Update failed', false);
//                                     }
//                                   },
//                                   dmy: _dmy,
//                                   subProjectOptions:
//                                       _childOptions
//                                           .where((e) => e != 'All')
//                                           .toList(),
//                                   statusOptions: _statusOptions,
//                                 );
//                               }
//                               return _PaginationInline(
//                                 currentPage: _currentPage,
//                                 totalPages: _totalPages,
//                                 onPageSelected: _goToPage,
//                                 onPrev: () => _goToPage(_currentPage - 1),
//                                 onNext: () => _goToPage(_currentPage + 1),
//                                 perPage: _perPage,
//                                 options: _perPageOptions,
//                                 onPerPageChanged: (v) {
//                                   setState(() {
//                                     _perPage = v;
//                                     _currentPage = 1;
//                                   });
//                                 },
//                               );
//                             },
//                           ),
//                 ),
//               ],
//             ),
//           ),

//           if (_loadingSites)
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

// /* ------------------------ Widgets / helpers ------------------------ */

// class _SiteCard extends StatelessWidget {
//   final _Site site;
//   final ValueChanged<_Site> onUpdate;
//   final String Function(String?) dmy;
//   final List<String> subProjectOptions;
//   final List<String> statusOptions;

//   const _SiteCard({
//     required this.site,
//     required this.onUpdate,
//     required this.dmy,
//     required this.subProjectOptions,
//     required this.statusOptions,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;
//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     return Container(
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 site.project,
//                 style: TextStyle(
//                   color: valueColor,
//                   fontWeight: FontWeight.w800,
//                   fontSize: 14,
//                 ),
//               ),
//               Text(
//                 'Status : ${site.status.isEmpty ? '—' : site.status}',
//                 style: TextStyle(
//                   color: valueColor,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 14,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 4),
//           Text(
//             'Sub Project: ${site.subProject.isEmpty ? '—' : site.subProject}',
//             style: TextStyle(color: labelColor, fontSize: 11),
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           // two columns
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('Site Name', site.siteName, labelColor, valueColor),
//                     _kv('Site ID', site.siteId, labelColor, valueColor),
//                     _kv('Address', site.address, labelColor, valueColor),
//                     _kv('Pincode', site.pincode, labelColor, valueColor),
//                     _kv(
//                       'Completion Date',
//                       dmy(site.completionDate),
//                       labelColor,
//                       valueColor,
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('POC', site.poc, labelColor, valueColor),
//                     _kv('Country', site.country, labelColor, valueColor),
//                     _kv('State', site.state, labelColor, valueColor),
//                     _kv('District', site.district, labelColor, valueColor),
//                     _kv('City', site.city, labelColor, valueColor),
//                   ],
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 8),
//           _kv(
//             'Remarks',
//             site.remarks.isEmpty ? '—' : site.remarks,
//             labelColor,
//             valueColor,
//           ),

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
//               onPressed: () async {
//                 final updated = await UpdateSiteModal.show(
//                   context,
//                   site: siteToModal(site, dmy),
//                   subProjects:
//                       subProjectOptions.isEmpty
//                           ? const ['—']
//                           : subProjectOptions,
//                   statusOptions: statusOptions,
//                 );
//                 if (updated != null) {
//                   onUpdate(modalToSite(updated, site));
//                 }
//               },
//               child: const Text(
//                 'Update',
//                 style: TextStyle(color: Colors.black, fontSize: 12),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // adapters for UpdateSiteModal
//   static dynamic siteToModal(_Site s, String Function(String?) dmy) {
//     return Site(
//       project: s.project,
//       subProject: s.subProject.isEmpty ? '—' : s.subProject,
//       status: s.status.isEmpty ? 'Pending' : s.status,
//       siteName: s.siteName,
//       siteId: s.siteId,
//       address: s.address,
//       pincode: s.pincode,
//       poc: s.poc,
//       country: s.country,
//       state: s.state,
//       district: s.district,
//       city: s.city,
//       completionDate: dmy(s.completionDate),
//       remarks: s.remarks.isEmpty ? '—' : s.remarks,
//     );
//   }

//   static _Site modalToSite(dynamic modalSite, _Site base) {
//     String undmy(String v) {
//       if (v.trim().isEmpty || v == '—') return '';
//       final s = v.contains('/') ? v.split('/') : v.split('-');
//       if (s.length != 3) return v;
//       final dd = s[0].padLeft(2, '0');
//       final mm = s[1].padLeft(2, '0');
//       final yy = s[2];
//       return '$yy-$mm-$dd';
//     }

//     return base.copyWith(
//       subProject: (modalSite.subProject == '—') ? '' : modalSite.subProject,
//       status: modalSite.status,
//       siteName: modalSite.siteName,
//       siteId: modalSite.siteId,
//       address: modalSite.address,
//       pincode: modalSite.pincode,
//       poc: modalSite.poc,
//       country: modalSite.country,
//       state: modalSite.state,
//       district: modalSite.district,
//       city: modalSite.city,
//       completionDate:
//           (() {
//             final x = undmy(modalSite.completionDate);
//             return x.isEmpty ? null : x;
//           })(),
//       remarks: (modalSite.remarks == '—') ? '' : modalSite.remarks,
//     );
//   }

//   Widget _kv(String k, String v, Color kColor, Color vColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         overflow: TextOverflow.ellipsis,
//         text: TextSpan(
//           text: '$k: ',
//           style: TextStyle(color: kColor, fontSize: 11),
//           children: [
//             TextSpan(
//               text: v.isEmpty ? '—' : v,
//               style: TextStyle(color: vColor, fontSize: 11),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SearchField extends StatelessWidget {
//   final TextEditingController controller;
//   const _SearchField({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return SizedBox(
//       height: 34,
//       child: TextField(
//         controller: controller,
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

// // Labeled dropdown wrapper
// class _LabeledDropdown<T> extends StatelessWidget {
//   final String label;
//   final T value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;
//   final bool enabled;
//   const _LabeledDropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.enabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 12,
//             color: cs.onSurfaceVariant,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         const SizedBox(height: 6),
//         Container(
//           height: 34,
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           decoration: BoxDecoration(
//             color:
//                 enabled ? cs.surfaceContainerHighest : cs.surfaceContainerHigh,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<T>(
//               value: value,
//               isExpanded: true,
//               dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//               iconEnabledColor: cs.onSurfaceVariant,
//               style: TextStyle(color: cs.onSurface, fontSize: 12),
//               items:
//                   items
//                       .map(
//                         (e) => DropdownMenuItem<T>(value: e, child: Text('$e')),
//                       )
//                       .toList(),
//               onChanged: enabled ? onChanged : null,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// /// Public model used by the UpdateSiteModal
// class Site {
//   final String project;
//   final String subProject;
//   final String status;
//   final String siteName;
//   final String siteId;
//   final String address;
//   final String pincode;
//   final String poc;
//   final String country;
//   final String state;
//   final String district;
//   final String city;
//   final String completionDate; // display string (dd/mm/yyyy or '—')
//   final String remarks;

//   Site({
//     required this.project,
//     required this.subProject,
//     required this.status,
//     required this.siteName,
//     required this.siteId,
//     required this.address,
//     required this.pincode,
//     required this.poc,
//     required this.country,
//     required this.state,
//     required this.district,
//     required this.city,
//     required this.completionDate,
//     required this.remarks,
//   });

//   Site copyWith({
//     String? project,
//     String? subProject,
//     String? status,
//     String? siteName,
//     String? siteId,
//     String? address,
//     String? pincode,
//     String? poc,
//     String? country,
//     String? state,
//     String? district,
//     String? city,
//     String? completionDate,
//     String? remarks,
//   }) {
//     return Site(
//       project: project ?? this.project,
//       subProject: subProject ?? this.subProject,
//       status: status ?? this.status,
//       siteName: siteName ?? this.siteName,
//       siteId: siteId ?? this.siteId,
//       address: address ?? this.address,
//       pincode: pincode ?? this.pincode,
//       poc: poc ?? this.poc,
//       country: country ?? this.country,
//       state: state ?? this.state,
//       district: district ?? this.district,
//       city: city ?? this.city,
//       completionDate: completionDate ?? this.completionDate,
//       remarks: remarks ?? this.remarks,
//     );
//   }
// }

// /* -------- Pagination (same style) -------- */

// class _PaginationBar extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;
//   static const int _windowSize = 5;

//   const _PaginationBar({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     final int windowStart =
//         ((currentPage - 1) ~/ _windowSize) * _windowSize + 1;
//     final int windowEnd = min(windowStart + _windowSize - 1, totalPages);

//     Widget pill({
//       required Widget child,
//       required bool selected,
//       VoidCallback? onTap,
//       double width = 40,
//     }) {
//       final bg = selected ? Colors.black : cs.surfaceContainerHighest;
//       final fg = selected ? Colors.white : cs.onSurface;

//       final content = Container(
//         width: width,
//         height: 36,
//         margin: const EdgeInsets.symmetric(horizontal: 4),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: DefaultTextStyle(
//           style: TextStyle(
//             color: fg,
//             fontWeight: FontWeight.w600,
//             fontSize: 13,
//           ),
//           child: IconTheme.merge(
//             data: IconThemeData(color: fg, size: 18),
//             child: child,
//           ),
//         ),
//       );

//       return onTap == null
//           ? Opacity(opacity: 0.5, child: content)
//           : InkWell(
//             onTap: onTap,
//             borderRadius: BorderRadius.circular(10),
//             child: content,
//           );
//     }

//     final hasPrevWindow = windowStart > 1;
//     final hasNextWindow = windowEnd < totalPages;

//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         pill(
//           child: const Icon(Icons.chevron_left),
//           selected: false,
//           onTap: hasPrevWindow ? () => onPageSelected(windowStart - 1) : null,
//         ),
//         for (int p = windowStart; p <= windowEnd; p++)
//           pill(
//             child: Text('$p'),
//             selected: p == currentPage,
//             onTap: () => onPageSelected(p),
//           ),
//         pill(
//           child: const Icon(Icons.chevron_right),
//           selected: false,
//           onTap: hasNextWindow ? () => onPageSelected(windowEnd + 1) : null,
//         ),
//       ],
//     );
//   }
// }

// class _PaginationInline extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;

//   final VoidCallback onPrev;
//   final VoidCallback onNext;

//   final int perPage;
//   final List<int> options;
//   final ValueChanged<int> onPerPageChanged;

//   const _PaginationInline({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageSelected,
//     required this.onPrev,
//     required this.onNext,
//     required this.perPage,
//     required this.options,
//     required this.onPerPageChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: SizedBox(
//         height: 40,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             _PaginationBar(
//               currentPage: currentPage,
//               totalPages: totalPages,
//               onPageSelected: onPageSelected,
//             ),
//             Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 height: 36,
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: cs.surfaceContainerHighest,
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(color: cs.outlineVariant),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<int>(
//                     value: perPage,
//                     dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//                     style: TextStyle(fontSize: 13, color: cs.onSurface),
//                     items:
//                         options
//                             .map(
//                               (n) =>
//                                   DropdownMenuItem(value: n, child: Text('$n')),
//                             )
//                             .toList(),
//                     onChanged: (v) {
//                       if (v != null) onPerPageChanged(v);
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//p test //
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:pmgt/core/api_client.dart';
import 'package:pmgt/core/theme.dart';
import 'package:pmgt/core/theme_controller.dart';
import 'package:pmgt/ui/utils/responsive.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';
import 'package:pmgt/ui/screens/profile/profile_screen.dart';

import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';


// Update modal
import '../modals/update_site_modal.dart';

class AllSitesScreen extends StatefulWidget {
  const AllSitesScreen({super.key});

  @override
  State<AllSitesScreen> createState() => _AllSitesScreenState();
}

/* ------------------------ DTOs ------------------------ */

class _ProjectOption {
  final String id;
  final String name;
  _ProjectOption({required this.id, required this.name});
}

class _Site {
  final String projectId;
  final String project;
  final String subProject; // may be ''
  final String
  status; // Completed | In progress | Pending | Hold | Abortive | Scheduled (etc.)
  final String siteName;
  final String siteId;
  final String address;
  final String pincode;
  final String poc;
  final String country;
  final String state;
  final String district;
  final String city;
  final String? completionDate; // yyyy-mm-dd or null
  final String remarks;

  // precomputed lower-case searchable string
  final String _search;

  _Site({
    required this.projectId,
    required this.project,
    required this.subProject,
    required this.status,
    required this.siteName,
    required this.siteId,
    required this.address,
    required this.pincode,
    required this.poc,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.completionDate,
    required this.remarks,
    required String searchJoin,
  }) : _search = searchJoin.toLowerCase();

  _Site copyWith({
    String? projectId,
    String? project,
    String? subProject,
    String? status,
    String? siteName,
    String? siteId,
    String? address,
    String? pincode,
    String? poc,
    String? country,
    String? state,
    String? district,
    String? city,
    String? completionDate,
    String? remarks,
  }) {
    final next = _Site(
      projectId: projectId ?? this.projectId,
      project: project ?? this.project,
      subProject: subProject ?? this.subProject,
      status: status ?? this.status,
      siteName: siteName ?? this.siteName,
      siteId: siteId ?? this.siteId,
      address: address ?? this.address,
      pincode: pincode ?? this.pincode,
      poc: poc ?? this.poc,
      country: country ?? this.country,
      state: state ?? this.state,
      district: district ?? this.district,
      city: city ?? this.city,
      completionDate: completionDate ?? this.completionDate,
      remarks: remarks ?? this.remarks,
      searchJoin: [
        project ?? this.project,
        subProject ?? this.subProject,
        siteName ?? this.siteName,
        siteId ?? this.siteId,
        address ?? this.address,
        pincode ?? this.pincode,
        poc ?? this.poc,
        country ?? this.country,
        state ?? this.state,
        district ?? this.district,
        city ?? this.city,
        status ?? this.status,
        (completionDate ?? this.completionDate) ?? '',
        remarks ?? this.remarks,
      ].join('|'),
    );
    return next;
  }
}

/* ------------------------ Screen ------------------------ */

class _AllSitesScreenState extends State<AllSitesScreen> {
  // navigation tab index from your app
  final int _selectedTab = 0;

  // API-backed state
  final List<_ProjectOption> _projects = [];
  bool _loadingProjects = false;

  final List<_Site> _sites = [];
  bool _loadingSites = false;

  // Filters
  String _selectedProjectName = 'All'; // stores project_name like web
  String _selectedSubProject = 'All';

  // derived: project-name list for dropdown
  List<String> get _projectNames => ['All', ..._projects.map((p) => p.name)];

  // Search (debounced)
  final _searchCtrl = TextEditingController();
  String _searchRaw = '';
  String _search = '';
  Timer? _debounce;

  // Pagination (client-side)
  int _currentPage = 1;
  int _perPage = 30;
  final List<int> _perPageOptions = const [15, 30, 50];

  // Status options for modal
  static const List<String> _statusOptions = [
    'Completed',
    'In progress',
    'Pending',
    'Hold',
    'Scheduled',
    'Abortive',
  ];

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() {
      _searchRaw = _searchCtrl.text;
      _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 120), () {
        if (!mounted) return;
        setState(() {
          _search = _searchRaw.trim().toLowerCase();
          _currentPage = 1;
        });
      });
    });
    _loadProjects();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchCtrl.dispose();
    super.dispose();
  }

  // ───────────────── API ─────────────────

  Future<void> _loadProjects() async {
    setState(() => _loadingProjects = true);
    try {
      final api = context.read<ApiClient>();
      final res = await api.get('/api/projects');
      final list = (jsonDecode(res.body) as List?) ?? [];
      _projects
        ..clear()
        ..addAll(
          list.map(
            (e) => _ProjectOption(
              id: (e['id'] ?? '').toString(),
              name: (e['project_name'] ?? '').toString(),
            ),
          ),
        );
      setState(() {});
      // initial sites load
      await _loadSites();
    } catch (e) {
      _toast('Failed to load projects', false);
    } finally {
      if (mounted) setState(() => _loadingProjects = false);
    }
  }

  Future<List<dynamic>> _fetchSitesFor(String projectId) async {
    final api = context.read<ApiClient>();
    final res = await api.get('/api/project-sites/$projectId');
    final list = (jsonDecode(res.body) as List?) ?? [];
    return list;
  }

  Future<void> _loadSites() async {
    if (_projects.isEmpty) {
      setState(() {
        _sites.clear();
      });
      return;
    }
    setState(() {
      _loadingSites = true;
      _currentPage = 1;
    });
    try {
      List<dynamic> raw = [];
      if (_selectedProjectName == 'All') {
        final results = await Future.wait(
          _projects.map((p) => _fetchSitesFor(p.id)),
        );
        raw = results.expand((x) => x).toList();
      } else {
        final proj = _projects.firstWhere(
          (p) => p.name == _selectedProjectName,
          orElse: () => _projects.first,
        );
        raw = await _fetchSitesFor(proj.id);
      }

      final data = <_Site>[];
      for (final x in raw) {
        String lower(dynamic v) => (v ?? '').toString().toLowerCase();
        final site = _Site(
          projectId: (x['project_id'] ?? '').toString(),
          project: (x['project_name'] ?? '').toString(),
          subProject: (x['sub_project_name'] ?? '').toString(),
          siteName: (x['site_name'] ?? '').toString(),
          siteId: (x['site_id'] ?? '').toString(),
          address: (x['address'] ?? '').toString(),
          pincode: (x['pincode'] ?? '').toString(),
          poc: (x['poc'] ?? '').toString(),
          country: (x['country'] ?? '').toString(),
          state: (x['state'] ?? '').toString(),
          district: (x['district'] ?? '').toString(),
          city: (x['city'] ?? '').toString(),
          status: (x['status'] ?? '').toString(),
          completionDate: (x['completion_date'] as String?) ?? null,
          remarks: (x['remarks'] ?? '').toString(),
          searchJoin: [
            x['project_name'],
            x['sub_project_name'],
            x['site_name'],
            x['site_id'],
            x['address'],
            x['pincode'],
            x['poc'],
            x['country'],
            x['state'],
            x['district'],
            x['city'],
            x['status'],
            x['remarks'],
            x['completion_date'],
          ].map(lower).join('|'),
        );
        data.add(site);
      }

      setState(() {
        _sites
          ..clear()
          ..addAll(data);
        // when project changes, reset sub-project filter to 'All'
        _selectedSubProject = 'All';
      });
    } catch (e) {
      _toast('Failed to load sites', false);
      setState(() => _sites.clear());
    } finally {
      if (mounted) setState(() => _loadingSites = false);
    }
  }

  // Export to CSV (saves to temp path and shows it)
  Future<void> _exportCsv() async {
    try {
      final api = context.read<ApiClient>();
      final String baseUrl = (api as dynamic).baseUrl as String;
      final String? token = (api as dynamic).token as String?;
      final uri = Uri.parse('$baseUrl/api/project-sites/export');

      final req = http.Request('GET', uri);
      if ((token ?? '').isNotEmpty) {
        req.headers['Authorization'] = 'Bearer $token';
      }
      final streamed = await req.send();
      final bytes = await streamed.stream.toBytes();

      if (streamed.statusCode < 200 || streamed.statusCode >= 300) {
        throw Exception('Export failed (${streamed.statusCode})');
      }

      final file = File('${Directory.systemTemp.path}/project_sites.csv');
      await file.writeAsBytes(bytes, flush: true);

      _toast('Sites exported → ${file.path}');
    } catch (e) {
      _toast('Export failed', false);
    }
  }

  // Derived: filtered rows (by project/sub/search)
  List<_Site> get _filtered {
    final term = _search;
    return _sites.where((r) {
      final okProj =
          _selectedProjectName == 'All' || r.project == _selectedProjectName;
      final okChild =
          _selectedSubProject == 'All' || r.subProject == _selectedSubProject;
      final okSearch = term.isEmpty || r._search.contains(term);
      return okProj && okChild && okSearch;
    }).toList();
  }

  // Derived: sub-project options based on current project filter
  List<String> get _childOptions {
    final base =
        _selectedProjectName == 'All'
            ? _sites
            : _sites.where((r) => r.project == _selectedProjectName);
    final unique = <String>{
      ...base.map((r) => r.subProject).where((s) => s.isNotEmpty),
    };
    final list = ['All', ...unique.toList()..sort()];
    if (!list.contains(_selectedSubProject)) _selectedSubProject = 'All';
    return list;
  }

  int get _totalPages {
    final len = _filtered.length;
    if (len == 0) return 1;
    return (len + _perPage - 1) ~/ _perPage;
  }

  List<_Site> get _paged {
    final items = _filtered;
    if (items.isEmpty) return const [];
    final start = (_currentPage - 1) * _perPage;
    final end = min(start + _perPage, items.length);
    if (start >= items.length) return const [];
    return items.sublist(start, end);
  }

  // ───────────────── Helpers ─────────────────
  void _goToPage(int p) => setState(() {
    _currentPage = p.clamp(1, _totalPages);
  });

  void _toast(String msg, [bool success = true]) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green.shade600 : Colors.red.shade700,
      ),
    );
    print(msg);
  }

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

  String _dmy(String? ymd) {
    if (ymd == null || ymd.isEmpty) return '—';
    final parts = ymd.split('-');
    if (parts.length != 3) return ymd;
    final y = parts[0], m = parts[1], d = parts[2];
    return '$d-$m-$y';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'All Sites',
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
      currentIndex: _selectedTab,
      onTabChanged: (i) => _handleTabChange(i),
      safeArea: false,
      reserveBottomPadding: true,
      body: Stack(
        children: [
          Padding(
            padding: responsivePadding(context).copyWith(top: 6, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Search + Export
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(child: _SearchField(controller: _searchCtrl)),
                    const SizedBox(width: 8),
                    SizedBox(
                      height: 34,
                      child: ElevatedButton.icon(
                        onPressed: _exportCsv,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                        ),
                        icon: const Icon(Icons.download),
                        label: const Text(
                          'Export',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Divider(color: cs.outlineVariant),
                const SizedBox(height: 8),

                // Filters
                Row(
                  children: [
                    Expanded(
                      child: _LabeledDropdown<String>(
                        label: 'Project',
                        value: _selectedProjectName,
                        items: _projectNames,
                        enabled: !_loadingProjects,
                        onChanged: (v) async {
                          setState(() {
                            _selectedProjectName = v ?? 'All';
                            _selectedSubProject = 'All';
                            _currentPage = 1;
                          });
                          await _loadSites();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _LabeledDropdown<String>(
                        label: 'Sub Project',
                        value: _selectedSubProject,
                        items: _childOptions,
                        onChanged: (v) {
                          setState(() {
                            _selectedSubProject = v ?? 'All';
                            _currentPage = 1;
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // List + pagination
                // Expanded(
                //   child:
                //       _paged.isEmpty
                //           ? Center(
                //             child: Text(
                //               _loadingSites ? '' : 'No records found.',
                //               style: TextStyle(color: cs.onSurfaceVariant),
                //             ),
                //           )
                //           : ListView.separated(
                //             padding: const EdgeInsets.only(bottom: 12 + 58),
                //             separatorBuilder:
                //                 (_, __) => const SizedBox(height: 12),
                //             itemCount: _paged.length + 1,
                //             itemBuilder: (context, i) {
                //               if (i < _paged.length) {
                //                 final s = _paged[i];
                //                 final globalIndex = _sites.indexOf(s);
                //                 return _SiteCard(
                //                   site: s,
                //                   onUpdate: (updated) async {
                //                     try {
                //                       final api = context.read<ApiClient>();
                //                       final String baseUrl =
                //                           (api as dynamic).baseUrl as String;
                //                       final String? token =
                //                           (api as dynamic).token as String?;
                //                       final uri = Uri.parse(
                //                         '$baseUrl/api/project-sites/${s.projectId}/${s.siteId}',
                //                       );

                //                       final resp = await http.put(
                //                         uri,
                //                         headers: {
                //                           if (token != null && token.isNotEmpty)
                //                             'Authorization': 'Bearer $token',
                //                           'Content-Type': 'application/json',
                //                         },
                //                         body: jsonEncode({
                //                           'site_name': updated.siteName,
                //                           'address': updated.address,
                //                           'pincode': updated.pincode,
                //                           'poc': updated.poc,
                //                           'country': updated.country,
                //                           'state': updated.state,
                //                           'district': updated.district,
                //                           'city': updated.city,
                //                           'remarks':
                //                               updated.remarks.isEmpty
                //                                   ? null
                //                                   : updated.remarks,
                //                           'status': updated.status,
                //                           'completion_date':
                //                               updated.completionDate == null ||
                //                                       updated
                //                                           .completionDate!
                //                                           .isEmpty
                //                                   ? null
                //                                   : updated.completionDate,
                //                         }),
                //                       );

                //                       if (resp.statusCode < 200 ||
                //                           resp.statusCode >= 300) {
                //                         final msg =
                //                             (jsonDecode(resp.body)
                //                                     as Map?)?['error']
                //                                 ?.toString() ??
                //                             'Update failed';
                //                         throw Exception(msg);
                //                       }

                //                       setState(
                //                         () => _sites[globalIndex] = updated,
                //                       );
                //                       _toast('Site updated');
                //                     } catch (e) {
                //                       _toast('Update failed', false);
                //                     }
                //                   },
                //                   dmy: _dmy,
                //                   subProjectOptions:
                //                       _childOptions
                //                           .where((e) => e != 'All')
                //                           .toList(),
                //                   statusOptions: _statusOptions,
                //                 );
                //               }
                //               return _PaginationInline(
                //                 currentPage: _currentPage,
                //                 totalPages: _totalPages,
                //                 onPageSelected: _goToPage,
                //                 onPrev: () => _goToPage(_currentPage - 1),
                //                 onNext: () => _goToPage(_currentPage + 1),
                //                 perPage: _perPage,
                //                 options: _perPageOptions,
                //                 onPerPageChanged: (v) {
                //                   setState(() {
                //                     _perPage = v;
                //                     _currentPage = 1;
                //                   });
                //                 },
                //               );
                //             },
                //           ),
                // ),

                Expanded(
  child: _paged.isEmpty
      ? Center(
          child: Text(
            _loadingSites ? '' : 'No records found.',
            style: TextStyle(color: cs.onSurfaceVariant),
          ),
        )
      : ListView.separated(
          padding: const EdgeInsets.only(bottom: 12 + 58),
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemCount: _paged.length + 1,
          itemBuilder: (context, i) {
            if (i < _paged.length) {
              final s = _paged[i];
              final globalIndex = _sites.indexOf(s);
              return _SiteCard(
                site: s,
                onUpdate: (updated) async {
                  try {
                    final api = context.read<ApiClient>();

                    // ✅ use core ApiClient.put (it auto-adds base URL & auth)
                    final resp = await api.put(
                      '/api/project-sites/${s.projectId}/${s.siteId}',
                      body: {
                        'site_name':       updated.siteName,
                        'address':         updated.address,
                        'pincode':         updated.pincode,
                        'poc':             updated.poc,
                        'country':         updated.country,
                        'state':           updated.state,
                        'district':        updated.district,
                        'city':            updated.city,
                        'remarks':         updated.remarks.isEmpty ? null : updated.remarks,
                        'status':          updated.status,
                        'completion_date': (updated.completionDate == null || updated.completionDate!.isEmpty)
                            ? null
                            : updated.completionDate,
                      },
                    );

                    if (resp.statusCode < 200 || resp.statusCode >= 300) {
                      final msg = (() {
                        try {
                          final m = jsonDecode(resp.body) as Map?;
                          return m?['error']?.toString();
                        } catch (_) {
                          return null;
                        }
                      })();
                      throw Exception(msg ?? 'Update failed');
                    }

                    setState(() => _sites[globalIndex] = updated);
                    _toast('Site updated');
                  } catch (e) {
                    _toast('Update failed', false);
                  }
                },
                dmy: _dmy,
                subProjectOptions:
                    _childOptions.where((e) => e != 'All').toList(),
                statusOptions: _statusOptions,
              );
            }
            return _PaginationInline(
              currentPage: _currentPage,
              totalPages: _totalPages,
              onPageSelected: _goToPage,
              onPrev: () => _goToPage(_currentPage - 1),
              onNext: () => _goToPage(_currentPage + 1),
              perPage: _perPage,
              options: _perPageOptions,
              onPerPageChanged: (v) {
                setState(() {
                  _perPage = v;
                  _currentPage = 1;
                });
              },
            );
          },
        ),
),

              ],
            ),
          ),

          if (_loadingSites)
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

/* ------------------------ Widgets / helpers ------------------------ */

class _SiteCard extends StatelessWidget {
  final _Site site;
  final ValueChanged<_Site> onUpdate;
  final String Function(String?) dmy;
  final List<String> subProjectOptions;
  final List<String> statusOptions;

  const _SiteCard({
    required this.site,
    required this.onUpdate,
    required this.dmy,
    required this.subProjectOptions,
    required this.statusOptions,
  });

  String _clean(String v) => v.replaceAll('\uFFFD', '');

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
    final valueColor = isLight ? Colors.black : cs.onSurface;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                site.project,
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                'Status : ${site.status.isEmpty ? '—' : site.status}',
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Sub Project: ${site.subProject.isEmpty ? '—' : site.subProject}',
            style: TextStyle(color: labelColor, fontSize: 11),
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 12),

          // two columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('Site Name', site.siteName, labelColor, valueColor),
                    _kv('Site ID', site.siteId, labelColor, valueColor),
                    // _kv('Address', site.address, labelColor, valueColor),
                    _kv(
                      'Address',
                      _clean(site.address),
                      labelColor,
                      valueColor,
                      wrap: true,
                    ),
                    _kv('Pincode', site.pincode, labelColor, valueColor),
                    _kv(
                      'Completion Date',
                      dmy(site.completionDate),
                      labelColor,
                      valueColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // _kv('POC', site.poc, labelColor, valueColor),
                    _kv(
                      'POC',
                      _clean(site.poc),
                      labelColor,
                      valueColor,
                      wrap: true,
                    ),

                    _kv('Country', site.country, labelColor, valueColor),
                    _kv('State', site.state, labelColor, valueColor),
                    _kv('District', site.district, labelColor, valueColor),
                    _kv('City', site.city, labelColor, valueColor),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          // _kv(
          //   'Remarks',
          //   site.remarks.isEmpty ? '—' : site.remarks,
          //   labelColor,
          //   valueColor,
          // ),
          _kv(
            'Remarks',
            site.remarks.isEmpty ? '—' : _clean(site.remarks),
            labelColor,
            valueColor,
            wrap: true,
          ),

          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                side: const BorderSide(color: AppTheme.accentColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              onPressed: () async {
                final updated = await UpdateSiteModal.show(
                  context,
                  site: siteToModal(site, dmy),
                  subProjects:
                      subProjectOptions.isEmpty
                          ? const ['—']
                          : subProjectOptions,
                  statusOptions: statusOptions,
                );
                if (updated != null) {
                  onUpdate(modalToSite(updated, site));
                }
              },
              child: const Text(
                'Update',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // adapters for UpdateSiteModal
  static dynamic siteToModal(_Site s, String Function(String?) dmy) {
    return Site(
      project: s.project,
      subProject: s.subProject.isEmpty ? '—' : s.subProject,
      status: s.status.isEmpty ? 'Pending' : s.status,
      siteName: s.siteName,
      siteId: s.siteId,
      address: s.address,
      pincode: s.pincode,
      poc: s.poc,
      country: s.country,
      state: s.state,
      district: s.district,
      city: s.city,
      completionDate: dmy(s.completionDate),
      remarks: s.remarks.isEmpty ? '—' : s.remarks,
    );
  }

  static _Site modalToSite(dynamic modalSite, _Site base) {
    String undmy(String v) {
      if (v.trim().isEmpty || v == '—') return '';
      final s = v.contains('/') ? v.split('/') : v.split('-');
      if (s.length != 3) return v;
      final dd = s[0].padLeft(2, '0');
      final mm = s[1].padLeft(2, '0');
      final yy = s[2];
      return '$yy-$mm-$dd';
    }

    return base.copyWith(
      subProject: (modalSite.subProject == '—') ? '' : modalSite.subProject,
      status: modalSite.status,
      siteName: modalSite.siteName,
      siteId: modalSite.siteId,
      address: modalSite.address,
      pincode: modalSite.pincode,
      poc: modalSite.poc,
      country: modalSite.country,
      state: modalSite.state,
      district: modalSite.district,
      city: modalSite.city,
      completionDate:
          (() {
            final x = undmy(modalSite.completionDate);
            return x.isEmpty ? null : x;
          })(),
      remarks: (modalSite.remarks == '—') ? '' : modalSite.remarks,
    );
  }

  // Widget _kv(String k, String v, Color kColor, Color vColor) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 4),
  //     child: RichText(
  //       overflow: TextOverflow.ellipsis,
  //       text: TextSpan(
  //         text: '$k: ',
  //         style: TextStyle(color: kColor, fontSize: 11),
  //         children: [
  //           TextSpan(
  //             text: v.isEmpty ? '—' : v,
  //             style: TextStyle(color: vColor, fontSize: 11),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _kv(
    String k,
    String v,
    Color kColor,
    Color vColor, {
    bool wrap = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text.rich(
        TextSpan(
          text: '$k: ',
          style: TextStyle(color: kColor, fontSize: 11),
          children: [
            TextSpan(
              text: v.isEmpty ? '—' : v,
              style: TextStyle(color: vColor, fontSize: 11),
            ),
          ],
        ),
        softWrap: wrap,
        overflow: wrap ? TextOverflow.visible : TextOverflow.ellipsis,
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final TextEditingController controller;
  const _SearchField({required this.controller});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 34,
      child: TextField(
        controller: controller,
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}

// Labeled dropdown wrapper
class _LabeledDropdown<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  final bool enabled;
  const _LabeledDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
        Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color:
                enabled ? cs.surfaceContainerHighest : cs.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isExpanded: true,
              dropdownColor: Theme.of(context).scaffoldBackgroundColor,
              iconEnabledColor: cs.onSurfaceVariant,
              style: TextStyle(color: cs.onSurface, fontSize: 12),
              items:
                  items
                      .map(
                        (e) => DropdownMenuItem<T>(value: e, child: Text('$e')),
                      )
                      .toList(),
              onChanged: enabled ? onChanged : null,
            ),
          ),
        ),
      ],
    );
  }
}

/// Public model used by the UpdateSiteModal
class Site {
  final String project;
  final String subProject;
  final String status;
  final String siteName;
  final String siteId;
  final String address;
  final String pincode;
  final String poc;
  final String country;
  final String state;
  final String district;
  final String city;
  final String completionDate; // display string (dd/mm/yyyy or '—')
  final String remarks;

  Site({
    required this.project,
    required this.subProject,
    required this.status,
    required this.siteName,
    required this.siteId,
    required this.address,
    required this.pincode,
    required this.poc,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.completionDate,
    required this.remarks,
  });

  Site copyWith({
    String? project,
    String? subProject,
    String? status,
    String? siteName,
    String? siteId,
    String? address,
    String? pincode,
    String? poc,
    String? country,
    String? state,
    String? district,
    String? city,
    String? completionDate,
    String? remarks,
  }) {
    return Site(
      project: project ?? this.project,
      subProject: subProject ?? this.subProject,
      status: status ?? this.status,
      siteName: siteName ?? this.siteName,
      siteId: siteId ?? this.siteId,
      address: address ?? this.address,
      pincode: pincode ?? this.pincode,
      poc: poc ?? this.poc,
      country: country ?? this.country,
      state: state ?? this.state,
      district: district ?? this.district,
      city: city ?? this.city,
      completionDate: completionDate ?? this.completionDate,
      remarks: remarks ?? this.remarks,
    );
  }
}

/* -------- Pagination (same style) -------- */

class _PaginationBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;
  static const int _windowSize = 5;

  const _PaginationBar({
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final int windowStart =
        ((currentPage - 1) ~/ _windowSize) * _windowSize + 1;
    final int windowEnd = min(windowStart + _windowSize - 1, totalPages);

    Widget pill({
      required Widget child,
      required bool selected,
      VoidCallback? onTap,
      double width = 40,
    }) {
      final bg = selected ? Colors.black : cs.surfaceContainerHighest;
      final fg = selected ? Colors.white : cs.onSurface;

      final content = Container(
        width: width,
        height: 36,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cs.outlineVariant),
        ),
        child: DefaultTextStyle(
          style: TextStyle(
            color: fg,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          child: IconTheme.merge(
            data: IconThemeData(color: fg, size: 18),
            child: child,
          ),
        ),
      );

      return onTap == null
          ? Opacity(opacity: 0.5, child: content)
          : InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(10),
            child: content,
          );
    }

    final hasPrevWindow = windowStart > 1;
    final hasNextWindow = windowEnd < totalPages;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        pill(
          child: const Icon(Icons.chevron_left),
          selected: false,
          onTap: hasPrevWindow ? () => onPageSelected(windowStart - 1) : null,
        ),
        for (int p = windowStart; p <= windowEnd; p++)
          pill(
            child: Text('$p'),
            selected: p == currentPage,
            onTap: () => onPageSelected(p),
          ),
        pill(
          child: const Icon(Icons.chevron_right),
          selected: false,
          onTap: hasNextWindow ? () => onPageSelected(windowEnd + 1) : null,
        ),
      ],
    );
  }
}

class _PaginationInline extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final ValueChanged<int> onPageSelected;

  final VoidCallback onPrev;
  final VoidCallback onNext;

  final int perPage;
  final List<int> options;
  final ValueChanged<int> onPerPageChanged;

  const _PaginationInline({
    required this.currentPage,
    required this.totalPages,
    required this.onPageSelected,
    required this.onPrev,
    required this.onNext,
    required this.perPage,
    required this.options,
    required this.onPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _PaginationBar(
              currentPage: currentPage,
              totalPages: totalPages,
              onPageSelected: onPageSelected,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: cs.outlineVariant),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: perPage,
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    style: TextStyle(fontSize: 13, color: cs.onSurface),
                    items:
                        options
                            .map(
                              (n) =>
                                  DropdownMenuItem(value: n, child: Text('$n')),
                            )
                            .toList(),
                    onChanged: (v) {
                      if (v != null) onPerPageChanged(v);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
