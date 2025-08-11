// // lib/ui/widgets/app_drawer.dart

// import 'package:flutter/material.dart';
// import '../../core/theme.dart';

// class AppDrawer extends StatefulWidget {
//   const AppDrawer({Key? key}) : super(key: key);

//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   bool _projectsOpen = false;
//   bool _sitesOpen    = false;
//   bool _usersOpen    = false;

//   final List<String> _userSubs = [
//     'Add PM +',
//     'Add BDM +',
//     'Add NOC +',
//     'Add SCM +',
//     'Add FE/Vendor +',
//     'Add User +',
//     'Add Customer +',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: AppTheme.backgroundColor,
//       child: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             // Header
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
//               child: Row(
//                 children: [
//                   Image.asset(
//                     'assets/pmgt_logo.png',
//                     width: 40,
//                     height: 40,
//                   ),
//                   const SizedBox(width: 12),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         'Atlas',
//                         style: TextStyle(
//                           fontFamily: 'Sansation',
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Project Management Tool',
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Padded divider
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               child: Divider(color: Colors.white24),
//             ),

//             // Menu
//             Expanded(
//               child: ListView(
//                 padding: EdgeInsets.zero,
//                 children: [
//                   // Projects
//                   ExpansionTile(
//                     tilePadding: const EdgeInsets.symmetric(horizontal: 16),
//                     childrenPadding: const EdgeInsets.only(left: 32),
//                     leading: const Icon(Icons.folder_open, color: Colors.white),
//                     title: const Text('Projects', style: AppTheme.bodyText),
//                     trailing: Icon(
//                       _projectsOpen
//                           ? Icons.keyboard_arrow_up
//                           : Icons.keyboard_arrow_down,
//                       color: Colors.white54,
//                     ),
//                     onExpansionChanged: (open) =>
//                         setState(() => _projectsOpen = open),
//                     children: [
//                       InkWell(
//                         onTap: () { /* TODO: View All Projects */ },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8),
//                           child: Text(
//                             'View All Projects',
//                             style:
//                                 TextStyle(fontSize: 14, color: Colors.white70),
//                           ),
//                         ),
//                       ),
//                       InkWell(
//                         onTap: () { /* TODO: Add Project */ },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8),
//                           child: Text(
//                             'Add Project +',
//                             style:
//                                 TextStyle(fontSize: 14, color: Colors.white70),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Sites
//                   ExpansionTile(
//                     tilePadding: const EdgeInsets.symmetric(horizontal: 16),
//                     childrenPadding: const EdgeInsets.only(left: 32),
//                     leading: const Icon(Icons.location_on, color: Colors.white),
//                     title: const Text('Sites', style: AppTheme.bodyText),
//                     trailing: Icon(
//                       _sitesOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//                       color: Colors.white54,
//                     ),
//                     onExpansionChanged: (open) => setState(() => _sitesOpen = open),
//                     children: [
//                       InkWell(
//                         onTap: () { /* TODO: View All Sites */ },
//                         child: const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 8),
//                           child: Text(
//                             'View All Sites',
//                             style:
//                                 TextStyle(fontSize: 14, color: Colors.white70),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   // Flat items
//                   ListTile(
//                     leading: const Icon(Icons.event_note, color: Colors.white),
//                     title: const Text('Activities', style: AppTheme.bodyText),
//                     onTap: () { /* TODO */ },
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.bar_chart, color: Colors.white),
//                     title: const Text('Analytics', style: AppTheme.bodyText),
//                     onTap: () { /* TODO */ },
//                   ),
//                   ListTile(
//                     leading: const Icon(Icons.notifications, color: Colors.white),
//                     title: const Text('Reminders', style: AppTheme.bodyText),
//                     onTap: () { /* TODO */ },
//                   ),

