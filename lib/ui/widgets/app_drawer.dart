// import 'package:flutter/material.dart';
// import 'package:pmgt/ui/screens/Projects/view_projects_screen.dart';
// import 'package:pmgt/ui/screens/Sites/view_sites_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/users/add_fe_vendor_screen.dart';
// import 'package:pmgt/ui/screens/users/add_scm_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import '../../core/theme.dart';
// import '../utils/responsive.dart';
// import '../screens/projects/add_project_screen.dart';
// import '../screens/Sites/add_site_screen.dart';
// import '../screens/reminders/reminders_screen.dart';
// import 'package:pmgt/ui/screens/users/add_pm_screen.dart';
// import 'package:pmgt/ui/screens/users/add_bdm_screen.dart';
// import 'package:pmgt/ui/screens/users/add_noc_screen.dart';
// import 'package:pmgt/ui/screens/users/add_user_screen.dart';
// import 'package:pmgt/ui/screens/users/add_customer_screen.dart';
// import '../screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/report_issue/report_issue_screen.dart';
// import 'package:pmgt/ui/screens/inventory/inventory_screen.dart';

// class AppDrawer extends StatefulWidget {
//   const AppDrawer({super.key});

//   @override
//   State<AppDrawer> createState() => _AppDrawerState();
// }

// class _AppDrawerState extends State<AppDrawer> {
//   bool _projectsOpen = false;
//   bool _sitesOpen = false;
//   bool _usersOpen = false;

//   final List<String> _userSubs = const [
//     'View All Users',
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
//       title: Text(
//         label,
//         style: Theme.of(
//           context,
//         ).textTheme.bodyLarge?.copyWith(color: cs.onSurface),
//       ),
//       trailing: Icon(
//         isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
//         color: cs.onSurfaceVariant,
//       ),
//       onTap: onTap,
//     );
//   }

//   Widget _buildSubItem(String label, VoidCallback onTap) {
//     final cs = Theme.of(context).colorScheme;
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16 + 56, top: 8, bottom: 8),
//         child: Text(
//           label,
//           style: Theme.of(
//             context,
//           ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
//         ),
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
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 0,
//                   vertical: 16,
//                 ),
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
//                           style: TextStyle(
//                             color: cs.onSurfaceVariant,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               Divider(color: cs.outlineVariant, height: 1),

//               // MENU
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.zero,
//                   children: [
//                     _buildMainItem(
//                       icon: Icons.folder_open,
//                       label: 'Projects',
//                       isOpen: _projectsOpen,
//                       onTap:
//                           () => setState(() => _projectsOpen = !_projectsOpen),
//                     ),
//                     if (_projectsOpen) ...[
//                       _buildSubItem('View All Projects', () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const ViewProjectsScreen(),
//                           ),
//                         );
//                       }),
//                       _buildSubItem('Add Project +', () {
//                         // close the drawer first
//                         Navigator.pop(context);
//                         // then push the Add Project screen
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddProjectScreen(),
//                           ),
//                         );
//                       }),
//                     ],

//                     _buildMainItem(
//                       icon: Icons.location_on,
//                       label: 'Sites',
//                       isOpen: _sitesOpen,
//                       onTap: () => setState(() => _sitesOpen = !_sitesOpen),
//                     ),

//                     if (_sitesOpen) ...[
//                       _buildSubItem('View All Sites', () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AllSitesScreen(),
//                           ),
//                         );
//                       }),
//                       _buildSubItem('Add Site +', () {
//                         Navigator.pop(context); // close drawer
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddSiteScreen(),
//                           ),
//                         );
//                       }),
//                     ],

//                     ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       leading: Icon(Icons.event_note, color: cs.onSurface),
//                       title: Text(
//                         'Activities',
//                         style: Theme.of(
//                           context,
//                         ).textTheme.bodyLarge?.copyWith(color: cs.onSurface),
//                       ),
//                       onTap: () {
//                         Navigator.pop(context); // close drawer
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddActivityScreen(),
//                           ),
//                         );
//                       },
//                     ),

//                     ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       leading: Icon(Icons.bar_chart, color: cs.onSurface),
//                       title: Text(
//                         'Analytics',
//                         style: Theme.of(
//                           context,
//                         ).textTheme.bodyLarge?.copyWith(color: cs.onSurface),
//                       ),
//                       onTap: () {
//                         Navigator.pop(context); // close the drawer first
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AnalyticsScreen(),
//                           ),
//                         );
//                       },
//                     ),

