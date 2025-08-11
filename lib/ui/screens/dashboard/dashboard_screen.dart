// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../widgets/simple_bottom_bar.dart';
// import '../../widgets/app_appbar.dart';
// import '../../widgets/app_drawer.dart';
// import '../../widgets/custom_bottom_nav_bar.dart';

// class DashboardScreen extends StatefulWidget {
//   const DashboardScreen({super.key});
//   @override
//   State<DashboardScreen> createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<DashboardScreen>
//     with SingleTickerProviderStateMixin {
//   int _selectedTab = 0;
//   bool _panelOpen = false;

//   // Toggle state for Project vs Summary
//   final List<bool> _isSelected = [true, false];

//   static const double _barHeight   = 70;
//   static const double _panelWidth  = 280;
//   static const double _panelRadius = 15;

//   // sample data for slide-out panel chart
//   final Map<String, double> _chartData = {
//     'Completed':    18,
//     'In Progress':   4,
//     'Open':          6,
//     'Rescheduled':   2,
//   };
//   final Map<String, Color> _chartColors = {
//     'Completed':    Colors.greenAccent,
//     'In Progress':  Colors.blueAccent,
//     'Open':         Color(0xFFFFD700),
//     'Rescheduled':  Colors.redAccent,
//   };

//   // sample reminders
//   final List<_Reminder> _reminders = [
//     _Reminder('10:50 PM', 'Personal', 'Airtel Cedge onsite support',  'Test'),
//     _Reminder('09:30 AM', 'Work',     'TelstraApari',                'Install'),
//     _Reminder('02:15 PM', 'Urgent',   'BPCL Aruba WIFI',             'Check'),
//     _Reminder('05:00 PM', 'Personal', 'Airtel CEDGE NAC',            'Follow-up'),
//     _Reminder('11:20 AM', 'Work',     'NPCI',                        'Review'),
//     _Reminder('03:40 PM', 'Personal', 'Airtel Cedge onsite support', 'Report'),
//   ];

//   // placeholder pages for other bottom-nav tabs
//   final _pages = [
//     // Dashboard itself is built inline when _selectedTab == 0
//     const SizedBox.shrink(),
//     Center(child: Text('Projects',  style: AppTheme.heading2)),
//     Center(child: Text('Analytics', style: AppTheme.heading2)),
//     Center(child: Text('Users',     style: AppTheme.heading2)),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBody: true,
//       backgroundColor: AppTheme.backgroundColor,
//       appBar: const AppAppBar(),
//       drawer: const AppDrawer(),

//       body: Stack(
//         children: [
//           // MAIN CONTENT
//           if (_selectedTab == 0)
//             _buildDashboardContent()
//           else
//             _pages[_selectedTab],

//           // 2) Tap-catcher behind the panel to close it
//           if (_panelOpen)
//             Positioned(
//               left: 0,
//               top: 0,
//               bottom: _barHeight,
//               right: _panelWidth,
//               child: GestureDetector(
//                 behavior: HitTestBehavior.translucent,
//                 onTap: () => setState(() => _panelOpen = false),
//               ),
//             ),

//           // 3) Slide-toggle handle
//           Align(
//             alignment: Alignment.centerRight,
//             child: GestureDetector(
//               onTap: () => setState(() => _panelOpen = !_panelOpen),
//               child: Container(
//                 width: 40,
//                 height: 80,
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF191A1E),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     bottomLeft: Radius.circular(40),
//                   ),
//                 ),
//                 child: Icon(
//                   _panelOpen ? Icons.arrow_forward : Icons.arrow_back,
//                   color: Colors.white54,
//                 ),
//               ),
//             ),
//           ),

//           // 4) Sliding panel
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//             top: 0,
//             bottom: _barHeight + MediaQuery.of(context).padding.bottom + 8,
//             right: _panelOpen ? 0 : -_panelWidth,
//             width: _panelWidth,
//             child: ClipRRect(
//               borderRadius: const BorderRadius.only(
//                 topLeft: Radius.circular(_panelRadius),
//                 bottomLeft: Radius.circular(_panelRadius),
//               ),
//               child: Container(
//                 color: const Color(0xFF191A1E),
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // --- Activity Status ---
//                     const Text(
//                       'Activity Status',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const Divider(color: Colors.white24),
//                     const SizedBox(height: 10),

