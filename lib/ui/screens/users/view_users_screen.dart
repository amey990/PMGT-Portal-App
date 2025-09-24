import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';



class ViewUsersScreen extends StatefulWidget {
  const ViewUsersScreen({super.key});
  @override
  State<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends State<ViewUsersScreen> {
  // int _selectedTab = 0; // bottom nav


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
  late List<bool> _isSelected = List<bool>.generate(
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
  }

  void _handleTabChange(BuildContext context, int i) {
  if (i == 4) return; // already on Users
  late final Widget target;
  switch (i) {
    case 0: target = const DashboardScreen();    break;
    case 1: target = const AddProjectScreen();   break;
    case 2: target = const AddActivityScreen();  break;
    case 3: target = const AnalyticsScreen();    break;
    default: return;
  }
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => target),
  );
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
    (i) => BDM('BDM #$i', 'bdm$i@atlas.com', '98xxx${(100 + i)}', 'NPCI'),
  );

  final List<NOC> nocList = List<NOC>.generate(
    12,
    (i) => NOC('NOC #$i', 'noc$i@atlas.com', '98xxx${(200 + i)}', 'NPCI'),
  );

  final List<SCM> scmList = List<SCM>.generate(
    10,
    (i) => SCM('SCM #$i', 'scm$i@atlas.com', '98xxx${(300 + i)}', 'NPCI'),
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
    (i) => Customer('Customer #$i', 'customer$i@atlas.com'),
  );

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
      // currentIndex: _selectedTab,
      // onTabChanged: (i) => setState(() => _selectedTab = i),
      currentIndex: 4,                                  // Users tab index
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

  // ---------- aligned key/value line ----------
  static const double _labelW = 92;

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
              value,
              style: TextStyle(color: valueColor, fontSize: 11),
              maxLines: isEmail ? 1 : 3,
              softWrap: !isEmail,
              overflow: isEmail ? TextOverflow.clip : TextOverflow.ellipsis,
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
        _kv('Project', data.project, labelColor, valueColor),
      ];
      right = const [];
    } else if (data is NOC) {
      titleLeft = data.name;
      titleRight = 'NOC Engineer';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
        _kv('Project', data.project, labelColor, valueColor),
      ];
      right = const [];
    } else if (data is SCM) {
      titleLeft = data.name;
      titleRight = 'Supply Chain Manager';
      left = [
        _kv('Email', data.email, labelColor, valueColor),
        _kv('Contact', data.contact, labelColor, valueColor),
        _kv('Project', data.project, labelColor, valueColor),
      ];
      right = const [];
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
      left = [_kv('Email', data.email, labelColor, valueColor)];
      right = const [];
    } else if (data is Customer) {
      titleLeft = data.name;
      titleRight = 'Customer';
      left = [_kv('Email', data.email, labelColor, valueColor)];
      right = const [];
    }

    // Build columns: use single column when right is empty (so email gets full width)
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
                style: TextStyle(color: Color(0xFF000000), fontSize: 12),
              ),
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
