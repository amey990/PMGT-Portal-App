// import 'package:flutter/material.dart';
// import 'package:pmgt/core/theme.dart';
// import 'package:pmgt/core/theme_controller.dart';
// import 'package:pmgt/ui/screens/profile/profile_screen.dart';
// import 'package:pmgt/ui/utils/responsive.dart';
// import 'package:pmgt/ui/widgets/layout/main_layout.dart';
// import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;
// import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
// import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
// import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
// import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
// import 'package:pmgt/ui/screens/users/view_users_screen.dart';
// import 'package:pmgt/ui/widgets/profile_avatar.dart';

// /// Public model so any page can navigate here without type pains.
// class PaItem {
//   final String projectName;
//   final String activity;
//   final String siteName;
//   final String siteCode;
//   final String state;

//   final String vendor;
//   final String feVendorName;
//   final String completionDate;

//   // Optional / not always present in the source card – we keep them blank by default
//   final String paDate; // default: today (yyyy-mm-dd)
//   final String bankName;
//   final String bankAccount;
//   final String bankIfsc;
//   final String panNo;
//   final String paymentTerms;

//   PaItem({
//     required this.projectName,
//     required this.activity,
//     required this.siteName,
//     required this.siteCode,
//     required this.state,
//     required this.vendor,
//     required this.feVendorName,
//     required this.completionDate,
//     this.paDate = '',
//     this.bankName = '',
//     this.bankAccount = '',
//     this.bankIfsc = '',
//     this.panNo = '',
//     this.paymentTerms = '',
//   });

//   /// Be forgiving about key names: supports both raise-PA (_PaItem) and any map.
//   factory PaItem.fromDynamic(dynamic it) {
//     String pick(Map m, List<String> keys, {String def = ''}) {
//       for (final k in keys) {
//         final v = m[k];
//         if (v != null && v.toString().trim().isNotEmpty) return v.toString();
//       }
//       return def;
//     }

//     if (it is PaItem) return it;

//     if (it is Map) {
//       final m = it.map((k, v) => MapEntry(k.toString(), v?.toString() ?? ''));
//       final today = DateTime.now();
//       final y = today.year.toString().padLeft(4, '0');
//       final mo = today.month.toString().padLeft(2, '0');
//       final d = today.day.toString().padLeft(2, '0');

//       return PaItem(
//         projectName: pick(m, ['projectName', 'project', 'name']),
//         activity: pick(m, ['activity', 'type']),
//         siteName: pick(m, ['siteName', 'site']),
//         siteCode: pick(m, ['siteCode', 'code']),
//         state: pick(m, ['state']),
//         vendor: pick(m, ['vendor', 'feVendor', 'fe']),
//         feVendorName: pick(m, ['feName', 'vendorFeName', 'feVendorName', 'pm']),
//         completionDate: pick(m, ['completionDate', 'end', 'completion']),
//         paDate: pick(m, ['paDate'], def: '$y-$mo-$d'),
//         bankName: pick(m, ['bankName']),
//         bankAccount: pick(m, ['bankAccount']),
//         bankIfsc: pick(m, ['bankIfsc', 'ifsc']),
//         panNo: pick(m, ['pan', 'panNo']),
//         paymentTerms: pick(m, ['paymentTerms'], def: 'Immediate'),
//       );
//     }

//     // Fallback completely empty (should never happen)
//     return PaItem(
//       projectName: '',
//       activity: '',
//       siteName: '',
//       siteCode: '',
//       state: '',
//       vendor: '',
//       feVendorName: '',
//       completionDate: '',
//     );
//   }
// }

// /// Simple line item row model
// class _LineItem {
//   final TextEditingController siteCtrl;
//   final TextEditingController descCtrl;
//   final TextEditingController qtyCtrl;
//   final TextEditingController priceCtrl;

//   _LineItem({String site = ''})
//     : siteCtrl = TextEditingController(text: site),
//       descCtrl = TextEditingController(),
//       qtyCtrl = TextEditingController(),
//       priceCtrl = TextEditingController();

//   void dispose() {
//     siteCtrl.dispose();
//     descCtrl.dispose();
//     qtyCtrl.dispose();
//     priceCtrl.dispose();
//   }
// }

