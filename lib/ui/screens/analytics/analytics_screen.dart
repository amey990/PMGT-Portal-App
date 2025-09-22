// lib/ui/screens/analytics/analytics_screen.dart
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _selectedTab = 2;

  // --- Filters (Generate Report) ---
  String? _project = 'All Projects';
  String? _site = 'All Sites';
  DateTime? _fromDate;
  DateTime? _toDate;

  final List<String> _projects = const [
    'All Projects',
    'NPCI',
    'TelstraApari',
    'BPCL Aruba WIFI',
  ];
  final List<String> _sites = const [
    'All Sites',
    'Site 000',
    'Site 001',
    'Site 002',
    'Site 003'
  ];

  // --- Timelines for charts ---
  final List<String> _timelineOptions = const [
    'Today',
    'Last Week',
    '15 Days',
    '30 Days',
    '3 Months',
    '6 Months',
  ];
  String _tlLine = '15 Days';
  String _tlBars = 'Today';
  String _tlPie = '3 Months';

  // --- Activity Trend data (sample) ---
  final List<FlSpot> _activityTrend = const [
    FlSpot(0, 0),
    FlSpot(1, 0),
    FlSpot(2, 0),
    FlSpot(3, 0),
    FlSpot(4, 0),
    FlSpot(5, 5),
    FlSpot(6, 0),
    FlSpot(7, 0),
    FlSpot(8, 0),
    FlSpot(9, 0),
    FlSpot(10, 0),
    FlSpot(11, 0),
    FlSpot(12, 0),
  ];

  // --- Activities by Category (stacked bar) sample ---
  // One stacked bar showing month buckets
  List<BarChartGroupData> _buildStackGroups(ColorScheme cs) {
    return [
      BarChartGroupData(
        x: 0,
        barRods: [
          BarChartRodData(
            toY: 11,
            rodStackItems: [
              BarChartRodStackItem(0, 2, const Color(0xFF20C77A)), // Breakdown
              BarChartRodStackItem(2, 6, const Color(0xFFF4D03F)), // New install
              BarChartRodStackItem(6, 7, const Color(0xFFE74C3C)), // Upgrades
              BarChartRodStackItem(7, 7.5, const Color(0xFF95A5A6)), // Corrective
              BarChartRodStackItem(7.5, 10, const Color(0xFFF39C12)), // Preventive
              BarChartRodStackItem(10, 10.5, const Color(0xFF3498DB)), // Revisit
              BarChartRodStackItem(10.5, 11, const Color(0xFF8E44AD)), // Site Survey
            ],
            width: 28,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    ];
  }

  // --- FE worked across projects (sample) ---
  final Map<String, double> _feAcrossProjects = const {
    'TCL GSTN': 0,
    'TCL': 0,
    'NDSatcom SAMOFA': 0,
    'Airtel VC': 1,
    'NTT HDFC VC': 4,
    'SES': 0,
    'Jio AMC': 0,
    'SONY AMC': 0,
    'Airtel SBMF': 1,
    'Airtel Cedge onsite support': 0,
    'TelstraApari': 0,
    'BPCL Aruba WIFI': 0,
    'Airtel IDBI PM': 0,
    'Airtel CEDGE NAC': 1,
    'NPCI': 1,
  };

  // ---------- helpers ----------
  Future<void> _pickFromDate() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    );
    if (d != null) setState(() => _fromDate = d);
  }

  Future<void> _pickToDate() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _toDate ?? now,
      firstDate: DateTime(now.year - 2),
      lastDate: DateTime(now.year + 2),
    );
    if (d != null) setState(() => _toDate = d);
  }

  String _fmt(DateTime? d) =>
      d == null ? 'mm/dd/yyyy' : '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';

  // Horizontal scrollable plot wrapper – FIX for hasSize + long timelines
  Widget _hScrollChart({
    required double height,
    required double minWidth,
    required Widget child,
  }) {
    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, c) {
          final w = max(c.maxWidth, minWidth);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(width: w, child: child),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Analytics',
      centerTitle: true,
      actions: [
        IconButton(
          tooltip:
              Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
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
            child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 8),
      ],
      currentIndex: _selectedTab,
      onTabChanged: (i) => setState(() => _selectedTab = i),
      safeArea: false,
      reserveBottomPadding: true,
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          // 1) Generate Report
          _card(
            context,
            header: 'Generate Report',
            trailing: TextButton(
              onPressed: () => setState(() {
                _project = 'All Projects';
                _site = 'All Sites';
                _fromDate = null;
                _toDate = null;
              }),
              child: const Text('Clear All'),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(
                  builder: (ctx, c) {
                    final isWide = c.maxWidth >= 840;
                    final gap = isWide ? 12.0 : 0.0;

                    final left = [
                      _dropdownField(
                        label: 'Project',
                        value: _project,
                        items: _projects,
                        onChanged: (v) => setState(() => _project = v),
                      ),
                      _dateField(
                        label: 'From',
                        value: _fmt(_fromDate),
                        onTap: _pickFromDate,
                      ),
                    ];
                    final right = [
                      _dropdownField(
                        label: 'Site',
                        value: _site,
                        items: _sites,
                        onChanged: (v) => setState(() => _site = v),
                      ),
                      _dateField(
                        label: 'To',
                        value: _fmt(_toDate),
                        onTap: _pickToDate,
                      ),
                    ];

                    if (!isWide) {
                      return Column(children: [...left, ...right]);
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: Column(children: left)),
                        SizedBox(width: gap),
                        Expanded(child: Column(children: right)),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: cs.surfaceVariant,
                        foregroundColor: cs.onSurface,
                      ),
                      onPressed: () {},
                      child: const Text('Export'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: () {},
                      child: const Text('Export All', style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // 2) Activity Trend (Line) – scrollable plot
          _card(
            context,
            header: 'Activity Trend',
            trailing: _timelineDropdown(
              _tlLine,
              (v) => setState(() => _tlLine = v),
            ),
            child: _hScrollChart(
              height: 220,
              minWidth: 900,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (v) => FlLine(
                      color: cs.outlineVariant.withOpacity(.4),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 28,
                        showTitles: true,
                        getTitlesWidget: (v, m) => Text(
                          v.toInt().toString(),
                          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        getTitlesWidget: (v, m) => Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            '09/${(8 + v.toInt()).toString().padLeft(2, '0')}',
                            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
                          ),
                        ),
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  minX: 0,
                  maxX: 12,
                  minY: 0,
                  maxY: 6,
                  lineTouchData: LineTouchData(enabled: true),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _activityTrend,
                      isCurved: true,
                      barWidth: 2.4,
                      color: AppTheme.accentColor,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // 3) Activities by Category (Stacked Bars) – scrollable plot area + legend
          _card(
            context,
            header: 'Activities by Category',
            trailing: _timelineDropdown(
              _tlBars,
              (v) => setState(() => _tlBars = v),
            ),
            child: SizedBox(
              height: 260,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _hScrollChart(
                      height: 260,
                      minWidth: 700,
                      child: BarChart(
                        BarChartData(
                          barGroups: _buildStackGroups(cs),
                          gridData: FlGridData(
                            getDrawingHorizontalLine: (v) => FlLine(
                              color: cs.outlineVariant.withOpacity(.4),
                              strokeWidth: 1,
                            ),
                            drawVerticalLine: false,
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 28,
                                showTitles: true,
                                getTitlesWidget: (v, m) => Text(
                                  v.toInt().toString(),
                                  style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
                                ),
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (v, m) => Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    'Aug 2025',
                                    style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
                                  ),
                                ),
                              ),
                            ),
                            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          barTouchData: BarTouchData(enabled: true),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _legendBlock(cs),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // 4) Status Distribution (Donut)
          _card(
            context,
            header: 'Status Distribution',
            trailing: _timelineDropdown(
              _tlPie,
              (v) => setState(() => _tlPie = v),
            ),
            child: SizedBox(
              height: 240,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 55,
                  sections: [
                    PieChartSectionData(
                      value: 10,
                      color: const Color(0xFF95A5A6),
                      title: '10%',
                      radius: 60,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    PieChartSectionData(
                      value: 90,
                      color: const Color(0xFF20C77A),
                      title: '90%',
                      radius: 60,
                      titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // 5) FE Worked Across Projects – scrollable plot
          _card(
            context,
            header: 'FE Worked Across Projects',
            trailing: _projectDropdown(cs),
            child: _hScrollChart(
              height: 260,
              minWidth: 1000,
              child: BarChart(
                BarChartData(
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (v) => FlLine(
                      color: cs.outlineVariant.withOpacity(.4),
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 28,
                        showTitles: true,
                        getTitlesWidget: (v, m) => Text(
                          v.toInt().toString(),
                          style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
                        ),
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (v, m) {
                          final idx = v.toInt();
                          if (idx < 0 || idx >= _feAcrossProjects.keys.length) {
                            return const SizedBox.shrink();
                          }
                          final txt = _feAcrossProjects.keys.elementAt(idx);
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: SizedBox(
                              width: 70,
                              child: Transform.rotate(
                                angle: -0.6,
                                child: Text(
                                  txt,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    for (int i = 0; i < _feAcrossProjects.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: _feAcrossProjects.values.elementAt(i),
                            color: AppTheme.accentColor,
                            width: 18,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------- UI bits ----------
  Widget _card(BuildContext context,
      {required String header, Widget? trailing, required Widget child}) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(14),
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
                  header,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: cs.onSurface,
                      ),
                ),
              ),
              if (trailing != null) trailing,
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  Widget _dropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cs.outlineVariant),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: value,
                iconEnabledColor: cs.onSurfaceVariant,
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                style: TextStyle(color: cs.onSurface),
                items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dateField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: cs.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: cs.outlineVariant),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(color: cs.onSurface),
                    ),
                  ),
                  Icon(Icons.calendar_month, color: cs.onSurfaceVariant),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _timelineDropdown(String value, ValueChanged<String> onChanged) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          items: _timelineOptions
              .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
              .toList(),
        ),
      ),
    );
  }

  Widget _projectDropdown(ColorScheme cs) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border.all(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: 'All',
          onChanged: (_) {},
          items: const [
            DropdownMenuItem(value: 'All', child: Text('All')),
          ],
        ),
      ),
    );
  }

  Widget _legendBlock(ColorScheme cs) {
    const entries = [
      ['Breakdown', Color(0xFF20C77A)],
      ['New Installation', Color(0xFFF4D03F)],
      ['Upgrades', Color(0xFFE74C3C)],
      ['Corrective\nMaintenance', Color(0xFF95A5A6)],
      ['Preventive\nMaintenance', Color(0xFFF39C12)],
      ['Revisit', Color(0xFF3498DB)],
      ['Site Survey', Color(0xFF8E44AD)],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final e in entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(width: 14, height: 14, decoration: BoxDecoration(color: e[1] as Color, borderRadius: BorderRadius.circular(3))),
                const SizedBox(width: 8),
                Text(e[0] as String, style: TextStyle(color: cs.onSurface)),
              ],
            ),
          ),
      ],
    );
  }
}
