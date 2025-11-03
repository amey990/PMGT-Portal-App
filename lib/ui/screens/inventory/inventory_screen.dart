import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import 'package:pmgt/ui/screens/dashboard/dashboard_screen.dart';
import 'package:pmgt/ui/screens/projects/add_project_screen.dart';
import 'package:pmgt/ui/screens/activities/add_activity_screen.dart';
import 'package:pmgt/ui/screens/analytics/analytics_screen.dart';
import 'package:pmgt/ui/screens/users/view_users_screen.dart';
import 'package:pmgt/ui/widgets/profile_avatar.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  // int _selectedTab = 0;

  // toggle: true = Upload Files, false = View Files
  bool _uploadMode = true;

  // dropdown data (mock)
  final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
  final _sites = const ['Aastha TV - Noida', 'Site 001', 'Site 002'];
  final _docTypes = const ['Project Plan', 'HLD', 'LLD', 'SOP', 'Misc'];

  String? _project;
  String? _site;
  String? _docType;

  // picked files
  final List<PlatformFile> _files = [];

  Future<void> _pickFiles() async {
    final remaining = 4 - _files.length;
    if (remaining <= 0) return;

    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withReadStream: false,
    );
    if (result == null) return;

    setState(() {
      for (final f in result.files) {
        if (_files.length >= 4) break;
        final exists = _files.any((e) => e.name == f.name && e.size == f.size);
        if (!exists) _files.add(f);
      }
    });
  }

  void _removeAt(int i) => setState(() => _files.removeAt(i));

  void _clearAll() {
    setState(() {
      _project = null;
      _site = null;
      _docType = null;
      _files.clear();
    });
  }

  bool get _canUpload =>
      _project != null &&
      _site != null &&
      _docType != null &&
      _files.isNotEmpty;

  // mock rows for View Files
  final List<_InvItem> _rows = List<_InvItem>.generate(
    7,
    (i) => _InvItem(
      id: i + 1,
      date: '01/08/2025',
      project: 'TelstraApari',
      site: ['Aastha TV - Noida', 'Site 001', 'Site 002'][i % 3],
      docType: ['Project Plan', 'HLD', 'LLD'][i % 3],
      fileName:
          [
            'Project plan_Telstra_PPT Ver 3.1.xlsx',
            'HLD INSN Aastha Noida - EDD.pdf',
            '127111-1 (GMN INSN Aastha Noida New Delhi Wiring)-MAIN.pdf',
          ][i % 3],
    ),
  );

  void _handleTabChange(BuildContext context, int i) {
  late final Widget target;
  switch (i) {
    case 0: target = const DashboardScreen();    break; // Dashboard
    case 1: target = const AddProjectScreen();   break; // Add Project
    case 2: target = const AddActivityScreen();  break; // Add Activity
    case 3: target = const AnalyticsScreen();    break; // Analytics
    case 4: target = const ViewUsersScreen();    break; // View Users
    default: return;
  }
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => target),
  );
}

  static const double _labelW = 84;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Inventory',
      centerTitle: true,
      // currentIndex: _selectedTab,
      // onTabChanged: (i) => setState(() => _selectedTab = i),
      currentIndex: -1,                                   // secondary page, no tab highlighted
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
          // icon: ClipOval(
          //   child: Image.asset(
          //     'assets/User_profile.png',
          //     width: 36,
          //     height: 36,
          //     fit: BoxFit.cover,
          //   ),
          // ),
          icon: const ProfileAvatar(size: 36),

        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          // ===== Toggle (matches Reminders style) =====
          Center(
            child: ToggleButtons(
              isSelected: [_uploadMode, !_uploadMode],
              borderRadius: BorderRadius.circular(8),
              constraints: const BoxConstraints(minHeight: 32, minWidth: 110),
              onPressed: (i) => setState(() => _uploadMode = i == 0),
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('Upload Files'),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('View Files'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // ===== Upload Files =====
          if (_uploadMode) _uploadCard(context),

          // ===== View Files =====
          if (!_uploadMode)
            ..._rows
                .map((r) => _inventoryItemCard(context, r))
                .expand((w) => [w, const SizedBox(height: 12)]),
        ],
      ),
    );
  }

  // ---------------- Upload card ----------------
  Widget _uploadCard(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      color: cs.surfaceContainerHighest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Upload Files',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: cs.onSurface,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                TextButton(onPressed: _clearAll, child: const Text('Clear')),
              ],
            ),
            Divider(color: cs.outlineVariant),

            const SizedBox(height: 8),
            _Dropdown<String>(
              label: 'Project',
              value: _project,
              items: _projects,
              onChanged: (v) => setState(() => _project = v),
            ),
            _Dropdown<String>(
              label: 'Site',
              value: _site,
              items: _sites,
              onChanged: (v) => setState(() => _site = v),
            ),
            _Dropdown<String>(
              label: 'Document Type',
              value: _docType,
              items: _docTypes,
              onChanged: (v) => setState(() => _docType = v),
            ),
            _ActionField(label: 'Choose File', onPressed: _pickFiles),
            _FilesChips(files: _files, onRemove: _removeAt),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Note: You can tap “Choose File” again to add up to 4 files.',
                style: TextStyle(
                  fontSize: 12,
                  color: cs.onSurfaceVariant,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed:
                    _canUpload
                        ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Uploading ${_files.length} file(s) to $_project / $_site ($_docType)…',
                              ),
                            ),
                          );
                        }
                        : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Upload',
                  style: TextStyle(fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- View Files row card ----------------
  Widget _inventoryItemCard(BuildContext context, _InvItem r) {
    final cs = Theme.of(context).colorScheme;

    Widget kv(String label, String value) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: _labelW,
            child: Text(
              '$label:',
              style: TextStyle(
                color: cs.onSurfaceVariant,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: cs.onSurface, fontSize: 12),
            ),
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '#${r.id.toString().padLeft(2, '0')}  ${r.project}',
                  style: TextStyle(
                    color: cs.onSurface,
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                r.date,
                style: TextStyle(
                  color: cs.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Divider(color: cs.outlineVariant),
          const SizedBox(height: 8),

          kv('Project', r.project),
          kv('Site', r.site),
          kv('Doc Type', r.docType),
          kv('File', r.fileName),

          const SizedBox(height: 6),
          Row(
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.download_rounded, size: 18),
                label: const Text('Download'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: cs.outlineVariant),
                  foregroundColor: cs.onSurface,
                  backgroundColor: cs.surface,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  backgroundColor: AppTheme.accentColor,
                  side: const BorderSide(color: AppTheme.accentColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ---------------- Small UI helpers ----------------

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

class _ActionField extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  const _ActionField({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return _FieldShell(
      label: label,
      child: SizedBox(
        height: 44,
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: cs.outlineVariant),
            backgroundColor: cs.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              label,
              style: TextStyle(
                color: onPressed == null ? cs.onSurfaceVariant : cs.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilesChips extends StatelessWidget {
  final List<PlatformFile> files;
  final void Function(int index) onRemove;
  const _FilesChips({required this.files, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    if (files.isEmpty) {
      return _FieldShell(
        label: 'Selected Files',
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          child: Text(
            'No files selected',
            style: TextStyle(color: cs.onSurfaceVariant, fontSize: 12),
          ),
        ),
      );
    }

    return _FieldShell(
      label: 'Selected Files',
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (int i = 0; i < files.length; i++)
            InputChip(
              label: Text(files[i].name, overflow: TextOverflow.ellipsis),
              onDeleted: () => onRemove(i),
              deleteIconColor: cs.onSurfaceVariant,
              backgroundColor: cs.surface,
              shape: StadiumBorder(side: BorderSide(color: cs.outlineVariant)),
            ),
        ],
      ),
    );
  }
}

class _InvItem {
  final int id;
  final String date;
  final String project;
  final String site;
  final String docType;
  final String fileName;
  _InvItem({
    required this.id,
    required this.date,
    required this.project,
    required this.site,
    required this.docType,
    required this.fileName,
  });
}