//                   // User Management
//                   ExpansionTile(
//                     tilePadding: const EdgeInsets.symmetric(horizontal: 16),
//                     childrenPadding: const EdgeInsets.only(left: 32),
//                     leading: const Icon(Icons.person, color: Colors.white),
//                     title:
//                         const Text('User Management', style: AppTheme.bodyText),
//                     trailing: Icon(
//                       _usersOpen
//                           ? Icons.keyboard_arrow_up
//                           : Icons.keyboard_arrow_down,
//                       color: Colors.white54,
//                     ),
//                     onExpansionChanged: (open) => setState(() => _usersOpen = open),
//                     children: _userSubs.map((label) {
//                       return InkWell(
//                         onTap: () { /* TODO: $label */ },
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 8),
//                           child: Text(
//                             label,
//                             style: const TextStyle(
//                               fontSize: 14,
//                               color: Colors.white70,
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                 ],
//               ),
//             ),

//             // Sign Out
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.logout, color: Color(0xFFFBDF3B)),
//                     onPressed: () { /* TODO: Sign Out */ },
//                   ),
//                   const SizedBox(width: 8),
//                   const Text(
//                     'Sign Out',
//                     style: TextStyle(fontSize: 16, color: Colors.white70),
//                   ),
//                 ],
//               ),
//             ),

//             // Version
//             const Padding(
//               padding: EdgeInsets.only(bottom: 16),
//               child: Text(
//                 'Version v1.0.0',
//                 style: TextStyle(color: Colors.white38, fontSize: 12),
//                 textAlign: TextAlign.center,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// lib/ui/widgets/app_drawer.dart

import 'package:flutter/material.dart';
import '../../core/theme.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _projectsOpen = false;
  bool _sitesOpen    = false;
  bool _usersOpen    = false;

  final List<String> _userSubs = [
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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: AppTheme.bodyText),
      trailing: Icon(
        isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
        color: Colors.white54,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSubItem(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16 + 56, top: 8, bottom: 8),
        child: Text(label, style: const TextStyle(fontSize: 14, color: Colors.white70)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppTheme.backgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // HEADER
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Row(
                children: [
                  Image.asset('assets/pmgt_logo.png', width: 40, height: 40),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Atlas',
                        style: TextStyle(
                          fontFamily: 'Sansation',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Project Management Tool',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // SINGLE DIVIDER
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(color: Colors.white24),
            ),

            // MENU
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // Projects
                  _buildMainItem(
                    icon: Icons.folder_open,
                    label: 'Projects',
                    isOpen: _projectsOpen,
                    onTap: () => setState(() => _projectsOpen = !_projectsOpen),
                  ),
                  if (_projectsOpen) ...[
                    _buildSubItem('View All Projects', () {/*TODO*/}),
                    _buildSubItem('Add Project +', () {/*TODO*/}),
                  ],

                  // Sites
                  _buildMainItem(
                    icon: Icons.location_on,
                    label: 'Sites',
                    isOpen: _sitesOpen,
                    onTap: () => setState(() => _sitesOpen = !_sitesOpen),
                  ),
                  if (_sitesOpen) 
                    _buildSubItem('View All Sites', () {/*TODO*/}),

                  // Flat items
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: const Icon(Icons.event_note, color: Colors.white),
                    title: const Text('Activities', style: AppTheme.bodyText),
                    onTap: () {/*TODO*/},
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: const Icon(Icons.bar_chart, color: Colors.white),
                    title: const Text('Analytics', style: AppTheme.bodyText),
                    onTap: () {/*TODO*/},
                  ),
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    leading: const Icon(Icons.notifications, color: Colors.white),
                    title: const Text('Reminders', style: AppTheme.bodyText),
                    onTap: () {/*TODO*/},
                  ),

                  // User Management
                  _buildMainItem(
                    icon: Icons.person,
                    label: 'User Management',
                    isOpen: _usersOpen,
                    onTap: () => setState(() => _usersOpen = !_usersOpen),
                  ),
                  if (_usersOpen)
                    for (var sub in _userSubs)
                      _buildSubItem(sub, () {/*TODO*/}),
                ],
              ),
            ),

            // SIGN OUT
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.logout, color: Color(0xFFFBDF3B)),
                    onPressed: () {/*TODO*/},
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ],
              ),
            ),

            // VERSION
            const Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Version v1.0.0',
                style: TextStyle(color: Colors.white38, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
