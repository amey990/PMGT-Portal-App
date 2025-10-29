// import 'package:flutter/material.dart';
// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';
// import '../profile/profile_screen.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';

// class AddActivityScreen extends StatefulWidget {
//   const AddActivityScreen({super.key});

//   @override
//   State<AddActivityScreen> createState() => _AddActivityScreenState();
// }

// class _AddActivityScreenState extends State<AddActivityScreen> {
//   // --- Controllers (readonly fields are still controllers so Clear works) ---
//   final _ticketNoCtrl = TextEditingController(text: 'npci-001'); // example
//   final _dateLabelKey = GlobalKey(); // keeps date field stable
//   final _countryCtrl = TextEditingController(text: 'India');
//   final _stateCtrl = TextEditingController(text: 'Maharashtra');
//   final _districtCtrl = TextEditingController(text: 'Thane');
//   final _cityCtrl = TextEditingController(text: 'Panvel');
//   final _addressCtrl = TextEditingController(text: 'XYZ');
//   final _siteIdCtrl = TextEditingController(text: '001');
//   final _pmCtrl = TextEditingController(text: 'Amey');
//   final _vendorCtrl = TextEditingController(text: '—');
//   final _feMobileCtrl = TextEditingController(text: '—');
//   final _remarksCtrl = TextEditingController();
//   final _statusCtrl = TextEditingController(text: 'Open');

//   // dropdowns
//   String? _project;
//   String? _subProject; // NEW
//   String? _siteName;
//   String? _feName;
//   String? _nocEngineer;
//   String? _activityCategory;

//   // dates
//   DateTime _date = DateTime.now();
//   DateTime? _completionDate;

//   // sample dropdown data
//   final _projects = const ['NPCI', 'TelstraApari', 'BPCL Aruba WIFI'];
//   final _subProjects = const ['SP-1', 'SP-2', 'Child-1', 'Child-2']; // NEW
//   final _siteNames = const ['ABCS', 'ABCD', 'HQ-01'];
//   final _feNames = const ['Rahul', 'Priya', 'Meera'];
//   final _nocEngineers = const ['Nikhil', 'Shreya', 'Aman'];
//   final _activityCategories = const [
//     'Breakdown',
//     'Install',
//     'Audit',
//     'Maintenance',
//   ];

//   @override
//   void dispose() {
//     _ticketNoCtrl.dispose();
//     _countryCtrl.dispose();
//     _stateCtrl.dispose();
//     _districtCtrl.dispose();
//     _cityCtrl.dispose();
//     _addressCtrl.dispose();
//     _siteIdCtrl.dispose();
//     _pmCtrl.dispose();
//     _vendorCtrl.dispose();
//     _feMobileCtrl.dispose();
//     _remarksCtrl.dispose();
//     _statusCtrl.dispose();
//     super.dispose();
//   }

//   void _clearAll() {
//     setState(() {
//       _ticketNoCtrl.text = '';
//       _countryCtrl.text = '';
//       _stateCtrl.text = '';
//       _districtCtrl.text = '';
//       _cityCtrl.text = '';
//       _addressCtrl.text = '';
//       _siteIdCtrl.text = '';
//       _pmCtrl.text = '';
//       _vendorCtrl.text = '';
//       _feMobileCtrl.text = '';
//       _remarksCtrl.clear();
//       _statusCtrl.text = 'Open';

//       _project = null;
//       _subProject = null;
//       _siteName = null;
//       _feName = null;
//       _nocEngineer = null;
//       _activityCategory = null;

//       _date = DateTime.now();
//       _completionDate = null;
//     });
//   }

