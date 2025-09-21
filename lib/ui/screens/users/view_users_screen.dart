

// // lib/ui/screens/users/view_users_screen.dart
// import 'dart:math';
// import 'package:flutter/material.dart';

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';

// class ViewAllUsersScreen extends StatefulWidget {
//   const ViewAllUsersScreen({super.key});

//   @override
//   State<ViewAllUsersScreen> createState() => _ViewAllUsersScreenState();
// }

// class _ViewAllUsersScreenState extends State<ViewAllUsersScreen> {
//   // ---------------------------------------------------------------------------
//   // Toggle (5 segments)
//   // ---------------------------------------------------------------------------
//   final List<String> _segments = const ['PM', 'BDM', 'NOC', 'SCM', 'FE/Vendor'];
//   final List<bool> _isSelected = [true, false, false, false, false];

//   UserKind _currentKind = UserKind.pm;

//   void _setKind(int index) {
//     setState(() {
//       for (var i = 0; i < _isSelected.length; i++) {
//         _isSelected[i] = (i == index);
//       }
//       _currentKind = UserKind.values[index];
//     });
//   }

//   // ---------------------------------------------------------------------------
//   // Sample typed data for each user type (so there is no List<Map> mismatch)
//   // ---------------------------------------------------------------------------

//   final List<PM> _pmList = List.generate(
//     8,
//     (i) => PM(
//       name: 'PM #${i + 1}',
//       email: 'pm$i@atlas.com',
//       contact: '98xxx${(1000 + i).toString().substring(1)}',
//       projects: ['NPCI', 'TelstraApari'],
//     ),
//   );

//   final List<BDM> _bdmList = List.generate(
//     6,
//     (i) => BDM(
//       name: 'BDM #${i + 1}',
//       email: 'bdm$i@atlas.com',
//       contact: '98xxx${(2000 + i).toString().substring(1)}',
//       projects: ['NPCI'],
//     ),
//   );

//   final List<NOCUser> _nocList = List.generate(
//     6,
//     (i) => NOCUser(
//       name: 'NOC #${i + 1}',
//       email: 'noc$i@atlas.com',
//       contact: '98xxx${(3000 + i).toString().substring(1)}',
//       projects: ['TelstraApari'],
//     ),
//   );

//   final List<SCM> _scmList = List.generate(
//     6,
//     (i) => SCM(
//       name: 'SCM #${i + 1}',
//       email: 'scm$i@atlas.com',
//       contact: '98xxx${(4000 + i).toString().substring(1)}',
//       projects: ['BPCL Aruba WIFI'],
//     ),
//   );

//   final List<FEVendor> _feList = List.generate(
//     12,
//     (i) => FEVendor(
//       name: 'FE/Vendor #$i',
//       role: 'Field Engineer / Vendor',
//       email: 'fe$i@atlas.com',
//       contact: '98xxx${(5000 + i).toString().substring(1)}',
//       project: 'NPCI',
//       site: 'Site ${i.toString().padLeft(3, '0')}',
//       zone: (['North', 'East', 'South', 'West'])[i % 4],
//       vendorName: 'Vendor ${String.fromCharCode(65 + (i % 26))}',
//       state: 'Maharashtra',
//       district: (i % 2 == 0) ? 'Thane' : 'Pune',
//     ),
//   );

//   // simple paging (shared across tabs just for UX parity)
//   int _currentPage = 1;
//   final List<int> _perPageOptions = const [5, 10, 15, 20];
//   int _perPage = 10;

//   List<T> _pageOf<T>(List<T> list) {
//     if (list.isEmpty) return const [];
//     final start = (_currentPage - 1) * _perPage;
//     final end = min(start + _perPage, list.length);
//     if (start >= list.length) return const [];
//     return list.sublist(start, end);
//   }

//   int _totalPagesFor(int total) => max(1, (total + _perPage - 1) ~/ _perPage);

//   void _goToPage(int p, int totalPages) {
//     setState(() => _currentPage = p.clamp(1, totalPages));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final pad = responsivePadding(context);

//     // pick source list based on current tab
//     late final int totalCount;
//     late final List<Widget> cards;