// class GeneratePaScreen extends StatefulWidget {
//   /// You can pass either a `PaItem` or a `Map<String,dynamic>` (the factory handles both).
//   final dynamic item;
//   const GeneratePaScreen({super.key, required this.item});

//   @override
//   State<GeneratePaScreen> createState() => _GeneratePaScreenState();
// }

// class _GeneratePaScreenState extends State<GeneratePaScreen> {
//   late final PaItem _item = PaItem.fromDynamic(widget.item);

//   // Form controllers (ordered exactly as requested)
//   late final _projectCtrl = TextEditingController(text: _item.projectName);
//   late final _activityCtrl = TextEditingController(text: _item.activity);
//   late final _siteNameCtrl = TextEditingController(text: _item.siteName);
//   late final _siteCodeCtrl = TextEditingController(text: _item.siteCode);

//   late final _stateCtrl = TextEditingController(text: _item.state);
//   late final _vendorCtrl = TextEditingController(text: _item.vendor);
//   late final _feNameCtrl = TextEditingController(text: _item.feVendorName);
//   late final _completionCtrl = TextEditingController(
//     text: _item.completionDate,
//   );

//   late final _paDateCtrl = TextEditingController(
//     text: _item.paDate.isEmpty ? _yyyyMmDd(DateTime.now()) : _item.paDate,
//   );
//   late final _bankNameCtrl = TextEditingController(text: _item.bankName);
//   late final _bankAccountCtrl = TextEditingController(text: _item.bankAccount);
//   late final _bankIfscCtrl = TextEditingController(text: _item.bankIfsc);
//   late final _panCtrl = TextEditingController(text: _item.panNo);
//   late final _termsCtrl = TextEditingController(
//     text: _item.paymentTerms.isEmpty ? 'Immediate' : _item.paymentTerms,
//   );

//   final List<_LineItem> _rows = [];

//   void _handleTabChange(BuildContext context, int i) {
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break; // Dashboard
//       case 1:
//         target = const AddProjectScreen();
//         break; // Add Project
//       case 2:
//         target = const AddActivityScreen();
//         break; // Add Activity
//       case 3:
//         target = const AnalyticsScreen();
//         break; // Analytics
//       case 4:
//         target = const ViewUsersScreen();
//         break; // View Users
//       default:
//         return;
//     }
//     Navigator.of(
//       context,
//     ).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   @override
//   void initState() {
//     super.initState();
//     _rows.add(_LineItem(site: _item.siteName)); // start with one row
//   }

//   @override
//   void dispose() {
//     _projectCtrl.dispose();
//     _activityCtrl.dispose();
//     _siteNameCtrl.dispose();
//     _siteCodeCtrl.dispose();
//     _stateCtrl.dispose();
//     _vendorCtrl.dispose();
//     _feNameCtrl.dispose();
//     _completionCtrl.dispose();
//     _paDateCtrl.dispose();
//     _bankNameCtrl.dispose();
//     _bankAccountCtrl.dispose();
//     _bankIfscCtrl.dispose();
//     _panCtrl.dispose();
//     _termsCtrl.dispose();
//     for (final r in _rows) {
//       r.dispose();
//     }
//     super.dispose();
//   }

//   // ----------------- helpers -----------------

//   String _yyyyMmDd(DateTime d) =>
//       '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

//   void _addRow() {
//     setState(() => _rows.add(_LineItem(site: _siteNameCtrl.text)));
//   }

//   void _clearRows() {
//     setState(() {
//       for (final r in _rows) {
//         r.dispose();
//       }
//       _rows
//         ..clear()
//         ..add(_LineItem(site: _siteNameCtrl.text));
//     });
//   }

//   double get _total {
//     double t = 0;
//     for (final r in _rows) {
//       final q = double.tryParse(r.qtyCtrl.text.trim()) ?? 0;
//       final p = double.tryParse(r.priceCtrl.text.trim()) ?? 0;
//       t += q * p;
//     }
//     return t;
//   }

//   InputDecoration _decoration(String label) {
//     final cs = Theme.of(context).colorScheme;
//     return InputDecoration(
//       labelText: label,
//       labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
//       filled: true,
//       fillColor: cs.surface,
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: cs.outlineVariant),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderSide: const BorderSide(color: AppTheme.accentColor),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//     );
//   }

//   Widget _half(Widget child) => Expanded(
//     child: Padding(padding: const EdgeInsets.only(bottom: 8), child: child),
//   );
//   Widget _gapW(double w) => SizedBox(width: w);

