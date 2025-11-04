// // lib/ui/screens/analytics/analytics_screen.dart
// import 'dart:math';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../activities/add_activity_screen.dart';
// import '../users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// class AnalyticsScreen extends StatefulWidget {
//   const AnalyticsScreen({super.key});

//   @override
//   State<AnalyticsScreen> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreen> {
//   // int _selectedTab = 2;

//   // --- Filters (Generate Report) ---
//   String? _project = 'All Projects';
//   String? _site = 'All Sites';
//   DateTime? _fromDate;
//   DateTime? _toDate;

//   final List<String> _projects = const [
//     'All Projects',
//     'NPCI',
//     'TelstraApari',
//     'BPCL Aruba WIFI',
//   ];
//   final List<String> _sites = const [
//     'All Sites',
//     'Site 000',
//     'Site 001',
//     'Site 002',
//     'Site 003'
//   ];

//   // --- Timelines for charts ---
//   final List<String> _timelineOptions = const [
//     'Today',
//     'Last Week',
//     '15 Days',
//     '30 Days',
//     '3 Months',
//     '6 Months',
//   ];
//   String _tlLine = '15 Days';
//   String _tlBars = 'Today';
//   String _tlPie = '3 Months';

//   // --- Activity Trend data (sample) ---
//   final List<FlSpot> _activityTrend = const [
//     FlSpot(0, 0),
//     FlSpot(1, 0),
//     FlSpot(2, 0),
//     FlSpot(3, 0),
//     FlSpot(4, 0),
//     FlSpot(5, 5),
//     FlSpot(6, 0),
//     FlSpot(7, 0),
//     FlSpot(8, 0),
//     FlSpot(9, 0),
//     FlSpot(10, 0),
//     FlSpot(11, 0),
//     FlSpot(12, 0),
//   ];

//   void _handleTabChange(BuildContext context, int i) {
//   if (i == 3) return; // already on Analytics
//   late final Widget target;
//   switch (i) {
//     case 0: target = const DashboardScreen();     break;
//     case 1: target = const AddProjectScreen();    break;
//     case 2: target = const AddActivityScreen();   break;
//     case 4: target = const ViewUsersScreen();     break;
//     default: return;
//   }
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (_) => target),
//   );
// }

//   // --- Activities by Category (stacked bar) sample ---
//   // One stacked bar showing month buckets
//   List<BarChartGroupData> _buildStackGroups(ColorScheme cs) {
//     return [
//       BarChartGroupData(
//         x: 0,
//         barRods: [
//           BarChartRodData(
//             toY: 11,
//             rodStackItems: [
//               BarChartRodStackItem(0, 2, const Color(0xFF20C77A)), // Breakdown
//               BarChartRodStackItem(2, 6, const Color(0xFFF4D03F)), // New install
//               BarChartRodStackItem(6, 7, const Color(0xFFE74C3C)), // Upgrades
//               BarChartRodStackItem(7, 7.5, const Color(0xFF95A5A6)), // Corrective
//               BarChartRodStackItem(7.5, 10, const Color(0xFFF39C12)), // Preventive
//               BarChartRodStackItem(10, 10.5, const Color(0xFF3498DB)), // Revisit
//               BarChartRodStackItem(10.5, 11, const Color(0xFF8E44AD)), // Site Survey
//             ],
//             width: 28,
//             borderRadius: BorderRadius.circular(4),
//           ),
//         ],
//       ),
//     ];
//   }

//   // --- FE worked across projects (sample) ---
//   final Map<String, double> _feAcrossProjects = const {
//     'TCL GSTN': 0,
//     'TCL': 0,
//     'NDSatcom SAMOFA': 0,
//     'Airtel VC': 1,
//     'NTT HDFC VC': 4,
//     'SES': 0,
//     'Jio AMC': 0,
//     'SONY AMC': 0,
//     'Airtel SBMF': 1,
//     'Airtel Cedge onsite support': 0,
//     'TelstraApari': 0,
//     'BPCL Aruba WIFI': 0,
//     'Airtel IDBI PM': 0,
//     'Airtel CEDGE NAC': 1,
//     'NPCI': 1,
//   };

//   // ---------- helpers ----------
//   Future<void> _pickFromDate() async {
//     final now = DateTime.now();
//     final d = await showDatePicker(
//       context: context,
//       initialDate: _fromDate ?? now,
//       firstDate: DateTime(now.year - 2),
//       lastDate: DateTime(now.year + 2),
//     );
//     if (d != null) setState(() => _fromDate = d);
//   }

//   Future<void> _pickToDate() async {
//     final now = DateTime.now();
//     final d = await showDatePicker(
//       context: context,
//       initialDate: _toDate ?? now,
//       firstDate: DateTime(now.year - 2),
//       lastDate: DateTime(now.year + 2),
//     );
//     if (d != null) setState(() => _toDate = d);
//   }

//   String _fmt(DateTime? d) =>
//       d == null ? 'mm/dd/yyyy' : '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';

//   // Horizontal scrollable plot wrapper – FIX for hasSize + long timelines
//   Widget _hScrollChart({
//     required double height,
//     required double minWidth,
//     required Widget child,
//   }) {
//     return SizedBox(
//       height: height,
//       child: LayoutBuilder(
//         builder: (context, c) {
//           final w = max(c.maxWidth, minWidth);
//           return SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: SizedBox(width: w, child: child),
//           );
//         },
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Analytics',
//       centerTitle: true,
//       actions: [
//         IconButton(
//           tooltip:
//               Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
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
//           // icon: ClipOval(
//           //   child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           // ),
//           icon: const ProfileAvatar(size: 36),