//                     // Donut chart
//                     Center(
//                       child: SizedBox(
//                         width: 160,
//                         height: 160,
//                         child: CustomPaint(
//                           painter: _DonutPainter(
//                             data: _chartData,
//                             colors: _chartColors,
//                           ),
//                         ),
//                       ),
//                     ),

//                     const SizedBox(height: 16),

//                     // Legend below chart
//                     ..._chartData.keys.map((key) {
//                       final val   = _chartData[key]!;
//                       final total = _chartData.values.fold(0.0, (a, b) => a + b);
//                       final pct   = total > 0 ? (val / total * 100).round() : 0;
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//                         child: Row(
//                           children: [
//                             Container(
//                               width: 10,
//                               height: 10,
//                               decoration: BoxDecoration(
//                                 color: _chartColors[key],
//                                 shape: BoxShape.circle,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Expanded(
//                               child: Text(key, style: const TextStyle(color: Colors.white)),
//                             ),
//                             Text('$pct%', style: const TextStyle(color: Colors.white70)),
//                           ],
//                         ),
//                       );
//                     }),

//                     const SizedBox(height: 24),

//                     // --- Personal Reminders ---
//                     const Text(
//                       'Personal reminders',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     const Divider(color: Colors.white24),

//                     // Scrollable reminder cards WITHOUT overscroll glow
//                     Expanded(
//                       child: NotificationListener<OverscrollIndicatorNotification>(
//                         onNotification: (overscroll) {
//                           overscroll.disallowIndicator();
//                           return true;
//                         },
//                         child: ListView.builder(
//                           physics: const ClampingScrollPhysics(),
//                           itemCount: _reminders.length,
//                           padding: EdgeInsets.zero,
//                           itemBuilder: (_, i) {
//                             final r = _reminders[i];
//                             return Container(
//                               margin: const EdgeInsets.only(bottom: 12),
//                               padding: const EdgeInsets.all(12),
//                               decoration: BoxDecoration(
//                                 color: Colors.white12,
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         r.time,
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 16,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Row(
//                                         children: [
//                                           Text(
//                                             r.category,
//                                             style: const TextStyle(
//                                               color: Color(0xFFFFD700),
//                                               fontWeight: FontWeight.w600,
//                                             ),
//                                           ),
//                                           const SizedBox(width: 6),
//                                           Container(
//                                             width: 8,
//                                             height: 8,
//                                             decoration: const BoxDecoration(
//                                               color: Color(0xFFFFD700),
//                                               shape: BoxShape.circle,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 8),
//                                   Text(
//                                     r.project,
//                                     style: const TextStyle(color: Colors.white, fontSize: 14),
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     r.note,
//                                     style: const TextStyle(color: Colors.white70, fontSize: 12),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),

//       bottomNavigationBar: CustomBottomNavBar(
//         currentIndex: _selectedTab,
//         onTap: (i) => setState(() => _selectedTab = i),
//       ),
//     );
//   }

//   /// Dashboard main-column containing the toggle and cards
//   Widget _buildDashboardContent() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       children: [
//         // ToggleButtons for Project / Summary
//         Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ToggleButtons(
//               isSelected: _isSelected,
//               borderRadius: BorderRadius.circular(8),
//               fillColor: AppTheme.accentColor.withOpacity(0.2),
//               selectedBorderColor: AppTheme.accentColor,
//               borderColor: Colors.white24,
//               selectedColor: AppTheme.accentColor,
//               color: Colors.white70,
//               // shrink the buttons:
//               constraints: const BoxConstraints(minHeight: 32, minWidth: 100),
//               onPressed: (index) {
//                 setState(() {
//                   for (var i = 0; i < _isSelected.length; i++) {
//                     _isSelected[i] = (i == index);
//                   }
//                 });
//               },
//               children: const [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Text('Project', style: TextStyle(fontSize: 16)),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16),
//                   child: Text('Summary', style: TextStyle(fontSize: 16)),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         // Display the appropriate card
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child:
//               _isSelected[0] ? _buildProjectCard() : _buildSummaryCard(),
//         ),

//         const SizedBox(height: 8),

//         // Placeholder for the rest of your dashboard
//         const Expanded(
//           child: Center(
//             child: Text(
//               '— Your dashboard content goes here —',
//               style: TextStyle(color: Colors.white38),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   /// Project card with trailing icon
//   Widget _buildProjectCard() {
//     return Card(
//       color: const Color(0xFF1E1F24),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     'Project – All projects',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Icon(
//                   Icons.folder_open,
//                   color: AppTheme.accentColor,
//                 ),
//               ],
//             ),
//             const SizedBox(height: 8),
//             const Divider(color: Colors.white24),
//             Text(
//               "Today's Count : 23",
//               style: TextStyle(
//                 color: AppTheme.accentColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   /// Summary card with all five statuses
//   Widget _buildSummaryCard() {
//     final summaryItems = [
//       {'label': 'Completed Activities',   'count': '0'},
//       {'label': 'Pending Activities',     'count': '0'},
//       {'label': 'In-Progress Activities', 'count': '0'},
//       {'label': 'Open Activities',        'count': '0'},
//       {'label': 'Rescheduled Activities', 'count': '0'},
//     ];

//     return Card(
//       color: const Color(0xFF1E1F24),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
//         child: Row(
//           children: summaryItems.map((item) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: Column(
//                 children: [
//                   Text(
//                     item['count']!,
//                     style: const TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     item['label']!,
//                     style: const TextStyle(
//                       fontSize: 14,
//                       color: Colors.white70,
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// /// Reminder model
// class _Reminder {
//   final String time, category, project, note;
//   _Reminder(this.time, this.category, this.project, this.note);
// }

// /// Donut painter with thicker stroke and matching panel-hole color
// class _DonutPainter extends CustomPainter {
//   final Map<String, double> data;
//   final Map<String, Color> colors;
//   _DonutPainter({required this.data, required this.colors});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final total = data.values.fold(0.0, (a, b) => a + b);
//     double startAngle = -pi / 2;

//     // thicker ring: 20% of the width
//     final stroke = size.width * 0.20;
//     final paint = Paint()
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = stroke
//       ..strokeCap = StrokeCap.butt;

//     final rect = Rect.fromLTWH(
//       stroke / 2,
//       stroke / 2,
//       size.width - stroke,
//       size.height - stroke,
//     );

//     data.forEach((key, value) {
//       if (value <= 0) return;
//       final sweep = (value / total) * 2 * pi;
//       paint.color = colors[key]!;
//       canvas.drawArc(rect, startAngle, sweep, false, paint);
//       startAngle += sweep;
//     });

//     // center hole matches panel color
//     final holePaint = Paint()..color = const Color(0xFF191A1E);
//     final radius = (size.width - stroke) / 2.3;
//     canvas.drawCircle(Offset(size.width / 2, size.height / 2), radius, holePaint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter old) => true;
// }


// lib/ui/screens/dashboard/dashboard_screen.dart

import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../widgets/app_appbar.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/custom_bottom_nav_bar.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  bool _panelOpen = false;

  // Toggle state for Project vs Summary
  final List<bool> _isSelected = [true, false];

  // Activities filter: index of Today/Tomorrow/Week/Month/All
  int _activityTimeIndex = 4; // default to "All"

  // Dropdown selections
  String _selectedProject = 'All';
  String _selectedStatus  = 'All';

  // sample list of projects & statuses
  final List<String> _projects = ['All', 'NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
  final List<String> _statuses = ['All', 'Completed', 'Pending', 'In-Progress', 'Open', 'Rescheduled'];

  // sample activities
  final List<Activity> _activities = List.generate(8, (i) => Activity(
    ticketNo: 'npci-00${i+1}',
    date:       '23/07/2025',
    project:    'NPCI',
    activity:   'Breakdown',
    state:      'Maharashtra',
    district:   'Thane',
    city:       'Panvel',
    address: 'XYZ',
    siteName: 'ABCS',
    siteCode: '001',
    pm: 'Amey',
    noc: 'xya',
    feVendor: 'hshsh',
    feContact: '37326382',
    completionDate: '23-03-2025',
    remarks: 'xyz',
    status:     (i % 2 == 0) ? 'Completed' : 'Pending',
  ));

  static const double _barHeight   = 70;
  static const double _panelWidth  = 280;
  static const double _panelRadius = 15;

  // slide-out panel data (unchanged)…
  final Map<String, double> _chartData = {
    'Completed':    18, 'In Progress': 4, 'Open': 6, 'Rescheduled': 2,
  };
  final Map<String, Color> _chartColors = {
    'Completed':    Colors.greenAccent,
    'In Progress':  Colors.blueAccent,
    'Open':         Color(0xFFFFD700),
    'Rescheduled':  Colors.redAccent,
  };
  final List<_Reminder> _reminders = [
    _Reminder('10:50 PM','Personal','Airtel Cedge onsite support','Test'),
    _Reminder('09:30 AM','Work','TelstraApari','Install'),
    _Reminder('02:15 PM','Urgent','BPCL Aruba WIFI','Check'),
    _Reminder('05:00 PM','Personal','Airtel CEDGE NAC','Follow-up'),
    _Reminder('11:20 AM','Work','NPCI','Review'),
    _Reminder('03:40 PM','Personal','Airtel Cedge onsite support','Report'),
  ];

  // placeholder pages for other nav tabs
  final _pages = [
    const SizedBox.shrink(),
    Center(child: Text('Projects',  style: AppTheme.heading2)),
    Center(child: Text('Analytics', style: AppTheme.heading2)),
    Center(child: Text('Users',     style: AppTheme.heading2)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppTheme.backgroundColor,
      appBar: const AppAppBar(),
      drawer: const AppDrawer(),

      body: Stack(
        children: [
          // Main content
          if (_selectedTab == 0)
            _buildDashboardContent()
          else
            _pages[_selectedTab],

          // Slide-out panel (unchanged)...
          if (_panelOpen)
            Positioned(
              left: 0, top: 0, bottom: _barHeight, right: _panelWidth,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => setState(() => _panelOpen = false),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => setState(() => _panelOpen = !_panelOpen),
              child: Container(
                width: 40, height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFF191A1E),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: Icon(
                  _panelOpen ? Icons.arrow_forward : Icons.arrow_back,
                  color: Colors.white54,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            top: 0,
            bottom: _barHeight + MediaQuery.of(context).padding.bottom + 8,
            right: _panelOpen ? 0 : -_panelWidth,
            width: _panelWidth,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(_panelRadius),
                bottomLeft: Radius.circular(_panelRadius),
              ),
              child: Container(
                color: const Color(0xFF191A1E), padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Activity Status',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                    const Divider(color: Colors.white24),
                    const SizedBox(height: 10),
                    Center(
                      child: SizedBox(
                        width: 160, height: 160,
                        child: CustomPaint(
                          painter: _DonutPainter(data: _chartData, colors: _chartColors),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ..._chartData.keys.map((key) {
                      final val = _chartData[key]!;
                      final total = _chartData.values.fold(0.0, (a,b)=>a+b);
                      final pct = total>0 ? (val/total*100).round():0;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical:4,horizontal:8),
                        child: Row(
                          children: [
                            Container(width:10,height:10,
                              decoration: BoxDecoration(color:_chartColors[key],shape:BoxShape.circle)),
                            const SizedBox(width:8),
                            Expanded(child: Text(key,style: const TextStyle(color:Colors.white))),
                            Text('$pct%',style: const TextStyle(color:Colors.white70)),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(height:24),
                    const Text('Personal reminders',
                      style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center),
                    const Divider(color:Colors.white24),
                    Expanded(
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overscroll){ overscroll.disallowIndicator(); return true; },
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          itemCount: _reminders.length,
                          itemBuilder: (_,i){
                            final r = _reminders[i];
                            return Container(
                              margin: const EdgeInsets.only(bottom:12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color:Colors.white12,borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children:[
                                      Text(r.time, style: const TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),
                                      Row(children:[
                                        Text(r.category, style: const TextStyle(color:Color(0xFFFFD700),fontWeight:FontWeight.w600)),
                                        const SizedBox(width:6),
                                        Container(width:8,height:8,decoration: const BoxDecoration(color:Color(0xFFFFD700),shape:BoxShape.circle)),
                                      ])
                                    ]),
                                  const SizedBox(height:8),
                                  Text(r.project, style: const TextStyle(color:Colors.white)),
                                  const SizedBox(height:4),
                                  Text(r.note, style: const TextStyle(color:Colors.white70,fontSize:12)),
                                ],
                              ),
                            );
                          })),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedTab,
        onTap: (i) => setState(() => _selectedTab = i),
      ),
    );
  }

  /// Builds the Dashboard’s scrollable content: toggle, cards, then Activities
  Widget _buildDashboardContent() {
    // return SingleChildScrollView(
    //   padding: EdgeInsets.only(bottom: _barHeight + MediaQuery.of(context).padding.bottom + 8),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       // ToggleButtons (Project / Summary)
    //       Center(
    //         child: Padding(
    //           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //           child: ToggleButtons(
    //             isSelected: _isSelected,
    //             borderRadius: BorderRadius.circular(8),
    //             fillColor: AppTheme.accentColor.withOpacity(0.2),
    //             selectedBorderColor: AppTheme.accentColor,
    //             borderColor: Colors.white24,
    //             selectedColor: AppTheme.accentColor,
    //             color: Colors.white70,
    //             constraints: const BoxConstraints(minHeight: 32, minWidth: 100),
    //             onPressed: (index) {
    //               setState(() {
    //                 for (var i = 0; i < _isSelected.length; i++) {
    //                   _isSelected[i] = (i == index);
    //                 }
    //               });
    //             },
    //             children: const [
    //               Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Project')),
    //               Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Text('Summary')),
    //             ],
    //           ),
    //         ),
    //       ),

    //       // Project or Summary card
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         child: _isSelected[0] ? _buildProjectCard() : _buildSummaryCard(),
    //       ),

    //       const SizedBox(height: 16),

    //       // --- Activities Section ---
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         child: Text('Activities',
    //           style: AppTheme.heading2.copyWith(color: Colors.white)),
    //       ),
    //       const SizedBox(height: 8),

    //       // Time filter row
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: ['Today','Tomorrow','Week','Month','All']
    //               .asMap().entries.map((e){
    //             final idx = e.key;
    //             final label = e.value;
    //             final selected = idx == _activityTimeIndex;
    //             return GestureDetector(
    //               onTap: () => setState(() => _activityTimeIndex = idx),
    //               child: Container(
    //                 padding: const EdgeInsets.symmetric(horizontal:12, vertical:6),
    //                 decoration: BoxDecoration(
    //                   color: selected ? AppTheme.accentColor : Colors.white12,
    //                   borderRadius: BorderRadius.circular(4),
    //                 ),
    //                 child: Text(label,
    //                   style: TextStyle(
    //                     color: selected ? Colors.black : Colors.white70,
    //                     fontSize: 12,
    //                   )),
    //               ),
    //             );
    //           }).toList(),
    //         ),
    //       ),

    //       const SizedBox(height: 12),

    //       // Search + dropdowns
    //       Padding(
    //         padding: const EdgeInsets.symmetric(horizontal: 16),
    //         child: Row(children: [
    //           Expanded(
    //             flex: 2,
    //             child: TextField(
    //               style: const TextStyle(color: Colors.white),
    //               decoration: InputDecoration(
    //                 hintText: 'Search...',
    //                 hintStyle: const TextStyle(color: Colors.white54),
    //                 prefixIcon: const Icon(Icons.search, color: Colors.white54),
    //                 filled: true,
    //                 fillColor: Colors.white12,
    //                 contentPadding: const EdgeInsets.symmetric(vertical: 0),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(8),
    //                   borderSide: BorderSide.none,
    //                 ),
    //               ),
    //             ),
    //           ),
    //           const SizedBox(width: 8),
    //           Expanded(
    //             child: _buildDropdown('Project', _projects, _selectedProject, (v){
    //               setState(()=>_selectedProject=v!);
    //             }),
    //           ),
    //           const SizedBox(width: 8),
    //           Expanded(
    //             child: _buildDropdown('Status', _statuses, _selectedStatus, (v){
    //               setState(()=>_selectedStatus=v!);
    //             }),
    //           ),
    //         ]),
    //       ),

    //       const SizedBox(height: 16),

    //       // Activity list
    //       ListView.builder(
    //         physics: const NeverScrollableScrollPhysics(),
    //         shrinkWrap: true,
    //         itemCount: _activities.length,
    //         padding: const EdgeInsets.symmetric(horizontal:16),
    //         itemBuilder: (_,i){
    //           final a = _activities[i];
    //           return Container(
    //             margin: const EdgeInsets.only(bottom:12),
    //             padding: const EdgeInsets.all(12),
    //             decoration: BoxDecoration(
    //               color: const Color(0xFF1E1F24),
    //               borderRadius: BorderRadius.circular(8),
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 // Ticket & date / status
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text('${a.ticketNo}  ${a.date}',
    //                       style: const TextStyle(
    //                         color: AppTheme.accentColor, fontWeight: FontWeight.bold)),
    //                     Text('Status : ${a.status}',
    //                       style: TextStyle(
    //                         color: a.status=='Completed' ? Colors.greenAccent : Colors.white70,
    //                         fontWeight: FontWeight.w600)),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 8),
    //                 // Details two-column
    //                 Row(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     // Left column
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           _infoRow('Project', a.project),
    //                           _infoRow('Activity', a.activity),
    //                           _infoRow('State', a.state),
    //                           _infoRow('District', a.district),
    //                           _infoRow('City', a.city),
    //                         ],
    //                       ),
    //                     ),
    //                     const SizedBox(width: 16),
    //                     // Right column: leaving blank or duplicate as needed
    //                     Expanded(
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           // Fill in right-side fields if needed
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 const SizedBox(height: 12),
    //                 // Update button
    //                 Align(
    //                   alignment: Alignment.centerRight,
    //                   child: ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                       backgroundColor: AppTheme.accentColor,
    //                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    //                     ),
    //                     onPressed: () {},
    //                     child: const Text('Update'),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           );
    //         },
    //       ),

    //       const SizedBox(height: 24),
    //     ],
    //   ),
    // );

    return Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  children: [
    // ToggleButtons (Project / Summary)
    Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ToggleButtons(
          isSelected: _isSelected,
          borderRadius: BorderRadius.circular(8),
          fillColor: AppTheme.accentColor.withOpacity(0.2),
          selectedBorderColor: AppTheme.accentColor,
          borderColor: Colors.white24,
          selectedColor: AppTheme.accentColor,
          color: Colors.white70,
          constraints: const BoxConstraints(minHeight: 32, minWidth: 100),
          onPressed: (index) {
            setState(() {
              for (var i = 0; i < _isSelected.length; i++) {
                _isSelected[i] = (i == index);
              }
            });
          },
          children: const [
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Project')),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('Summary')),
          ],
        ),
      ),
    ),

    // Project or Summary card
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _isSelected[0]
          ? _buildProjectCard()
          : _buildSummaryCard(),
    ),

    const SizedBox(height: 16),

    // --- Activities Header + Divider ---
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Activities',
              style: AppTheme.heading2.copyWith(color: Colors.white)),
          const SizedBox(height: 8),
          const Divider(color: Colors.white24),
        ],
      ),
    ),

    const SizedBox(height: 8),

    // Time filter row
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: ['Today', 'Tomorrow', 'Week', 'Month', 'All']
            .asMap()
            .entries
            .map((e) {
          final idx = e.key;
          final label = e.value;
          final selected = idx == _activityTimeIndex;
          return GestureDetector(
            onTap: () => setState(() => _activityTimeIndex = idx),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: selected ? AppTheme.accentColor : Colors.white12,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(label,
                  style: TextStyle(
                    color: selected ? Colors.black : Colors.white70,
                    fontSize: 12,
                  )),
            ),
          );
        }).toList(),
      ),
    ),

    const SizedBox(height: 12),

    // Search + dropdowns
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: const TextStyle(color: Colors.white54),
                prefixIcon:
                    const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.white12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildDropdown('Project', _projects,
                _selectedProject, (v) => setState(() => _selectedProject = v!)),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _buildDropdown('Status', _statuses, _selectedStatus,
                (v) => setState(() => _selectedStatus = v!)),
          ),
        ],
      ),
    ),

    const SizedBox(height: 16),

    // --- Activity Cards (ONLY this scrolls) ---
    Expanded(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom:
              _barHeight + MediaQuery.of(context).padding.bottom + 8,
        ),
        child: ListView.builder(
          itemCount: _activities.length,
          itemBuilder: (_, i) {
            final a = _activities[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1E1F24),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1) Header + Status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${a.ticketNo}  ${a.date}',
                          style: TextStyle(
                              color: AppTheme.accentColor,
                              fontWeight: FontWeight.bold)),
                      Text('Status : ${a.status}',
                          style: TextStyle(
                              color: a.status == 'Completed'
                                  ? Colors.greenAccent
                                  : Colors.white70,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 12),

                  // 2) Two columns of detail rows
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow('Project', a.project),
                            _infoRow('Activity', a.activity),
                            _infoRow('State', a.state),
                            _infoRow('District', a.district),
                            _infoRow('City', a.city),
                            _infoRow('Address', a.address),
                            _infoRow('Remarks', a.remarks),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Right
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _infoRow('Site Name', a.siteName),
                            _infoRow('Site Code', a.siteCode),
                            _infoRow('PM', a.pm),
                            _infoRow('Noc', a.noc),
                            _infoRow('FE/Vendor', a.feVendor),
                            _infoRow('FE/Vendor Contact', a.feContact),
                            _infoRow('Completion Date', a.completionDate),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // 3) Update button
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        side: BorderSide(color: AppTheme.accentColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Update',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  ],
);

  }

  /// Small helper to render label + value in activity card
  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.only(bottom:4),
    child: RichText(
      text: TextSpan(
        text: '$label: ',
        style: const TextStyle(color: Colors.white54, fontSize: 12),
        children: [
          TextSpan(text: value, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    ),
  );

  /// Builds a dark dropdown with a label hint
  Widget _buildDropdown(
      String hint,
      List<String> items,
      String selected,
      ValueChanged<String?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:8),
      decoration: BoxDecoration(color: Colors.white12, borderRadius: BorderRadius.circular(8)),
      child: DropdownButton<String>(
        value: selected,
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: const Color(0xFF2A2B30),
        iconEnabledColor: Colors.white54,
        style: const TextStyle(color: Colors.white),
        onChanged: onChanged,
        items: items.map((s) => DropdownMenuItem(
          value: s,
          child: Text(s, style: const TextStyle(fontSize: 12)),
        )).toList(),
      ),
    );
  }

  // /   /// Project card with trailing icon
  Widget _buildProjectCard() {
    return Card(
      color: const Color(0xFF1E1F24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Project – All projects',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(
                  Icons.folder_open,
                  color: AppTheme.accentColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(color: Colors.white24),
            Text(
              "Today's Count : 23",
              style: TextStyle(
                color: AppTheme.accentColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Summary card with all five statuses
  Widget _buildSummaryCard() {
    final summaryItems = [
      {'label': 'Completed Activities',   'count': '0'},
      {'label': 'Pending Activities',     'count': '0'},
      {'label': 'In-Progress Activities', 'count': '0'},
      {'label': 'Open Activities',        'count': '0'},
      {'label': 'Rescheduled Activities', 'count': '0'},
    ];

    return Card(
      color: const Color(0xFF1E1F24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          children: summaryItems.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  Text(
                    item['count']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label']!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}


/// Simple Activity model
class Activity {
  final String ticketNo, date, project, activity, state, district, city, address,remarks,siteName, siteCode, pm , noc, feVendor, feContact, completionDate,status;
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
    required this.status
  });
}

/// Reminder model for slide-out panel
class _Reminder {
  final String time, category, project, note;
  _Reminder(this.time, this.category, this.project, this.note);
}

/// Donut painter (unchanged)
class _DonutPainter extends CustomPainter {
  final Map<String, double> data;
  final Map<String, Color> colors;
  _DonutPainter({required this.data, required this.colors});
  @override
  void paint(Canvas canvas, Size size) {
    final total = data.values.fold(0.0,(a,b)=>a+b);
    double startAngle = -pi/2;
    final stroke = size.width * 0.20;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.butt;
    final rect = Rect.fromLTWH(stroke/2, stroke/2, size.width-stroke, size.height-stroke);
    data.forEach((key, value) {
      if (value <= 0) return;
      final sweep = (value/total)*2*pi;
      paint.color = colors[key]!;
      canvas.drawArc(rect, startAngle, sweep, false, paint);
      startAngle += sweep;
    });
    final holePaint = Paint()..color = const Color(0xFF191A1E);
    canvas.drawCircle(Offset(size.width/2,size.height/2),(size.width-stroke)/2.3,holePaint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}