//   // ----------------- UI -----------------

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Generate PA',
//       centerTitle: true,
//       drawerMode: DrawerMode.accounts,
//       // currentIndex: 0,
//       // onTabChanged: (_) {},
//       currentIndex: -1, // this is a secondary page
//       onTabChanged: (i) => _handleTabChange(context, i),

//       safeArea: false,
//       reserveBottomPadding: true,
//       actions: [
//         IconButton(
//           tooltip:
//               Theme.of(context).brightness == Brightness.dark
//                   ? 'Light mode'
//                   : 'Dark mode',
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
//             Navigator.of(
//               context,
//             ).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
//           // icon: ClipOval(
//           //   child: Image.asset(
//           //     'assets/User_profile.png',
//           //     width: 36,
//           //     height: 36,
//           //     fit: BoxFit.cover,
//           //   ),
//           // ),
//           icon: const ProfileAvatar(size: 36),
//         ),
//         const SizedBox(width: 8),
//       ],
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
//         children: [
//           // ------------- Card 1: Details -------------
//           _DetailsCard(
//             children: [
//               // Row 1: Project name | Activity
//               Row(
//                 children: [
//                   _half(
//                     TextField(
//                       controller: _projectCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Project Name'),
//                     ),
//                   ),
//                   _gapW(12),
//                   _half(
//                     TextField(
//                       controller: _activityCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Activity'),
//                     ),
//                   ),
//                 ],
//               ),

//               // Row 2: Site name | Site code
//               Row(
//                 children: [
//                   _half(
//                     TextField(
//                       controller: _siteNameCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Site Name'),
//                     ),
//                   ),
//                   _gapW(12),
//                   _half(
//                     TextField(
//                       controller: _siteCodeCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Site Code'),
//                     ),
//                   ),
//                 ],
//               ),

//               // Row 3: State | Vendor
//               Row(
//                 children: [
//                   _half(
//                     TextField(
//                       controller: _stateCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('State'),
//                     ),
//                   ),
//                   _gapW(12),
//                   _half(
//                     TextField(
//                       controller: _vendorCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Vendor'),
//                     ),
//                   ),
//                 ],
//               ),

//               // Row 4: FE/Vendor Name | Completion Date
//               Row(
//                 children: [
//                   _half(
//                     TextField(
//                       controller: _feNameCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('FE/Vendor Name'),
//                     ),
//                   ),
//                   _gapW(12),
//                   _half(
//                     TextField(
//                       controller: _completionCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Completion Date'),
//                     ),
//                   ),
//                 ],
//               ),

//               // Row 5: PA Date | Bank Name
//               Row(
//                 children: [
//                   _half(
//                     TextField(
//                       controller: _paDateCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('PA Date'),
//                     ),
//                   ),
//                   _gapW(12),
//                   _half(
//                     TextField(
//                       controller: _bankNameCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Bank Name'),
//                     ),
//                   ),
//                 ],
//               ),

//               // Row 6: Bank Account | Bank IFSC
//               Row(
//                 children: [
//                   _half(
//                     TextField(
//                       controller: _bankAccountCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Bank Account'),
//                     ),
//                   ),
//                   _gapW(12),
//                   _half(
//                     TextField(
//                       controller: _bankIfscCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Bank IFSC'),
//                     ),
//                   ),
//                 ],
//               ),

//               // Row 7: PAN No | Payment Terms
//               Row(
//                 children: [
//                   _half(
//                     TextField(
//                       controller: _panCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('PAN No'),
//                     ),
//                   ),
//                   _gapW(12),
//                   _half(
//                     TextField(
//                       controller: _termsCtrl,
//                       style: TextStyle(color: cs.onSurface),
//                       decoration: _decoration('Payment Terms'),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),

//           const SizedBox(height: 12),

//           // ------------- Card 2: Line Items (mobile-friendly) -------------
//           _DetailsCard(
//             title: 'Items & Costs',
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextButton(onPressed: _clearRows, child: const Text('Clear')),
//                 const SizedBox(width: 8),
//                 ElevatedButton(
//                   onPressed: _addRow,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.redAccent,
//                     foregroundColor: Colors.white,
//                     elevation: 0,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 10,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: const Text('Add'),
//                 ),
//               ],
//             ),
//             children: [
//               // Each item is a compact row-card
//               ..._rows.asMap().entries.map((entry) {
//                 final i = entry.key;
//                 final r = entry.value;

