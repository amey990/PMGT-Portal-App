// import 'package:flutter/material.dart';
// import '../../core/theme.dart';
// import '../utils/responsive.dart';
// // add this import near the top
// import '../screens/activities/Create_activity.dart';


// class AppDrawer extends StatefulWidget {
//   const AppDrawer({super.key});

//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   bool _projectsOpen = false;
//   bool _sitesOpen    = false;
//   bool _usersOpen    = false;

//   final List<String> _userSubs = const [
//     'Add PM +',
//     'Add BDM +',
//     'Add NOC +',
//     'Add SCM +',
//     'Add FE/Vendor +',
//     'Add User +',
//     'Add Customer +',
//   ];

//   Widget _buildMainItem({
//     required IconData icon,
//     required String label,
//     required bool isOpen,
//     required VoidCallback onTap,
//   }) {
//     final cs = Theme.of(context).colorScheme;
//     return ListTile(
//       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//       leading: Icon(icon, color: cs.onSurface),
//       title: Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurface)),
//       trailing: Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
//       onTap: onTap,
//     );
//   }

//   Widget _buildSubItem(String label, VoidCallback onTap) {
//     final cs = Theme.of(context).colorScheme;
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16 + 56, top: 8, bottom: 8),
//         child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return Drawer(
//       backgroundColor: cs.surface,
//       child: SafeArea(
//         child: Padding(
//           padding: responsivePadding(context).copyWith(top: 0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               // HEADER
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
//                 child: Row(
//                   children: [
//                     Image.asset('assets/pmgt_logo.png', width: 40, height: 40),
//                     const SizedBox(width: 12),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Atlas',
//                           style: const TextStyle(
//                             fontFamily: 'Sansation',
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ).copyWith(color: cs.onSurface),
//                         ),
//                         const SizedBox(height: 4),
//                         Text(
//                           'Project Management Tool',
//                           style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               // SINGLE DIVIDER
//               Divider(color: cs.outlineVariant),

//               // MENU
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     // Projects
//                     _buildMainItem(
//                       icon: Icons.folder_open,
//                       label: 'Projects',
//                       isOpen: _projectsOpen,
//                       onTap: () => setState(() => _projectsOpen = !_projectsOpen),
//                     ),
//                     if (_projectsOpen) ...[
//                       _buildSubItem('View All Projects', () {/*TODO*/}),
//                       _buildSubItem('Add Project +', () {/*TODO*/}),
//                     ],

//                     // Sites
//                     _buildMainItem(
//                       icon: Icons.location_on,
//                       label: 'Sites',
//                       isOpen: _sitesOpen,
//                       onTap: () => setState(() => _sitesOpen = !_sitesOpen),
//                     ),
//                     if (_sitesOpen) _buildSubItem('View All Sites', () {/*TODO*/}),

                   

//                     ListTile(
//   contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//   leading: Icon(Icons.event_note, color: cs.onSurface),
//   title: Text(
//     'Activities',
//     style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurface),
//   ),
//   onTap: () {
//     Navigator.pop(context); // close the drawer first
//     Navigator.of(context).push(
//       MaterialPageRoute(builder: (_) => const CreateActivityScreen()),
//     );
//   },
// ),

//                     ListTile(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                       leading: Icon(Icons.bar_chart, color: cs.onSurface),
//                       title: Text('Analytics', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurface)),
//                       onTap: () {/*TODO*/},
//                     ),
//                     ListTile(
//                       contentPadding: const EdgeInsets.symmetric(horizontal: 16),
//                       leading: Icon(Icons.notifications, color: cs.onSurface),
//                       title: Text('Reminders', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurface)),
//                       onTap: () {/*TODO*/},
//                     ),

//                     // User Management
//                     _buildMainItem(
//                       icon: Icons.person,
//                       label: 'User Management',
//                       isOpen: _usersOpen,
//                       onTap: () => setState(() => _usersOpen = !_usersOpen),
//                     ),
//                     if (_usersOpen) for (var sub in _userSubs) _buildSubItem(sub, () {/*TODO*/}),
//                   ],
//                 ),
//               ),

