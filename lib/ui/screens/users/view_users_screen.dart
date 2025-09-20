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
//   // Small, multi-option toggle
  
//   static const _segments = [
//     'PM',
//     'BDM',
//     'NOC',
//     'SCM',
//     'FE/Vendor',
//     'Users',
//     'Customer',
//   ];
//   int _segmentIndex = 0;

//   // ------- Sample data sets (mock) -------
//   final _pmList = List.generate(
//     6,
//     (i) => {
//       'name': 'PM #$i',
//       'role': 'Project Manager',
//       'email': 'pm$i@atlas.com',
//       'projects': 'NPCI, Telstra',
//       'contact': '9xxxxx${i}12',
//     },
//   );

//   final _bdmList = List.generate(
//     6,
//     (i) => {
//       'name': 'BDM #$i',
//       'role': 'BDM',
//       'email': 'bdm$i@atlas.com',
//       'projects': 'NPCI',
//       'contact': '8xxxxx${i}45',
//     },
//   );

//   final _nocList = List.generate(
//     6,
//     (i) => {
//       'name': 'NOC #$i',
//       'role': 'NOC',
//       'email': 'noc$i@atlas.com',
//       'projects': 'BPCL Aruba WIFI',
//       'contact': '7xxxxx${i}78',
//     },
//   );

//   final _scmList = List.generate(
//     6,
//     (i) => {
//       'name': 'SCM #$i',
//       'role': 'Supply Chain Manager',
//       'email': 'scm$i@atlas.com',
//       'projects': 'TelstraApari',
//       'contact': '9xxxxx${i}90',
//     },
//   );

//   final _feList = List.generate(
//     6,
//     (i) => {
//       'name': 'FE/Vendor #$i',
//       'role': 'Field Engineer / Vendor',
//       'email': 'fe$i@atlas.com',
//       'contact': '98xxx${i}321',
//       'project': 'NPCI',
//       'site': 'Site 00${i + 1}',
//       'zone': i.isEven ? 'West' : 'South',
//       'vendorName': 'Vendor ${String.fromCharCode(65 + i)}',
//       'bankName': 'HDFC',
//       'bankAcc': '1234***${i}890',
//       'ifsc': 'HDFC0001',
//       'pan': 'ABCDE$i',
//       'state': 'Maharashtra',
//       'district': 'Thane',
//     },
//   );

//   final _usersList = List.generate(
//     6,
//     (i) => {
//       'username': 'user_$i',
//       'role': (i % 4 == 0)
//           ? 'Admin'
//           : (i % 4 == 1)
//               ? 'Project Manager'
//               : (i % 4 == 2)
//                   ? 'NOC'
//                   : 'SCM',
//       'email': 'user$i@atlas.com',
//     },
//   );

//   final _customersList = List.generate(
//     6,
//     (i) => {
//       'name': 'Customer #$i',
//       'role': 'Customer',
//       'email': 'customer$i@atlas.com',
//     },
//   );

//   List<Map<String, String>> get _currentData {
//     switch (_segments[_segmentIndex]) {
//       case 'PM':
//         return _pmList.cast<Map<String, String>>();
//       case 'BDM':
//         return _bdmList.cast<Map<String, String>>();
//       case 'NOC':
//         return _nocList.cast<Map<String, String>>();
//       case 'SCM':
//         return _scmList.cast<Map<String, String>>();
//       case 'FE/Vendor':
//         return _feList.cast<Map<String, String>>();
//       case 'Users':
//         return _usersList.cast<Map<String, String>>();
//       case 'Customer':
//         return _customersList.cast<Map<String, String>>();
//       default:
//         return const [];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'All Users',
//       centerTitle: true,
//       currentIndex: 0,
//       onTabChanged: (_) {},
//       safeArea: false,
//       reserveBottomPadding: true,
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
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 10, bottom: 12),
//         children: [
//           _buildTinyToggle(context),

//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 8),