//                 return Container(
//                   margin: const EdgeInsets.only(bottom: 10),
//                   padding: const EdgeInsets.all(12),
//                   decoration: BoxDecoration(
//                     color: cs.surface,
//                     border: Border.all(color: cs.outlineVariant),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(
//                     children: [
//                       // Site (full width)
//                       TextField(
//                         controller: r.siteCtrl,
//                         style: TextStyle(color: cs.onSurface),
//                         decoration: _decoration('Site'),
//                       ),
//                       const SizedBox(height: 8),

//                       // Description
//                       TextField(
//                         controller: r.descCtrl,
//                         style: TextStyle(color: cs.onSurface),
//                         decoration: _decoration('Description'),
//                       ),
//                       const SizedBox(height: 8),

//                       // qty | price
//                       Row(
//                         children: [
//                           _half(
//                             TextField(
//                               controller: r.qtyCtrl,
//                               keyboardType: TextInputType.number,
//                               style: TextStyle(color: cs.onSurface),
//                               decoration: _decoration('Quantity'),
//                             ),
//                           ),
//                           _gapW(12),
//                           _half(
//                             TextField(
//                               controller: r.priceCtrl,
//                               keyboardType: TextInputType.number,
//                               style: TextStyle(color: cs.onSurface),
//                               decoration: _decoration('Unit Price'),
//                             ),
//                           ),
//                           const SizedBox(width: 8),
//                           IconButton(
//                             tooltip: 'Remove',
//                             onPressed: () {
//                               setState(() {
//                                 r.dispose();
//                                 _rows.removeAt(i);
//                                 if (_rows.isEmpty) {
//                                   _rows.add(
//                                     _LineItem(site: _siteNameCtrl.text),
//                                   );
//                                 }
//                               });
//                             },
//                             icon: Icon(Icons.close, color: cs.onSurfaceVariant),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
//               }),

//               // Total (computed)
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 4),
//                   child: Text(
//                     'Total: ${_total.toStringAsFixed(2)}',
//                     style: TextStyle(
//                       color: cs.onSurface,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//               ),

//               const SizedBox(height: 12),

//               // Generate PA
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: ElevatedButton(
//                   onPressed: _onGenerate,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppTheme.accentColor,
//                     foregroundColor: Colors.black,
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 20,
//                       vertical: 12,
//                     ),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: const Text(
//                     'Generate PA',
//                     style: TextStyle(fontWeight: FontWeight.w800),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   void _onGenerate() {
//     // Here you'd call your API. For now just show a toast-like SnackBar.
//     final msg =
//         StringBuffer()
//           ..writeln('PA generated for ${_projectCtrl.text}')
//           ..writeln(
//             'Items: ${_rows.length}, Total: ${_total.toStringAsFixed(2)}',
//           );
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(msg.toString())));
//   }
// }

// // ---------------------------------------------------------------------------
// // Small reusable card
// // ---------------------------------------------------------------------------
// class _DetailsCard extends StatelessWidget {
//   final String? title;
//   final Widget? trailing;
//   final List<Widget> children;

//   const _DetailsCard({this.title, this.trailing, required this.children});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Container(
//       decoration: BoxDecoration(
//         color: cs.surfaceContainerHighest,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       padding: const EdgeInsets.all(14),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           if (title != null || trailing != null) ...[
//             Row(
//               children: [
//                 if (title != null)
//                   Expanded(
//                     child: Text(
//                       title!,
//                       style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                         color: cs.onSurface,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                   )
//                 else
//                   const Spacer(),
//                 if (trailing != null) trailing!,
//               ],
//             ),
//             Divider(color: cs.outlineVariant),
//             const SizedBox(height: 8),
//           ],
//           ...children,
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:pmgt/core/theme.dart';
import 'package:pmgt/core/theme_controller.dart';
import 'package:pmgt/ui/screens/profile/profile_screen.dart';
import 'package:pmgt/ui/utils/responsive.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';
import 'package:pmgt/ui/widgets/app_drawer.dart' show DrawerMode;
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

import 'dart:typed_data';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher_string.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'package:pmgt/core/api_client.dart';