//   void _handleTabChange(BuildContext context, int i) {
//     if (i == 2) return; // already on Add Activity
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break;
//       case 1:
//         target = const AddProjectScreen();
//         break;
//       case 3:
//         target = const AnalyticsScreen();
//         break;
//       case 4:
//         target = const ViewUsersScreen();
//         break;
//       default:
//         return;
//     }
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   Future<void> _pickDate({required bool isCompletion}) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: isCompletion ? (_completionDate ?? DateTime.now()) : _date,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isCompletion) {
//           _completionDate = picked;
//         } else {
//           _date = picked;
//         }
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add Activity',
//       centerTitle: true,
//       currentIndex: 2,
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       actions: [
//         IconButton(
//           tooltip: Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
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
//             Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
//           icon: ClipOval(
//             child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           ),
//         ),
//         const SizedBox(width: 8),
//       ],
//       body: ListView(
//         padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//         children: [
//           Card(
//             color: Theme.of(context).cardColor,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: const EdgeInsets.all(14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Header row
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           'Create New Activity',
//                           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                 color: cs.onSurface,
//                                 fontWeight: FontWeight.w800,
//                               ),
//                         ),
//                       ),
//                       TextButton(onPressed: _clearAll, child: const Text('CLEAR')),
//                     ],
//                   ),
//                   Divider(color: cs.outlineVariant),

//                   // Fields (responsive two columns)
//                   LayoutBuilder(
//                     builder: (context, c) {
//                       final isWide = c.maxWidth >= 640; // break point
//                       final columnGap = isWide ? 12.0 : 0.0;

//                       // ORDER requested:
//                       // Ticket No (RO), Date, Project, Sub Project, Activity Category,
//                       // Country (RO), State (RO), District (RO), City (RO),
//                       // Address (RO), Site ID (RO), Site Name (readonly in spec; keeping dropdown logic),
//                       // Project Manager (RO), Vendor, FE Name (drop), FE Mobile (RO),
//                       // NOC Engineer (drop), Remarks, Status (Open), Completion Date

//                       final left = <Widget>[
//                         _ROText('Ticket No *', _ticketNoCtrl),
//                         _Dropdown<String>(
//                           label: 'Project *',
//                           value: _project,
//                           items: _projects,
//                           onChanged: (v) => setState(() => _project = v),
//                         ),
//                         _Dropdown<String>(
//                           label: 'Sub Project',
//                           value: _subProject,
//                           items: _subProjects,
//                           onChanged: (v) => setState(() => _subProject = v),
//                         ),
//                         _ROText('Country *', _countryCtrl),
//                         _ROText('City *', _cityCtrl),
//                         _ROText('Site Id *', _siteIdCtrl),
//                         // Keeping your original dropdown logic for Site Name
//                         _Dropdown<String>(
//                           label: 'Site Name *',
//                           value: _siteName,
//                           items: _siteNames,
//                           onChanged: (v) => setState(() => _siteName = v),
//                         ),
//                         _ROText('Project Manager *', _pmCtrl),
//                         _Dropdown<String>(
//                           label: 'FE Name',
//                           value: _feName,
//                           items: _feNames,
//                           onChanged: (v) => setState(() => _feName = v),
//                         ),
//                         _DateField(
//                           label: 'Completion Date',
//                           date: _completionDate,
//                           onTap: () => _pickDate(isCompletion: true),
//                         ),
//                       ];

//                       final right = <Widget>[
//                         _DateField(
//                           key: _dateLabelKey,
//                           label: 'Scheduled Date *',
//                           date: _date,
//                           onTap: () => _pickDate(isCompletion: false),
//                         ),
//                         _Dropdown<String>(
//                           label: 'Activity Category *',
//                           value: _activityCategory,
//                           items: _activityCategories,
//                           onChanged: (v) => setState(() => _activityCategory = v),
//                         ),
//                         _ROText('State *', _stateCtrl),
//                         _ROText('District *', _districtCtrl),
//                         _ROText('Address *', _addressCtrl),
//                         _ROText('Vendor', _vendorCtrl),
//                         _ROText('FE Mobile', _feMobileCtrl),
//                         _Dropdown<String>(
//                           label: 'NOC Engineer',
//                           value: _nocEngineer,
//                           items: _nocEngineers,
//                           onChanged: (v) => setState(() => _nocEngineer = v),
//                         ),
//                         _Multiline(label: 'Remarks', controller: _remarksCtrl),
//                         _ROText('Status', _statusCtrl), // defaults to Open
//                       ];

//                       if (!isWide) {
//                         return Column(children: [...left, ...right, const SizedBox(height: 12)]);
//                       }

//                       // Two columns on wide
//                       return Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(child: Column(children: left)),
//                           SizedBox(width: columnGap),
//                           Expanded(child: Column(children: right)),
//                         ],
//                       );
//                     },
//                   ),

//                   const SizedBox(height: 12),
//                   _CreateButton(onPressed: _onCreate),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _onCreate() {
//     // TODO: Add submit logic / validation / API call
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Create tapped')));
//   }
// }

// // === Small UI helpers ========================================================

// class _FieldShell extends StatelessWidget {
//   final String label;
//   final Widget child;
//   const _FieldShell({required this.label, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 6),
//           child,
//         ],
//       ),
//     );
//   }
// }

// class _ROText extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _ROText(this.label, this.controller);

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         enabled: false,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           hintText: 'Read-only',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         ),
//       ),
//     );
//   }
// }

// class _Dropdown<T> extends StatelessWidget {
//   final String label;
//   final T? value;
//   final List<T> items;
//   final ValueChanged<T?> onChanged;
//   const _Dropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: Container(
//         decoration: BoxDecoration(
//           color: cs.surfaceContainerHighest,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(color: cs.outlineVariant),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         child: DropdownButtonHideUnderline(
//           child: DropdownButton<T>(
//             value: value,
//             isExpanded: true,
//             iconEnabledColor: cs.onSurfaceVariant,
//             dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//             style: TextStyle(color: cs.onSurface, fontSize: 14),
//             items: items.map((e) => DropdownMenuItem<T>(value: e, child: Text('$e'))).toList(),
//             hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//             onChanged: onChanged,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DateField extends StatelessWidget {
//   final String label;
//   final DateTime? date;
//   final VoidCallback onTap;
//   const _DateField({
//     super.key,
//     required this.label,
//     required this.date,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final text = date == null
//         ? 'Select date'
//         : '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}';
//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   text,
//                   style: TextStyle(color: date == null ? cs.onSurfaceVariant : cs.onSurface),
//                 ),
//               ),
//               Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _Multiline extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _Multiline({required this.label, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         maxLines: 4,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           hintText: 'Enter $label',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppTheme.accentColor),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         ),
//       ),
//     );
//   }
// }

// class _CreateButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   const _CreateButton({required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppTheme.accentColor,
//           foregroundColor: Colors.black,
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child: const Text('CREATE', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5)),
//       ),
//     );
//   }
// }



//p2//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../core/theme.dart';
// import '../../../core/theme_controller.dart';
// import '../../../core/api_client.dart';
// import '../../../state/user_session.dart';

// import '../../utils/responsive.dart';
// import '../../widgets/layout/main_layout.dart';

// import '../profile/profile_screen.dart';
// import '../dashboard/dashboard_screen.dart';
// import '../projects/add_project_screen.dart';
// import '../analytics/analytics_screen.dart';
// import '../users/view_users_screen.dart';

// class AddActivityScreen extends StatefulWidget {
//   const AddActivityScreen({super.key});

//   @override
//   State<AddActivityScreen> createState() => _AddActivityScreenState();
// }

// class _AddActivityScreenState extends State<AddActivityScreen> {
//   // --- Controllers (readonly fields are still controllers so Clear works) ---
//   final _ticketNoCtrl = TextEditingController(); // will be generated
//   final _countryCtrl = TextEditingController();
//   final _stateCtrl = TextEditingController();
//   final _districtCtrl = TextEditingController();
//   final _cityCtrl = TextEditingController();
//   final _addressCtrl = TextEditingController();
//   final _siteIdCtrl = TextEditingController();
//   final _pmCtrl = TextEditingController();
//   final _vendorCtrl = TextEditingController(text: '—');
//   final _feMobileCtrl = TextEditingController(text: '—');
//   final _remarksCtrl = TextEditingController();
//   final _statusCtrl = TextEditingController(text: 'Open');

//   // dropdowns (values are backend IDs unless noted)
//   String? _projectId;
//   String? _subProjectId;
//   String? _siteKey; // composed key site_id::sub_project_id
//   String? _feId;
//   String? _nocId;
//   String? _activityCategory;

//   // dates
//   DateTime _date = DateTime.now();
//   DateTime? _completionDate;

//   bool _loading = false;

//   // lookups
//   List<_Project> _projects = [];
//   List<_SubProject> _subProjects = [];
//   List<_SiteOption> _siteOptions = [];
//   List<_FE> _fes = [];
//   List<_NOC> _nocs = [];

//   final List<String> _categories = const [
//     'Breakdown',
//     'New Installation',
//     'Upgrades',
//     'Corrective Maintenance',
//     'Preventive Maintenance',
//     'Revisit',
//     'Site Survey',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _bootstrap();
//   }

//   @override
//   void dispose() {
//     _ticketNoCtrl.dispose();
//     _countryCtrl.dispose();
//     _stateCtrl.dispose();
//     _districtCtrl.dispose();
//     _cityCtrl.dispose();
//     _addressCtrl.dispose();
//     _siteIdCtrl.dispose();
//     _pmCtrl.dispose();
//     _vendorCtrl.dispose();
//     _feMobileCtrl.dispose();
//     _remarksCtrl.dispose();
//     _statusCtrl.dispose();
//     super.dispose();
//   }

//   Future<void> _bootstrap() async {
//     // pull initial lists (projects, FEs, NOCs)
//     final api = context.read<ApiClient>();
//     setState(() => _loading = true);

//     try {
//       // Projects
//       final pRes = await api.get('/api/projects');
//       final pData = (jsonDecode(pRes.body) as List?) ?? [];
//       _projects
//         ..clear()
//         ..addAll(pData.map((e) => _Project(
//               id: e['id'].toString(),
//               name: (e['project_name'] ?? '').toString(),
//               manager: (e['project_manager'] ?? '').toString(),
//             )));