//           // Cards list
//           ..._currentData.map((m) => _UserCard(segment: _segments[_segmentIndex], data: m)),
//           const SizedBox(height: 58), // keep space above bottom nav
//         ],
//       ),
//     );
//   }

//   Widget _buildTinyToggle(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Center(
//       child: ToggleButtons(
//         isSelected: List.generate(_segments.length, (i) => i == _segmentIndex),
//         onPressed: (i) => setState(() => _segmentIndex = i),
//         borderRadius: BorderRadius.circular(8),
//         constraints: const BoxConstraints(minWidth: 70, minHeight: 28),
//         fillColor: AppTheme.accentColor.withOpacity(0.18),
//         selectedBorderColor: AppTheme.accentColor,
//         borderColor: cs.outlineVariant,
//         selectedColor: AppTheme.accentColor,
//         color: cs.onSurfaceVariant,
//         children: _segments
//             .map(
//               (s) => Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8),
//                 child: Text(
//                   s,
//                   style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
//                 ),
//               ),
//             )
//             .toList(),
//       ),
//     );
//   }
// }

// class _UserCard extends StatelessWidget {
//   final String segment;
//   final Map<String, String> data;
//   const _UserCard({required this.segment, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final isLight = Theme.of(context).brightness == Brightness.light;

//     final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
//     final valueColor = isLight ? Colors.black : cs.onSurface;

//     // Header texts per segment
//     String titleLeft;
//     String titleRight;

//     switch (segment) {
//       case 'PM':
//       case 'BDM':
//       case 'NOC':
//       case 'SCM':
//         titleLeft = data['name'] ?? '';
//         titleRight = data['role'] ?? '';
//         break;
//       case 'FE/Vendor':
//         titleLeft = data['name'] ?? '';
//         titleRight = data['role'] ?? '';
//         break;
//       case 'Users':
//         titleLeft = data['username'] ?? '';
//         titleRight = data['role'] ?? '';
//         break;
//       case 'Customer':
//         titleLeft = data['name'] ?? '';
//         titleRight = data['role'] ?? '';
//         break;
//       default:
//         titleLeft = '';
//         titleRight = '';
//     }

//     // Build fields per segment
//     final leftChildren = <Widget>[];
//     final rightChildren = <Widget>[];

//     void addRowLeft(String l, String? v) =>
//         leftChildren.add(_row(l, v ?? '-', labelColor, valueColor));
//     void addRowRight(String l, String? v) =>
//         rightChildren.add(_row(l, v ?? '-', labelColor, valueColor));

//     switch (segment) {
//       case 'PM':
//       case 'BDM':
//       case 'NOC':
//       case 'SCM':
//         addRowLeft('Name', data['name']);
//         addRowLeft('Email', data['email']);
//         addRowLeft('Projects', data['projects']);
//         addRowRight('Role', data['role']);
//         addRowRight('Contact', data['contact']);
//         break;

//       case 'FE/Vendor':
//         addRowLeft('Email', data['email']);
//         addRowLeft('Contact', data['contact']);
//         addRowLeft('Project', data['project']);
//         addRowLeft('Site', data['site']);

//         addRowRight('Zone', data['zone']);
//         addRowRight('Vendor Name', data['vendorName']);
//         addRowRight('State', data['state']);
//         addRowRight('District', data['district']);
//         break;

//       case 'Users':
//         addRowLeft('Username', data['username']);
//         addRowLeft('Email', data['email']);
//         addRowRight('Role', data['role']);
//         break;

//       case 'Customer':
//         addRowLeft('Customer Name', data['name']);
//         addRowLeft('Email', data['email']);
//         addRowRight('Role', data['role']);
//         break;
//     }

//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
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
//                   fontSize: 13,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 12),

//           // Two columns
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: leftChildren)),
//               const SizedBox(width: 16),
//               Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: rightChildren)),
//             ],
//           ),