//         ),
//         const SizedBox(width: 8),
//       ],
//       // currentIndex: _selectedTab,
//       // onTabChanged: (i) => setState(() => _selectedTab = i),
//       currentIndex: 3,                                  // Analytics tab index
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           // 1) Generate Report
//           _card(
//             context,
//             header: 'Generate Report',
//             trailing: TextButton(
//               onPressed: () => setState(() {
//                 _project = 'All Projects';
//                 _site = 'All Sites';
//                 _fromDate = null;
//                 _toDate = null;
//               }),
//               child: const Text('Clear All'),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 LayoutBuilder(
//                   builder: (ctx, c) {
//                     final isWide = c.maxWidth >= 840;
//                     final gap = isWide ? 12.0 : 0.0;

//                     final left = [
//                       _dropdownField(
//                         label: 'Project',
//                         value: _project,
//                         items: _projects,
//                         onChanged: (v) => setState(() => _project = v),
//                       ),
//                       _dateField(
//                         label: 'From',
//                         value: _fmt(_fromDate),
//                         onTap: _pickFromDate,
//                       ),
//                     ];
//                     final right = [
//                       _dropdownField(
//                         label: 'Site',
//                         value: _site,
//                         items: _sites,
//                         onChanged: (v) => setState(() => _site = v),
//                       ),
//                       _dateField(
//                         label: 'To',
//                         value: _fmt(_toDate),
//                         onTap: _pickToDate,
//                       ),
//                     ];

//                     if (!isWide) {
//                       return Column(children: [...left, ...right]);
//                     }
//                     return Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(child: Column(children: left)),
//                         SizedBox(width: gap),
//                         Expanded(child: Column(children: right)),
//                       ],
//                     );
//                   },
//                 ),
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: cs.surfaceContainerHighest,
//                         foregroundColor: cs.onSurface,
//                       ),
//                       onPressed: () {},
//                       child: const Text('Export'),
//                     ),
//                     const SizedBox(width: 10),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppTheme.accentColor,
//                         foregroundColor: Colors.black,
//                       ),
//                       onPressed: () {},
//                       child: const Text('Export All', style: TextStyle(fontWeight: FontWeight.w800)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 14),

//           // 2) Activity Trend (Line) – scrollable plot
//           _card(
//             context,
//             header: 'Activity Trend',
//             trailing: _timelineDropdown(
//               _tlLine,
//               (v) => setState(() => _tlLine = v),
//             ),
//             child: _hScrollChart(
//               height: 220,
//               minWidth: 900,
//               child: LineChart(
//                 LineChartData(
//                   gridData: FlGridData(
//                     drawVerticalLine: false,
//                     getDrawingHorizontalLine: (v) => FlLine(
//                       color: cs.outlineVariant.withOpacity(.4),
//                       strokeWidth: 1,
//                     ),
//                   ),
//                   titlesData: FlTitlesData(
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         reservedSize: 28,
//                         showTitles: true,
//                         getTitlesWidget: (v, m) => Text(
//                           v.toInt().toString(),
//                           style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
//                         ),
//                       ),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         interval: 1,
//                         getTitlesWidget: (v, m) => Padding(
//                           padding: const EdgeInsets.only(top: 6),
//                           child: Text(
//                             '09/${(8 + v.toInt()).toString().padLeft(2, '0')}',
//                             style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
//                           ),
//                         ),
//                       ),
//                     ),
//                     rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   ),
//                   minX: 0,
//                   maxX: 12,
//                   minY: 0,
//                   maxY: 6,
//                   lineTouchData: LineTouchData(enabled: true),
//                   borderData: FlBorderData(show: false),
//                   lineBarsData: [
//                     LineChartBarData(
//                       spots: _activityTrend,
//                       isCurved: true,
//                       barWidth: 2.4,
//                       color: AppTheme.accentColor,
//                       dotData: FlDotData(show: true),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 14),

//           // 3) Activities by Category (Stacked Bars) – scrollable plot area + legend
//           _card(
//             context,
//             header: 'Activities by Category',
//             trailing: _timelineDropdown(
//               _tlBars,
//               (v) => setState(() => _tlBars = v),
//             ),
//             child: SizedBox(
//               height: 260,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: _hScrollChart(
//                       height: 260,
//                       minWidth: 700,
//                       child: BarChart(
//                         BarChartData(
//                           barGroups: _buildStackGroups(cs),
//                           gridData: FlGridData(
//                             getDrawingHorizontalLine: (v) => FlLine(
//                               color: cs.outlineVariant.withOpacity(.4),
//                               strokeWidth: 1,
//                             ),
//                             drawVerticalLine: false,
//                           ),
//                           titlesData: FlTitlesData(
//                             leftTitles: AxisTitles(
//                               sideTitles: SideTitles(
//                                 reservedSize: 28,
//                                 showTitles: true,
//                                 getTitlesWidget: (v, m) => Text(
//                                   v.toInt().toString(),
//                                   style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                             bottomTitles: AxisTitles(
//                               sideTitles: SideTitles(
//                                 showTitles: true,
//                                 getTitlesWidget: (v, m) => Padding(
//                                   padding: const EdgeInsets.only(top: 4),
//                                   child: Text(
//                                     'Aug 2025',
//                                     style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                             topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                           ),
//                           borderData: FlBorderData(show: false),
//                           barTouchData: BarTouchData(enabled: true),
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   _legendBlock(cs),
//                 ],
//               ),
//             ),
//           ),

//           const SizedBox(height: 14),

//           // 4) Status Distribution (Donut)
//           _card(
//             context,
//             header: 'Status Distribution',
//             trailing: _timelineDropdown(
//               _tlPie,
//               (v) => setState(() => _tlPie = v),
//             ),
//             child: SizedBox(
//               height: 240,
//               child: PieChart(
//                 PieChartData(
//                   sectionsSpace: 2,
//                   centerSpaceRadius: 55,
//                   sections: [
//                     PieChartSectionData(
//                       value: 10,
//                       color: const Color(0xFF95A5A6),
//                       title: '10%',
//                       radius: 60,
//                       titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                     ),
//                     PieChartSectionData(
//                       value: 90,
//                       color: const Color(0xFF20C77A),
//                       title: '90%',
//                       radius: 60,
//                       titleStyle: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),