//       // FEs
//       final feRes = await api.get('/api/field-engineers');
//       final feData =
//           (jsonDecode(feRes.body) as Map?)?['field_engineers'] as List? ?? [];
//       _fes
//         ..clear()
//         ..addAll(feData.map((e) => _FE(
//               id: e['id'].toString(),
//               name: (e['full_name'] ?? '').toString(),
//               phone: (e['contact_no'] ?? '').toString(),
//               vendor: (e['contact_person'] ?? '')?.toString(),
//             )));

//       // NOCs
//       final nRes = await api.get('/api/nocs');
//       final nData = (jsonDecode(nRes.body) as List?) ?? [];
//       _nocs
//         ..clear()
//         ..addAll(nData.map((e) => _NOC(
//               id: e['id'].toString(),
//               name: (e['full_name'] ?? '').toString(),
//             )));
//     } catch (e) {
//       _snack('Failed to load lists. ${e.toString()}');
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   Future<void> _onProjectChanged(String? id) async {
//     setState(() {
//       _projectId = id;
//       _subProjectId = null;
//       _siteKey = null;

//       _countryCtrl.clear();
//       _stateCtrl.clear();
//       _districtCtrl.clear();
//       _cityCtrl.clear();
//       _addressCtrl.clear();
//       _siteIdCtrl.clear();
//       _pmCtrl.clear();

//       _subProjects.clear();
//       _siteOptions.clear();
//     });

//     if (id == null || id.isEmpty) return;

//     final api = context.read<ApiClient>();
//     try {
//       // sub-projects
//       final spRes = await api.get('/api/projects/$id/sub-projects');
//       final spData = (jsonDecode(spRes.body) as List?) ?? [];
//       _subProjects
//         ..clear()
//         ..addAll(spData.map((e) => _SubProject(
//               id: e['id'].toString(),
//               name: (e['name'] ?? '').toString(),
//             )));

//       // project sites
//       final sRes = await api.get('/api/project-sites/$id');
//       final sData = (jsonDecode(sRes.body) as List?) ?? [];
//       _siteOptions
//         ..clear()
//         ..addAll(sData.map((e) {
//           final siteId = (e['site_id'] ?? '').toString();
//           final subPid = e['sub_project_id']?.toString() ?? '';
//           final siteName = (e['site_name'] ?? '').toString();
//           final subName = (e['sub_project_name'] ?? '').toString();

//           return _SiteOption(
//             key: '$siteId::$subPid',
//             siteId: siteId,
//             siteName: siteName,
//             country: (e['country'] ?? '').toString(),
//             state: (e['state'] ?? '').toString(),
//             district: (e['district'] ?? '').toString(),
//             city: (e['city'] ?? '').toString(),
//             address: (e['address'] ?? '').toString(),
//             subProjectId: subPid.isEmpty ? null : subPid,
//             subProjectName: subName.isEmpty ? null : subName,
//           );
//         }));

//       // project manager
//       final proj = _projects.firstWhere((p) => p.id == id, orElse: () => _Project.empty());
//       _pmCtrl.text = proj.manager;

//       // generate next ticket for this project
//       await _generateTicketNo(id);
//     } catch (e) {
//       _snack('Failed to load project data. ${e.toString()}');
//     } finally {
//       if (mounted) setState(() {});
//     }
//   }

//   Future<void> _generateTicketNo(String projectId) async {
//   final api = context.read<ApiClient>();

//   try {
//     // GET /api/activities/tickets?projectId=...
//     final tRes = await api.get(
//       '/api/activities/tickets?projectId=${Uri.encodeQueryComponent(projectId)}',
//     );

//     final list = (jsonDecode(tRes.body) as List?) ?? [];
//     final existing = list
//         .map((e) => (e['ticket_no'] ?? '').toString())
//         .where((s) => s.isNotEmpty)
//         .toList();

//     // prefix from project name (same as web)
//     final proj = _projects.firstWhere((p) => p.id == projectId);
//     final prefix = proj.name.replaceAll(RegExp(r'\s+'), '').toLowerCase();

//     int max = 0;
//     for (final s in existing) {
//       final m = RegExp('^$prefix-(\\d{3})\$').firstMatch(s); // <-- fixed regex
//       if (m != null) {
//         final n = int.tryParse(m.group(1)!) ?? 0;
//         if (n > max) max = n;
//       }
//     }
//     // final next = (max + 1).toString().padStart(3, '0');
//     final next = (max + 1).toString().padLeft(3, '0');

//     _ticketNoCtrl.text = '$prefix-$next';
//   } catch (_) {
//     _ticketNoCtrl.text = 'ticket-${DateTime.now().millisecondsSinceEpoch}';
//   }
// }


//   void _clearAll() {
//     setState(() {
//       _ticketNoCtrl.clear();
//       _countryCtrl.clear();
//       _stateCtrl.clear();
//       _districtCtrl.clear();
//       _cityCtrl.clear();
//       _addressCtrl.clear();
//       _siteIdCtrl.clear();
//       _pmCtrl.clear();
//       _vendorCtrl.text = '—';
//       _feMobileCtrl.text = '—';
//       _remarksCtrl.clear();
//       _statusCtrl.text = 'Open';

//       _projectId = null;
//       _subProjectId = null;
//       _siteKey = null;
//       _feId = null;
//       _nocId = null;
//       _activityCategory = null;

//       _date = DateTime.now();
//       _completionDate = null;

//       _subProjects.clear();
//       _siteOptions.clear();
//     });
//   }

//   void _handleTabChange(BuildContext context, int i) {
//     if (i == 2) return; // already here
//     late final Widget target;
//     switch (i) {
//       case 0:
//         target = const DashboardScreen();
//         break;
//       case 1:
//         target = const AddProjectScreen();
//         break;
//       case 3:
//         target = const AnalyticsScreen();
//         break;
//       case 4:
//         target = const ViewUsersScreen();
//         break;
//       default:
//         return;
//     }
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => target));
//   }

//   Future<void> _pickDate({required bool isCompletion}) async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: isCompletion ? (_completionDate ?? DateTime.now()) : _date,
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2100),
//       builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isCompletion) {
//           _completionDate = picked;
//         } else {
//           _date = picked;
//         }
//       });
//     }
//   }

//   void _snack(String msg) {
//     if (!mounted) return;
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }

//   Future<void> _onCreate() async {
//     if ((_projectId ?? '').isEmpty) return _snack('Please select a project.');
//     if ((_activityCategory ?? '').isEmpty) return _snack('Please select an activity category.');
//     if ((_siteIdCtrl.text).isEmpty) return _snack('Please pick a site.');

