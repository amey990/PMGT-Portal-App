// import 'package:flutter/material.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';
// import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;

// class AccountsRaisePaScreen extends StatefulWidget {
//   const AccountsRaisePaScreen({super.key});

//   @override
//   State<AccountsRaisePaScreen> createState() => _AccountsRaisePaScreenState();
// }

// class _AccountsRaisePaScreenState extends State<AccountsRaisePaScreen> {
//   String _query = '';

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
//       currentIndex: 0,
//       onTabChanged: (_) {},
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
//         padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
//         children: [
//           _SearchField(onChanged: (v) => setState(() => _query = v)),
//           const SizedBox(height: 12),
//           ..._filtered.map((e) => _PaCard(item: e)),
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
//   const _PaCard({required this.item});

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
//                         onPressed: () {
//                           // TODO: Generate PA flow
//                         },
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

// // ---------- model ----------

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



// lib/ui/screens/accounts/accounts_raise_pa_screen.dart
import 'package:flutter/material.dart';
import 'package:pmgt/core/theme.dart';
import 'package:pmgt/core/theme_controller.dart';
import 'package:pmgt/ui/screens/accounts/generate_pa_screen.dart';
import 'package:pmgt/ui/screens/profile/profile_screen.dart';
import 'package:pmgt/ui/utils/responsive.dart';
import 'package:pmgt/ui/widgets/app_drawer.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';

class AccountsRaisePaScreen extends StatefulWidget {
  const AccountsRaisePaScreen({super.key, required this.project});

  final dynamic project; // _AccProject from project-list; using dynamic to avoid circular import

  @override
  State<AccountsRaisePaScreen> createState() => _AccountsRaisePaScreenState();
}

class _AccountsRaisePaScreenState extends State<AccountsRaisePaScreen> {
  // Mock PA-able activities for the chosen project
  final List<_PaItem> _items = const [
    _PaItem(
      projectName: 'Airtel CEDGE NAC',
      completionDate: '22/09/2025',
      createdDate: '20/09/2025',
      activity: 'New Installation',
      siteName: 'TURKAPALLY',
      siteCode: '186',
      city: 'Hyderabad',
      district: 'Medchal',
      state: 'Telangana',
      vendor: 'CSPL',
      pm: 'Sandeep K',
      feName: 'Sandeep K',
      feMobile: '99999 00000',
      status: 'Ready',
    ),
    _PaItem(
      projectName: 'Airtel CEDGE NAC',
      completionDate: '24/09/2025',
      createdDate: '22/09/2025',
      activity: 'Site Survey',
      siteName: 'Hitech City',
      siteCode: '201',
      city: 'Hyderabad',
      district: 'Serilingampally',
      state: 'Telangana',
      vendor: 'CSPL',
      pm: 'Aniket',
      feName: 'Rahul S',
      feMobile: '88888 11111',
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Raise PA',
      centerTitle: true,
      drawerMode: DrawerMode.accounts,
      currentIndex: 0,
      onTabChanged: (_) {},
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
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ProfileScreen()),
          ),
          icon: ClipOval(
            child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
        children: _items
            .map(
              (e) => _PaCard(
                item: e,
                onGenerate: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => GeneratePaScreen(item: e),
                    ),
                  );
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PaCard extends StatelessWidget {
  final _PaItem item;
  final VoidCallback onGenerate;
  const _PaCard({required this.item, required this.onGenerate});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

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
          Row(
            children: [
              Expanded(
                child: Text(
                  item.projectName,
                  style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              Text(item.completionDate,
                  style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w700, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 12),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEFT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('Created Date', item.createdDate, cs),
                    _kv('Activity', item.activity, cs),
                    _kv('Site name', item.siteName, cs),
                    _kv('Site code', item.siteCode, cs),
                    _kv('City', item.city, cs),
                    _kv('District', item.district, cs),
                    _kv('State', item.state, cs),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // RIGHT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _kv('Vendor', item.vendor, cs),
                    _kv('PM', item.pm, cs),
                    _kv('Vendor/FE name', item.feName, cs),
                    _kv('FE/Vendor Mobile', item.feMobile, cs),
                    _kv('Status', item.status, cs),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          side: const BorderSide(color: AppTheme.accentColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        ),
                        onPressed: onGenerate,
                        child: const Text('Generate PA', style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _kv(String k, String v, ColorScheme cs) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: RichText(
          text: TextSpan(
            text: '$k: ',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
            children: [TextSpan(text: v, style: TextStyle(color: cs.onSurface, fontSize: 12))],
          ),
        ),
      );
}

class _PaItem {
  final String projectName;
  final String completionDate;
  final String createdDate;
  final String activity;
  final String siteName;
  final String siteCode;
  final String city;
  final String district;
  final String state;
  final String vendor;
  final String pm;
  final String feName;
  final String feMobile;
  final String status;

  const _PaItem({
    required this.projectName,
    required this.completionDate,
    required this.createdDate,
    required this.activity,
    required this.siteName,
    required this.siteCode,
    required this.city,
    required this.district,
    required this.state,
    required this.vendor,
    required this.pm,
    required this.feName,
    required this.feMobile,
    required this.status,
  });
}