//                     ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       leading: Icon(Icons.notifications, color: cs.onSurface),
//                       title: Text(
//                         'Reminders',
//                         style: Theme.of(
//                           context,
//                         ).textTheme.bodyLarge?.copyWith(color: cs.onSurface),
//                       ),
//                       onTap: () {
//                         Navigator.pop(context); // close drawer
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const RemindersScreen(),
//                           ),
//                         );
//                       },
//                     ),

//                     _buildMainItem(
//                       icon: Icons.person,
//                       label: 'User Management',
//                       isOpen: _usersOpen,
//                       onTap: () => setState(() => _usersOpen = !_usersOpen),
//                     ),
//                     if (_usersOpen) ...[
//                       _buildSubItem('View All Users', () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const ViewUsersScreen(),
//                           ),
//                         );
//                       }),

//                       _buildSubItem('Add PM +', () {
//                         Navigator.pop(context); // close drawer
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddPmScreen(),
//                           ),
//                         );
//                       }),

//                       _buildSubItem('Add BDM +', () {
//                         Navigator.pop(context); // close drawer
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddBdmScreen(),
//                           ),
//                         );
//                       }),

//                       _buildSubItem('Add NOC +', () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddNocScreen(),
//                           ),
//                         );
//                       }),

//                       _buildSubItem('Add SCM +', () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddScmScreen(),
//                           ),
//                         );
//                       }),

//                       _buildSubItem('Add FE/Vendor +', () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddFEVendorScreen(),
//                           ),
//                         );
//                       }),

//                       _buildSubItem('Add User +', () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddUserScreen(),
//                           ),
//                         );
//                       }),

//                       _buildSubItem('Add Customer +', () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const AddCustomerScreen(),
//                           ),
//                         );
//                       }),
//                     ],

//                     // --- Report Issue ---
//                     ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       leading: Icon(Icons.help_outline, color: cs.onSurface),
//                       title: Text(
//                         'Report Issue',
//                         style: Theme.of(
//                           context,
//                         ).textTheme.bodyLarge?.copyWith(color: cs.onSurface),
//                       ),
//                       onTap: () {
//                         Navigator.pop(context); // close drawer
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const ReportIssueScreen(),
//                           ),
//                         );
//                       },
//                     ),

//                     ListTile(
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                       ),
//                       leading: Icon(Icons.inventory_2, color: cs.onSurface),
//                       title: Text(
//                         'Inventory',
//                         style: Theme.of(
//                           context,
//                         ).textTheme.bodyLarge?.copyWith(color: cs.onSurface),
//                       ),
//                       onTap: () {
//                         Navigator.pop(context); // close drawer
//                         Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (_) => const InventoryScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),

//               // SIGN OUT
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border(top: BorderSide(color: cs.outlineVariant)),
//                 ),
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       icon: Icon(Icons.logout, color: AppTheme.accentColor),
//                       onPressed: () {
//                         /* TODO */
//                       },
//                     ),
//                     const SizedBox(width: 8),
//                     Text(
//                       'Sign Out',
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: cs.onSurfaceVariant,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

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

import 'package:pmgt/ui/screens/Projects/view_projects_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/Sites/view_sites_screen.dart';
import 'package:pmgt/ui/screens/Sites/add_site_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/reminders/reminders_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/screens/users/add_pm_screen.dart';
import 'package:pmgt/ui/screens/users/add_bdm_screen.dart';
import 'package:pmgt/ui/screens/users/add_noc_screen.dart';
import 'package:pmgt/ui/screens/users/add_scm_screen.dart';
import 'package:pmgt/ui/screens/users/add_fe_vendor_screen.dart';
import 'package:pmgt/ui/screens/users/add_user_screen.dart';
import 'package:pmgt/ui/screens/users/add_customer_screen.dart';
import 'package:pmgt/ui/screens/report_issue/report_issue_screen.dart';
import 'package:pmgt/ui/screens/inventory/inventory_screen.dart';

// ---- Accounts module pages (you said these exist) ----
import 'package:pmgt/ui/screens/accounts/accounts_project_list_screen.dart';
import 'package:pmgt/ui/screens/accounts/accounts_pa_list_screen.dart';
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import '../../core/theme.dart';
import '../utils/responsive.dart';