//     final api = context.read<ApiClient>();
//     final body = {
//       'ticket_no': _ticketNoCtrl.text,
//       'project_id': _projectId,
//       'site_id': _siteIdCtrl.text,
//       'sub_project_id': _subProjectId,
//       'activity_category': _activityCategory,
//       'activity_date':
//           '${_date.year.toString().padLeft(4, '0')}-${_date.month.toString().padLeft(2, '0')}-${_date.day.toString().padLeft(2, '0')}',
//       'completion_date': _completionDate == null
//           ? null
//           : '${_completionDate!.year.toString().padLeft(4, '0')}-${_completionDate!.month.toString().padLeft(2, '0')}-${_completionDate!.day.toString().padLeft(2, '0')}',
//       'country': _countryCtrl.text,
//       'state': _stateCtrl.text,
//       'district': _districtCtrl.text,
//       'city': _cityCtrl.text,
//       'address': _addressCtrl.text,
//       'project_manager': _pmCtrl.text,
//       'vendor': _vendorCtrl.text,
//       'field_engineer_id': _feId,
//       'fe_mobile': _feMobileCtrl.text,
//       'noc_engineer_id': _nocId,
//       'remarks': _remarksCtrl.text,
//       'status': _statusCtrl.text,
//     };

//     try {
//       setState(() => _loading = true);
//       final res = await api.post('/api/activities', body: body);
//       if (res.statusCode >= 200 && res.statusCode < 300) {
//         _snack('Activity created successfully.');
//         _clearAll();
//       } else {
//         final data = jsonDecode(res.body);
//         _snack(data['error']?.toString() ?? 'Failed to create activity.');
//       }
//     } catch (e) {
//       _snack('Failed to create activity. ${e.toString()}');
//     } finally {
//       if (mounted) setState(() => _loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;

//     return MainLayout(
//       title: 'Add Activity',
//       centerTitle: true,
//       currentIndex: 2,
//       onTabChanged: (i) => _handleTabChange(context, i),
//       safeArea: false,
//       reserveBottomPadding: true,
//       actions: [
//         IconButton(
//           tooltip: Theme.of(context).brightness == Brightness.dark ? 'Light mode' : 'Dark mode',
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
//             Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
//           },
//           icon: ClipOval(
//             child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
//           ),
//         ),
//         const SizedBox(width: 8),
//       ],
//       body: AbsorbPointer(
//         absorbing: _loading,
//         child: ListView(
//           padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
//           children: [
//             Card(
//               color: Theme.of(context).cardColor,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Padding(
//                 padding: const EdgeInsets.all(14),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             'Create New Activity',
//                             style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                                   color: cs.onSurface,
//                                   fontWeight: FontWeight.w800,
//                                 ),
//                           ),
//                         ),
//                         TextButton(onPressed: _clearAll, child: const Text('CLEAR')),
//                       ],
//                     ),
//                     Divider(color: cs.outlineVariant),

//                     LayoutBuilder(
//                       builder: (context, c) {
//                         final isWide = c.maxWidth >= 640;
//                         final columnGap = isWide ? 12.0 : 0.0;

//                         final left = <Widget>[
//                           _ROText('Ticket No *', _ticketNoCtrl),
//                           _Dropdown<String>(
//                             label: 'Project *',
//                             value: _projectId,
//                             items: _projects.map((e) => DropdownMenuItem(value: e.id, child: Text(e.name))).toList(),
//                             onChanged: (v) => _onProjectChanged(v),
//                           ),
//                           _Dropdown<String>(
//                             label: 'Sub Project',
//                             value: _subProjectId,
//                             items: _subProjects
//                                 .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
//                                 .toList(),
//                             onChanged: (v) => setState(() => _subProjectId = v),
//                             enabled: _subProjects.isNotEmpty,
//                           ),
//                           _ROText('Country *', _countryCtrl),
//                           _ROText('City *', _cityCtrl),
//                           _ROText('Site Id *', _siteIdCtrl),
//                           _Dropdown<String>(
//                             label: 'Site Name *',
//                             value: _siteKey,
//                             items: _siteOptions
//                                 .where((s) =>
//                                     _subProjectId == null ||
//                                     s.subProjectId == _subProjectId ||
//                                     (s.subProjectId == null &&
//                                         (_subProjects
//                                                 .firstWhere(
//                                                   (sp) => sp.id == (_subProjectId ?? ''),
//                                                   orElse: () => _SubProject(id: '', name: ''),
//                                                 )
//                                                 .name
//                                                 .toLowerCase() ==
//                                             (s.subProjectName ?? '').toLowerCase())))
//                                 .map((s) => DropdownMenuItem(
//                                       value: s.key,
//                                       child: Text('${s.siteId} — ${s.siteName}'
//                                           '${s.subProjectName != null ? ' (${s.subProjectName})' : ''}'),
//                                     ))
//                                 .toList(),
//                             onChanged: (v) {
//                               setState(() {
//                                 _siteKey = v;
//                                 final sel = _siteOptions.firstWhere((x) => x.key == v);
//                                 _siteIdCtrl.text = sel.siteId;
//                                 _countryCtrl.text = sel.country;
//                                 _stateCtrl.text = sel.state;
//                                 _districtCtrl.text = sel.district;
//                                 _cityCtrl.text = sel.city;
//                                 _addressCtrl.text = sel.address;
//                                 _subProjectId = sel.subProjectId;
//                               });
//                             },
//                             enabled: _siteOptions.isNotEmpty,
//                           ),
//                           _ROText('Project Manager *', _pmCtrl),
//                           _Dropdown<String>(
//                             label: 'FE Name',
//                             value: _feId,
//                             items: _fes
//                                 .map((e) => DropdownMenuItem(value: e.id, child: Text(e.name)))
//                                 .toList(),
//                             onChanged: (v) {
//                               setState(() {
//                                 _feId = v;
//                                 final fe = _fes.firstWhere((x) => x.id == v);
//                                 _feMobileCtrl.text = fe.phone;
//                                 _vendorCtrl.text = fe.vendor ?? '—';
//                               });
//                             },
//                           ),
//                           _DateField(
//                             label: 'Completion Date',
//                             date: _completionDate,
//                             onTap: () => _pickDate(isCompletion: true),
//                           ),
//                         ];

//                         final right = <Widget>[
//                           _DateField(
//                             label: 'Scheduled Date *',
//                             date: _date,
//                             onTap: () => _pickDate(isCompletion: false),
//                           ),
//                           _Dropdown<String>(
//                             label: 'Activity Category *',
//                             value: _activityCategory,
//                             items: _categories
//                                 .map((c) => DropdownMenuItem(value: c, child: Text(c)))
//                                 .toList(),
//                             onChanged: (v) => setState(() => _activityCategory = v),
//                           ),
//                           _ROText('State *', _stateCtrl),
//                           _ROText('District *', _districtCtrl),
//                           _ROText('Address *', _addressCtrl),
//                           _ROText('Vendor', _vendorCtrl),
//                           _ROText('FE Mobile', _feMobileCtrl),
//                           _Dropdown<String>(
//                             label: 'NOC Engineer',
//                             value: _nocId,
//                             items:
//                                 _nocs.map((e) => DropdownMenuItem(value: e.id, child: Text(e.name))).toList(),
//                             onChanged: (v) => setState(() => _nocId = v),
//                           ),
//                           _Multiline(label: 'Remarks', controller: _remarksCtrl),
//                           _ROText('Status', _statusCtrl), // defaults to Open
//                         ];

