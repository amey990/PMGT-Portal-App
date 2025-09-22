import 'package:flutter/material.dart';
import 'package:pmgt/core/theme.dart';
import 'package:pmgt/ui/widgets/layout/main_layout.dart';
import 'package:pmgt/ui/widgets/app_drawer.dart'; // for DrawerMode

// -----------------------------------------------------------------------------
// Minimal model used by the screen. If you already have a PaItem model elsewhere,
// delete this and import yours (but keep the field names you use below).
// -----------------------------------------------------------------------------
class PaItem {
  final String projectName;
  final String activity;
  final String siteName;
  final String siteCode;
  final String state;
  final String vendor;
  final String feName;
  final String completionDate; // dd/mm/yyyy (or any display string)
  final String paymentTerms;

  PaItem({
    required this.projectName,
    required this.activity,
    required this.siteName,
    required this.siteCode,
    required this.state,
    required this.vendor,
    required this.feName,
    required this.completionDate,
    this.paymentTerms = 'Immediate',
  });
}

// Simple line-item model
class _LineItem {
  final TextEditingController siteCtrl;
  final TextEditingController descCtrl;
  final TextEditingController qtyCtrl;
  final TextEditingController priceCtrl;

  _LineItem({
    required this.siteCtrl,
    required this.descCtrl,
    required this.qtyCtrl,
    required this.priceCtrl,
  });

  void dispose() {
    siteCtrl.dispose();
    descCtrl.dispose();
    qtyCtrl.dispose();
    priceCtrl.dispose();
  }
}

// -----------------------------------------------------------------------------
// Screen
// -----------------------------------------------------------------------------
class GeneratePaScreen extends StatefulWidget {
  const GeneratePaScreen({super.key, required this.item});
  final PaItem item;

  @override
  State<GeneratePaScreen> createState() => _GeneratePaScreenState();
}

class _GeneratePaScreenState extends State<GeneratePaScreen> {
  // Top form controllers (declared here; initialized in initState)
  late final TextEditingController _projectCtrl;
  late final TextEditingController _activityCtrl;
  late final TextEditingController _siteNameCtrl;
  late final TextEditingController _siteCodeCtrl;
  late final TextEditingController _stateCtrl;
  late final TextEditingController _vendorCtrl;
  late final TextEditingController _feNameCtrl;
  late final TextEditingController _completionCtrl;

  late final TextEditingController _paDateCtrl;
  late final TextEditingController _panCtrl;
  late final TextEditingController _bankNameCtrl;
  late final TextEditingController _bankAccCtrl;
  late final TextEditingController _bankIfscCtrl;
  late final TextEditingController _paymentTermsCtrl;

  final List<_LineItem> _lines = [];

  @override
  void initState() {
    super.initState();

    // initialize from widget.item here (this is the error you were hitting)
    _projectCtrl     = TextEditingController(text: widget.item.projectName);
    _activityCtrl    = TextEditingController(text: widget.item.activity);
    _siteNameCtrl    = TextEditingController(text: widget.item.siteName);
    _siteCodeCtrl    = TextEditingController(text: widget.item.siteCode);
    _stateCtrl       = TextEditingController(text: widget.item.state);
    _vendorCtrl      = TextEditingController(text: widget.item.vendor);
    _feNameCtrl      = TextEditingController(text: widget.item.feName);
    _completionCtrl  = TextEditingController(text: widget.item.completionDate);

    _paDateCtrl      = TextEditingController(
      text: DateTime.now().toIso8601String().split('T').first,
    );
    _panCtrl         = TextEditingController();
    _bankNameCtrl    = TextEditingController();
    _bankAccCtrl     = TextEditingController();
    _bankIfscCtrl    = TextEditingController();
    _paymentTermsCtrl= TextEditingController(text: widget.item.paymentTerms);

    // start with one line, prefilled site
    _lines.add(_newLine(prefillSite: widget.item.siteName));
  }