//           const SizedBox(height: 14),
//           Align(
//             alignment: Alignment.centerRight,
//             child: OutlinedButton(
//               style: OutlinedButton.styleFrom(
//                 backgroundColor: AppTheme.accentColor,
//                 side: const BorderSide(color: AppTheme.accentColor),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//                 padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//               ),
//               onPressed: () {},
//               child: const Text('Update', style: TextStyle(color: Color(0xFF000000), fontSize: 12)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _row(
//     String label,
//     String value,
//     Color labelColor,
//     Color valueColor,
//   ) {
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


// lib/ui/screens/users/view_users_screen.dart
import 'dart:math';
import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

class ViewAllUsersScreen extends StatefulWidget {
  const ViewAllUsersScreen({super.key});

  @override
  State<ViewAllUsersScreen> createState() => _ViewAllUsersScreenState();
}

class _ViewAllUsersScreenState extends State<ViewAllUsersScreen> {
  // ---------------------------------------------------------------------------
  // Toggle (5 segments)
  // ---------------------------------------------------------------------------
  final List<String> _segments = const ['PM', 'BDM', 'NOC', 'SCM', 'FE/Vendor'];
  final List<bool> _isSelected = [true, false, false, false, false];

  UserKind _currentKind = UserKind.pm;

  void _setKind(int index) {
    setState(() {
      for (var i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = (i == index);
      }
      _currentKind = UserKind.values[index];
    });
  }

  // ---------------------------------------------------------------------------
  // Sample typed data for each user type (so there is no List<Map> mismatch)
  // ---------------------------------------------------------------------------

  final List<PM> _pmList = List.generate(
    8,
    (i) => PM(
      name: 'PM #${i + 1}',
      email: 'pm$i@atlas.com',
      contact: '98xxx${(1000 + i).toString().substring(1)}',
      projects: ['NPCI', 'TelstraApari'],
    ),
  );

  final List<BDM> _bdmList = List.generate(
    6,
    (i) => BDM(
      name: 'BDM #${i + 1}',
      email: 'bdm$i@atlas.com',
      contact: '98xxx${(2000 + i).toString().substring(1)}',
      projects: ['NPCI'],
    ),
  );

  final List<NOCUser> _nocList = List.generate(
    6,
    (i) => NOCUser(
      name: 'NOC #${i + 1}',
      email: 'noc$i@atlas.com',
      contact: '98xxx${(3000 + i).toString().substring(1)}',
      projects: ['TelstraApari'],
    ),
  );

  final List<SCM> _scmList = List.generate(
    6,
    (i) => SCM(
      name: 'SCM #${i + 1}',
      email: 'scm$i@atlas.com',
      contact: '98xxx${(4000 + i).toString().substring(1)}',
      projects: ['BPCL Aruba WIFI'],
    ),
  );

  final List<FEVendor> _feList = List.generate(
    12,
    (i) => FEVendor(
      name: 'FE/Vendor #$i',
      role: 'Field Engineer / Vendor',
      email: 'fe$i@atlas.com',
      contact: '98xxx${(5000 + i).toString().substring(1)}',
      project: 'NPCI',
      site: 'Site ${i.toString().padLeft(3, '0')}',
      zone: (['North', 'East', 'South', 'West'])[i % 4],
      vendorName: 'Vendor ${String.fromCharCode(65 + (i % 26))}',
      state: 'Maharashtra',
      district: (i % 2 == 0) ? 'Thane' : 'Pune',
    ),
  );

  // simple paging (shared across tabs just for UX parity)
  int _currentPage = 1;
  final List<int> _perPageOptions = const [5, 10, 15, 20];
  int _perPage = 10;

  List<T> _pageOf<T>(List<T> list) {
    if (list.isEmpty) return const [];
    final start = (_currentPage - 1) * _perPage;
    final end = min(start + _perPage, list.length);
    if (start >= list.length) return const [];
    return list.sublist(start, end);
  }

  int _totalPagesFor(int total) => max(1, (total + _perPage - 1) ~/ _perPage);

