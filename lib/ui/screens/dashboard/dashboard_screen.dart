import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  // int _selectedTab = 0; // bottom nav index


  // Toggle state for Project vs Summary
  final List<bool> _isSelected = [true, false];
  // Activities filter: index of Today/Tomorrow/Week/Month/All
  int _activityTimeIndex = 4; // default to "All"
  // Dropdown selections
  String _selectedProject = 'All';
  String _selectedStatus = 'All';

  // pagination
  int _currentPage = 1;
  final List<int> _perPageOptions = [5, 10, 15, 20];
  int _perPage = 10;

  // sample list of projects & statuses
  final List<String> _projects = const [
    'All',
    'NPCI',
    'TelstraApari',
    'BPCL Aruba WIFI',
  ];
  final List<String> _statuses = const [
    'All',
    'Completed',
    'Pending',
    'In-Progress',
    'Open',
    'Rescheduled',
  ];

  final List<Activity> _activities = List.generate(
    30,
    (i) => Activity(
      ticketNo: 'npci-${(i + 1).toString().padLeft(3, '0')}',
      date: '23/07/2025',
      project: 'NPCI',
      activity: 'Breakdown',
      state: 'Maharashtra',
      district: 'Thane',
      city: 'Panvel',
      address: 'XYZ',
      siteName: 'ABCS',
      siteCode: '001',
      pm: 'Amey',
      noc: 'xya',
      feVendor: 'hshsh',
      feContact: '37326382',
      completionDate: '23-03-2025',
      remarks: 'xyz',
      status: (i % 2 == 0) ? 'Completed' : 'Pending',
    ),
  );

  // --- filtering + paging helpers ---
  List<Activity> get _filteredActivities {
    return _activities.where((a) {
      final okProject =
          _selectedProject == 'All' || a.project == _selectedProject;
      final okStatus = _selectedStatus == 'All' || a.status == _selectedStatus;
      return okProject && okStatus;
    }).toList();
  }

  int get _totalPages {
    final len = _filteredActivities.length;
    if (len == 0) return 1; // keep UI stable
    return (len + _perPage - 1) ~/ _perPage;
  }

  List<Activity> get _pagedActivities {
    final list = _filteredActivities;
    if (list.isEmpty) return const [];
    final start = (_currentPage - 1) * _perPage;
    final end = min(start + _perPage, list.length);
    if (start >= list.length) return const [];
    return list.sublist(start, end);
  }

  void _goToPage(int p) => setState(() {
    _currentPage = p.clamp(1, _totalPages);
  });

  // summary chart data
  final Map<String, double> _chartData = const {
    'Completed': 18,
    'In Progress': 4,
    'Open': 6,
    'Rescheduled': 2,
  };
  final Map<String, Color> _chartColors = const {
    'Completed': Colors.greenAccent,
    'In Progress': Colors.blueAccent,
    'Open': AppTheme.accentColor,
    'Rescheduled': Colors.redAccent,
  };

  // placeholder pages for other nav tabs
  // final _pages = const [
  //   SizedBox.shrink(),
  //   Center(child: Text('Projects')),
  //   Center(child: Text('Analytics')),
  //   Center(child: Text('Users')),
  // ];

  void _handleTabChange(BuildContext context, int i) {
  if (i == 0) return; // already on Dashboard
  late final Widget target;
  switch (i) {
    case 1: target = const AddProjectScreen();  break;
    case 2: target = const AddActivityScreen(); break;
    case 3: target = const AnalyticsScreen();   break;
    case 4: target = const ViewUsersScreen();   break;
    default: return;
  }
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => target),
  );
}


  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      // use the centered toggle as the title
      titleWidget: _buildTopToggle(context),
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
      // safeArea: false,
      // reserveBottomPadding: true,

      // body:
      //     _selectedTab == 0
      //         ? _buildDashboardContent()
      //         : DefaultTextStyle(
      //           style: TextStyle(
      //             color: cs.onSurface,
      //             fontSize: 18,
      //             fontWeight: FontWeight.w600,
      //           ),
      //           child: _pages[_selectedTab],
      //         ),

      currentIndex: 0,