/// Which drawer variant to render.
enum DrawerMode { atlas, accounts }

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key, this.mode = DrawerMode.atlas});

  /// If `accounts`, the drawer only shows the 4 Accounts options.
  final DrawerMode mode;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  bool _projectsOpen = false;
  bool _sitesOpen = false;
  bool _usersOpen = false;

  // ---------- helpers ----------
  ListTile _mainTile({
    required IconData icon,
    required String label,
    VoidCallback? onTap,
    bool expandable = false,
    bool expanded = false,
  }) {
    final cs = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      leading: Icon(icon, color: cs.onSurface),
      title: Text(
        label,
        style: Theme.of(
          context,
        ).textTheme.bodyLarge?.copyWith(color: cs.onSurface),
      ),
      trailing:
          expandable
              ? Icon(
                expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: cs.onSurfaceVariant,
              )
              : null,
      onTap: onTap,
    );
  }

  Widget _subItem(String label, VoidCallback onTap) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 16 + 56, top: 8, bottom: 8),
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
        ),
      ),
    );
  }

  List<Widget> _atlasMenu(BuildContext context) {
    return [
      _mainTile(
        icon: Icons.folder_open,
        label: 'Projects',
        expandable: true,
        expanded: _projectsOpen,
        onTap: () => setState(() => _projectsOpen = !_projectsOpen),
      ),
      if (_projectsOpen) ...[
        _subItem('View All Projects', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const ViewProjectsScreen()));
        }),
        _subItem('Add Project +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddProjectScreen()));
        }),
      ],

      _mainTile(
        icon: Icons.location_on,
        label: 'Sites',
        expandable: true,
        expanded: _sitesOpen,
        onTap: () => setState(() => _sitesOpen = !_sitesOpen),
      ),
      if (_sitesOpen) ...[
        _subItem('View All Sites', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AllSitesScreen()));
        }),
        _subItem('Add Site +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddSiteScreen()));
        }),
      ],

      _mainTile(
        icon: Icons.event_note,
        label: 'Activities',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddActivityScreen()));
        },
      ),

      _mainTile(
        icon: Icons.bar_chart,
        label: 'Analytics',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AnalyticsScreen()));
        },
      ),

      _mainTile(
        icon: Icons.notifications,
        label: 'Reminders',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const RemindersScreen()));
        },
      ),

      _mainTile(
        icon: Icons.person,
        label: 'User Management',
        expandable: true,
        expanded: _usersOpen,
        onTap: () => setState(() => _usersOpen = !_usersOpen),
      ),
      if (_usersOpen) ...[
        _subItem('View All Users', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const ViewUsersScreen()));
        }),
        _subItem('Add PM +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddPmScreen()));
        }),
        _subItem('Add BDM +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddBdmScreen()));
        }),
        _subItem('Add NOC +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddNocScreen()));
        }),
        _subItem('Add SCM +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddScmScreen()));
        }),
        _subItem('Add FE/Vendor +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddFEVendorScreen()));
        }),
        _subItem('Add User +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddUserScreen()));
        }),
        _subItem('Add Customer +', () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const AddCustomerScreen()));
        }),
      ],

      _mainTile(
        icon: Icons.help_outline,
        label: 'Report Issue',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const ReportIssueScreen()));
        },
      ),

      _mainTile(
        icon: Icons.inventory_2,
        label: 'Inventory',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const InventoryScreen()));
        },
      ),

      // entry to jump into Accounts module
      _mainTile(
        icon: Icons.account_balance_wallet_outlined,
        label: 'Accounts',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AccountsProjectListScreen(),
            ),
          );
        },
      ),
    ];
  }

  List<Widget> _accountsMenu(BuildContext context) {
    return [
      _mainTile(
        icon: Icons.list_alt,
        label: 'Project List',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AccountsProjectListScreen(),
            ),
          );
        },
      ),
      _mainTile(
        icon: Icons.receipt_long,
        label: 'PA List',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AccountsPaListScreen()),
          );
        },
      ),
      _mainTile(
        icon: Icons.inventory_2,
        label: 'Inventory',
        onTap: () {
          Navigator.pop(context);
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const InventoryScreen()));
        },
      ),
      _mainTile(
        icon: Icons.apps,
        label: 'Atlas',
        onTap: () {
          Navigator.pop(context);
          // send back to the main app area (Projects list is a good landing)
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (_) => const DashboardScreen()));
        },
      ),
    ];
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
              GestureDetector(
                onTap: () {
                  // close the drawer first
                  Navigator.pop(context);
                  // go to Dashboard (clear stack so Back doesn't return to Accounts)
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const DashboardScreen()),
                    (route) => false,
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 16,
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/pmgt_logo.png',
                        width: 40,
                        height: 40,
                      ),
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
                            style: TextStyle(
                              color: cs.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(color: cs.outlineVariant, height: 1),

              // menu
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children:
                      widget.mode == DrawerMode.accounts
                          ? _accountsMenu(context)
                          : _atlasMenu(context),
                ),
              ),

              // footer
              Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: cs.outlineVariant)),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.logout, color: AppTheme.accentColor),
                      onPressed: () {},
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 16,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Version v1.0.0',
                  style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