//           const SizedBox(height: 14),

//           // 5) FE Worked Across Projects – scrollable plot
//           _card(
//             context,
//             header: 'FE Worked Across Projects',
//             trailing: _projectDropdown(cs),
//             child: _hScrollChart(
//               height: 260,
//               minWidth: 1000,
//               child: BarChart(
//                 BarChartData(
//                   gridData: FlGridData(
//                     drawVerticalLine: false,
//                     getDrawingHorizontalLine: (v) => FlLine(
//                       color: cs.outlineVariant.withOpacity(.4),
//                       strokeWidth: 1,
//                     ),
//                   ),
//                   titlesData: FlTitlesData(
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         reservedSize: 28,
//                         showTitles: true,
//                         getTitlesWidget: (v, m) => Text(
//                           v.toInt().toString(),
//                           style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
//                         ),
//                       ),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (v, m) {
//                           final idx = v.toInt();
//                           if (idx < 0 || idx >= _feAcrossProjects.keys.length) {
//                             return const SizedBox.shrink();
//                           }
//                           final txt = _feAcrossProjects.keys.elementAt(idx);
//                           return Padding(
//                             padding: const EdgeInsets.only(top: 6),
//                             child: SizedBox(
//                               width: 70,
//                               child: Transform.rotate(
//                                 angle: -0.6,
//                                 child: Text(
//                                   txt,
//                                   textAlign: TextAlign.right,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(color: cs.onSurfaceVariant, fontSize: 10),
//                                 ),
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                   ),
//                   borderData: FlBorderData(show: false),
//                   barGroups: [
//                     for (int i = 0; i < _feAcrossProjects.length; i++)
//                       BarChartGroupData(
//                         x: i,
//                         barRods: [
//                           BarChartRodData(
//                             toY: _feAcrossProjects.values.elementAt(i),
//                             color: AppTheme.accentColor,
//                             width: 18,
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ---------- UI bits ----------
//   Widget _card(BuildContext context,
//       {required String header, Widget? trailing, required Widget child}) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       padding: const EdgeInsets.all(14),
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   header,
//                   style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         fontWeight: FontWeight.w800,
//                         color: cs.onSurface,
//                       ),
//                 ),
//               ),
//               if (trailing != null) trailing,
//             ],
//           ),
//           const SizedBox(height: 8),
//           Divider(color: cs.outlineVariant),
//           const SizedBox(height: 8),
//           child,
//         ],
//       ),
//     );
//   }

