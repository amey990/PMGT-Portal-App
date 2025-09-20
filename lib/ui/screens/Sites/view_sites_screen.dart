// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';

// class ViewSitesScreen extends StatefulWidget {
//   const ViewSitesScreen({super.key});

//   @override
//   State<ViewSitesScreen> createState() => _ViewSitesScreenState();
// }

// class _ViewSitesScreenState extends State<ViewSitesScreen> {
//   // search + filter
//   String _search = '';
//   String _selectedProject = 'All';

//   final List<String> _projects = const [
//     'All',
//     'NPCI',
//     'TelstraApari',
//     'BPCL Aruba WIFI',
//   ];

//   // sample data
//   final List<_Site> _allSites = List.generate(
//     30,
//     (i) => _Site(
//       project: (i % 3 == 0)
//           ? 'NPCI'
//           : (i % 3 == 1)
//               ? 'TelstraApari'
//               : 'BPCL Aruba WIFI',
//       status: (i % 2 == 0) ? 'Active' : 'Inactive',
//       siteName: 'Site ${(i + 1).toString().padLeft(3, '0')}',
//       siteId: (i + 1).toString().padLeft(3, '0'),
//       address: 'XYZ Street, Some Area',
//       pincode: '400${(i % 90).toString().padLeft(2, '0')}',
//       poc: (i % 2 == 0) ? 'Amey' : 'Priya',
//       state: 'Maharashtra',
//       district: (i % 2 == 0) ? 'Thane' : 'Pune',
//       city: (i % 2 == 0) ? 'Panvel' : 'Pune',
//     ),
//   );

//   // pagination (reuse pattern used earlier)
//   int _currentPage = 1;
//   final List<int> _perPageOptions = const [5, 10, 15, 20];
//   int _perPage = 10;

//   List<_Site> get _filtered {
//     final q = _search.trim().toLowerCase();
//     return _allSites.where((s) {
//       final okProject = _selectedProject == 'All' || s.project == _selectedProject;
//       final okSearch = q.isEmpty ||
//           s.project.toLowerCase().contains(q) ||
//           s.siteName.toLowerCase().contains(q) ||
//           s.siteId.toLowerCase().contains(q) ||
//           s.city.toLowerCase().contains(q);
//       return okProject && okSearch;
//     }).toList();
//   }

//   int get _totalPages {
//     final len = _filtered.length;
//     if (len == 0) return 1;
//     return (len + _perPage - 1) ~/ _perPage;
//   }

//   List<_Site> get _paged {
//     final list = _filtered;
//     if (list.isEmpty) return const [];
//     final start = (_currentPage - 1) * _perPage;
//     final end = min(start + _perPage, list.length);
//     if (start >= list.length) return const [];
//     return list.sublist(start, end);
//   }

//   void _goToPage(int p) => setState(() {
//         _currentPage = p.clamp(1, _totalPages);
//       });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final pad = responsivePadding(context);

