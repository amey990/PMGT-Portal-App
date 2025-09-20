// import 'package:flutter/material.dart';

// class AddSiteScreen extends StatefulWidget {
//   const AddSiteScreen({super.key});

//   @override
//   State<AddSiteScreen> createState() => _AddSiteScreenState();
// }

// class _AddSiteScreenState extends State<AddSiteScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';

class AddSiteScreen extends StatefulWidget {
  const AddSiteScreen({super.key});

  @override
  State<AddSiteScreen> createState() => _AddSiteScreenState();
}

class _AddSiteScreenState extends State<AddSiteScreen> {
  // --- sample dropdown data ---
  final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
  final _states = const ['Maharashtra', 'Gujarat', 'Karnataka'];
  final _districts = const ['Thane', 'Pune', 'Ahmedabad', 'Bengaluru Urban'];
  final _cities = const ['Panvel', 'Thane', 'Pune', 'Ahmedabad', 'Bengaluru'];

  // --- bulk upload ---
  String? _bulkProject;
  String? _bulkFileName;

  // --- single site ---
  String? _project;
  String? _state;
  String? _district;
  String? _city;

  final _siteNameCtrl = TextEditingController();
  final _siteIdCtrl = TextEditingController(
    text: 'AUTO-SITE-001',
  ); // read-only placeholder
  final _addressCtrl = TextEditingController();
  final _pincodeCtrl = TextEditingController();
  final _pocCtrl = TextEditingController();

  @override
  void dispose() {
    _siteNameCtrl.dispose();
    _siteIdCtrl.dispose();
    _addressCtrl.dispose();
    _pincodeCtrl.dispose();
    _pocCtrl.dispose();
    super.dispose();
  }

  void _clearBulk() {
    setState(() {
      _bulkProject = null;
      _bulkFileName = null;
    });
  }

  void _clearSingle() {
    setState(() {
      _project = null;
      _state = null;
      _district = null;
      _city = null;
      _siteNameCtrl.clear();
      _addressCtrl.clear();
      _pincodeCtrl.clear();
      _pocCtrl.clear();
      _siteIdCtrl.text = 'AUTO-SITE-001';
    });
  }

  Future<void> _pickFile() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls', 'csv'],
      withData: false,
    );
    if (res != null && res.files.isNotEmpty) {
      setState(() => _bulkFileName = res.files.single.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add Site',
      centerTitle: true,
      currentIndex: 0,
      onTabChanged: (_) {},
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
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          // ===== Card 1: Bulk upload =====
          Card(
            color: cs.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header: title + CLEAR
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add Sites in Bulk',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _clearBulk,
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  _Dropdown<String>(
                    label: 'Project *',
                    value: _bulkProject,
                    items: _projects,
                    onChanged: (v) => setState(() => _bulkProject = v),
                  ),

                  // File name display + choose button (single button picker)
                  _FieldShell(
                    label: 'Choose File',
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 48,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: cs.surface,
                              border: Border.all(color: cs.outlineVariant),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _bulkFileName ?? 'No file selected',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color:
                                    _bulkFileName == null
                                        ? cs.onSurfaceVariant
                                        : cs.onSurface,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        OutlinedButton(
                          onPressed: _pickFile,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: cs.outlineVariant),
                          ),
                          child: const Text('Choose File'),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Bottom row: Download Template (start) + Upload (end)
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          // TODO: Hook real template download
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Downloading template...'),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppTheme.accentColor),
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                        ),
                        child: const Text('Download Template'),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // TODO: bulk upload handler
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Upload started...')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.accentColor,
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Upload',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ===== Card 2: Single site =====
          Card(
            color: cs.surfaceContainerHighest,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Add Site',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            color: cs.onSurface,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: _clearSingle,
                        child: const Text('Clear'),
                      ),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  LayoutBuilder(
                    builder: (context, c) {
                      final isWide = c.maxWidth >= 640;
                      final gap = isWide ? 12.0 : 0.0;

                      final left = [
                        _Dropdown<String>(
                          label: 'Project *',
                          value: _project,
                          items: _projects,
                          onChanged: (v) => setState(() => _project = v),
                        ),
                        _TextField(
                          label: 'Site Name *',
                          controller: _siteNameCtrl,
                        ),
                        _TextField(
                          label: 'Address *',
                          controller: _addressCtrl,
                          maxLines: 3,
                        ),
                        _Dropdown<String>(
                          label: 'POC *',
                          value: _pocCtrl.text.isEmpty ? null : _pocCtrl.text,
                          items: const ['—', 'Amey', 'Priya', 'Rahul'],
                          onChanged: (v) {
                            setState(() => _pocCtrl.text = v ?? '');
                          },
                        ),
                        _Dropdown<String>(
                          label: 'District *',
                          value: _district,
                          items: _districts,
                          onChanged: (v) => setState(() => _district = v),
                        ),
                      ];

                      final right = [
                        _ROText('Site ID *', _siteIdCtrl),
                        _TextField(
                          label: 'Pincode *',
                          controller: _pincodeCtrl,
                          keyboardType: TextInputType.number,
                        ),
                        _Dropdown<String>(
                          label: 'State *',
                          value: _state,
                          items: _states,
                          onChanged: (v) => setState(() => _state = v),
                        ),
                        _Dropdown<String>(
                          label: 'City *',
                          value: _city,
                          items: _cities,
                          onChanged: (v) => setState(() => _city = v),
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

                  // const SizedBox(height: 12),
                  // Align(
                  //   alignment: Alignment.centerRight,
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       // TODO: single add handler
                  //       ScaffoldMessenger.of(context).showSnackBar(
                  //         const SnackBar(content: Text('Site added')),
                  //       );
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       backgroundColor: AppTheme.accentColor,
                  //       foregroundColor: Colors.black,
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 24,
                  //         vertical: 12,
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(8),
                  //       ),
                  //     ),
                  //     child: const Text(
                  //       'Add',
                  //       style: TextStyle(fontWeight: FontWeight.w800),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: single add handler
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Site added')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.accentColor,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'ADD',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ----- Small UI helpers (consistent look) -----

class _FieldShell extends StatelessWidget {
  final String label;
  final Widget child;
  const _FieldShell({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: cs.onSurfaceVariant,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;
  final TextInputType? keyboardType;
  const _TextField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surface,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.accentColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

class _ROText extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  const _ROText(this.label, this.controller);

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: TextField(
        controller: controller,
        enabled: false,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surface,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  final String label;
  final T? value;
  final List<T> items;
  final ValueChanged<T?> onChanged;
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: cs.outlineVariant),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            value: value,
            isExpanded: true,
            iconEnabledColor: cs.onSurfaceVariant,
            dropdownColor: Theme.of(context).scaffoldBackgroundColor,
            style: TextStyle(color: cs.onSurface, fontSize: 14),
            items:
                items
                    .map(
                      (e) => DropdownMenuItem<T>(value: e, child: Text('$e')),
                    )
                    .toList(),
            hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