  void _goToPage(int p, int totalPages) {
    setState(() => _currentPage = p.clamp(1, totalPages));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final pad = responsivePadding(context);

    // pick source list based on current tab
    late final int totalCount;
    late final List<Widget> cards;

    switch (_currentKind) {
      case UserKind.pm:
        totalCount = _pmList.length;
        cards = _pageOf(_pmList).map((m) => _PMCard(m)).toList();
        break;
      case UserKind.bdm:
        totalCount = _bdmList.length;
        cards = _pageOf(_bdmList).map((m) => _BDMCard(m)).toList();
        break;
      case UserKind.noc:
        totalCount = _nocList.length;
        cards = _pageOf(_nocList).map((m) => _NOCCard(m)).toList();
        break;
      case UserKind.scm:
        totalCount = _scmList.length;
        cards = _pageOf(_scmList).map((m) => _SCMCard(m)).toList();
        break;
      case UserKind.fevendor:
        totalCount = _feList.length;
        cards = _pageOf(_feList).map((m) => _FEVendorCard(m)).toList();
        break;
    }

    final totalPages = _totalPagesFor(totalCount);

    return MainLayout(
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
      currentIndex: 3, // (wherever this tab lives in your bottom nav)
      onTabChanged: (_) {},
      safeArea: false,
      reserveBottomPadding: true,
      body: Padding(
        padding: pad.copyWith(top: 8, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Compact 5-segment toggle (fits on small screens)
            Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: ToggleButtons(
                  isSelected: _isSelected,
                  onPressed: (i) {
                    _setKind(i);
                    _currentPage = 1; // reset paging on tab change
                  },
                  borderRadius: BorderRadius.circular(8),
                  constraints:
                      const BoxConstraints(minWidth: 76, minHeight: 32),
                  fillColor: AppTheme.accentColor.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.20 : .25,
                  ),
                  selectedBorderColor: AppTheme.accentColor,
                  borderColor: cs.outlineVariant,
                  selectedColor: AppTheme.accentColor,
                  color: cs.onSurfaceVariant,
                  children: _segments
                      .map((s) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              s,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w700),
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.only(bottom: 12 + 58),
                itemCount: cards.length + 1,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  if (index < cards.length) return cards[index];
                  // Pagination row (same style as dashboard)
                  return _PaginationInline(
                    currentPage: _currentPage,
                    totalPages: totalPages,
                    onPageSelected: (p) => _goToPage(p, totalPages),
                    onPrev: () => _goToPage(_currentPage - 1, totalPages),
                    onNext: () => _goToPage(_currentPage + 1, totalPages),
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

// -----------------------------------------------------------------------------
// Models
// -----------------------------------------------------------------------------
enum UserKind { pm, bdm, noc, scm, fevendor }

class PM {
  final String name, email, contact;
  final List<String> projects;
  PM({
    required this.name,
    required this.email,
    required this.contact,
    required this.projects,
  });
}

class BDM {
  final String name, email, contact;
  final List<String> projects;
  BDM({
    required this.name,
    required this.email,
    required this.contact,
    required this.projects,
  });
}

class NOCUser {
  final String name, email, contact;
  final List<String> projects;
  NOCUser({
    required this.name,
    required this.email,
    required this.contact,
    required this.projects,
  });
}

class SCM {
  final String name, email, contact;
  final List<String> projects;
  SCM({
    required this.name,
    required this.email,
    required this.contact,
    required this.projects,
  });
}

class FEVendor {
  final String name,
      role,
      email,
      contact,
      project,
      site,
      zone,
      vendorName,
      state,
      district;
  FEVendor({
    required this.name,
    required this.role,
    required this.email,
    required this.contact,
    required this.project,
    required this.site,
    required this.zone,
    required this.vendorName,
    required this.state,
    required this.district,
  });
}

// -----------------------------------------------------------------------------
// Cards
// -----------------------------------------------------------------------------
class _CardShell extends StatelessWidget {
  final String leftTitle;
  final String rightRole;
  final List<Widget> leftChildren;
  final List<Widget> rightChildren;

  const _CardShell({
    required this.leftTitle,
    required this.rightRole,
    required this.leftChildren,
    required this.rightChildren,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                leftTitle,
                style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 14),
              ),
              Text(
                rightRole,
                style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w700,
                    fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 8),
          // Two columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Column(children: leftChildren)),
              const SizedBox(width: 16),
              Expanded(child: Column(children: rightChildren)),
            ],
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                side: const BorderSide(color: AppTheme.accentColor),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              onPressed: () {},
              child: const Text('Update',
                  style: TextStyle(color: Colors.black, fontSize: 12)),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _kv(String k, String v, BuildContext context) {
  final cs = Theme.of(context).colorScheme;
  final label = TextStyle(color: cs.onSurfaceVariant, fontSize: 11);
  final val = TextStyle(color: cs.onSurface, fontSize: 11);
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: RichText(
      text: TextSpan(
        text: '$k: ',
        style: label,
        children: [TextSpan(text: v, style: val)],
      ),
    ),
  );
}

class _PMCard extends StatelessWidget {
  final PM m;
  const _PMCard(this.m);

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      leftTitle: m.name,
      rightRole: 'Project Manager',
      leftChildren: [
        _kv('Email', m.email, context),
        _kv('Contact', m.contact, context),
      ],
      rightChildren: [
        _kv('Projects', m.projects.join(', '), context),
        _kv('Role', 'PM', context),
      ],
    );
  }
}

class _BDMCard extends StatelessWidget {
  final BDM m;
  const _BDMCard(this.m);

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      leftTitle: m.name,
      rightRole: 'Business Development Manager',
      leftChildren: [
        _kv('Email', m.email, context),
        _kv('Contact', m.contact, context),
      ],
      rightChildren: [
        _kv('Projects', m.projects.join(', '), context),
        _kv('Role', 'BDM', context),
      ],
    );
  }
}

class _NOCCard extends StatelessWidget {
  final NOCUser m;
  const _NOCCard(this.m);

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      leftTitle: m.name,
      rightRole: 'NOC Engineer',
      leftChildren: [
        _kv('Email', m.email, context),
        _kv('Contact', m.contact, context),
      ],
      rightChildren: [
        _kv('Projects', m.projects.join(', '), context),
        _kv('Role', 'NOC', context),
      ],
    );
  }
}