/// Public model so any page can navigate here without type pains.
class PaItem {
  final String projectName;
  final String activity;
  final String siteName;
  final String siteCode;
  final String state;

  final String vendor;
  final String feVendorName;
  final String completionDate;

  // Optional
  final String paDate; // default: today (yyyy-mm-dd)
  final String bankName;
  final String bankAccount;
  final String bankIfsc;
  final String panNo;
  final String paymentTerms;

  PaItem({
    required this.projectName,
    required this.activity,
    required this.siteName,
    required this.siteCode,
    required this.state,
    required this.vendor,
    required this.feVendorName,
    required this.completionDate,
    this.paDate = '',
    this.bankName = '',
    this.bankAccount = '',
    this.bankIfsc = '',
    this.panNo = '',
    this.paymentTerms = '',
  });

  factory PaItem.fromDynamic(dynamic it) {
    String pick(Map m, List<String> keys, {String def = ''}) {
      for (final k in keys) {
        final v = m[k];
        if (v != null && v.toString().trim().isNotEmpty) return v.toString();
      }
      return def;
    }

    if (it is PaItem) return it;

    if (it is Map) {
      final m = it.map((k, v) => MapEntry(k.toString(), v?.toString() ?? ''));
      final today = DateTime.now();
      final y = today.year.toString().padLeft(4, '0');
      final mo = today.month.toString().padLeft(2, '0');
      final d = today.day.toString().padLeft(2, '0');

      return PaItem(
        projectName: pick(m, ['projectName', 'project', 'name']),
        activity: pick(m, ['activity', 'type']),
        siteName: pick(m, ['siteName', 'site']),
        siteCode: pick(m, ['siteCode', 'code', 'site_id']),
        state: pick(m, ['state']),
        vendor: pick(m, ['vendor', 'feVendor', 'fe']),
        feVendorName: pick(m, ['feVendorName', 'feName', 'vendorFeName']),
        completionDate: pick(m, ['completionDate', 'end', 'completion', 'completed_at']),
        paDate: pick(m, ['paDate'], def: '$y-$mo-$d'),
        bankName: pick(m, ['bankName']),
        bankAccount: pick(m, ['bankAccount']),
        bankIfsc: pick(m, ['bankIfsc', 'ifsc']),
        panNo: pick(m, ['pan', 'panNo']),
        paymentTerms: pick(m, ['paymentTerms'], def: 'Immediate'),
      );
    }

    return PaItem(
      projectName: '',
      activity: '',
      siteName: '',
      siteCode: '',
      state: '',
      vendor: '',
      feVendorName: '',
      completionDate: '',
    );
  }
}

/// Simple line item row model
class _LineItem {
  final TextEditingController siteCtrl;
  final TextEditingController descCtrl;
  final TextEditingController qtyCtrl;
  final TextEditingController priceCtrl;

  _LineItem({String site = ''})
      : siteCtrl = TextEditingController(text: site),
        descCtrl = TextEditingController(),
        qtyCtrl = TextEditingController(text: '1'),
        priceCtrl = TextEditingController(text: '0');

  void dispose() {
    siteCtrl.dispose();
    descCtrl.dispose();
    qtyCtrl.dispose();
    priceCtrl.dispose();
  }
}

class GeneratePaScreen extends StatefulWidget {
  /// You can pass either a `PaItem` or a `Map<String,dynamic>`.
  final dynamic item;
  const GeneratePaScreen({super.key, required this.item});

  @override
  State<GeneratePaScreen> createState() => _GeneratePaScreenState();
}

class _GeneratePaScreenState extends State<GeneratePaScreen> {
  late final PaItem _item = PaItem.fromDynamic(widget.item);

  // Form controllers
  late final _projectCtrl = TextEditingController(text: _item.projectName);
  late final _activityCtrl = TextEditingController(text: _item.activity);
  late final _siteNameCtrl = TextEditingController(text: _item.siteName);
  late final _siteCodeCtrl = TextEditingController(text: _item.siteCode);
  late final _stateCtrl = TextEditingController(text: _item.state);
  late final _vendorCtrl = TextEditingController(text: _item.vendor);
  late final _feNameCtrl = TextEditingController(text: _item.feVendorName);
  late final _completionCtrl = TextEditingController(text: _item.completionDate);
  late final _paDateCtrl = TextEditingController(
    text: _item.paDate.isEmpty ? _yyyyMmDd(DateTime.now()) : _item.paDate,
  );
  late final _bankNameCtrl = TextEditingController(text: _item.bankName);
  late final _bankAccountCtrl = TextEditingController(text: _item.bankAccount);
  late final _bankIfscCtrl = TextEditingController(text: _item.bankIfsc);
  late final _panCtrl = TextEditingController(text: _item.panNo);
  late final _termsCtrl =
      TextEditingController(text: _item.paymentTerms.isEmpty ? 'Immediate' : _item.paymentTerms);

