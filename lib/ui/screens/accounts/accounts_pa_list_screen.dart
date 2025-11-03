import 'package:flutter/material.dart';
import '../../../core/theme_controller.dart';
import '../../../core/theme.dart';
import '../../widgets/layout/main_layout.dart';
import '../../utils/responsive.dart';
import '../profile/profile_screen.dart';
import '../../widgets/app_drawer.dart';
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

class AccountsPaListScreen extends StatefulWidget {
  const AccountsPaListScreen({super.key});

  @override
  State<AccountsPaListScreen> createState() => _AccountsPaListScreenState();
}

class _AccountsPaListScreenState extends State<AccountsPaListScreen> {
  // int _tab = 0;

  // Search + project filter
  String _query = '';
  String _selectedProject = 'All';

  final List<String> _projectFilter = const [
    'All',
    'Airtel CEDGE NAC',
    'TCL GSTN',
    'NDSatcom SAMOFA',
  ];

  // Demo PA rows
  final List<_PaRow> _rows = const [
    _PaRow(
      paNo: 'Airtel CEDGE NAC-PA-005',
      project: 'Airtel CEDGE NAC',
      paDate: '2025-09-16',
      siteName: 'GARREPALLI',
      siteCode: '101',
      paStatus: 'Pending',
      paymentStatus: 'Unpaid',
    ),
    _PaRow(
      paNo: 'Airtel CEDGE NAC-PA-004',
      project: 'Airtel CEDGE NAC',
      paDate: '2025-07-15',
      siteName: 'UPPUNUTHALA',
      siteCode: '7123',
      paStatus: 'Pending',
      paymentStatus: 'Unpaid',
    ),
    _PaRow(
      paNo: 'TCL GSTN-PA-001',
      project: 'TCL GSTN',
      paDate: '2025-07-11',
      siteName: 'DILSUKHNAGAR',
      siteCode: '151',
      paStatus: 'Approved',
      paymentStatus: 'Paid',
    ),
    _PaRow(
      paNo: 'NDS SAMOFA-PA-003',
      project: 'NDSatcom SAMOFA',
      paDate: '2025-07-13',
      siteName: 'DILSUKHNAGAR',
      siteCode: '151',
      paStatus: 'Pending',
      paymentStatus: 'Unpaid',
    ),
  ];

  void _handleTabChange(BuildContext context, int i) {
  // This screen isn’t one of the 5 primary tabs, so we always navigate.
  late final Widget target;
  switch (i) {
    case 0: target = const DashboardScreen();    break;
    case 1: target = const AddProjectScreen();   break;
    case 2: target = const AddActivityScreen();  break; // “Add” (center)
    case 3: target = const AnalyticsScreen();    break;
    case 4: target = const ViewUsersScreen();    break;
    default: return;
  }
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => target),
  );
}

  List<_PaRow> get _filtered {
    final q = _query.trim().toLowerCase();
    return _rows.where((r) {
      final okProject = _selectedProject == 'All' || r.project == _selectedProject;
      final okSearch = q.isEmpty ||
          r.paNo.toLowerCase().contains(q) ||
          r.project.toLowerCase().contains(q) ||
          r.siteName.toLowerCase().contains(q) ||
          r.siteCode.toLowerCase().contains(q) ||
          r.paStatus.toLowerCase().contains(q) ||
          r.paymentStatus.toLowerCase().contains(q);
      return okProject && okSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      // title: 'Accounts – PA List',
      // centerTitle: true,
      // drawerMode: DrawerMode.accounts, // show Accounts drawer
      // currentIndex: _tab,
      // onTabChanged: (i) => setState(() => _tab = i),
      // safeArea: false,
      // reserveBottomPadding: true,
      title: 'Accounts – PA List',
  centerTitle: true,
  drawerMode: DrawerMode.accounts,
  currentIndex: 0,                              // Not a primary tab; use 0 (or 1) just to render the bar
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
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
          },
          // icon: ClipOval(
          //   child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
          // ),
          icon: const ProfileAvatar(size: 36),

        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          // Search + Project dropdown in a single row
          Row(
            children: [
              Expanded(child: _SearchField(onChanged: (v) => setState(() => _query = v))),
              const SizedBox(width: 8),
              SizedBox(
                width: 160,
                child: _CompactDropdown<String>(
                  value: _selectedProject,
                  items: _projectFilter,
                  hint: 'Project',
                  onChanged: (v) => setState(() => _selectedProject = v ?? 'All'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Cards
          ..._filtered.map((r) => _PaCard(r: r)),

          if (_filtered.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: Text('No PA found', style: TextStyle(color: cs.onSurfaceVariant)),
              ),
            ),
        ],
      ),
    );
  }
}

/* ---------- Card ---------- */

class _PaCard extends StatelessWidget {
  final _PaRow r;
  const _PaCard({required this.r});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;
    final labelColor = isLight ? Colors.black54 : cs.onSurfaceVariant;
    final valueColor = isLight ? Colors.black : cs.onSurface;

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
          // Header: PA No | PA Status
          Row(
            children: [
              Expanded(
                child: Text(
                  r.paNo,
                  style: TextStyle(color: valueColor, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
              Text(
                r.paStatus,
                style: TextStyle(color: valueColor, fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 10),

          // Details (left-aligned column)
          _kv('Project', r.project, labelColor, valueColor),
          _kv('PA Date', r.paDate, labelColor, valueColor),
          _kv('Site Name', r.siteName, labelColor, valueColor),
          _kv('Site Code', r.siteCode, labelColor, valueColor),
          _kv('Payment Status', r.paymentStatus, labelColor, valueColor),

          const SizedBox(height: 12),

          // Buttons row (aligned to the end)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: cs.outlineVariant),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                ),
                onPressed: () {
                  // TODO: implement download logic
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Downloading PA…')),
                  );
                },
                icon: const Icon(Icons.download),
                label: const Text('Download'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // TODO: implement update route
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Open Update PA…')),
                  );
                },
                child: const Text('Update', style: TextStyle(fontWeight: FontWeight.w700)),
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

/* ---------- Small UI helpers (same compact style used elsewhere) ---------- */

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
          hintText: 'Search…',
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

class _CompactDropdown<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String hint;
  final ValueChanged<T?> onChanged;
  const _CompactDropdown({
    required this.value,
    required this.items,
    required this.hint,
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
          hint: Text(hint, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12)),
          items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

/* ---------- Model ---------- */

class _PaRow {
  final String paNo;
  final String project;
  final String paDate;
  final String siteName;
  final String siteCode;
  final String paStatus;
  final String paymentStatus;

  const _PaRow({
    required this.paNo,
    required this.project,
    required this.paDate,
    required this.siteName,
    required this.siteCode,
    required this.paStatus,
    required this.paymentStatus,
  });
}
