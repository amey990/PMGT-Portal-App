// lib/ui/screens/dashboard/dashboard_screen.dart

import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme.dart';
import '../../widgets/simple_bottom_bar.dart';
import '../../widgets/app_appbar.dart';
import '../../widgets/app_drawer.dart';
import '../../widgets/custom_bottom_nav_bar.dart';  // ← import your new bar

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;
  bool _panelOpen = false;

  static const double _barHeight   = 70;
  static const double _panelWidth  = 280;
  static const double _panelRadius = 15;

  // sample data for chart
  final Map<String, double> _chartData = {
    'Completed':    18,
    'In Progress':   4,
    'Open':          6,
    'Rescheduled':   2,
  };
  final Map<String, Color> _chartColors = {
    'Completed':    Colors.greenAccent,
    'In Progress':  Colors.blueAccent,
    'Open':         Color(0xFFFFD700),
    'Rescheduled':  Colors.redAccent,
  };

  // sample reminders
  final List<_Reminder> _reminders = [
    _Reminder('10:50 PM', 'Personal', 'Airtel Cedge onsite support',  'Test'),
    _Reminder('09:30 AM', 'Work',     'TelstraApari',                'Install'),
    _Reminder('02:15 PM', 'Urgent',   'BPCL Aruba WIFI',             'Check'),
    _Reminder('05:00 PM', 'Personal', 'Airtel CEDGE NAC',            'Follow-up'),
    _Reminder('11:20 AM', 'Work',     'NPCI',                        'Review'),
    _Reminder('03:40 PM', 'Personal', 'Airtel Cedge onsite support', 'Report'),
  ];

  final _pages = [
    Center(child: Text('Dashboard', style: AppTheme.heading2)),
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

      body: Stack(children: [
        // 1) Main content
        _pages[_selectedTab],

        // 2) Tap-catcher to close panel
        if (_panelOpen)
          Positioned(
            left: 0,
            top: 0,
            bottom: _barHeight,
            right: _panelWidth,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => setState(() => _panelOpen = false),
            ),
          ),

        // // 3) Floating "+" button
        // Positioned(
        //   right: 16,
        //   bottom: _barHeight + 16,
        //   child: FloatingActionButton(
        //     onPressed: () {},
        //     backgroundColor: AppTheme.accentColor,
        //     child: const Icon(Icons.add, size: 32, color: Colors.white),
        //   ),
        // ),

        // 4) Slide-toggle handle
        Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: () => setState(() => _panelOpen = !_panelOpen),
            child: Container(
              width: 40,
              height: 80,
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

        // 5) Sliding panel
        // AnimatedPositioned(
        //   duration: const Duration(milliseconds: 300),
        //   curve: Curves.easeInOut,
        //   top: 0,
        //   bottom: _barHeight,
        //   right: _panelOpen ? 0 : -_panelWidth,
        //   width: _panelWidth,

                // leave an extra gap so the panel doesn't slide under the bottom bar
        AnimatedPositioned(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          top: 0,
          // push panel up by barHeight + safeArea inset + 8px
          bottom: _barHeight + MediaQuery.of(context).padding.bottom + 8,
          right: _panelOpen ? 0 : -_panelWidth,
          width: _panelWidth,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(_panelRadius),
              bottomLeft: Radius.circular(_panelRadius),
            ),
            child: Container(
              color: const Color(0xFF191A1E),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- Activity Status ---
                  const Text(
                    'Activity Status',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(color: Colors.white24),

                  SizedBox(height: 10,),

                  // Donut chart
                  Center(
                    child: SizedBox(
                      width: 160,
                      height: 160,
                      child: CustomPaint(
                        painter: _DonutPainter(
                          data: _chartData,
                          colors: _chartColors,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Legend below chart
                  ..._chartData.keys.map((key) {
                    final val   = _chartData[key]!;
                    final total = _chartData.values.fold(0.0, (a, b) => a + b);
                    final pct   = total > 0 ? (val / total * 100).round() : 0;
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: _chartColors[key],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(key, style: const TextStyle(color: Colors.white)),
                          ),
                          Text('$pct%', style: const TextStyle(color: Colors.white70)),
                        ],
                      ),
                    );
                  }).toList(),

                  const SizedBox(height: 24),

                  // --- Personal Reminders ---
                  const Text(
                    'Personal reminders',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Divider(color: Colors.white24),

                  // Scrollable reminder cards WITHOUT overscroll glow
                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowIndicator();
                        return true;
                      },
                      child: ListView.builder(
                         physics: const ClampingScrollPhysics(),
                        itemCount: _reminders.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (_, i) {
                          final r = _reminders[i];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      r.time,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          r.category,
                                          style: const TextStyle(
                                            color: Color(0xFFFFD700),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            color: Color(0xFFFFD700),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  r.project,
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  r.note,
                                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),

      // bottomNavigationBar: SimpleBottomBar(
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedTab,
        onTap: (i) => setState(() => _selectedTab = i),
        // height: _barHeight,
      ),
    );
  }
}

/// Reminder model
class _Reminder {
  final String time, category, project, note;
  _Reminder(this.time, this.category, this.project, this.note);
}

/// Donut painter with thicker stroke and matching panel-hole color
class _DonutPainter extends CustomPainter {
  final Map<String, double> data;
  final Map<String, Color> colors;
  _DonutPainter({required this.data, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final total = data.values.fold(0.0, (a, b) => a + b);
    double startAngle = -pi / 2;

    // thicker ring: 20% of the width
    final stroke = size.width * 0.20;
    final paint = Paint()
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

    // center hole matches panel color
    final holePaint = Paint()..color = const Color(0xFF191A1E);
    final radius = (size.width - stroke) / 2.3;
    canvas.drawCircle(Offset(size.width/2, size.height/2), radius, holePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => true;
}