  _LineItem _newLine({String? prefillSite}) => _LineItem(
    siteCtrl:  TextEditingController(text: prefillSite ?? ''),
    descCtrl:  TextEditingController(),
    qtyCtrl:   TextEditingController(),
    priceCtrl: TextEditingController(),
  );

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
    _panCtrl.dispose();
    _bankNameCtrl.dispose();
    _bankAccCtrl.dispose();
    _bankIfscCtrl.dispose();
    _paymentTermsCtrl.dispose();
    for (final l in _lines) { l.dispose(); }
    super.dispose();
  }

  void _clear() {
    _panCtrl.clear();
    _bankNameCtrl.clear();
    _bankAccCtrl.clear();
    _bankIfscCtrl.clear();
    _paymentTermsCtrl.text = 'Immediate';

    for (final l in _lines) { l.dispose(); }
    _lines
      ..clear()
      ..add(_newLine(prefillSite: widget.item.siteName));
    setState(() {});
  }

  void _addLine() {
    setState(() => _lines.add(_newLine(prefillSite: widget.item.siteName)));
  }

  void _removeLine(int i) {
    setState(() {
      _lines[i].dispose();
      _lines.removeAt(i);
    });
  }

  void _generate() {
    // You’d gather data and call your API here.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('PA generated (demo).')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Atlas Accounting',
      centerTitle: true,
      drawerMode: DrawerMode.accounts,   // <-- Accounts drawer
      currentIndex: 0,
      onTabChanged: (_) {},
      safeArea: false,
      reserveBottomPadding: true,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Header card
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Generate PA',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: cs.onSurface, fontWeight: FontWeight.w800)),
                const SizedBox(height: 12),

                // Grid (3 columns on wide, 1 on narrow)
                LayoutBuilder(
                  builder: (context, c) {
                    final wide = c.maxWidth >= 900;
                    final cols = wide ? 3 : 1;
                    final children = [
                      _tf('Project Name', _projectCtrl, readOnly: true),
                      _tf('Activity', _activityCtrl, readOnly: true),
                      _tf('Site Name', _siteNameCtrl, readOnly: true),

                      _tf('Site Code', _siteCodeCtrl, readOnly: true),
                      _tf('State', _stateCtrl, readOnly: true),
                      _tf('FE/Vendor Name', _feNameCtrl, readOnly: true),

                      _tf('Vendor(FE)', _vendorCtrl, readOnly: true),
                      _tf('Completion Date', _completionCtrl, readOnly: true),
                      _tf('PA Date', _paDateCtrl),

                      _tf('Bank Name', _bankNameCtrl),
                      _tf('Bank Account', _bankAccCtrl),
                      _tf('Bank IFSC', _bankIfscCtrl),

                      _tf('PAN No', _panCtrl, spanFull: !wide),
                      _tf('Payment Terms', _paymentTermsCtrl, spanFull: !wide),
                    ];

                    return _grid(children, cols: cols, gap: 12);
                  },
                ),

                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: _clear,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: cs.onSurface,
                        side: BorderSide(color: cs.outlineVariant),
                      ),
                      child: const Text('Clear'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _addLine,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.shade200,
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Line items "table"
          Container(
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                _tableHeader(context),
                for (int i = 0; i < _lines.length; i++) _tableRow(i),
              ],
            ),
          ),

          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _generate,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.accentColor,
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Generate PA',
                  style: TextStyle(fontWeight: FontWeight.w800)),
            ),
          ),
        ],
      ),
    );
  }

  // --- UI helpers ------------------------------------------------------------

  Widget _grid(List<Widget> children, {required int cols, double gap = 8}) {
    if (cols == 1) {
      return Column(
        children: [
          for (final w in children) Padding(padding: EdgeInsets.only(bottom: gap), child: w),
        ],
      );
    }
    return LayoutBuilder(
      builder: (context, c) {
        final w = (c.maxWidth - (gap * (cols - 1))) / cols;
        final rows = <Widget>[];
        for (int i = 0; i < children.length; i += cols) {
          final slice = children.sublist(i, (i + cols).clamp(0, children.length));
          rows.add(
            Row(
              children: [
                for (int j = 0; j < slice.length; j++)
                  SizedBox(width: w, child: slice[j]),
                if (slice.length < cols)
                  for (int k = 0; k < cols - slice.length; k++)
                    SizedBox(width: w),
              ],
            ),
          );
          if (i + cols < children.length) rows.add(SizedBox(height: gap));
        }
        return Column(children: rows);
      },
    );
  }

  Widget _tf(String label, TextEditingController c,
      {bool readOnly = false, bool spanFull = false}) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(
              color: cs.onSurfaceVariant,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 6),
        TextField(
          controller: c,
          readOnly: readOnly,
          style: TextStyle(color: cs.onSurface),
          decoration: InputDecoration(
            filled: true,
            fillColor: cs.surface,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: cs.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: AppTheme.accentColor),
            ),
          ),
        ),
      ],
    );
  }

  Widget _tableHeader(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    TextStyle head =
        TextStyle(color: cs.onSurface, fontWeight: FontWeight.w700);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text('Site', style: head)),
          Expanded(flex: 4, child: Text('Description', style: head)),
          Expanded(flex: 2, child: Text('Quantity', style: head)),
          Expanded(flex: 2, child: Text('Unit Price', style: head)),
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _tableRow(int i) {
    final cs = Theme.of(context).colorScheme;
    final row = _lines[i];
    InputDecoration deco = InputDecoration(
      isDense: true,
      filled: true,
      fillColor: cs.surface,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: cs.outlineVariant),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppTheme.accentColor),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: cs.outlineVariant)),
      ),
      child: Row(
        children: [
          Expanded(flex: 2, child: TextField(controller: row.siteCtrl, decoration: deco)),
          const SizedBox(width: 8),
          Expanded(flex: 4, child: TextField(controller: row.descCtrl, decoration: deco)),
          const SizedBox(width: 8),
          Expanded(flex: 2, child: TextField(controller: row.qtyCtrl, decoration: deco, keyboardType: TextInputType.number)),
          const SizedBox(width: 8),
          Expanded(flex: 2, child: TextField(controller: row.priceCtrl, decoration: deco, keyboardType: TextInputType.number)),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Remove',
            onPressed: () => _removeLine(i),
            icon: Icon(Icons.close, color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