  final List<_LineItem> _rows = [];

  String? _activityId;

  void _handleTabChange(BuildContext context, int i) {
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
      case 3:
        target = const AnalyticsScreen();
        break;
      case 4:
        target = const ViewUsersScreen();
        break;
      default:
        return;
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
  }

  @override
  void initState() {
    super.initState();
  
    final raw = widget.item;
if (raw is Map) {
  _activityId = (raw['activityId'] ?? '').toString().trim().isEmpty
      ? null
      : raw['activityId'].toString();
}
    _rows.add(_LineItem(site: _item.siteName)); // start with one row
  }

  @override
  void dispose() {
    _projectCtrl.dispose();
    _activityCtrl.dispose();
    _siteNameCtrl.dispose();
    _siteCodeCtrl.dispose();
    _stateCtrl.dispose();
    _vendorCtrl.dispose();
    _feNameCtrl.dispose();
    _completionCtrl.dispose();
    _paDateCtrl.dispose();
    _bankNameCtrl.dispose();
    _bankAccountCtrl.dispose();
    _bankIfscCtrl.dispose();
    _panCtrl.dispose();
    _termsCtrl.dispose();
    for (final r in _rows) {
      r.dispose();
    }
    super.dispose();
  }

  String _yyyyMmDd(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  void _addRow() => setState(() => _rows.add(_LineItem(site: _siteNameCtrl.text)));

  void _clearRows() {
    setState(() {
      for (final r in _rows) r.dispose();
      _rows..clear()..add(_LineItem(site: _siteNameCtrl.text));
    });
  }

  Future<Uint8List> _buildPdfBytes() async {
  final pdf = pw.Document();
  final text = pw.TextStyle(fontSize: 11);
  final bold = pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold);

  double total = 0;
  final rows = <List<String>>[];
  for (var i = 0; i < _rows.length; i++) {
    final r = _rows[i];
    final q = double.tryParse(r.qtyCtrl.text.trim()) ?? 0;
    final p = double.tryParse(r.priceCtrl.text.trim()) ?? 0;
    final t = q * p;
    total += t;
    rows.add([
      (i + 1).toString(),
      r.descCtrl.text.trim().isEmpty ? '-' : r.descCtrl.text.trim(),
      q.toStringAsFixed(0),
      p.toStringAsFixed(2),
      t.toStringAsFixed(2),
    ]);
  }

  final today = _paDateCtrl.text.trim();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (ctx) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(height: 6),
          pw.Center(child: pw.Text('Payment Advice', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 8),
          pw.Divider(),

          pw.SizedBox(height: 6),
          pw.Text('From: CSPL-Accounts Team', style: text),
          pw.Text('To:   CSPL-PMGT Team', style: text),
          pw.SizedBox(height: 8),

          pw.Text('Project Name: ${_projectCtrl.text}', style: bold),
          pw.Text('PA Date:       $today', style: text),
          pw.Text('Location:      ${_stateCtrl.text}', style: text),
          pw.Text('Site & Code:   ${_siteNameCtrl.text} / ${_siteCodeCtrl.text}', style: text),
          pw.Text('Completion:    ${_completionCtrl.text}', style: text),

          pw.SizedBox(height: 10),
          pw.Text('Bank Details', style: bold),
          pw.Divider(),
          pw.Text('Bank Name:     ${_bankNameCtrl.text}', style: text),
          pw.Text('Bank Account:  ${_bankAccountCtrl.text}', style: text),
          pw.Text('Bank IFSC:     ${_bankIfscCtrl.text}', style: text),
          pw.Text('PAN No:        ${_panCtrl.text}', style: text),
          pw.Text('Payment Terms: ${_termsCtrl.text}', style: text),

          pw.SizedBox(height: 14),
          pw.Text('Generated PA', style: bold),
          pw.SizedBox(height: 4),
          pw.Table.fromTextArray(
            headerStyle: bold,
            headerDecoration: const pw.BoxDecoration(color: PdfColors.grey300),
            cellStyle: text,
            headers: const ['Sr No', 'Description', 'Qty', 'Unit Price', 'Total'],
            data: rows,
            cellAlignment: pw.Alignment.centerLeft,
            columnWidths: {
              0: const pw.FixedColumnWidth(40),
              1: const pw.FlexColumnWidth(),
              2: const pw.FixedColumnWidth(50),
              3: const pw.FixedColumnWidth(70),
              4: const pw.FixedColumnWidth(70),
            },
          ),
          pw.SizedBox(height: 6),
          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.Text('Total: ${total.toStringAsFixed(2)}', style: bold),
          ),

          pw.Spacer(),
          pw.Divider(),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text('Prepared By: Commedia Admin', style: text),
              pw.Text('Authorized Signature', style: text),
            ],
          ),
        ],
      ),
    ),
  );

  return Uint8List.fromList(await pdf.save());
}

  double get _total {
    double t = 0;
    for (final r in _rows) {
      final q = double.tryParse(r.qtyCtrl.text.trim()) ?? 0;
      final p = double.tryParse(r.priceCtrl.text.trim()) ?? 0;
      t += q * p;
    }
    return t;
  }

  InputDecoration _decoration(String label, {bool readOnly = false}) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
      filled: true,
      fillColor: cs.surface,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppTheme.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    ).copyWith(
      // visual cue for read-only
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _half(Widget child) => Expanded(child: Padding(padding: const EdgeInsets.only(bottom: 8), child: child));
  Widget _gapW(double w) => SizedBox(width: w);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Generate PA',
      centerTitle: true,
      drawerMode: DrawerMode.accounts,
      currentIndex: -1,
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
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen())),
          icon: const ProfileAvatar(size: 36),
        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 8, bottom: 12),
        children: [
          // ------------- Card 1: Details (read-only like web) -------------
          _DetailsCard(
            children: [
              Row(
                children: [
                  _half(TextField(controller: _projectCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Project Name', readOnly: true))),
                  _gapW(12),
                  _half(TextField(controller: _activityCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Activity', readOnly: true))),
                ],
              ),
              Row(
                children: [
                  _half(TextField(controller: _siteNameCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Site Name', readOnly: true))),
                  _gapW(12),
                  _half(TextField(controller: _siteCodeCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Site Code', readOnly: true))),
                ],
              ),
              Row(
                children: [
                  _half(TextField(controller: _stateCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('State', readOnly: true))),
                  _gapW(12),
                  _half(TextField(controller: _vendorCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Vendor', readOnly: true))),
                ],
              ),
              Row(
                children: [
                  _half(TextField(controller: _feNameCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('FE/Vendor Name', readOnly: true))),
                  _gapW(12),
                  _half(TextField(controller: _completionCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Completion Date', readOnly: true))),
                ],
              ),
              Row(
                children: [
                  _half(TextField(controller: _paDateCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('PA Date', readOnly: true))),
                  _gapW(12),
                  _half(TextField(controller: _bankNameCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Bank Name', readOnly: true))),
                ],
              ),
              Row(
                children: [
                  _half(TextField(controller: _bankAccountCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Bank Account', readOnly: true))),
                  _gapW(12),
                  _half(TextField(controller: _bankIfscCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Bank IFSC', readOnly: true))),
                ],
              ),
              Row(
                children: [
                  _half(TextField(controller: _panCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('PAN No', readOnly: true))),
                  _gapW(12),
                  _half(TextField(controller: _termsCtrl, readOnly: true, enabled: false, style: TextStyle(color: cs.onSurface), decoration: _decoration('Payment Terms', readOnly: true))),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // ------------- Card 2: Line Items -------------
          _DetailsCard(
            title: 'Items & Costs',
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(onPressed: _clearRows, child: const Text('Clear')),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addRow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
            children: [
              ..._rows.asMap().entries.map((entry) {
                final i = entry.key;
                final r = entry.value;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: cs.surface,
                    border: Border.all(color: cs.outlineVariant),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      TextField(controller: r.siteCtrl, style: TextStyle(color: cs.onSurface), decoration: _decoration('Site')),
                      const SizedBox(height: 8),
                      TextField(controller: r.descCtrl, style: TextStyle(color: cs.onSurface), decoration: _decoration('Description')),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _half(TextField(controller: r.qtyCtrl, keyboardType: TextInputType.number, style: TextStyle(color: cs.onSurface), decoration: _decoration('Quantity'))),
                          _gapW(12),
                          _half(TextField(controller: r.priceCtrl, keyboardType: TextInputType.number, style: TextStyle(color: cs.onSurface), decoration: _decoration('Unit Price'))),
                          const SizedBox(width: 8),
                          IconButton(
                            tooltip: 'Remove',
                            onPressed: () {
                              setState(() {
                                r.dispose();
                                _rows.removeAt(i);
                                if (_rows.isEmpty) _rows.add(_LineItem(site: _siteNameCtrl.text));
                              });
                            },
                            icon: Icon(Icons.close, color: cs.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text('Total: ${_total.toStringAsFixed(2)}',
                      style: TextStyle(color: cs.onSurface, fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: _onGenerate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Generate PA', style: TextStyle(fontWeight: FontWeight.w800)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  

  Future<void> _onGenerate() async {
  if (_rows.isEmpty) return;

  try {
    // 1) Make the PDF
    final pdfBytes = await _buildPdfBytes();

    // 2) Create PA row => presigned PUT
    final api = context.read<ApiClient>();
    final fileName =
        'PA-${_projectCtrl.text.replaceAll(RegExp(r"\\s+"), "_")}-${DateTime.now().millisecondsSinceEpoch}.pdf';

    final body = {
      if (_activityId != null) 'activity_id': _activityId,
      'pa_date': _paDateCtrl.text.trim(),
      'fileName': fileName,
    };

    final create = await api.post('/api/payment_advices', body: body);
    if (create.statusCode < 200 || create.statusCode >= 300) {
      final txt = create.body.isNotEmpty ? create.body : 'Create PA failed';
      throw Exception(txt);
    }
    final info = Map<String, dynamic>.from(
      (await api.decode(create)) as Map,
    );
    final uploadURL = (info['uploadURL'] ?? '').toString();
    final key = (info['key'] ?? '').toString();
    if (uploadURL.isEmpty || key.isEmpty) {
      throw Exception('Missing upload URL or key');
    }

    // 3) Upload PDF to S3 (PUT)
    final put = await http.put(
      Uri.parse(uploadURL),
      headers: {'Content-Type': 'application/pdf'},
      body: pdfBytes,
    );
    if (put.statusCode < 200 || put.statusCode >= 300) {
      throw Exception('S3 PUT failed: ${put.statusCode}');
    }

    // 4) Fetch list, find our file, open download URL externally
    final listRes = await api.get('/api/payment_advices');
    if (listRes.statusCode < 200 || listRes.statusCode >= 300) {
      throw Exception('List payment_advices failed');
    }
    final list = await api.decode(listRes);
    String? dl;
    if (list is List) {
      for (final r in list) {
        if (r is Map && (r['file_key'] ?? '') == key) {
          dl = (r['downloadURL'] ?? '').toString();
          break;
        }
      }
    }
    if (dl == null || dl!.isEmpty) {
      throw Exception('Download URL not found for uploaded file');
    }

    // await launchUrlString(dl!, mode: LaunchMode.externalApplication);
    await launchUrlString(dl!, mode: LaunchMode.externalApplication);
    if (mounted) {
  _clearRows(); // ← clears Items & Costs (keeps one fresh empty row)
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Purchase Advice generated')),
  );
}
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to generate PA: $e')),
      );
    }
  }
}
}

// ---- Small reusable card ----
class _DetailsCard extends StatelessWidget {
  final String? title;
  final Widget? trailing;
  final List<Widget> children;
  const _DetailsCard({this.title, this.trailing, required this.children});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (title != null || trailing != null) ...[
            Row(
              children: [
                if (title != null)
                  Expanded(
                    child: Text(
                      title!,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                  )
                else
                  const Spacer(),
                if (trailing != null) trailing!,
              ],
            ),
            Divider(color: cs.outlineVariant),
            const SizedBox(height: 8),
          ],
          ...children,
        ],
      ),
    );
  }
}