//                         if (!isWide) {
//                           return Column(children: [...left, ...right, const SizedBox(height: 12)]);
//                         }

//                         return Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(child: Column(children: left)),
//                             SizedBox(width: columnGap),
//                             Expanded(child: Column(children: right)),
//                           ],
//                         );
//                       },
//                     ),

//                     const SizedBox(height: 12),
//                     _CreateButton(onPressed: _onCreate),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // === Small UI helpers & models ===============================================

// class _Project {
//   final String id;
//   final String name;
//   final String manager;
//   _Project({required this.id, required this.name, required this.manager});
//   factory _Project.empty() => _Project(id: '', name: '', manager: '');
// }

// class _SubProject {
//   final String id;
//   final String name;
//   _SubProject({required this.id, required this.name});
// }

// class _SiteOption {
//   final String key; // siteId::subProjectId
//   final String siteId;
//   final String siteName;
//   final String country;
//   final String state;
//   final String district;
//   final String city;
//   final String address;
//   final String? subProjectId;
//   final String? subProjectName;
//   _SiteOption({
//     required this.key,
//     required this.siteId,
//     required this.siteName,
//     required this.country,
//     required this.state,
//     required this.district,
//     required this.city,
//     required this.address,
//     required this.subProjectId,
//     required this.subProjectName,
//   });
// }

// class _FE {
//   final String id;
//   final String name;
//   final String phone;
//   final String? vendor;
//   _FE({required this.id, required this.name, required this.phone, this.vendor});
// }

// class _NOC {
//   final String id;
//   final String name;
//   _NOC({required this.id, required this.name});
// }

// class _FieldShell extends StatelessWidget {
//   final String label;
//   final Widget child;
//   const _FieldShell({required this.label, required this.child});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Text(
//             label,
//             style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600),
//           ),
//           const SizedBox(height: 6),
//           child,
//         ],
//       ),
//     );
//   }
// }

// class _ROText extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _ROText(this.label, this.controller);

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         enabled: false,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           hintText: 'Read-only',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           disabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         ),
//       ),
//     );
//   }
// }

// class _Dropdown<T> extends StatelessWidget {
//   final String label;
//   final T? value;
//   final List<DropdownMenuItem<T>> items;
//   final ValueChanged<T?> onChanged;
//   final bool enabled;
//   const _Dropdown({
//     required this.label,
//     required this.value,
//     required this.items,
//     required this.onChanged,
//     this.enabled = true,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: IgnorePointer(
//         ignoring: !enabled,
//         child: Opacity(
//           opacity: enabled ? 1 : 0.6,
//           child: Container(
//             decoration: BoxDecoration(
//               color: cs.surfaceContainerHighest,
//               borderRadius: BorderRadius.circular(8),
//               border: Border.all(color: cs.outlineVariant),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 8),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<T>(
//                 value: value,
//                 isExpanded: true,
//                 iconEnabledColor: cs.onSurfaceVariant,
//                 dropdownColor: Theme.of(context).scaffoldBackgroundColor,
//                 style: TextStyle(color: cs.onSurface, fontSize: 14),
//                 items: items,
//                 hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
//                 onChanged: onChanged,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _DateField extends StatelessWidget {
//   final String label;
//   final DateTime? date;
//   final VoidCallback onTap;
//   const _DateField({
//     super.key,
//     required this.label,
//     required this.date,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     final text = date == null
//         ? 'Select date'
//         : '${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}';
//     return _FieldShell(
//       label: label,
//       child: InkWell(
//         onTap: onTap,
//         borderRadius: BorderRadius.circular(8),
//         child: Container(
//           height: 48,
//           decoration: BoxDecoration(
//             color: cs.surfaceContainerHighest,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(color: cs.outlineVariant),
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: Text(
//                   text,
//                   style: TextStyle(color: date == null ? cs.onSurfaceVariant : cs.onSurface),
//                 ),
//               ),
//               Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _Multiline extends StatelessWidget {
//   final String label;
//   final TextEditingController controller;
//   const _Multiline({required this.label, required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     final cs = Theme.of(context).colorScheme;
//     return _FieldShell(
//       label: label,
//       child: TextField(
//         controller: controller,
//         maxLines: 4,
//         style: TextStyle(color: cs.onSurface),
//         decoration: InputDecoration(
//           filled: true,
//           fillColor: cs.surfaceContainerHighest,
//           hintText: 'Enter $label',
//           hintStyle: TextStyle(color: cs.onSurfaceVariant),
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: cs.outlineVariant),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: AppTheme.accentColor),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//         ),
//       ),
//     );
//   }
// }

// class _CreateButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   const _CreateButton({required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppTheme.accentColor,
//           foregroundColor: Colors.black,
//           padding: const EdgeInsets.symmetric(vertical: 14),
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         ),
//         child:
//             const Text('CREATE', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5)),
//       ),
//     );
//   }
// }



//p3//
// lib/ui/screens/activities/add_activity_screen.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme.dart';
import '../../../core/theme_controller.dart';
import '../../../core/api_client.dart';
import '../../utils/responsive.dart';
import '../../widgets/layout/main_layout.dart';
import '../profile/profile_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../projects/add_project_screen.dart';
import '../analytics/analytics_screen.dart';
import '../users/view_users_screen.dart';

class AddActivityScreen extends StatefulWidget {
  const AddActivityScreen({super.key});

  @override
  State<AddActivityScreen> createState() => _AddActivityScreenState();
}

// ---------- simple row types (avoid _Fe vs _FE name collisions) -----------
class FeRow {
  final String id;
  final String name;
  final String phone;
  final String? vendor;
  FeRow({required this.id, required this.name, required this.phone, this.vendor});
}

class NocRow {
  final String id;
  final String name;
  NocRow({required this.id, required this.name});
}

class Project {
  final String id;
  final String name;
  final String manager;
  Project({required this.id, required this.name, required this.manager});
}

class SubProject {
  final String id;
  final String name;
  SubProject({required this.id, required this.name});
}

class SiteRow {
  final String id;         // site_id
  final String name;       // site_name
  final String country;
  final String state;
  final String district;
  final String city;
  final String address;
  final String? subProjectId;
  final String? subProjectName;
  SiteRow({
    required this.id,
    required this.name,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.address,
    this.subProjectId,
    this.subProjectName,
  });
}