onTabChanged: (i) => _handleTabChange(context, i),
safeArea: false,
reserveBottomPadding: true,

body: _buildDashboardContent(),

    );
  }

  /// Center toggle placed in the AppBar
  Widget _buildTopToggle(BuildContext context) {
    final isLight = Theme.of(context).brightness == Brightness.light;
    final cs = Theme.of(context).colorScheme;

    final fillColor =
        isLight ? Colors.black12 : AppTheme.accentColor.withOpacity(0.18);
    final selBorderColor = isLight ? Colors.black : AppTheme.accentColor;
    final borderColor = isLight ? Colors.black26 : cs.outlineVariant;
    final selTextColor = isLight ? Colors.black : AppTheme.accentColor;
    final unselectedColor = isLight ? Colors.black54 : cs.onSurfaceVariant;

    return ToggleButtons(
      isSelected: _isSelected,
      borderRadius: BorderRadius.circular(8),
      fillColor: fillColor,
      selectedBorderColor: selBorderColor,
      borderColor: borderColor,
      selectedColor: selTextColor,
      color: unselectedColor,
      constraints: const BoxConstraints(minHeight: 32, minWidth: 96),
      onPressed: (index) {
        setState(() {
          for (var i = 0; i < _isSelected.length; i++) {
            _isSelected[i] = (i == index);
          }
        });
      },
      children: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text('Project'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14),
          child: Text('Summary'),
        ),
      ],
    );
  }

  /// Main dashboard content
  Widget _buildDashboardContent() {
    final cs = Theme.of(context).colorScheme;
    final pad = responsivePadding(context);

    // ===== Summary tab =====
    if (!_isSelected[0]) {
      return ListView(
        padding: pad.copyWith(
          top: 4,
          bottom: 8 + 58, // matches CustomBottomNavBar.reservedBodyPadding
        ),
        children: const [
          // summary tiles + donut chart
          _SummaryCardWrapper(),
          SizedBox(height: 12),
          _ActivityStatusSection(),
        ],
      );
    }

    // ===== Project tab =====
    return Padding(
      padding: pad.copyWith(top: 2, bottom: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // _buildProjectCard(),
          const SizedBox(height: 4),

          Row(
            children: [
              Text(
                'Activities',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              SizedBox(width: 220, child: const _SearchField()), // narrower
            ],
          ),
          const SizedBox(height: 2),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 2),

          // Time filter row (centered)
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min, // <- key: shrink to content
                children:
                    [
                      'Today',
                      'Tomorrow',
                      'Week',
                      'Month',
                      'All',
                    ].asMap().entries.map((e) {
                      final idx = e.key;
                      final label = e.value;
                      final selected = idx == _activityTimeIndex;

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _activityTimeIndex = idx),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  selected
                                      ? AppTheme.accentColor
                                      : Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              label,
                              style: TextStyle(
                                color:
                                    selected
                                        ? Colors.black
                                        : Theme.of(
                                          context,
                                        ).colorScheme.onSurfaceVariant,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Two filters in a single row
          Row(
            children: [
              Expanded(
                child: _buildDropdown(
                  'Project',
                  _projects,
                  _selectedProject,
                  (v) => setState(() => _selectedProject = v!),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildDropdown(
                  'Status',
                  _statuses,
                  _selectedStatus,
                  (v) => setState(() => _selectedStatus = v!),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(
                bottom: 12 + 58, // keep some space above bottom nav
              ),
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemCount: _pagedActivities.length + 1,
              itemBuilder: (context, i) {
                // normal cards
                if (i < _pagedActivities.length) {
                  return _ActivityCard(a: _pagedActivities[i]);
                }

                // last item = pagination row
                return _PaginationInline(
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  onPrev: () => _goToPage(_currentPage - 1),
                  onNext: () => _goToPage(_currentPage + 1),
                  onPageSelected: _goToPage,
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
    );
  }

  /// Themed dropdown (compact)
  Widget _buildDropdown(
    String hint,
    List<String> items,
    String selected,
    ValueChanged<String?> onChanged,
  ) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 34,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: selected,
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: Theme.of(context).scaffoldBackgroundColor,
        iconEnabledColor: cs.onSurfaceVariant,
        style: TextStyle(color: cs.onSurface, fontSize: 12),
        hint: Text(
          hint,
          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
        ),
        onChanged: onChanged,
        items:
            items
                .map(
                  (s) => DropdownMenuItem(
                    value: s,
                    child: Text(s, style: const TextStyle(fontSize: 12)),
                  ),
                )
                .toList(),
      ),
    );
  }

  // Widget _buildProjectCard() {
  //   final cs = Theme.of(context).colorScheme;
  //   final isLight = Theme.of(context).brightness == Brightness.light;

  //   return Card(
  //     color: cs.surfaceContainerHighest,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  //     child: Padding(
  //       // less vertical padding since the height is reduced now
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //       child: Row(
  //         children: [
  //           Icon(
  //             Icons.folder_open,
  //             color: isLight ? Colors.black : AppTheme.accentColor,
  //           ),
  //           const SizedBox(width: 10),
  //           Expanded(
  //             child: Text(
  //               'Project – All projects',
  //               style: TextStyle(
  //                 color: isLight ? Colors.black : cs.onSurface,
  //                 fontSize: 16,
  //                 fontWeight: FontWeight.w800,
  //               ),
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Text(
  //             "Today's Count : 23",
  //             style: TextStyle(
  //               color:
  //                   isLight
  //                       ? const Color.fromARGB(255, 35, 35, 35)
  //                       : AppTheme.accentColor,
  //               fontSize: 14,
  //               fontWeight: FontWeight.w700,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Summary tiles card
  Widget _buildSummaryCard() {
    final cs = Theme.of(context).colorScheme;
    final isLight = Theme.of(context).brightness == Brightness.light;

    const summaryItems = [
      {'label': 'Completed', 'count': '0'},
      {'label': 'Pending', 'count': '0'},
      {'label': 'In-Progress', 'count': '0'},
      {'label': 'Open', 'count': '0'},
      {'label': 'Rescheduled', 'count': '0'},
    ];

    return Card(
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: LayoutBuilder(
          builder: (context, c) {
            final tileWidth =
                (c.maxWidth - 24) / 2; // compensate for Wrap spacing
            return Wrap(
              spacing: 12,
              runSpacing: 12,
              children:
                  summaryItems.map((item) {
                    return SizedBox(
                      width: tileWidth,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: cs.surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              item['count']!,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: isLight ? Colors.black : cs.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['label']!,
                              style: TextStyle(
                                fontSize: 13,
                                color:
                                    isLight
                                        ? Colors.black54
                                        : cs.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
            );
          },
        ),
      ),
    );
  }
}

// Helper to access the state's _buildSummaryCard from a child stateless widget.
class _SummaryCardWrapper extends StatelessWidget {
  const _SummaryCardWrapper();
  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_DashboardScreenState>()!;
    return state._buildSummaryCard();
  }
}

class _ActivityStatusSection extends StatelessWidget {
  const _ActivityStatusSection();

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_DashboardScreenState>()!;
    final cs = Theme.of(context).colorScheme;

    final data = state._chartData;
    final colors = state._chartColors;

    return Card(
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Activity Status',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: cs.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(color: cs.outlineVariant),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: CustomPaint(
                  painter: _DonutPainter(
                    data: data,
                    colors: colors,
                    holeColor: cs.surfaceContainerHighest,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...data.keys.map((key) {
              final val = data[key]!;
              final total = data.values.fold(0.0, (a, b) => a + b);
              final pct = total > 0 ? (val / total * 100).round() : 0;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: colors[key],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(key, style: TextStyle(color: cs.onSurface)),
                    ),
                    Text('$pct%', style: TextStyle(color: cs.onSurfaceVariant)),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}


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

    // Current 5-wide "window": 1–5, 6–10, 11–15, ...
    final int windowStart = ((currentPage - 1) ~/ _windowSize) * _windowSize + 1;
    final int windowEnd   = min(windowStart + _windowSize - 1, totalPages);

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
          style: TextStyle(color: fg, fontWeight: FontWeight.w600, fontSize: 13),
          child: IconTheme.merge(
            data: IconThemeData(color: fg, size: 18),
            child: child,
          ),
        ),
      );

      return onTap == null
          ? Opacity(opacity: 0.5, child: content)
          : InkWell(onTap: onTap, borderRadius: BorderRadius.circular(10), child: content);
    }

    final hasPrevWindow = windowStart > 1;
    final hasNextWindow = windowEnd < totalPages;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Jump to previous window
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
        // Jump to next window
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

  /// Not used anymore (arrows jump window), but keep the API the same.
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

    // Row height kept tight; pagination centered via Stack.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: SizedBox(
        height: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Center: page numbers (5-wide window)
            _PaginationBar(
              currentPage: currentPage,
              totalPages: totalPages,
              onPageSelected: onPageSelected,
            ),

            // Right: Cards/Page selector
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
                        .map((n) => DropdownMenuItem(value: n, child: Text('$n')))
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

/// Search field (compact)
class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      height: 34,
      child: TextField(
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

/// Activity card (compact, two columns)
class _ActivityCard extends StatelessWidget {
  final Activity a;
  const _ActivityCard({required this.a});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${a.ticketNo}  ${a.date}',
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
              Text(
                'Status : ${a.status}',
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

          // Two columns
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Project', a.project, labelColor, valueColor),
                    _infoRow('Activity', a.activity, labelColor, valueColor),
                    _infoRow('State', a.state, labelColor, valueColor),
                    _infoRow('District', a.district, labelColor, valueColor),
                    _infoRow('City', a.city, labelColor, valueColor),
                    _infoRow('Address', a.address, labelColor, valueColor),
                    _infoRow('Remarks', a.remarks, labelColor, valueColor),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoRow('Site Name', a.siteName, labelColor, valueColor),
                    _infoRow('Site Code', a.siteCode, labelColor, valueColor),
                    _infoRow('PM', a.pm, labelColor, valueColor),
                    _infoRow('Noc', a.noc, labelColor, valueColor),
                    _infoRow('FE/Vendor', a.feVendor, labelColor, valueColor),
                    _infoRow(
                      'FE/Vendor Contact',
                      a.feContact,
                      labelColor,
                      valueColor,
                    ),
                    _infoRow(
                      'Completion Date',
                      a.completionDate,
                      labelColor,
                      valueColor,
                    ),
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
                style: TextStyle(color: Color(0xFF000000), fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    String label,
    String value,
    Color labelColor,
    Color valueColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          text: '$label: ',
          style: TextStyle(color: labelColor, fontSize: 11),
          children: [
            TextSpan(
              text: value,
              style: TextStyle(color: valueColor, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}

class Activity {
  final String ticketNo,
      date,
      project,
      activity,
      state,
      district,
      city,
      address,
      remarks,
      siteName,
      siteCode,
      pm,
      noc,
      feVendor,
      feContact,
      completionDate,
      status;
  Activity({
    required this.ticketNo,
    required this.date,
    required this.project,
    required this.activity,
    required this.state,
    required this.district,
    required this.city,
    required this.address,
    required this.remarks,
    required this.siteName,
    required this.siteCode,
    required this.pm,
    required this.completionDate,
    required this.feContact,
    required this.feVendor,
    required this.noc,
    required this.status,
  });
}

class _DonutPainter extends CustomPainter {
  final Map<String, double> data;
  final Map<String, Color> colors;
  final Color holeColor;
  _DonutPainter({
    required this.data,
    required this.colors,
    required this.holeColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final total = data.values.fold(0.0, (a, b) => a + b);
    double startAngle = -pi / 2;
    final stroke = size.width * 0.20;
    final paint =
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..strokeCap = StrokeCap.butt;
    final rect = Rect.fromLTWH(
      stroke / 2,
      stroke / 2,
      size.width - stroke,
      size.height - stroke,
    );
    data.forEach((key, value) {
      if (value <= 0) return;
      final sweep = (value / total) * 2 * pi;
      paint.color = colors[key]!;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep;
    });
    final holePaint = Paint()..color = holeColor;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      (size.width - stroke) / 2.3,
      holePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}