//     switch (_currentKind) {
//       case UserKind.pm:
//         totalCount = _pmList.length;
//         cards = _pageOf(_pmList).map((m) => _PMCard(m)).toList();
//         break;
//       case UserKind.bdm:
//         totalCount = _bdmList.length;
//         cards = _pageOf(_bdmList).map((m) => _BDMCard(m)).toList();
//         break;
//       case UserKind.noc:
//         totalCount = _nocList.length;
//         cards = _pageOf(_nocList).map((m) => _NOCCard(m)).toList();
//         break;
//       case UserKind.scm:
//         totalCount = _scmList.length;
//         cards = _pageOf(_scmList).map((m) => _SCMCard(m)).toList();
//         break;
//       case UserKind.fevendor:
//         totalCount = _feList.length;
//         cards = _pageOf(_feList).map((m) => _FEVendorCard(m)).toList();
//         break;
//     }

//     final totalPages = _totalPagesFor(totalCount);

//     return MainLayout(
//       title: 'All Users',
//       centerTitle: true,
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
//         IconButton(
//           tooltip: 'Profile',
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (_) => const ProfileScreen()),
//             );
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
//       currentIndex: 3, // (wherever this tab lives in your bottom nav)
//       onTabChanged: (_) {},
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Padding(
//         padding: pad.copyWith(top: 8, bottom: 0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Compact 5-segment toggle (fits on small screens)
//             Center(
//               child: SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 physics: const BouncingScrollPhysics(),
//                 child: ToggleButtons(
//                   isSelected: _isSelected,
//                   onPressed: (i) {
//                     _setKind(i);
//                     _currentPage = 1; // reset paging on tab change
//                   },
//                   borderRadius: BorderRadius.circular(8),
//                   constraints:
//                       const BoxConstraints(minWidth: 76, minHeight: 32),
//                   fillColor: AppTheme.accentColor.withOpacity(
//                     Theme.of(context).brightness == Brightness.dark ? 0.20 : .25,
//                   ),
//                   selectedBorderColor: AppTheme.accentColor,
//                   borderColor: cs.outlineVariant,
//                   selectedColor: AppTheme.accentColor,
//                   color: cs.onSurfaceVariant,
//                   children: _segments
//                       .map((s) => Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             child: Text(
//                               s,
//                               style: const TextStyle(
//                                   fontSize: 12, fontWeight: FontWeight.w700),
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.only(bottom: 12 + 58),
//                 itemCount: cards.length + 1,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (context, index) {
//                   if (index < cards.length) return cards[index];
//                   // Pagination row (same style as dashboard)
//                   return _PaginationInline(
//                     currentPage: _currentPage,
//                     totalPages: totalPages,
//                     onPageSelected: (p) => _goToPage(p, totalPages),
//                     onPrev: () => _goToPage(_currentPage - 1, totalPages),
//                     onNext: () => _goToPage(_currentPage + 1, totalPages),
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

// // -----------------------------------------------------------------------------
// // Models
// // -----------------------------------------------------------------------------
// enum UserKind { pm, bdm, noc, scm, fevendor }

// class PM {
//   final String name, email, contact;
//   final List<String> projects;
//   PM({
//     required this.name,
//     required this.email,
//     required this.contact,
//     required this.projects,
//   });
// }

// class BDM {
//   final String name, email, contact;
//   final List<String> projects;
//   BDM({
//     required this.name,
//     required this.email,
//     required this.contact,
//     required this.projects,
//   });
// }

// class NOCUser {
//   final String name, email, contact;
//   final List<String> projects;
//   NOCUser({
//     required this.name,
//     required this.email,
//     required this.contact,
//     required this.projects,
//   });
// }

// class SCM {
//   final String name, email, contact;
//   final List<String> projects;
//   SCM({
//     required this.name,
//     required this.email,
//     required this.contact,
//     required this.projects,
//   });
// }

// class FEVendor {
//   final String name,
//       role,
//       email,
//       contact,
//       project,
//       site,
//       zone,
//       vendorName,
//       state,
//       district;
//   FEVendor({
//     required this.name,
//     required this.role,
//     required this.email,
//     required this.contact,
//     required this.project,
//     required this.site,
//     required this.zone,
//     required this.vendorName,
//     required this.state,
//     required this.district,
//   });
// }

// // -----------------------------------------------------------------------------
// // Cards
// // -----------------------------------------------------------------------------
// class _CardShell extends StatelessWidget {
//   final String leftTitle;
//   final String rightRole;
//   final List<Widget> leftChildren;
//   final List<Widget> rightChildren;

//   const _CardShell({
//     required this.leftTitle,
//     required this.rightRole,
//     required this.leftChildren,
//     required this.rightChildren,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Container(
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           // Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 leftTitle,
//                 style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w800,
//                     fontSize: 14),
//               ),
//               Text(
//                 rightRole,
//                 style: TextStyle(
//                     color: cs.onSurface,
//                     fontWeight: FontWeight.w700,
//                     fontSize: 14),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 8),
//           // Two columns
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(child: Column(children: leftChildren)),
//               const SizedBox(width: 16),
//               Expanded(child: Column(children: rightChildren)),
//             ],
//           ),
//           const SizedBox(height: 12),
//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppTheme.accentColor,
//                 side: const BorderSide(color: AppTheme.accentColor),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(6)),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               ),
//               onPressed: () {},
//               child: const Text('Update',
//                   style: TextStyle(color: Colors.black, fontSize: 12)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// Widget _kv(String k, String v, BuildContext context) {
//   final cs = Theme.of(context).colorScheme;
//   final label = TextStyle(color: cs.onSurfaceVariant, fontSize: 11);
//   final val = TextStyle(color: cs.onSurface, fontSize: 11);
//   return Padding(
//     padding: const EdgeInsets.only(bottom: 4),
//     child: RichText(
//       text: TextSpan(
//         text: '$k: ',
//         style: label,
//         children: [TextSpan(text: v, style: val)],
//       ),
//     ),
//   );
// }

// class _PMCard extends StatelessWidget {
//   final PM m;
//   const _PMCard(this.m);

//   @override
//   Widget build(BuildContext context) {
//     return _CardShell(
//       leftTitle: m.name,
//       rightRole: 'Project Manager',
//       leftChildren: [
//         _kv('Email', m.email, context),
//         _kv('Contact', m.contact, context),
//       ],
//       rightChildren: [
//         _kv('Projects', m.projects.join(', '), context),
//         _kv('Role', 'PM', context),
//       ],
//     );
//   }
// }

// class _BDMCard extends StatelessWidget {
//   final BDM m;
//   const _BDMCard(this.m);

//   @override
//   Widget build(BuildContext context) {
//     return _CardShell(
//       leftTitle: m.name,
//       rightRole: 'Business Development Manager',
//       leftChildren: [
//         _kv('Email', m.email, context),
//         _kv('Contact', m.contact, context),
//       ],
//       rightChildren: [
//         _kv('Projects', m.projects.join(', '), context),
//         _kv('Role', 'BDM', context),
//       ],
//     );
//   }
// }

// class _NOCCard extends StatelessWidget {
//   final NOCUser m;
//   const _NOCCard(this.m);

//   @override
//   Widget build(BuildContext context) {
//     return _CardShell(
//       leftTitle: m.name,
//       rightRole: 'NOC Engineer',
//       leftChildren: [
//         _kv('Email', m.email, context),
//         _kv('Contact', m.contact, context),
//       ],
//       rightChildren: [
//         _kv('Projects', m.projects.join(', '), context),
//         _kv('Role', 'NOC', context),
//       ],
//     );
//   }
// }

// class _SCMCard extends StatelessWidget {
//   final SCM m;
//   const _SCMCard(this.m);

//   @override
//   Widget build(BuildContext context) {
//     return _CardShell(
//       leftTitle: m.name,
//       rightRole: 'Supply Chain Manager',
//       leftChildren: [
//         _kv('Email', m.email, context),
//         _kv('Contact', m.contact, context),
//       ],
//       rightChildren: [
//         _kv('Projects', m.projects.join(', '), context),
//         _kv('Role', 'SCM', context),
//       ],
//     );
//   }
// }

// class _FEVendorCard extends StatelessWidget {
//   final FEVendor m;
//   const _FEVendorCard(this.m);

//   @override
//   Widget build(BuildContext context) {
//     return _CardShell(
//       leftTitle: m.name,
//       rightRole: m.role,
//       leftChildren: [
//         _kv('Email', m.email, context),
//         _kv('Contact', m.contact, context),
//         _kv('Project', m.project, context),
//         _kv('Site', m.site, context),
//       ],
//       rightChildren: [
//         _kv('Zone', m.zone, context),
//         _kv('Vendor Name', m.vendorName, context),
//         _kv('State', m.state, context),
//         _kv('District', m.district, context),
//       ],
//     );
//   }
// }

// // -----------------------------------------------------------------------------
// // Pagination (same inline widget used on dashboard)
// // -----------------------------------------------------------------------------
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
//           style:
//               TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 13),
//           child:
//               IconTheme.merge(data: IconThemeData(color: fg, size: 18), child: child),
//         ),
//       );

//       return onTap == null
//           ? Opacity(opacity: 0.5, child: content)
//           : InkWell(
//               onTap: onTap, borderRadius: BorderRadius.circular(10), child: content);
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
//                     items: options
//                         .map((n) =>
//                             DropdownMenuItem(value: n, child: Text('$n')))
//                         .toList(),
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


// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';

// class ViewUsersScreen extends StatefulWidget {
//   const ViewUsersScreen({super.key});
//   @override
//   State<ViewUsersScreen> createState() => _ViewUsersScreenState();
// }

// class _ViewUsersScreenState extends State<ViewUsersScreen> {
//   int _selectedTab = 0; // bottom nav

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
//   late List<bool> _isSelected =
//       List<bool>.generate(_segments.length, (i) => i == 0);
//   UserKind _currentKind = UserKind.pm;

//   void _selectKind(int idx) {
//     setState(() {
//       for (var i = 0; i < _isSelected.length; i++) {
//         _isSelected[i] = i == idx;
//       }
//       _currentKind = UserKind.values[idx];
//     });
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
//     (i) => BDM(
//       'BDM #$i',
//       'bdm$i@atlas.com',
//       '98xxx${(100 + i).toString()}',
//       'NPCI',
//     ),
//   );

//   final List<NOC> nocList = List<NOC>.generate(
//     12,
//     (i) => NOC(
//       'NOC #$i',
//       'noc$i@atlas.com',
//       '98xxx${(200 + i)}',
//       'NPCI',
//     ),
//   );

//   final List<SCM> scmList = List<SCM>.generate(
//     10,
//     (i) => SCM(
//       'SCM #$i',
//       'scm$i@atlas.com',
//       '98xxx${(300 + i)}',
//       'NPCI',
//     ),
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
//     (i) => Customer(
//       'Customer #$i',
//       'customer$i@atlas.com',
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       // AppBar with theme toggle + profile (same as Dashboard)
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
//             Navigator.of(context).push(
//               MaterialPageRoute(builder: (_) => const ProfileScreen()),
//             );
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
//       currentIndex: _selectedTab,
//       onTabChanged: (i) => setState(() => _selectedTab = i),
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
//                 fillColor: Theme.of(context).brightness == Brightness.light
//                     ? Colors.black12
//                     : AppTheme.accentColor.withOpacity(0.18),
//                 selectedColor: Theme.of(context).brightness == Brightness.light
//                     ? Colors.black
//                     : AppTheme.accentColor,
//                 color: cs.onSurfaceVariant,
//                 children: _segments
//                     .map(
//                       (s) => Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 12),
//                         child: Text(
//                           s,
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                       ),
//                     )
//                     .toList(),
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