class _AddActivityScreenState extends State<AddActivityScreen> {
  // -------------------- controllers / form state ---------------------------
  final _ticketNoCtrl = TextEditingController();
  final _countryCtrl  = TextEditingController();
  final _stateCtrl    = TextEditingController();
  final _districtCtrl = TextEditingController();
  final _cityCtrl     = TextEditingController();
  final _addressCtrl  = TextEditingController();
  final _siteIdCtrl   = TextEditingController();
  final _siteNameCtrl = TextEditingController();
  final _pmCtrl       = TextEditingController();
  final _vendorCtrl   = TextEditingController();
  final _feMobileCtrl = TextEditingController();
  final _remarksCtrl  = TextEditingController();
  final _statusCtrl   = TextEditingController(text: 'Open');

  DateTime _date = DateTime.now();
  DateTime? _completionDate;

  String? _projectId;
  String? _subProjectId;
  String? _feId;
  String? _nocId;
  String? _activityCategory;

  final _categories = const [
    'Breakdown',
    'New Installation',
    'Upgrades',
    'Corrective Maintenance',
    'Preventive Maintenance',
    'Revisit',
    'Site Survey',
  ];

  // -------------------- lookups ---------------------------
  final List<Project>    _projects        = [];
  final List<SubProject> _subProjects     = [];
  final List<SiteRow>    _sitesForProject = [];
  final List<FeRow>      _feList          = [];
  final List<NocRow>     _nocList         = [];

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  @override
  void dispose() {
    _ticketNoCtrl.dispose();
    _countryCtrl.dispose();
    _stateCtrl.dispose();
    _districtCtrl.dispose();
    _cityCtrl.dispose();
    _addressCtrl.dispose();
    _siteIdCtrl.dispose();
    _siteNameCtrl.dispose();
    _pmCtrl.dispose();
    _vendorCtrl.dispose();
    _feMobileCtrl.dispose();
    _remarksCtrl.dispose();
    _statusCtrl.dispose();
    super.dispose();
  }

  // -------------------- bootstrap: fetch projects, FEs, NOCs ----------------
  Future<void> _bootstrap() async {
    setState(() => _loading = true);
    final api = context.read<ApiClient>();

    try {
      // Projects
      final pRes = await api.get('/api/projects');
      final pData = (jsonDecode(pRes.body) as List?) ?? [];
      _projects
        ..clear()
        ..addAll(pData.map((e) => Project(
              id: (e['id'] ?? '').toString(),
              name: (e['project_name'] ?? '').toString(),
              manager: (e['project_manager'] ?? '').toString(),
            )));

      // Field Engineers
      final feRes = await api.get('/api/field-engineers');
      final fePayload = (jsonDecode(feRes.body) as Map?) ?? {};
      final feList = (fePayload['field_engineers'] as List?) ?? [];
      _feList
        ..clear()
        ..addAll(feList.map((e) => FeRow(
              id: (e['id'] ?? '').toString(),
              name: (e['full_name'] ?? '').toString(),
              phone: (e['contact_no'] ?? '').toString(),
              vendor: (e['contact_person'] as String?),
            )));

      // NOCs
      final nRes = await api.get('/api/nocs');
      final nList = (jsonDecode(nRes.body) as List?) ?? [];
      _nocList
        ..clear()
        ..addAll(nList.map((e) => NocRow(
              id: (e['id'] ?? '').toString(),
              name: (e['full_name'] ?? '').toString(),
            )));
    } catch (e) {
      _toast('Failed to load lookups');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  // -------------------- when project changes -------------------------------
  Future<void> _onProjectChanged(String? id) async {
    if (id == null || id.isEmpty) return;
    setState(() {
      _projectId = id;
      _subProjectId = null;
      _sitesForProject.clear();
      _clearSiteFields();
      final p = _projects.firstWhere((e) => e.id == id);
      _pmCtrl.text = p.manager;
    });

    await Future.wait([
      _loadSubProjects(id),
      _loadSitesForProject(id),
      _generateTicketNo(id),
    ]);
  }

  Future<void> _loadSubProjects(String projectId) async {
    final api = context.read<ApiClient>();
    try {
      final r = await api.get('/api/projects/$projectId/sub-projects');
      final list = (jsonDecode(r.body) as List?) ?? [];
      _subProjects
        ..clear()
        ..addAll(list.map((e) => SubProject(
              id: (e['id'] ?? '').toString(),
              name: (e['name'] ?? '').toString(),
            )));
      if (mounted) setState(() {});
    } catch (_) {
      _subProjects.clear();
      if (mounted) setState(() {});
    }
  }

  Future<void> _loadSitesForProject(String projectId) async {
    final api = context.read<ApiClient>();
    try {
      final r = await api.get('/api/project-sites/$projectId');
      final list = (jsonDecode(r.body) as List?) ?? [];
      _sitesForProject
        ..clear()
        ..addAll(list.map((e) => SiteRow(
              id: (e['site_id'] ?? '').toString(),
              name: (e['site_name'] ?? '').toString(),
              country: (e['country'] ?? '').toString(),
              state: (e['state'] ?? '').toString(),
              district: (e['district'] ?? '').toString(),
              city: (e['city'] ?? '').toString(),
              address: (e['address'] ?? '').toString(),
              subProjectId: (e['sub_project_id'])?.toString(),
              subProjectName: (e['sub_project_name'] as String?),
            )));
      if (mounted) setState(() {});
    } catch (_) {
      _sitesForProject.clear();
      if (mounted) setState(() {});
    }
  }

  // -------------------- ticket generator (web-style) ------------------------
  // Future<void> _generateTicketNo(String projectId) async {
  //   final api = context.read<ApiClient>();
  //   try {
  //     final tRes = await api.get('/api/activities/tickets', params: {'projectId': projectId});
  //     final list = (jsonDecode(tRes.body) as List?) ?? [];
  //     final existing = list
  //         .map((e) => (e['ticket_no'] ?? '').toString())
  //         .where((s) => s.isNotEmpty)
  //         .toList();

  //     final proj = _projects.firstWhere((p) => p.id == projectId);
  //     final prefix = proj.name.replaceAll(RegExp(r'\s+'), '').toLowerCase();

  //     int max = 0;
  //     final re = RegExp('^$prefix-(\\d{3})\$');
  //     for (final s in existing) {
  //       final m = re.firstMatch(s);
  //       if (m != null) {
  //         final n = int.tryParse(m.group(1)!) ?? 0;
  //         if (n > max) max = n;
  //       }
  //     }
  //     final next = (max + 1).toString().padLeft(3, '0');
  //     _ticketNoCtrl.text = '$prefix-$next';
  //     if (mounted) setState(() {});
  //   } catch (_) {
  //     _ticketNoCtrl.text = 'ticket-${DateTime.now().millisecondsSinceEpoch}';
  //     if (mounted) setState(() {});
  //   }
  // }

  Future<void> _generateTicketNo(String projectId) async {
  final api = context.read<ApiClient>();

  try {
    // GET /api/activities/tickets?projectId=...
    final tRes = await api.get(
      '/api/activities/tickets?projectId=${Uri.encodeQueryComponent(projectId)}',
    );

    final list = (jsonDecode(tRes.body) as List?) ?? [];
    final existing = list
        .map((e) => (e['ticket_no'] ?? '').toString())
        .where((s) => s.isNotEmpty)
        .toList();

    // prefix from project name (same as web)
    final proj = _projects.firstWhere((p) => p.id == projectId);
    final prefix = proj.name.replaceAll(RegExp(r'\s+'), '').toLowerCase();

    int max = 0;
    for (final s in existing) {
      final m = RegExp('^$prefix-(\\d{3})\$').firstMatch(s); // <-- fixed regex
      if (m != null) {
        final n = int.tryParse(m.group(1)!) ?? 0;
        if (n > max) max = n;
      }
    }
    // final next = (max + 1).toString().padStart(3, '0');
    final next = (max + 1).toString().padLeft(3, '0');

    _ticketNoCtrl.text = '$prefix-$next';
  } catch (_) {
    _ticketNoCtrl.text = 'ticket-${DateTime.now().millisecondsSinceEpoch}';
  }
}

  // -------------------- FE change → auto mobile & vendor -------------------
  void _onFeChanged(String? id) {
    setState(() {
      _feId = id;
      final fe = _feList.firstWhere(
        (e) => e.id == id,
        orElse: () => FeRow(id: '', name: '', phone: '', vendor: ''),
      );
      _feMobileCtrl.text = fe.phone;
      _vendorCtrl.text = fe.vendor ?? '';
    });
  }

  // -------------------- Site ID autocompletion -----------------------------
  Iterable<SiteRow> _siteOptions(String pattern) {
    final q = pattern.trim().toLowerCase();
    if (q.isEmpty) return _sitesForProject;
    return _sitesForProject.where((s) =>
        s.id.toLowerCase().contains(q) ||
        s.name.toLowerCase().contains(q) ||
        (s.subProjectName ?? '').toLowerCase().contains(q));
  }

  void _onSitePicked(SiteRow s) {
    setState(() {
      _siteIdCtrl.text = s.id;
      _siteNameCtrl.text = s.name;
      _countryCtrl.text = s.country;
      _stateCtrl.text = s.state;
      _districtCtrl.text = s.district;
      _cityCtrl.text = s.city;
      _addressCtrl.text = s.address;
      // also reconcile subproject if available
      _subProjectId = s.subProjectId ?? _subProjectId;
    });
  }

  void _clearSiteFields() {
    _siteIdCtrl.clear();
    _siteNameCtrl.clear();
    _countryCtrl.clear();
    _stateCtrl.clear();
    _districtCtrl.clear();
    _cityCtrl.clear();
    _addressCtrl.clear();
  }

  // -------------------- pickers & helpers ----------------------------------
  Future<void> _pickDate({required bool completion}) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: completion ? (_completionDate ?? _date) : _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (ctx, child) => Theme(data: Theme.of(context), child: child!),
    );
    if (picked != null) {
      setState(() {
        if (completion) {
          _completionDate = picked;
        } else {
          _date = picked;
        }
      });
    }
  }