//               // SIGN OUT
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.logout, color: AppTheme.accentColor),
//                       onPressed: () {/*TODO*/},
//                     ),
//                     const SizedBox(width: 8),
//                     Text('Sign Out', style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant)),
//                   ],
//                 ),
//               ),

//               // VERSION
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 16),
//                 child: Text(
//                   'Version v1.0.0',
//                   style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../../core/theme.dart';
import '../utils/responsive.dart';
import '../screens/activities/Create_activity.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _projectsOpen = false;
  bool _sitesOpen    = false;
  bool _usersOpen    = false;

  final List<String> _userSubs = const [
    'Add PM +',
    'Add BDM +',
    'Add NOC +',
    'Add SCM +',
    'Add FE/Vendor +',
    'Add User +',
    'Add Customer +',
  ];

  Widget _buildMainItem({
    required IconData icon,
    required String label,
    required bool isOpen,
    required VoidCallback onTap,
  }) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: cs.onSurface),
      title: Text(label, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurface)),
      trailing: Icon(isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: cs.onSurfaceVariant),
      onTap: onTap,
    );
  }

  Widget _buildSubItem(String label, VoidCallback onTap) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16 + 56, top: 8, bottom: 8),
        child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Drawer(
      backgroundColor: cs.surface,
      child: SafeArea(
        child: Padding(
          padding: responsivePadding(context).copyWith(top: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
                child: Row(
                  children: [
                    Image.asset('assets/pmgt_logo.png', width: 40, height: 40),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Atlas',
                          style: const TextStyle(
                            fontFamily: 'Sansation',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ).copyWith(color: cs.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Project Management Tool',
                          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(color: cs.outlineVariant, height: 1),

              // MENU
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _buildMainItem(
                      icon: Icons.folder_open,
                      label: 'Projects',
                      isOpen: _projectsOpen,
                      onTap: () => setState(() => _projectsOpen = !_projectsOpen),
                    ),
                    if (_projectsOpen) ...[
                      _buildSubItem('View All Projects', () {/* TODO */}),
                      _buildSubItem('Add Project +', () {/* TODO */}),
                    ],

                    _buildMainItem(
                      icon: Icons.location_on,
                      label: 'Sites',
                      isOpen: _sitesOpen,
                      onTap: () => setState(() => _sitesOpen = !_sitesOpen),
                    ),
                    if (_sitesOpen) _buildSubItem('View All Sites', () {/* TODO */}),

                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: Icon(Icons.event_note, color: cs.onSurface),
                      title: Text('Activities',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurface)),
                      onTap: () {
                        Navigator.pop(context); // close drawer
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const CreateActivityScreen()));
                      },
                    ),

                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: Icon(Icons.bar_chart, color: cs.onSurface),
                      title: Text('Analytics',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurface)),
                      onTap: () {/* TODO */},
                    ),
                    ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      leading: Icon(Icons.notifications, color: cs.onSurface),
                      title: Text('Reminders',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cs.onSurface)),
                      onTap: () {/* TODO */},
                    ),

                    _buildMainItem(
                      icon: Icons.person,
                      label: 'User Management',
                      isOpen: _usersOpen,
                      onTap: () => setState(() => _usersOpen = !_usersOpen),
                    ),
                    if (_usersOpen) for (var sub in _userSubs) _buildSubItem(sub, () {/* TODO */}),
                  ],
                ),
              ),

              // SIGN OUT
              Container(
                decoration: BoxDecoration(border: Border(top: BorderSide(color: cs.outlineVariant))),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(icon: Icon(Icons.logout, color: AppTheme.accentColor), onPressed: () {/* TODO */}),
                    const SizedBox(width: 8),
                    Text('Sign Out', style: TextStyle(fontSize: 16, color: cs.onSurfaceVariant)),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text('Version v1.0.0',
                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12), textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