//   Widget _dropdownField({
//     required String label,
//     required String? value,
//     required List<String> items,
//     required ValueChanged<String?> onChanged,
//   }) {
//     final cs = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 6),
//           Container(
//             decoration: BoxDecoration(
//               color: cs.surface,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: cs.outlineVariant),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 isExpanded: true,
//                 value: value,
//                 iconEnabledColor: cs.onSurfaceVariant,
//                 dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//                 style: TextStyle(color: cs.onSurface),
//                 items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
//                 onChanged: onChanged,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _dateField({
//     required String label,
//     required String value,
//     required VoidCallback onTap,
//   }) {
//     final cs = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12, fontWeight: FontWeight.w600)),
//           const SizedBox(height: 6),
//           InkWell(
//             onTap: onTap,
//             borderRadius: BorderRadius.circular(8),
//             child: Container(
//               height: 44,
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               decoration: BoxDecoration(
//                 color: cs.surface,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: cs.outlineVariant),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       value,
//                       style: TextStyle(color: cs.onSurface),
//                     ),
//                   ),
//                   Icon(Icons.calendar_month, color: cs.onSurfaceVariant),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _timelineDropdown(String value, ValueChanged<String> onChanged) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       height: 38,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: cs.surface,
//         border: Border.all(color: cs.outlineVariant),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: value,
//           onChanged: (v) {
//             if (v != null) onChanged(v);
//           },
//           items: _timelineOptions
//               .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
//               .toList(),
//         ),
//       ),
//     );
//   }

//   Widget _projectDropdown(ColorScheme cs) {
//     return Container(
//       height: 38,
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         color: cs.surface,
//         border: Border.all(color: cs.outlineVariant),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<String>(
//           value: 'All',
//           onChanged: (_) {},
//           items: const [
//             DropdownMenuItem(value: 'All', child: Text('All')),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _legendBlock(ColorScheme cs) {
//     const entries = [
//       ['Breakdown', Color(0xFF20C77A)],
//       ['New Installation', Color(0xFFF4D03F)],
//       ['Upgrades', Color(0xFFE74C3C)],
//       ['Corrective\nMaintenance', Color(0xFF95A5A6)],
//       ['Preventive\nMaintenance', Color(0xFFF39C12)],
//       ['Revisit', Color(0xFF3498DB)],
//       ['Site Survey', Color(0xFF8E44AD)],
//     ];

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         for (final e in entries)
//           Padding(
//             padding: const EdgeInsets.only(bottom: 8),
//             child: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Container(width: 14, height: 14, decoration: BoxDecoration(color: e[1] as Color, borderRadius: BorderRadius.circular(3))),
//                 const SizedBox(width: 8),
//                 Text(e[0] as String, style: TextStyle(color: cs.onSurface)),
//               ],
//             ),
//           ),
//       ],
//     );
//   }
// }

// p4//
// lib/ui/screens/analytics/analytics_screen.dart
import 'dart:convert';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:http/http.dart' as http;

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../../core/api_client.dart';

import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../activities/add_activity_screen.dart';
import '../users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

// ─────────────────────────────────────────────────────────────────────────────
// Helpers / models
// ─────────────────────────────────────────────────────────────────────────────
class _ProjectItem {
  final String id;
  final String name;
  _ProjectItem(this.id, this.name);
}

enum _TL { today, lastWeek, days15, days30, months3, months6 }

const _tlLabels = {
  _TL.today: 'Today',
  _TL.lastWeek: 'Last Week',
  _TL.days15: '15 Days',
  _TL.days30: '30 Days',
  _TL.months3: '3 Months',
  _TL.months6: '6 Months',
};

String _tlToParam(_TL tl) =>
    {
      _TL.today: 'today',
      _TL.lastWeek: 'lastWeek',
      _TL.days15: '15Days',
      _TL.days30: '30Days',
      _TL.months3: '3Months',
      _TL.months6: '6Months',
    }[tl]!;

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  // Filters (Generate Report)
  _ProjectItem? _selectedProject; // null => All Projects
  String? _selectedSite; // null => All Sites
  DateTime? _fromDate;
  DateTime? _toDate;

  // Lookups
  final List<_ProjectItem> _projects = [];
  List<String> _sitesForProject = [];

  // Timelines
  _TL _tlLine = _TL.days15;
  _TL _tlBars = _TL.today;
  _TL _tlPie = _TL.months3;

  // KPI totals
  int _kpiTotal = 0, _kpiCompleted = 0, _kpiPending = 0, _kpiInProgress = 0;

  // Charts
  List<String> _trendLabels = const []; // NEW: x-axis labels from API
  List<FlSpot> _activityTrend = const [FlSpot(0, 0)];

  List<BarChartGroupData> _categoryBars = const [];
  List<String> _categoryLabels = const [];

  int _statusOpen = 0,
      _statusCompleted = 0,
      _statusPending = 0,
      _statusInProg = 0;

  // FE counts (now independently filterable like web)
  List<String> _feLabels = const [];
  List<double> _feCounts = const [];
  String _feProjectId = 'all'; // "all" or project id

  ApiClient get _api => context.read<ApiClient>();

  @override
  void initState() {
    super.initState();
    _prime();
  }

  Future<void> _prime() async {
    await _loadProjects();
    await _refreshAll();
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Routing (bottom nav)
  // ───────────────────────────────────────────────────────────────────────────
  void _handleTabChange(BuildContext context, int i) {
    if (i == 3) return; // already on Analytics
    late final Widget target;
    switch (i) {
      case 0:
        target = const DashboardScreen();
        break;
      case 1:
        target = const AddProjectScreen();
        break;
      case 2:
        target = const AddActivityScreen();
        break;
      case 4:
        target = const ViewUsersScreen();
        break;
      default:
        return;
    }
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Data loading
  // ───────────────────────────────────────────────────────────────────────────
  Future<void> _loadProjects() async {
    try {
      final r = await _api.get('/api/projects');
      if (r.statusCode != 200) return;
      final list = jsonDecode(utf8.decode(r.bodyBytes)) as List;
      _projects
        ..clear()
        ..addAll(
          list.map((p) => _ProjectItem('${p['id']}', '${p['project_name']}')),
        );
      setState(() {});
    } catch (_) {}
  }

  Future<void> _loadSitesForProject(_ProjectItem? p) async {
    if (p == null) {
      setState(() => _sitesForProject = []);
      return;
    }
    try {
      final r = await _api.get(
        '/api/project-sites/by-project-name/${Uri.encodeComponent(p.name)}',
      );
      if (r.statusCode != 200) return;
      final list =
          (jsonDecode(utf8.decode(r.bodyBytes)) as List)
              .map((e) => '${e['site_name']}')
              .toList();
      setState(() => _sitesForProject = list);
    } catch (_) {}
  }

  String get _projectIdOrAll => _selectedProject?.id ?? 'all';

  Future<int> _fetchCount({String? status}) async {
    final qp = {
      if (_projectIdOrAll != 'all') 'projectId': _projectIdOrAll,
      if (status != null) 'status': status,
    };
    final r = await _api.get('/api/activities/count', query: qp);
    if (r.statusCode != 200) return 0;
    return (jsonDecode(utf8.decode(r.bodyBytes)) as Map)['count'] as int? ?? 0;
  }

  Future<void> _loadKpis() async {
    try {
      final results = await Future.wait([
        _fetchCount(),
        _fetchCount(status: 'Completed'),
        _fetchCount(status: 'Pending'),
        _fetchCount(status: 'In Progress'),
      ]);
      setState(() {
        _kpiTotal = results[0];
        _kpiCompleted = results[1];
        _kpiPending = results[2];
        _kpiInProgress = results[3];
      });
    } catch (_) {}
  }

  Future<void> _loadTrend() async {
    try {
      final r = await _api.get(
        '/api/analytics/trend',
        query: {'projectId': _projectIdOrAll, 'tl': _tlToParam(_tlLine)},
      );
      if (r.statusCode != 200) return;
      final m = jsonDecode(utf8.decode(r.bodyBytes)) as Map;
      final labels = (m['labels'] as List?)?.cast<String>() ?? [];
      final data = (m['data'] as List).cast<num>();
      setState(() {
        _trendLabels =
            labels.isNotEmpty
                ? labels
                : List.generate(data.length, (i) => '${i + 1}');
        _activityTrend = [
          for (int i = 0; i < data.length; i++)
            FlSpot(i.toDouble(), data[i].toDouble()),
        ];
      });
    } catch (_) {}
  }

  Future<void> _loadCategories() async {
    try {
      final r = await _api.get(
        '/api/analytics/categories',
        query: {'projectId': _projectIdOrAll, 'tl': _tlToParam(_tlBars)},
      );
      if (r.statusCode != 200) return;
      final m = jsonDecode(utf8.decode(r.bodyBytes)) as Map;
      final labels = (m['labels'] as List).cast<String>();
      final datasets = (m['datasets'] as List).cast<Map>();

      final groups = <BarChartGroupData>[];
      for (int x = 0; x < labels.length; x++) {
        double start = 0;
        final items = <BarChartRodStackItem>[];
        for (int d = 0; d < datasets.length; d++) {
          final v = (datasets[d]['data'] as List)[x] as num? ?? 0;
          final end = start + v.toDouble();
          items.add(BarChartRodStackItem(start, end, _catColor(d)));
          start = end;
        }
        groups.add(
          BarChartGroupData(
            x: x,
            barRods: [
              BarChartRodData(
                toY: items.isEmpty ? 0 : items.last.toY,
                rodStackItems: items,
                width: 28,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
          ),
        );
      }
      setState(() {
        _categoryBars = groups;
        _categoryLabels = labels;
      });
    } catch (_) {}
  }

  Color _catColor(int i) {
    switch (i) {
      case 0:
        return const Color(0xFF20C77A); // Breakdown
      case 1:
        return const Color(0xFFFBDF3B); // New Installation
      case 2:
        return const Color(0xFFE53935); // Upgrades
      case 3:
        return const Color(0xFF9E9E9E); // Corrective
      case 4:
        return const Color(0xFFFFB300); // Preventive
      case 5:
        return const Color(0xFF29B6F6); // Revisit
      case 6:
        return const Color(0xFFD946EF); // Site Survey
      default:
        return const Color(0xFF7C7C7C); // Others
    }
  }

  Future<void> _loadStatus() async {
    try {
      final r = await _api.get(
        '/api/analytics/status',
        query: {'projectId': _projectIdOrAll, 'tl': _tlToParam(_tlPie)},
      );
      if (r.statusCode != 200) return;
      final m = jsonDecode(utf8.decode(r.bodyBytes)) as Map;
      setState(() {
        _statusOpen = (m['open'] ?? 0) as int;
        _statusCompleted = (m['completed'] ?? 0) as int;
        _statusPending = (m['pending'] ?? 0) as int;
        _statusInProg = (m['inProgress'] ?? 0) as int;
      });
    } catch (_) {}
  }

  Future<void> _loadFeCounts() async {
    try {
      final r = await _api.get(
        '/api/analytics/fe-counts',
        query: _feProjectId == 'all' ? null : {'projectId': _feProjectId},
      );
      if (r.statusCode != 200) return;
      final list = (jsonDecode(utf8.decode(r.bodyBytes)) as List).cast<Map>();
      setState(() {
        _feLabels = list.map((e) => '${e['name']}').toList();
        _feCounts = list.map((e) => (e['count'] as num).toDouble()).toList();
      });
    } catch (_) {}
  }

  Future<void> _refreshAll() async {
    await Future.wait([
      _loadKpis(),
      _loadTrend(),
      _loadCategories(),
      _loadStatus(),
      _loadFeCounts(),
    ]);
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Export
  // ───────────────────────────────────────────────────────────────────────────
  Future<void> _exportAll() async {
    final url = '${_api.baseUrl}/api/activities/export';
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  Future<void> _exportFiltered() async {
    String url = '${_api.baseUrl}/api/activities/export';
    if (_selectedProject != null) {
      url += '/project/${Uri.encodeComponent(_selectedProject!.name)}';
      if (_selectedSite != null) {
        url += '/site/${Uri.encodeComponent(_selectedSite!)}';
      }
    }
    final qs = <String>[];
    if (_fromDate != null) {
      final f =
          '${_fromDate!.year}-${_fromDate!.month.toString().padLeft(2, '0')}-${_fromDate!.day.toString().padLeft(2, '0')}';
      qs.add('from=$f');
    }
    if (_toDate != null) {
      final t =
          '${_toDate!.year}-${_toDate!.month.toString().padLeft(2, '0')}-${_toDate!.day.toString().padLeft(2, '0')}';
      qs.add('to=$t');
    }
    if (qs.isNotEmpty) url += '?${qs.join('&')}';
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Date helpers
  // ───────────────────────────────────────────────────────────────────────────
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
      d == null
          ? 'mm/dd/yyyy'
          : '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';

  double _headroom(double v) =>
      v <= 0 ? 1 : v * 1.12 + 1; // 12% + 1 unit of padding

  // ───────────────────────────────────────────────────────────────────────────
  // UI
  // ───────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final hasFilter =
        _selectedProject != null ||
        _selectedSite != null ||
        _fromDate != null ||
        _toDate != null;

    // line chart headroom
    final lineYMax =
        _activityTrend.isEmpty
            ? 1.0
            : _activityTrend.map((e) => e.y).reduce(max) * 1.1;

    // category bars headroom
    double _categoryMaxY() {
      double m = 1;
      for (final g in _categoryBars) {
        if (g.barRods.isEmpty) continue;
        m = max(m, g.barRods.first.toY);
      }
      return m * 1.1;
    }

    return MainLayout(
      title: 'Analytics',
      centerTitle: true,
      currentIndex: 3,
      onTabChanged: (i) => _handleTabChange(context, i),
      safeArea: false,
      reserveBottomPadding: true,
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
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          // Generate Report
          _card(
            context,
            header: 'Generate Report',
            trailing: TextButton(
              onPressed: () async {
                setState(() {
                  _selectedProject = null;
                  _selectedSite = null;
                  _fromDate = null;
                  _toDate = null;
                  _sitesForProject = [];
                });
                await _refreshAll();
              },
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
                      _projectDropdownField(
                        label: 'Project',
                        value: _selectedProject,
                        items: _projects,
                        onChanged: (v) async {
                          setState(() {
                            _selectedProject = v;
                            _selectedSite = null;
                          });
                          await _loadSitesForProject(v);
                          await _refreshAll();
                        },
                      ),
                      _dateField(
                        label: 'From',
                        value: _fmt(_fromDate),
                        onTap: _pickFromDate,
                      ),
                    ];
                    final right = [
                      _siteDropdownField(
                        label: 'Site',
                        value: _selectedSite,
                        items: _sitesForProject,
                        enabled: _selectedProject != null,
                        onChanged: (v) => setState(() => _selectedSite = v),
                      ),
                      _dateField(
                        label: 'To',
                        value: _fmt(_toDate),
                        onTap: _pickToDate,
                      ),
                    ];

                    if (!isWide) return Column(children: [...left, ...right]);
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
                        backgroundColor: cs.surfaceContainerHighest,
                        foregroundColor: cs.onSurface,
                      ),
                      onPressed: hasFilter ? _exportFiltered : null,
                      child: const Text('Export'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        foregroundColor: Colors.black,
                      ),
                      onPressed: hasFilter ? null : _exportAll,
                      child: const Text(
                        'Export All',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // KPI cards (uniform size; count left; compact labels)
          _kpiGrid(cs),

          const SizedBox(height: 14),

          // Activity Trend (Line) — labels from API + scroll
          _card(
            context,
            header: 'Activity Trend',
            trailing: _timelineDropdown(
              value: _tlLine,
              onChanged: (v) async {
                setState(() => _tlLine = v);
                await _loadTrend();
              },
            ),
            child: SizedBox(
              height: 240,
              child: LayoutBuilder(
                builder: (context, c) {
                  final minWidth = max(720.0, _trendLabels.length * 110.0);
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SizedBox(
                      width: max(c.maxWidth, minWidth),
                      child: LineChart(
                        LineChartData(
                          minY: 0,

                          maxY: lineYMax <= 0 ? 1 : lineYMax,
                          clipData: const FlClipData.none(),
                          gridData: FlGridData(
                            drawVerticalLine: false,
                            getDrawingHorizontalLine:
                                (v) => FlLine(
                                  color: cs.outlineVariant.withOpacity(.4),
                                  strokeWidth: 1,
                                ),
                          ),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 36,
                                showTitles: true,
                                getTitlesWidget:
                                    (v, m) => Text(
                                      v.toInt().toString(),
                                      style: TextStyle(
                                        color: cs.onSurfaceVariant,
                                        fontSize: 11,
                                      ),
                                    ),
                              ),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 28,
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (v, m) {
                                  final i = v.toInt();
                                  if (i < 0 || i >= _trendLabels.length)
                                    return const SizedBox.shrink();
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: Text(
                                      _trendLabels[i],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: cs.onSurfaceVariant,
                                        fontSize: 11,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            rightTitles: const AxisTitles(
                              sideTitles: SideTitles(showTitles: false),
                            ),

                            // topTitles: const AxisTitles(
                            //   sideTitles: SideTitles(showTitles: false),
                            // ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize:
                                    14, // top padding so the top gridline doesn’t touch the edge
                                getTitlesWidget:
                                    (v, m) => const SizedBox.shrink(),
                              ),
                            ),
                          ),
                          minX: 0,
                          maxX:
                              (_activityTrend.isEmpty
                                      ? 1
                                      : _activityTrend.length - 1)
                                  .toDouble(),
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
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Activities by Category (Stacked Bars) – scroll room + no overflow
          _card(
            context,
            header: 'Activities by Category',
            trailing: _timelineDropdown(
              value: _tlBars,
              onChanged: (v) async {
                setState(() => _tlBars = v);
                await _loadCategories();
              },
            ),
            child: SizedBox(
              height: 310,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, c) {
                        final minWidth = max(
                          720.0,
                          _categoryBars.length * 140.0,
                        );
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: max(c.maxWidth, minWidth),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: BarChart(
                                BarChartData(
                                  minY: 0,
                                  maxY: _categoryMaxY(),
                                  groupsSpace:
                                      18, // breathing room between bars
                                  barGroups: _categoryBars,

                                  gridData: FlGridData(
                                    getDrawingHorizontalLine:
                                        (v) => FlLine(
                                          color: cs.outlineVariant.withOpacity(
                                            .4,
                                          ),
                                          strokeWidth: 1,
                                        ),
                                    drawVerticalLine: false,
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        reservedSize: 36,
                                        showTitles: true,
                                        getTitlesWidget:
                                            (v, m) => Text(
                                              v.toInt().toString(),
                                              style: TextStyle(
                                                color: cs.onSurfaceVariant,
                                                fontSize: 11,
                                              ),
                                            ),
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        reservedSize: 28,
                                        showTitles: true,
                                        getTitlesWidget: (v, m) {
                                          final i = v.toInt();
                                          if (i < 0 ||
                                              i >= _categoryLabels.length) {
                                            return const SizedBox.shrink();
                                          }
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                              top: 4,
                                            ),
                                            child: Text(
                                              _categoryLabels[i],
                                              style: TextStyle(
                                                color: cs.onSurfaceVariant,
                                                fontSize: 11,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    // topTitles: const AxisTitles(
                                    //   sideTitles: SideTitles(showTitles: false),
                                    // ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 14,
                                        getTitlesWidget:
                                            (v, m) => const SizedBox.shrink(),
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  barTouchData: BarTouchData(enabled: true),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 150,
                    child: SingleChildScrollView(child: _legendBlock(cs)),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

          // Status Distribution (Donut with % labels)
          //   _card(
          //     context,
          //     header: 'Status Distribution',
          //     trailing: _timelineDropdown(
          //       value: _tlPie,
          //       onChanged: (v) async {
          //         setState(() => _tlPie = v);
          //       await _loadStatus();
          //     },
          //   ),
          //   child: SizedBox(
          //     height: 260,
          //     child: Builder(
          //       builder: (context) {
          //         final total =
          //             _statusOpen +
          //             _statusCompleted +
          //             _statusPending +
          //             _statusInProg;
          //         if (total == 0) {
          //           return Center(
          //             child: Text(
          //               'No records for this timeline',
          //               style: TextStyle(color: cs.onSurfaceVariant),
          //             ),
          //           );
          //         }
          //         double pct(num v) => total == 0 ? 0 : (v / total * 100);
          //         String label(num v) =>
          //             pct(v) == 0 ? '' : '${pct(v).round()}%';

          //         return PieChart(
          //           PieChartData(
          //             sectionsSpace: 2,
          //             centerSpaceRadius: 55,
          //             sections: [
          //               PieChartSectionData(
          //                 value: _statusOpen.toDouble(),
          //                 color: const Color(0xFF95A5A6),
          //                 title: label(_statusOpen),
          //                 radius: 62,
          //                 titleStyle: const TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               PieChartSectionData(
          //                 value: _statusCompleted.toDouble(),
          //                 color: const Color(0xFF20C77A),
          //                 title: label(_statusCompleted),
          //                 radius: 62,
          //                 titleStyle: const TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               PieChartSectionData(
          //                 value: _statusPending.toDouble(),
          //                 color: const Color(0xFFFBDF3B),
          //                 title: label(_statusPending),
          //                 radius: 62,
          //                 titleStyle: const TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //               PieChartSectionData(
          //                 value: _statusInProg.toDouble(),
          //                 color: const Color(0xFFE53935),
          //                 title: label(_statusInProg),
          //                 radius: 62,
          //                 titleStyle: const TextStyle(
          //                   color: Colors.white,
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.bold,
          //                 ),
          //               ),
          //             ],
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),

          // Status Distribution (Donut with % labels + legend row)
          _card(
            context,
            header: 'Status Distribution',
            trailing: _timelineDropdown(
              value: _tlPie,
              onChanged: (v) async {
                setState(() => _tlPie = v);
                await _loadStatus();
              },
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // legend row
                Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _statusLegendChip(const Color(0xFF95A5A6), 'Open', cs),
                    _statusLegendChip(const Color(0xFF20C77A), 'Completed', cs),
                    _statusLegendChip(const Color(0xFFFBDF3B), 'Pending', cs),
                    _statusLegendChip(
                      const Color(0xFFE53935),
                      'In-Progress',
                      cs,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 220,
                  child: Builder(
                    builder: (context) {
                      final total =
                          _statusOpen +
                          _statusCompleted +
                          _statusPending +
                          _statusInProg;
                      if (total == 0) {
                        return Center(
                          child: Text(
                            'No records for this timeline',
                            style: TextStyle(color: cs.onSurfaceVariant),
                          ),
                        );
                      }
                      double pct(num v) => total == 0 ? 0 : (v / total * 100);
                      String label(num v) =>
                          pct(v) == 0 ? '' : '${pct(v).round()}%';

                      return PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 55,
                          sections: [
                            PieChartSectionData(
                              value: _statusOpen.toDouble(),
                              color: const Color(0xFF95A5A6),
                              title: label(_statusOpen),
                              radius: 62,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value: _statusCompleted.toDouble(),
                              color: const Color(0xFF20C77A),
                              title: label(_statusCompleted),
                              radius: 62,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value: _statusPending.toDouble(),
                              color: const Color(0xFFFBDF3B),
                              title: label(_statusPending),
                              radius: 62,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            PieChartSectionData(
                              value: _statusInProg.toDouble(),
                              color: const Color(0xFFE53935),
                              title: label(_statusInProg),
                              radius: 62,
                              titleStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 14),

          // FE Worked Across Projects – dropdown + scroll + spacing + headroom
          _card(
            context,
            header: 'FE Worked Across Projects',
            trailing: _feProjectDropdown(cs),
            child: _feBarChart(cs),
          ),
        ],
      ),
    );
  }

  // ───────────────────────────────────────────────────────────────────────────
  // Small UI helpers
  // ───────────────────────────────────────────────────────────────────────────

  // Uniform KPI grid
  Widget _kpiGrid(ColorScheme cs) {
    final items = [
      ('Total Activities', _kpiTotal),
      ('Completed', _kpiCompleted),
      ('Pending', _kpiPending),
      ('In-Progress', _kpiInProgress),
    ];

    Widget cell(String label, int value) {
      return Container(
        height: 120,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // number on left
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              maxLines: label == 'Total Activities' ? 2 : 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
            Text(
              '$value',
              style: TextStyle(
                color: cs.onSurface,
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      );
    }

    return LayoutBuilder(
      builder: (ctx, c) {
        final isTwo = c.maxWidth > 520;
        final spacing = 12.0;
        return Wrap(
          runSpacing: spacing,
          spacing: spacing,
          children:
              items
                  .map(
                    (e) => SizedBox(
                      width: isTwo ? (c.maxWidth - spacing) / 2 : c.maxWidth,
                      child: cell(e.$1, e.$2),
                    ),
                  )
                  .toList(),
        );
      },
    );
  }

  Widget _card(
    BuildContext context, {
    required String header,
    Widget? trailing,
    required Widget child,
  }) {
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

  Widget _statusLegendChip(Color color, String label, ColorScheme cs) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: TextStyle(color: cs.onSurface)),
      ],
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
          Text(
            label,
            style: TextStyle(
              color: cs.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
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
                    child: Text(value, style: TextStyle(color: cs.onSurface)),
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

  Widget _timelineDropdown({
    required _TL value,
    required ValueChanged<_TL> onChanged,
  }) {
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
        child: DropdownButton<_TL>(
          value: value,
          onChanged: (v) {
            if (v != null) onChanged(v);
          },
          items:
              _TL.values
                  .map(
                    (e) => DropdownMenuItem<_TL>(
                      value: e,
                      child: Text(_tlLabels[e]!),
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }

  Widget _legendBlock(ColorScheme cs) {
    const entries = [
      ['Breakdown', Color(0xFF20C77A)],
      ['New Installation', Color(0xFFFBDF3B)],
      ['Upgrades', Color(0xFFE53935)],
      ['Corrective\nMaintenance', Color(0xFF9E9E9E)],
      ['Preventive\nMaintenance', Color(0xFFFFB300)],
      ['Revisit', Color(0xFF29B6F6)],
      ['Site Survey', Color(0xFFD946EF)],
      ['Others', Color(0xFF7C7C7C)],
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
                Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: e[1] as Color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    e[0] as String,
                    style: TextStyle(color: cs.onSurface),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Project dropdown (All + fetched)
  Widget _projectDropdownField({
    required String label,
    required _ProjectItem? value,
    required List<_ProjectItem> items,
    required ValueChanged<_ProjectItem?> onChanged,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: cs.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Container(
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: cs.outlineVariant),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<_ProjectItem?>(
                isExpanded: true,
                value: value,
                iconEnabledColor: cs.onSurfaceVariant,
                dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                style: TextStyle(color: cs.onSurface),
                items: [
                  const DropdownMenuItem<_ProjectItem?>(
                    value: null,
                    child: Text('All Projects'),
                  ),
                  ...items.map(
                    (e) => DropdownMenuItem<_ProjectItem?>(
                      value: e,
                      child: Text(e.name, overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ],
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Site dropdown (All + fetched for project)
  Widget _siteDropdownField({
    required String label,
    required String? value,
    required List<String> items,
    required bool enabled,
    required ValueChanged<String?> onChanged,
  }) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: cs.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Opacity(
            opacity: enabled ? 1 : 0.6,
            child: IgnorePointer(
              ignoring: !enabled,
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: cs.outlineVariant),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String?>(
                    isExpanded: true,
                    value: value,
                    iconEnabledColor: cs.onSurfaceVariant,
                    dropdownColor: Theme.of(context).scaffoldBackgroundColor,
                    style: TextStyle(color: cs.onSurface),
                    items: [
                      const DropdownMenuItem<String?>(
                        value: null,
                        child: Text('All Sites'),
                      ),
                      ...items.map(
                        (e) => DropdownMenuItem<String?>(
                          value: e,
                          child: Text(e, overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ],
                    onChanged: onChanged,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FE project filter dropdown (All + projects)
  Widget _feProjectDropdown(ColorScheme cs) {
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
          value: _feProjectId,
          onChanged: (v) async {
            if (v == null) return;
            setState(() => _feProjectId = v);
            await _loadFeCounts();
          },
          items: [
            const DropdownMenuItem(value: 'all', child: Text('All')),
            ..._projects.map(
              (p) => DropdownMenuItem(value: p.id, child: Text(p.name)),
            ),
          ],
        ),
      ),
    );
  }

  // FE chart with headroom + horizontal scroll + horizontal labels + spacing
  Widget _feBarChart(ColorScheme cs) {
    if (_feLabels.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 24),
        child: Center(child: Text('No data')),
      );
    }

    // final maxY = (_feCounts.isEmpty ? 1 : _feCounts.reduce(max)) * 1.1;
    final rawMax = _feCounts.isEmpty ? 1.0 : _feCounts.reduce(max);
    final niceMax = ((rawMax / 10).ceil() * 10).toDouble(); // snap to 10s
    final maxY = max(10.0, niceMax); // at least 10

    return SizedBox(
      height: 260,
      child: LayoutBuilder(
        builder: (context, c) {
          final minWidth = max(900.0, _feLabels.length * 140.0);
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: max(c.maxWidth, minWidth),
              child: BarChart(
                BarChartData(
                  minY: 0,
                  maxY: maxY <= 0 ? 1 : maxY,

                  groupsSpace: 20, // add room between bars
                  gridData: FlGridData(
                    drawVerticalLine: false,
                    getDrawingHorizontalLine:
                        (v) => FlLine(
                          color: cs.outlineVariant.withOpacity(.4),
                          strokeWidth: 1,
                        ),
                  ),
                  titlesData: FlTitlesData(
                    // leftTitles: AxisTitles(
                    //   sideTitles: SideTitles(
                    //     reservedSize: 40,
                    //     showTitles: true,
                    //     getTitlesWidget:
                    //         (v, m) => Text(
                    //           v.toInt().toString(),
                    //           style: TextStyle(
                    //             color: cs.onSurfaceVariant,
                    //             fontSize: 11,
                    //           ),
                    //         ),
                    //   ),
                    // ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 40,
                        showTitles: true,
                        interval: 10, // ← force 10,20,30...
                        getTitlesWidget: (v, m) {
                          // hide non-multiples of 10 to avoid 35/36 crowding
                          if (v % 10 != 0) return const SizedBox.shrink();
                          return Text(
                            v.toInt().toString(),
                            style: TextStyle(
                              color: cs.onSurfaceVariant,
                              fontSize: 11,
                            ),
                          );
                        },
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        reservedSize: 32,
                        showTitles: true,
                        getTitlesWidget: (v, m) {
                          final idx = v.toInt();
                          if (idx < 0 || idx >= _feLabels.length)
                            return const SizedBox.shrink();
                          final txt = _feLabels[idx];
                          return Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: SizedBox(
                              width: 120,
                              child: Text(
                                txt,
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: cs.onSurfaceVariant,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    // topTitles: const AxisTitles(
                    //   sideTitles: SideTitles(showTitles: false),
                    // ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 14,
                        getTitlesWidget: (v, m) => const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    for (int i = 0; i < _feCounts.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: _feCounts[i],
                            color: AppTheme.accentColor,
                            width: 28,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