  void _toast(String msg, {bool success = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: success ? Colors.green.shade600 : null,
      ),
    );
  }

  void _clearAll() {
    setState(() {
      _ticketNoCtrl.clear();
      _countryCtrl.clear();
      _stateCtrl.clear();
      _districtCtrl.clear();
      _cityCtrl.clear();
      _addressCtrl.clear();
      _siteIdCtrl.clear();
      _siteNameCtrl.clear();
      _pmCtrl.clear();
      _vendorCtrl.clear();
      _feMobileCtrl.clear();
      _remarksCtrl.clear();
      _statusCtrl.text = 'Open';

      _projectId = null;
      _subProjectId = null;
      _feId = null;
      _nocId = null;
      _activityCategory = null;

      _date = DateTime.now();
      _completionDate = null;

      _subProjects.clear();
      _sitesForProject.clear();
    });
  }

  // -------------------- submit --------------------------------------------
  Future<void> _create() async {
    if ((_projectId ?? '').isEmpty ||
        _ticketNoCtrl.text.trim().isEmpty ||
        _siteIdCtrl.text.trim().isEmpty ||
        (_activityCategory ?? '').isEmpty) {
      _toast('Please fill required fields (*).');
      return;
    }

    final api = context.read<ApiClient>();
    try {
      final body = {
        'ticket_no': _ticketNoCtrl.text.trim(),
        'project_id': _projectId,
        'site_id': _siteIdCtrl.text.trim(),
        'sub_project_id': _subProjectId,
        'activity_category': _activityCategory,
        'activity_date': _date.toIso8601String().split('T').first,
        'completion_date': _completionDate?.toIso8601String().split('T').first,
        'country': _countryCtrl.text,
        'state': _stateCtrl.text,
        'district': _districtCtrl.text,
        'city': _cityCtrl.text,
        'address': _addressCtrl.text,
        'project_manager': _pmCtrl.text,
        'vendor': _vendorCtrl.text,
        'field_engineer_id': _feId,
        'fe_mobile': _feMobileCtrl.text,
        'noc_engineer_id': _nocId,
        'remarks': _remarksCtrl.text,
        'status': _statusCtrl.text,
      };

      final r = await api.post('/api/activities', body: body);
      if (r.statusCode >= 200 && r.statusCode < 300) {
        _toast('Activity created successfully!', success: true);
        _clearAll();
      } else {
        final errJson = (jsonDecode(r.body) as Map?) ?? {};
        _toast(errJson['error']?.toString() ?? 'Failed to create activity.');
      }
    } catch (e) {
      _toast('Failed to create activity.');
    }
  }

  // -------------------- navigation bar taps --------------------------------
  void _handleTabChange(BuildContext context, int i) {
    if (i == 2) return; // already here
    late final Widget target;
    switch (i) {
      case 0:
        target = const DashboardScreen();
        break;
      case 1:
        target = const AddProjectScreen();
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

  // =============================== UI ======================================
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return MainLayout(
      title: 'Add Activity',
      centerTitle: true,
      currentIndex: 2,
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
          icon: ClipOval(
            child: Image.asset('assets/User_profile.png', width: 36, height: 36, fit: BoxFit.cover),
          ),
        ),
        const SizedBox(width: 8),
      ],
      body: ListView(
        padding: responsivePadding(context).copyWith(top: 12, bottom: 12),
        children: [
          Card(
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Header
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Create New Activity',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w800,
                              ),
                        ),
                      ),
                      TextButton(onPressed: _clearAll, child: const Text('CLEAR')),
                    ],
                  ),
                  Divider(color: cs.outlineVariant),

                  if (_loading)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: CircularProgressIndicator(color: AppTheme.accentColor),
                      ),
                    ),

                  if (!_loading)
                    LayoutBuilder(
                      builder: (context, c) {
                        final isWide = c.maxWidth >= 640;
                        final gap = isWide ? 12.0 : 0.0;

                        final left = <Widget>[
                          _roText('Ticket No *', _ticketNoCtrl),
                          _dropdown<String>(
                            label: 'Project *',
                            value: _projectId,
                            items: _projects.map((p) => p.id).toList(),
                            display: (id) => _projects.firstWhere((p) => p.id == id).name,
                            onChanged: _onProjectChanged,
                          ),
                          _dropdown<String>(
                            label: 'Sub Project',
                            value: _subProjectId,
                            items: _subProjects.map((sp) => sp.id).toList(),
                            display: (id) => _subProjects.firstWhere((sp) => sp.id == id).name,
                            onChanged: (v) => setState(() => _subProjectId = v),
                            enabled: _subProjects.isNotEmpty,
                          ),
                          _roText('Country *', _countryCtrl),
                          _roText('City *', _cityCtrl),

                          // --- Site ID searchable (typeahead) ---
                          _siteIdAutocomplete(
                            label: 'Site ID *',
                            controller: _siteIdCtrl,
                            enabled: _sitesForProject.isNotEmpty,
                            optionsBuilder: _siteOptions,
                            onSelected: _onSitePicked,
                          ),

                          _roText('Site Name *', _siteNameCtrl),
                          _roText('Project Manager *', _pmCtrl),
                          _dropdown<String>(
                            label: 'FE Name',
                            value: _feId,
                            items: _feList.map((f) => f.id).toList(),
                            display: (id) => _feList.firstWhere((f) => f.id == id).name,
                            onChanged: _onFeChanged,
                          ),
                          _dateField(
                            label: 'Completion Date',
                            date: _completionDate,
                            onTap: () => _pickDate(completion: true),
                          ),
                        ];

                        final right = <Widget>[
                          _dateField(
                            label: 'Scheduled Date *',
                            date: _date,
                            onTap: () => _pickDate(completion: false),
                          ),
                          _dropdown<String>(
                            label: 'Activity Category *',
                            value: _activityCategory,
                            items: _categories,
                            display: (s) => s,
                            onChanged: (v) => setState(() => _activityCategory = v),
                          ),
                          _roText('State *', _stateCtrl),
                          _roText('District *', _districtCtrl),
                          _roText('Address *', _addressCtrl),
                          _roText('Vendor', _vendorCtrl),
                          _roText('FE Mobile', _feMobileCtrl),
                          _dropdown<String>(
                            label: 'NOC Engineer',
                            value: _nocId,
                            items: _nocList.map((n) => n.id).toList(),
                            display: (id) => _nocList.firstWhere((n) => n.id == id).name,
                            onChanged: (v) => setState(() => _nocId = v),
                          ),
                          _multiline(label: 'Remarks', controller: _remarksCtrl),
                          _roText('Status', _statusCtrl),
                        ];

                        if (!isWide) {
                          return Column(children: [...left, ...right, const SizedBox(height: 12)]);
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
                  _CreateButton(onPressed: _create),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------- small UI helpers -----------------------------------

  Widget _fieldShell({required String label, required Widget child}) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(label,
              style: TextStyle(fontSize: 12, color: cs.onSurfaceVariant, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          child,
        ],
      ),
    );
  }

  Widget _roText(String label, TextEditingController controller) {
    final cs = Theme.of(context).colorScheme;
    return _fieldShell(
      label: label,
      child: TextField(
        controller: controller,
        enabled: false,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          hintText: 'Read-only',
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _dropdown<T>({
    required String label,
    required T? value,
    required List<T> items,
    required String Function(T) display,
    required ValueChanged<T?> onChanged,
    bool enabled = true,
  }) {
    final cs = Theme.of(context).colorScheme;
    return _fieldShell(
      label: label,
      child: Container(
        decoration: BoxDecoration(
          color: cs.surfaceContainerHighest,
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
            items: items
                .map((e) => DropdownMenuItem<T>(
                      value: e,
                      child: Text(display(e)),
                    ))
                .toList(),
            hint: Text('Select', style: TextStyle(color: cs.onSurfaceVariant)),
            onChanged: enabled ? onChanged : null,
          ),
        ),
      ),
    );
  }

  Widget _dateField({required String label, required DateTime? date, required VoidCallback onTap}) {
    final cs = Theme.of(context).colorScheme;
    final text = date == null
        ? 'Select date'
        : '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    return _fieldShell(
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(text, style: TextStyle(color: date == null ? cs.onSurfaceVariant : cs.onSurface)),
              ),
              Icon(Icons.calendar_today_rounded, size: 18, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }

  Widget _multiline({required String label, required TextEditingController controller}) {
    final cs = Theme.of(context).colorScheme;
    return _fieldShell(
      label: label,
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: TextStyle(color: cs.onSurface),
        decoration: InputDecoration(
          filled: true,
          fillColor: cs.surfaceContainerHighest,
          hintText: 'Enter $label',
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: cs.outlineVariant),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.accentColor),
            borderRadius: BorderRadius.circular(8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  // Searchable Site ID field using Autocomplete<SiteRow>
  Widget _siteIdAutocomplete({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    required Iterable<SiteRow> Function(String) optionsBuilder,
    required void Function(SiteRow) onSelected,
  }) {
    final cs = Theme.of(context).colorScheme;

    return _fieldShell(
      label: label,
      child: AbsorbPointer(
        absorbing: !enabled,
        child: Autocomplete<SiteRow>(
          displayStringForOption: (o) => o.id,
          optionsBuilder: (TextEditingValue tev) => enabled ? optionsBuilder(tev.text) : const Iterable.empty(),
          onSelected: (o) => onSelected(o),
          fieldViewBuilder: (ctx, textCtrl, focus, onSubmit) {
            // keep UI controller in sync for Clear + autofill
            textCtrl
              ..text = controller.text
              ..selection = TextSelection.fromPosition(TextPosition(offset: textCtrl.text.length));
            textCtrl.addListener(() => controller.text = textCtrl.text);

            return TextField(
              controller: textCtrl,
              focusNode: focus,
              enabled: enabled,
              style: TextStyle(color: cs.onSurface),
              decoration: InputDecoration(
                hintText: enabled ? 'Type to search Site ID' : 'Select Project first',
                hintStyle: TextStyle(color: cs.onSurfaceVariant),
                filled: true,
                fillColor: cs.surfaceContainerHighest,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: cs.outlineVariant),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.accentColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              ),
            );
          },
          optionsViewBuilder: (ctx, onSelect, options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 280, maxWidth: 520, minWidth: 260),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: options.length,
                    itemBuilder: (ctx, i) {
                      final s = options.elementAt(i);
                      final subtitle = [
                        s.name,
                        if ((s.subProjectName ?? '').isNotEmpty) '(${s.subProjectName})',
                        ' – ${s.city}',
                      ].join(' ');
                      return ListTile(
                        dense: true,
                        title: Text(s.id),
                        subtitle: Text(subtitle),
                        onTap: () {
                          onSelect(s);
                          _onSitePicked(s);
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  final VoidCallback onPressed;
  const _CreateButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentColor,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text('CREATE', style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: 0.5)),
      ),
    );
  }
}