class _SCMCard extends StatelessWidget {
  final SCM m;
  const _SCMCard(this.m);

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      leftTitle: m.name,
      rightRole: 'Supply Chain Manager',
      leftChildren: [
        _kv('Email', m.email, context),
        _kv('Contact', m.contact, context),
      ],
      rightChildren: [
        _kv('Projects', m.projects.join(', '), context),
        _kv('Role', 'SCM', context),
      ],
    );
  }
}

class _FEVendorCard extends StatelessWidget {
  final FEVendor m;
  const _FEVendorCard(this.m);

  @override
  Widget build(BuildContext context) {
    return _CardShell(
      leftTitle: m.name,
      rightRole: m.role,
      leftChildren: [
        _kv('Email', m.email, context),
        _kv('Contact', m.contact, context),
        _kv('Project', m.project, context),
        _kv('Site', m.site, context),
      ],
      rightChildren: [
        _kv('Zone', m.zone, context),
        _kv('Vendor Name', m.vendorName, context),
        _kv('State', m.state, context),
        _kv('District', m.district, context),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// Pagination (same inline widget used on dashboard)
// -----------------------------------------------------------------------------
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
          style:
              TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 13),
          child:
              IconTheme.merge(data: IconThemeData(color: fg, size: 18), child: child),
        ),
      );

      return onTap == null
          ? Opacity(opacity: 0.5, child: content)
          : InkWell(
              onTap: onTap, borderRadius: BorderRadius.circular(10), child: content);
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
                    items: options
                        .map((n) =>
                            DropdownMenuItem(value: n, child: Text('$n')))
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