//     return MainLayout(
//       title: 'All Sites',
//       centerTitle: true,
//       currentIndex: 0,
//       onTabChanged: (_) {},
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: Padding(
//         padding: pad.copyWith(top: 2),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Search
//             const SizedBox(height: 6),
//             SizedBox(
//               height: 40,
//               child: TextField(
//                 onChanged: (v) => setState(() {
//                   _search = v;
//                   _currentPage = 1;
//                 }),
//                 style: TextStyle(color: cs.onSurface, fontSize: 13),
//                 decoration: InputDecoration(
//                   hintText: 'Search…',
//                   hintStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 13),
//                   prefixIcon:
//                       Icon(Icons.search, color: cs.onSurfaceVariant, size: 20),
//                   filled: true,
//                   fillColor: cs.surfaceContainerHighest,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 8),
//             Divider(color: cs.outlineVariant),
//             const SizedBox(height: 8),

//             // Project dropdown + Export button
//             Row(
//               children: [
//                 Expanded(
//                   child: _Dropdown<String>(
//                     label: 'Project',
//                     value: _selectedProject,
//                     items: _projects,
//                     onChanged: (v) => setState(() {
//                       _selectedProject = v ?? 'All';
//                       _currentPage = 1;
//                     }),
//                   ),
//                 ),
//                 const SizedBox(width: 8),
//                 _ExportButton(onPressed: () {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text('Export started…')),
//                   );
//                 }),
//               ],
//             ),
//             const SizedBox(height: 12),

//             // List + inline pagination
//             Expanded(
//               child: ListView.separated(
//                 padding: const EdgeInsets.only(bottom: 12 + 58),
//                 itemCount: _paged.length + 1,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (context, i) {
//                   if (i < _paged.length) {
//                     return _SiteCard(site: _paged[i]);
//                   }
//                   // pagination row
//                   return Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                     child: Row(
//                       children: [
//                         const SizedBox(width: 80),
//                         Expanded(
//                           child: Center(
//                             child: _PaginationBar(
//                               currentPage: _currentPage,
//                               totalPages: _totalPages,
//                               onPrev: () => _goToPage(_currentPage - 1),
//                               onNext: () => _goToPage(_currentPage + 1),
//                               onPageSelected: _goToPage,
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: 34,
//                           padding: const EdgeInsets.symmetric(horizontal: 8),
//                           decoration: BoxDecoration(
//                             color: cs.surfaceContainerHighest,
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(color: cs.outlineVariant),
//                           ),
//                           child: DropdownButtonHideUnderline(
//                             child: DropdownButton<int>(
//                               value: _perPage,
//                               dropdownColor:
//                                   Theme.of(context).scaffoldBackgroundColor,
//                               style:
//                                   TextStyle(fontSize: 12, color: cs.onSurface),
//                               items: _perPageOptions
//                                   .map((n) => DropdownMenuItem(
//                                         value: n,
//                                         child: Text('$n'),
//                                       ))
//                                   .toList(),
//                               onChanged: (v) {
//                                 if (v != null) {
//                                   setState(() {
//                                     _perPage = v;
//                                     _currentPage = 1;
//                                   });
//                                 }
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
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

// // -------- UI bits --------

// class _ExportButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   const _ExportButton({required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: AppTheme.accentColor,
//         foregroundColor: Colors.black,
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       icon: const Icon(Icons.download, size: 18),
//       label: const Text(
//         'Export',
//         style: TextStyle(fontWeight: FontWeight.w800),
//       ),
//     );
//   }
// }

// class _SiteCard extends StatelessWidget {
//   final _Site site;
//   const _SiteCard({required this.site});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     final label = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final value = isLight ? Colors.black : cs.onSurface;

//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
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
//                     color: value, fontWeight: FontWeight.w800, fontSize: 14),
//               ),
//               Text(
//                 'Status : ${site.status}',
//                 style: TextStyle(
//                     color: value, fontWeight: FontWeight.w700, fontSize: 14),
//               ),
//             ],
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
//                     _kv('Site Name', site.siteName, label, value),
//                     _kv('Site ID', site.siteId, label, value),
//                     _kv('Address', site.address, label, value),
//                     _kv('Pincode', site.pincode, label, value),
//                   ],
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _kv('POC', site.poc, label, value),
//                     _kv('State', site.state, label, value),
//                     _kv('District', site.district, label, value),
//                     _kv('City', site.city, label, value),
//                   ],
//                 ),
//               ),
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
//               onPressed: () {
//                 // TODO: update site flow
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

//   Widget _kv(String k, String v, Color kColor, Color vColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: RichText(
//         text: TextSpan(
//           text: '$k: ',
//           style: TextStyle(color: kColor, fontSize: 11),
//           children: [
//             TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 11)),
//           ],
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
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         Text(label,
//             style: TextStyle(
//                 fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
//         const SizedBox(height: 6),
//         Container(
//           height: 34,
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 8),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton<T>(
//               value: value,
//               isExpanded: true,
//               iconEnabledColor: cs.onSurfaceVariant,
//               dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//               style: TextStyle(color: cs.onSurface, fontSize: 12),
//               items: items
//                   .map((e) =>
//                       DropdownMenuItem<T>(value: e, child: Text('$e')))
//                   .toList(),
//               onChanged: onChanged,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _PaginationBar extends StatelessWidget {
//   final int currentPage;
//   final int totalPages;
//   final ValueChanged<int> onPageSelected;
//   final VoidCallback onPrev;
//   final VoidCallback onNext;

//   const _PaginationBar({
//     required this.currentPage,
//     required this.totalPages,
//     required this.onPageSelected,
//     required this.onPrev,
//     required this.onNext,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     List<int?> pages = _buildPages(currentPage, totalPages);

//     Widget pill({
//       required Widget child,
//       required bool selected,
//       VoidCallback? onTap,
//       double width = 36,
//     }) {
//       final bg = selected ? Colors.black : cs.surfaceContainerHighest;
//       final fg = selected ? Colors.white : cs.onSurface;

//       final content = Container(
//         width: width,
//         height: 32,
//         margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: bg,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         child: DefaultTextStyle(
//           style: TextStyle(
//             color: fg,
//             fontWeight: FontWeight.w600,
//             fontSize: 12,
//           ),
//           child: IconTheme.merge(
//             data: IconThemeData(color: fg, size: 16),
//             child: child,
//           ),
//         ),
//       );

//       return onTap == null
//           ? Opacity(opacity: 0.5, child: content)
//           : InkWell(
//               onTap: onTap,
//               borderRadius: BorderRadius.circular(8),
//               child: content,
//             );
//     }

//     final hasPrev = currentPage > 1;
//     final hasNext = currentPage < totalPages;

//     return Center(
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 560),
//         child: Wrap(
//           alignment: WrapAlignment.center,
//           crossAxisAlignment: WrapCrossAlignment.center,
//           children: [
//             pill(
//               child: const Icon(Icons.chevron_left),
//               selected: false,
//               onTap: hasPrev ? onPrev : null,
//             ),
//             ...pages.map((p) {
//               if (p == null) {
//                 return pill(
//                   child: const Text('…'),
//                   selected: false,
//                   onTap: null,
//                   width: 32,
//                 );
//               }
//               final sel = p == currentPage;
//               return pill(
//                 child: Text('$p'),
//                 selected: sel,
//                 onTap: () => onPageSelected(p),
//               );
//             }),
//             pill(
//               child: const Icon(Icons.chevron_right),
//               selected: false,
//               onTap: hasNext ? onNext : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<int?> _buildPages(int current, int total) {
//     if (total <= 6) return List<int>.generate(total, (i) => i + 1);
//     final List<int?> result = [1];
//     int start = (current - 1).clamp(2, total - 3);
//     int end = (current + 1).clamp(4, total - 1);
//     if (start > 2) result.add(null);
//     for (int i = start; i <= end; i++) result.add(i);
//     if (end < total - 1) result.add(null);
//     result.add(total);
//     return result;
//   }
// }

// class _Site {
//   final String project, status, siteName, siteId, address, pincode, poc, state, district, city;
//   const _Site({
//     required this.project,
//     required this.status,
//     required this.siteName,
//     required this.siteId,
//     required this.address,
//     required this.pincode,
//     required this.poc,
//     required this.state,
//     required this.district,
//     required this.city,
//   });
// }

// lib/ui/screens/sites/all_sites_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

class AllSitesScreen extends StatefulWidget {
  const AllSitesScreen({super.key});

  @override
  State<AllSitesScreen> createState() => _AllSitesScreenState();
}

class _AllSitesScreenState extends State<AllSitesScreen> {
  // --- filters/search/pagination ---
  final List<String> _projects = const [
    'All',
    'NPCI',
    'TelstraApari',
    'BPCL Aruba WIFI',
  ];
  String _selectedProject = 'All';

  String _search = '';

  int _currentPage = 1;
  int _perPage = 10;
  final List<int> _perPageOptions = const [5, 10, 15, 20];

  // --- sample data (fake) ---
  final List<_Site> _sites = List.generate(
    30,
    (i) => _Site(
      project:
          i % 3 == 0
              ? 'NPCI'
              : (i % 3 == 1 ? 'TelstraApari' : 'BPCL Aruba WIFI'),
      status: i.isEven ? 'Active' : 'Inactive',
      siteName: 'Site ${(i + 1).toString().padLeft(3, '0')}',
      siteId: (i + 1).toString().padLeft(3, '0'),
      address: 'XYZ Street, Some Area',
      pincode: '400${(i % 10).toString().padLeft(2, '0')}',
      poc: i.isEven ? 'Amey' : 'Priya',
      state: 'Maharashtra',
      district: i.isEven ? 'Thane' : 'Pune',
      city: i.isEven ? 'Panvel' : 'Pune',
    ),
  );

  // --- helpers ---
  List<_Site> get _filtered {
    final q = _search.trim().toLowerCase();
    return _sites.where((s) {
      final okProject =
          _selectedProject == 'All' || s.project == _selectedProject;
      final okSearch =
          q.isEmpty ||
          s.project.toLowerCase().contains(q) ||
          s.siteName.toLowerCase().contains(q) ||
          s.siteId.toLowerCase().contains(q) ||
          s.city.toLowerCase().contains(q) ||
          s.district.toLowerCase().contains(q);
      return okProject && okSearch;
    }).toList();
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

  void _goToPage(int p) => setState(() {
    _currentPage = p.clamp(1, _totalPages);
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'All Sites',
      centerTitle: true,
      // AppBar actions (theme + profile)
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
      safeArea: false,
      reserveBottomPadding: true,
      body: Padding(
        padding: responsivePadding(context).copyWith(top: 6, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search
            const SizedBox(height: 4),
            _SearchField(
              initial: _search,
              onChanged: (v) {
                setState(() {
                  _search = v;
                  _currentPage = 1;
                });
              },
            ),
            const SizedBox(height: 8),
            Divider(color: cs.outlineVariant),
            const SizedBox(height: 8),

            // Project dropdown + Export (aligned, same height)
            Row(
              children: [
                Expanded(
                  child: _Dropdown<String>(
                    hint: 'Select project',
                    value: _selectedProject,
                    items: _projects,
                    onChanged:
                        (v) => setState(() {
                          _selectedProject = v ?? 'All';
                          _currentPage = 1;
                        }),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  height: 34,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Export handler
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Export started...')),
                      );
                    },
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

            const SizedBox(height: 12),

            // List + pagination footer (like Dashboard)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 12 + 58),
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemCount: _paged.length + 1,
                itemBuilder: (context, i) {
                  if (i < _paged.length) return _SiteCard(site: _paged[i]);
                  // inline pagination row
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
    );
  }
}

/* ------------------------ Widgets / helpers ------------------------ */

class _SiteCard extends StatelessWidget {
  final _Site site;
  const _SiteCard({required this.site});

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
                'Status : ${site.status}',
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
                    _kv('Address', site.address, labelColor, valueColor),
                    _kv('Pincode', site.pincode, labelColor, valueColor),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('POC', site.poc, labelColor, valueColor),
                    _kv('State', site.state, labelColor, valueColor),
                    _kv('District', site.district, labelColor, valueColor),
                    _kv('City', site.city, labelColor, valueColor),
                  ],
                ),
              ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
              ),
              onPressed: () {},
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

  Widget _kv(String k, String v, Color kColor, Color vColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$k: ',
          style: TextStyle(color: kColor, fontSize: 11),
          children: [
            TextSpan(text: v, style: TextStyle(color: vColor, fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final String initial;
  final ValueChanged<String> onChanged;
  const _SearchField({required this.initial, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 34,
      child: TextField(
        controller: TextEditingController(text: initial),
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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
        ),
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final String hint;
  final T value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  const _Dropdown({
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: Theme.of(context).scaffoldBackgroundColor,
          iconEnabledColor: cs.onSurfaceVariant,
          style: TextStyle(color: cs.onSurface, fontSize: 12),
          hint: Text(
            hint,
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          ),
          items:
              items
                  .map((e) => DropdownMenuItem<T>(value: e, child: Text('$e')))
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/* -------- Pagination (copied from Dashboard style) -------- */

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

  final VoidCallback onPrev; // unused but kept for API parity
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

/* ------------------------ models ------------------------ */

class _Site {
  final String project,
      status,
      siteName,
      siteId,
      address,
      pincode,
      poc,
      state,
      district,
      city;
  _Site({
    required this.project,
    required this.status,
    required this.siteName,
    required this.siteId,
    required this.address,
    required this.pincode,
    required this.poc,
    required this.state,
    required this.district,
    required this.city,
  });
}