//   // Dashboard-style 2-column card for each kind
//   Widget _buildCardFor(dynamic data) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     Color labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     Color valueColor = isLight ? Colors.black : cs.onSurface;

//     String titleLeft = '';
//     String titleRight = '';

//     List<Widget> left = [];
//     List<Widget> right = [];

//     if (data is PM) {
//       titleLeft = data.name;
//       titleRight = 'Project Manager';
//       left = [
//         _info('Email', data.email, labelColor, valueColor),
//         _info('Contact', data.contact, labelColor, valueColor),
//         _info('Project', data.project, labelColor, valueColor),
//         _info('Site', data.site, labelColor, valueColor),
//       ];
//       right = const [];
//     } else if (data is BDM) {
//       titleLeft = data.name;
//       titleRight = 'Business Development Manager';
//       left = [
//         _info('Email', data.email, labelColor, valueColor),
//         _info('Contact', data.contact, labelColor, valueColor),
//       ];
//       right = [
//         _info('Project', data.project, labelColor, valueColor),
//       ];
//     } else if (data is NOC) {
//       titleLeft = data.name;
//       titleRight = 'NOC Engineer';
//       left = [
//         _info('Email', data.email, labelColor, valueColor),
//         _info('Contact', data.contact, labelColor, valueColor),
//       ];
//       right = [
//         _info('Project', data.project, labelColor, valueColor),
//       ];
//     } else if (data is SCM) {
//       titleLeft = data.name;
//       titleRight = 'Supply Chain Manager';
//       left = [
//         _info('Email', data.email, labelColor, valueColor),
//         _info('Contact', data.contact, labelColor, valueColor),
//       ];
//       right = [
//         _info('Project', data.project, labelColor, valueColor),
//       ];
//     } else if (data is FEVendor) {
//       titleLeft = data.name;
//       titleRight = 'Field Engineer / Vendor';
//       left = [
//         _info('Email', data.email, labelColor, valueColor),
//         _info('Contact', data.contact, labelColor, valueColor),
//         _info('Project', data.project, labelColor, valueColor),
//         _info('Site', data.site, labelColor, valueColor),
//       ];
//       right = [
//         _info('Zone', data.zone, labelColor, valueColor),
//         _info('Vendor Name', data.vendorName, labelColor, valueColor),
//         _info('State', data.state, labelColor, valueColor),
//         _info('District', data.district, labelColor, valueColor),
//       ];
//     } else if (data is UserAcc) {
//       titleLeft = data.username;
//       titleRight = data.role;
//       left = [
//         _info('Email', data.email, labelColor, valueColor),
//       ];
//       right = const [];
//     } else if (data is Customer) {
//       titleLeft = data.name;
//       titleRight = 'Customer';
//       left = [
//         _info('Email', data.email, labelColor, valueColor),
//       ];
//       right = const [];
//     }

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

//           // Two columns like dashboard
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(child: Column(children: left)),
//               const SizedBox(width: 16),
//               Expanded(child: Column(children: right)),
//             ],
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
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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

//   Widget _info(
//       String label, String value, Color labelColor, Color valueColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$label: ',
//           style: TextStyle(color: labelColor, fontSize: 11),
//           children: [
//             TextSpan(
//               text: value,
//               style: TextStyle(color: valueColor, fontSize: 11),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ---------- Models (no underscores) ----------
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




import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({super.key});
  @override
  State<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  int _selectedTab = 0; // bottom nav

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
  late List<bool> _isSelected =
      List<bool>.generate(_segments.length, (i) => i == 0);
  UserKind _currentKind = UserKind.pm;

  void _selectKind(int idx) {
    setState(() {
      for (var i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == idx;
      }
      _currentKind = UserKind.values[idx];
    });
  }

  // ---------------- Sample data ----------------
  final List<PM> pmList = List<PM>.generate(
    16,
    (i) => PM(
      'PM #$i',
      'pm$i@atlas.com',
      '98xxx${i.toString().padLeft(3, '0')}',
      'NPCI',
      'Site ${i.toString().padLeft(3, '0')}',
    ),
  );

  final List<BDM> bdmList = List<BDM>.generate(
    14,
    (i) => BDM(
      'BDM #$i',
      'bdm$i@atlas.com',
      '98xxx${(100 + i)}',
      'NPCI',
    ),
  );

  final List<NOC> nocList = List<NOC>.generate(
    12,
    (i) => NOC(
      'NOC #$i',
      'noc$i@atlas.com',
      '98xxx${(200 + i)}',
      'NPCI',
    ),
  );

  final List<SCM> scmList = List<SCM>.generate(
    10,
    (i) => SCM(
      'SCM #$i',
      'scm$i@atlas.com',
      '98xxx${(300 + i)}',
      'NPCI',
    ),
  );

  final List<FEVendor> feList = List<FEVendor>.generate(
    18,
    (i) => FEVendor(
      'FE/Vendor #$i',
      'fe$i@atlas.com',
      '98xxx${(400 + i)}',
      'NPCI',
      'Site ${i.toString().padLeft(3, '0')}',
      ['North', 'East', 'South', 'West'][i % 4],
      'Vendor ${String.fromCharCode(65 + (i % 26))}',
      'Maharashtra',
      ['Thane', 'Pune', 'Mumbai', 'Nagpur'][i % 4],
    ),
  );

  final List<UserAcc> userList = List<UserAcc>.generate(
    8,
    (i) => UserAcc(
      'user$i',
      ['Admin', 'Project Manager', 'Viewer'][i % 3],
      'user$i@atlas.com',
    ),
  );

  final List<Customer> customerList = List<Customer>.generate(
    6,
    (i) => Customer(
      'Customer #$i',
      'customer$i@atlas.com',
    ),
  );

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      // AppBar with theme toggle + profile (same as Dashboard)
      title: 'All Users',
      centerTitle: true,
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
        IconButton(
          tooltip: 'Profile',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ProfileScreen()),
            );
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
      currentIndex: _selectedTab,
      onTabChanged: (i) => setState(() => _selectedTab = i),
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
                fillColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.black12
                    : AppTheme.accentColor.withOpacity(0.18),
                selectedColor: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : AppTheme.accentColor,
                color: cs.onSurfaceVariant,
                children: _segments
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
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 12 + 58),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: _currentItems.length,
                itemBuilder: (context, i) {
                  final item = _currentItems[i];
                  return _buildCardFor(item);
                },
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
        return pmList;
      case UserKind.bdm:
        return bdmList;
      case UserKind.noc:
        return nocList;
      case UserKind.scm:
        return scmList;
      case UserKind.fevendor:
        return feList;
      case UserKind.users:
        return userList;
      case UserKind.customer:
        return customerList;
    }
  }

  // Fixed label column width (so everything aligns like the dashboard)
  static const double _labelW = 92;

  Widget _kv(String label, String value, Color labelColor, Color valueColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _labelW,
            child: Text('$label:',
                style: TextStyle(color: labelColor, fontSize: 11)),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: valueColor, fontSize: 11),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // Dashboard-style 2-column card for each kind
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
        _kv('Project', data.project, labelColor, valueColor),
        _kv('Site', data.site, labelColor, valueColor),
      ];
      right = const [];
    } else if (data is BDM) {
      titleLeft = data.name;
      titleRight = 'Business Development Manager';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
      ];
      right = [
        _kv('Project', data.project, labelColor, valueColor),
      ];
    } else if (data is NOC) {
      titleLeft = data.name;
      titleRight = 'NOC Engineer';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
      ];
      right = [
        _kv('Project', data.project, labelColor, valueColor),
      ];
    } else if (data is SCM) {
      titleLeft = data.name;
      titleRight = 'Supply Chain Manager';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
      ];
      right = [
        _kv('Project', data.project, labelColor, valueColor),
      ];
    } else if (data is FEVendor) {
      titleLeft = data.name;
      titleRight = 'Field Engineer / Vendor';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
        _kv('Project', data.project, labelColor, valueColor),
        _kv('Site', data.site, labelColor, valueColor),
      ];
      right = [
        _kv('Zone', data.zone, labelColor, valueColor),
        _kv('Vendor Name', data.vendorName, labelColor, valueColor),
        _kv('State', data.state, labelColor, valueColor),
        _kv('District', data.district, labelColor, valueColor),
      ];
    } else if (data is UserAcc) {
      titleLeft = data.username;
      titleRight = data.role;
      left = [
        _kv('Email', data.email, labelColor, valueColor),
      ];
      right = const [];
    } else if (data is Customer) {
      titleLeft = data.name;
      titleRight = 'Customer';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
      ];
      right = const [];
    }

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

          // Two columns like dashboard
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(children: left)),
              const SizedBox(width: 16),
              Expanded(child: Column(children: right)),
            ],
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {},
              child: const Text(
                'Update',
                style: TextStyle(color: Color(0xFF000000), fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Models (no underscores) ----------
enum UserKind { pm, bdm, noc, scm, fevendor, users, customer }

class PM {
  final String name, email, contact, project, site;
  PM(this.name, this.email, this.contact, this.project, this.site);
}

class BDM {
  final String name, email, contact, project;
  BDM(this.name, this.email, this.contact, this.project);
}

class NOC {
  final String name, email, contact, project;
  NOC(this.name, this.email, this.contact, this.project);
}

class SCM {
  final String name, email, contact, project;
  SCM(this.name, this.email, this.contact, this.project);
}

class FEVendor {
  final String name,
      email,
      contact,
      project,
      site,
      zone,
      vendorName,
      state,
      district;
  FEVendor(
    this.name,
    this.email,
    this.contact,
    this.project,
    this.site,
    this.zone,
    this.vendorName,
    this.state,
    this.district,
  );
}

class UserAcc {
  final String username, role, email;
  UserAcc(this.username, this.role, this.email);
}

class Customer {
  final String name, email;
  Customer(this.name, this.email);
}

