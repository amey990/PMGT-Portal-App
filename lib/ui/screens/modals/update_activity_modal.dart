//p3//
import 'package:flutter/material.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';

import '../../../core/theme.dart';
import '../dashboard/dashboard_screen.dart'
    show Activity, SubProject, SiteAPI, FieldEngineer, NocEngineer;

class UpdateActivityModal extends StatefulWidget {
  final Activity activity;

  /// pass full lists (like the web modal)
  final List<SubProject> subProjects; // id + name
  final List<SiteAPI> sites; // includes subProjectId + location fields
  final List<FieldEngineer> fes; // id + name + mobile + vendor
  final List<NocEngineer> nocs; // id + name

  final void Function(Activity updated) onSubmit;
  final VoidCallback? onDelete;

  const UpdateActivityModal({
    super.key,
    required this.activity,
    required this.subProjects,
    required this.sites,
    required this.fes,
    required this.nocs,
    required this.onSubmit,
    this.onDelete,
  });

  static Future<void> show(
    BuildContext context, {
    required Activity activity,
    required List<SubProject> subProjects,
    required List<SiteAPI> sites,
    required List<FieldEngineer> fes,
    required List<NocEngineer> nocs,
    required void Function(Activity updated) onSubmit,
    VoidCallback? onDelete,
  }) {
    final cs = Theme.of(context).colorScheme;
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cs.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (ctx) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom,
            ),
            child: UpdateActivityModal(
              activity: activity,
              subProjects: subProjects,
              sites: sites,
              fes: fes,
              nocs: nocs,
              onSubmit: onSubmit,
              onDelete: onDelete,
            ),
          ),
    );
  }

  @override
  State<UpdateActivityModal> createState() => _UpdateActivityModalState();
}

class _UpdateActivityModalState extends State<UpdateActivityModal> {
  final _formKey = GlobalKey<FormState>();

  // read-only controllers
  late final TextEditingController _ticketNoCtrl;
  late final TextEditingController _projectCtrl;
  late final TextEditingController _siteNameCtrl;
  // late final TextEditingController
  // _siteIdReadOnlyCtrl; 
  late final TextEditingController _pmCtrl;
  late final TextEditingController _vendorCtrl;
  late final TextEditingController _addressCtrl;
  late final TextEditingController _feMobileCtrl;

  // editable fields
  DateTime? _scheduledDate;
  DateTime? _completionDate;

  String? _activityCategory;
  String? _remarks;
  String? _status;

  // FE / NOC (store ids like web)
  String? _feId;
  String? _nocId;

  // sub-project (store id like web)
  String _subProjectId = '';

  // site selection uses composite key siteId::subProjectId
  String _siteKey = ''; // computed
  String get _siteIdFromKey => _siteKey.split('::').first;
  String get _spIdFromKey =>
      _siteKey.contains('::') ? _siteKey.split('::')[1] : '';

  // location (labels required; using CSCPickerPlus)
  String? _country; // display name
  String? _state;
  String? _city;
  final TextEditingController _districtCtrl = TextEditingController();

  static const _activityCategories = <String>[
    'Breakdown',
    'New Installation',
    'Upgrades',
    'Corrective Maintenance',
    'Preventive Maintenance',
    'Revisit',
    'Site Survey',
  ];
  static const _statusOptions = <String>[
    'Open',
    'Reschedule',
    'Pending',
    'In Progress',
    'Completed',
    'Canceled',
  ];

  @override
  void initState() {
    super.initState();
    final a = widget.activity;

    _ticketNoCtrl = TextEditingController(text: a.tNo);
    _projectCtrl = TextEditingController(text: a.project);
    _siteNameCtrl = TextEditingController(text: a.siteName);
    // _siteIdReadOnlyCtrl = TextEditingController(text: a.siteId);
    _pmCtrl = TextEditingController(text: a.pm);
    _vendorCtrl = TextEditingController(text: a.vendor);
    _addressCtrl = TextEditingController(text: a.address);
    _feMobileCtrl = TextEditingController(text: a.feMobile);

    _scheduledDate = _parseIso(a.date);
    _completionDate = _parseIso(a.completionDate);

    _activityCategory = a.activity;
    _remarks = a.remarks;
    _status = a.status;

    _country = a.country;
    _state = a.state;
    _city = a.city;
    _districtCtrl.text = a.district;

    // resolve sub-project id robustly (either id already present or by name)
    _subProjectId = (a.subProjectId ?? '').trim();
    if (_subProjectId.isEmpty && (a.subProject ?? '').isNotEmpty) {
      final hit = widget.subProjects.firstWhere(
        (sp) => (sp.name).toLowerCase() == (a.subProject ?? '').toLowerCase(),
        orElse: () => SubProject(id: '', name: ''),
      );
      _subProjectId = hit.id;
    }

    // compute composite key for the Site ID dropdown
    _siteKey = _makeKey(a.siteId, _subProjectId);

    final siteForRow = widget.sites.firstWhere(
  (s) =>
      s.projectId == a.projectId &&
      s.siteId == a.siteId &&
      // if the row has a subProjectId, prefer exact match, else accept first match
      ((a.subProjectId?.isNotEmpty ?? false)
          ? (s.subProjectId ?? '') == (a.subProjectId ?? '')
          : true),
  orElse: () => SiteAPI(
    projectId: a.projectId,
    projectName: a.project,
    siteId: a.siteId,
    siteName: a.siteName,
    country: a.country,
    state: a.state,
    district: a.district,
    city: a.city,
    address: a.address,
    subProjectId: a.subProjectId,
    subProjectName: a.subProject ?? '',
  ),
);

// If our current subProject id isn't present in the dropdown options,
// overwrite it from the site match (if available).
final spIdsFromOptions = widget.subProjects.map((sp) => sp.id.trim()).toSet();
if (_subProjectId.isEmpty || !spIdsFromOptions.contains(_subProjectId.trim())) {
  final candidate = (siteForRow.subProjectId ?? '').trim();
  if (candidate.isNotEmpty) {
    _subProjectId = candidate;
  }
}

// If we still have nothing but the row has a sub-project name,
// try matching by name to one of the provided options.
if (_subProjectId.isEmpty && (a.subProject ?? '').trim().isNotEmpty) {
  final hitByName = widget.subProjects.firstWhere(
    (sp) => sp.name.trim().toLowerCase() == (a.subProject ?? '').trim().toLowerCase(),
    orElse: () => SubProject(id: '', name: ''),
  );
  if (hitByName.id.isNotEmpty) {
    _subProjectId = hitByName.id;
  }
}

    // FE/NOC ids by name
    _feId =
        widget.fes
            .firstWhere(
              (f) =>
                  f.name.trim().toLowerCase() == a.feName.trim().toLowerCase(),
              orElse:
                  () => FieldEngineer(id: '', name: '', mobile: '', vendor: ''),
            )
            .id;
    _nocId =
        widget.nocs
            .firstWhere(
              (n) =>
                  n.name.trim().toLowerCase() ==
                  a.nocEngineer.trim().toLowerCase(),
              orElse: () => NocEngineer(id: '', name: ''),
            )
            .id;
  }

  @override
  void dispose() {
    _ticketNoCtrl.dispose();
    _projectCtrl.dispose();
    _siteNameCtrl.dispose();
    // _siteIdReadOnlyCtrl.dispose();
    _pmCtrl.dispose();
    _vendorCtrl.dispose();
    _addressCtrl.dispose();
    _feMobileCtrl.dispose();
    _districtCtrl.dispose();
    super.dispose();
  }

  // ───────────────── helpers ─────────────────
  DateTime? _parseIso(String? iso) {
    if (iso == null || iso.isEmpty) return null;
    try {
      return DateTime.parse(iso);
    } catch (_) {
      return null;
    }
  }

  String _fmtDmy(DateTime? d) {
    if (d == null) return '';
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    final yyyy = d.year.toString();
    return '$dd/$mm/$yyyy';
  }

  String _fmtIso(DateTime? d) =>
      d == null
          ? ''
          : '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  String _norm(String? v) => (v ?? '').trim();
  String _makeKey(String siteId, String? spid) =>
      '${_norm(siteId)}::${_norm(spid)}';

  // visible sites filtered by selected sub-project like web
  List<SiteAPI> get _visibleSites {
    if (_subProjectId.isEmpty) {
      // show sites from the same project only (like web fetch per-project)
      return widget.sites
          .where((s) => s.projectId == widget.activity.projectId)
          .toList();
    }
    return widget.sites.where((s) {
      final sameProject = s.projectId == widget.activity.projectId;
      final matches = _norm(s.subProjectId) == _norm(_subProjectId);
      // also tolerate name match if some entries only carry name
      final spName =
          widget.subProjects
              .firstWhere(
                (sp) => sp.id == _subProjectId,
                orElse: () => SubProject(id: '', name: ''),
              )
              .name;
      final matchesName =
          (s.subProjectName ?? '').toLowerCase() == spName.toLowerCase();
      return sameProject && (matches || matchesName);
    }).toList();
  }

  // options for Site ID dropdown (label = "id — name (subproject?)")
  List<({String key, String label, SiteAPI src})> get _siteOptions {
    return _visibleSites.map((s) {
      final lbl =
          '${s.siteId} — ${s.siteName}'
          '${(s.subProjectName != null && s.subProjectName!.isNotEmpty) ? ' (${s.subProjectName})' : ''}';
      return (key: _makeKey(s.siteId, s.subProjectId), label: lbl, src: s);
    }).toList();
  }

  // when Site changes: update name + location + subProjectId + address
  void _applySite(SiteAPI s) {
    _siteNameCtrl.text = s.siteName;
    // _siteIdReadOnlyCtrl.text = s.siteId;
    _addressCtrl.text = s.address;
    _country = s.country.isNotEmpty ? s.country : _country;
    _state = s.state.isNotEmpty ? s.state : _state;
    _city = s.city.isNotEmpty ? s.city : _city;
    _districtCtrl.text = s.district;
    if ((s.subProjectId ?? '').isNotEmpty) {
      _subProjectId = s.subProjectId!;
    }
    setState(() {});
  }

  Future<void> _pickDate({
    required DateTime? initial,
    required ValueChanged<DateTime?> onPicked,
  }) async {
    final now = DateTime.now();
    final first = DateTime(now.year - 10);
    final last = DateTime(now.year + 10);
    final result = await showDatePicker(
      context: context,
      initialDate: initial ?? now,
      firstDate: first,
      lastDate: last,
    );
    if (result != null) onPicked(result);
  }

  InputDecoration _dec(String label, {bool readOnly = false}) {
    final cs = Theme.of(context).colorScheme;
    return InputDecoration(
      labelText: label,
      filled: true,
      fillColor:
          readOnly ? cs.surfaceContainerHigh : cs.surfaceContainerHighest,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return SafeArea(
      minimum: const EdgeInsets.only(top: 17),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 15, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Update Activity',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: cs.onSurface,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      _row2(
                        TextFormField(
                          controller: _ticketNoCtrl,
                          readOnly: true,
                          decoration: _dec(
                            'Ticket No (read-only)',
                            readOnly: true,
                          ),
                        ),
                        _dateField(
                          label: 'Scheduled Date',
                          valueText: _fmtDmy(_scheduledDate),
                          onTap:
                              () => _pickDate(
                                initial: _scheduledDate,
                                onPicked:
                                    (d) => setState(() => _scheduledDate = d),
                              ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      _row2(
                        _dateField(
                          label: 'Completion Date',
                          valueText: _fmtDmy(_completionDate),
                          onTap:
                              () => _pickDate(
                                initial: _completionDate,
                                onPicked:
                                    (d) => setState(() => _completionDate = d),
                              ),
                        ),
                        TextFormField(
                          controller: _projectCtrl,
                          readOnly: true,
                          decoration: _dec(
                            'Project (read-only)',
                            readOnly: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      _row2(
                        

  //                       DropdownButtonFormField<String>(
  // initialValue: _subProjectId.isEmpty ? null : _subProjectId,
  DropdownButtonFormField<String>(
  value: _subProjectId.isEmpty ? null : _subProjectId,
  isExpanded: true,
  decoration: _dec('Sub Project'),
  items: widget.subProjects
      .map((sp) => DropdownMenuItem(
            value: sp.id,
            child: Text(sp.name, overflow: TextOverflow.ellipsis),
          ))
      .toList(),
  onChanged: (v) {
    setState(() {
      _subProjectId = (v ?? '').trim();

      // When sub-project changes, recompute Site ID options (scoped to child)
      // and keep (or re-pick) a valid site under this child.
      final opts = _siteOptions;
      if (opts.isNotEmpty) {
        // if current site is not under this child, pick first option
        final stillValid = opts.any((o) => o.key == _siteKey);
        if (!stillValid) {
          _siteKey = opts.first.key;
          _applySite(opts.first.src);
        }
      } else {
        _siteKey = _makeKey('', _subProjectId);
      }
    });
  },
),
                        // DropdownButtonFormField<String>(
                        //   initialValue: _activityCategory,
                        DropdownButtonFormField<String>(
  value: _activityCategory,
                          isExpanded: true,
                          decoration: _dec('Activity Category'),
                          items:
                              _activityCategories
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                          onChanged:
                              (v) => setState(() => _activityCategory = v),
                          validator:
                              (v) =>
                                  (v == null || v.isEmpty)
                                      ? 'Select Activity'
                                      : null,
                        ),
                      ),
                      const SizedBox(height: 15),

                      _row2(
                        // Site ID (composite) — like web Autocomplete; here a searchable dropdown substitute
                        // DropdownButtonFormField<String>(
                        //   initialValue:
                        //       _siteOptions.any((o) => o.key == _siteKey)
                        //           ? _siteKey
                        //           : null,
                        DropdownButtonFormField<String>(
  value: _siteOptions.any((o) => o.key == _siteKey) ? _siteKey : null,
                          isExpanded: true,
                          decoration: _dec('Site ID'),
                          items:
                              _siteOptions
                                  .map(
                                    (o) => DropdownMenuItem(
                                      value: o.key,
                                      child: Text(
                                        o.label,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            if (v == null) return;
                            setState(() {
                              _siteKey = v;
                              final picked =
                                  _siteOptions
                                      .firstWhere((o) => o.key == v)
                                      .src;
                              _applySite(picked);
                            });
                          },
                          validator:
                              (v) =>
                                  (v == null || v.isEmpty)
                                      ? 'Select Site ID'
                                      : null,
                        ),
                        // Site Name readonly (ellipsis fix)
                        TextFormField(
                          controller: _siteNameCtrl,
                          readOnly: true,
                          maxLines: 1,
                          decoration: _dec(
                            'Site Name (read-only)',
                            readOnly: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      

                      _row2(
                        // PM (read-only) stays; it now occupies the left slot
                        TextFormField(
                          controller: _pmCtrl,
                          readOnly: true,
                          decoration: _dec('PM (read-only)', readOnly: true),
                        ),
                        // Vendor (read-only) moves up to keep the grid balanced
                        TextFormField(
                          controller: _vendorCtrl,
                          readOnly: true,
                          decoration: _dec('Vendor (read-only)', readOnly: true),
                        ),
                      ),
                      const SizedBox(height: 15),

                     

                      // Country / State / City with visible labels
                      _buildLocationPicker(Theme.of(context).colorScheme),
                      const SizedBox(height: 15),

                      _row2(
                        TextFormField(
                          controller: _addressCtrl,
                          readOnly: true,
                          maxLines: 1,
                          decoration: _dec(
                            'Address (read-only)',
                            readOnly: true,
                          ),
                        ),
                        // DropdownButtonFormField<String>(
                        //   initialValue: (_feId ?? '').isEmpty ? null : _feId,
                        DropdownButtonFormField<String>(
  value: (_feId ?? '').isEmpty ? null : _feId,
                          isExpanded: true,
                          decoration: _dec('FE Name'),
                          items:
                              widget.fes
                                  .map(
                                    (fe) => DropdownMenuItem(
                                      value: fe.id,
                                      child: Text(fe.name),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) {
                            setState(() {
                              _feId = v ?? '';
                              final fe = widget.fes.firstWhere(
                                (f) => f.id == _feId,
                                orElse:
                                    () => FieldEngineer(
                                      id: '',
                                      name: '',
                                      mobile: '',
                                      vendor: '',
                                    ),
                              );
                              _feMobileCtrl.text = fe.mobile;
                              // keep vendor from FE when present (mimic web auto-fill)
                              if (fe.vendor.isNotEmpty) {
                                _vendorCtrl.text = fe.vendor;
                              }
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 15),

                      _row2(
                        TextFormField(
                          controller: _feMobileCtrl,
                          readOnly: true,
                          decoration: _dec(
                            'FE Mobile (read-only)',
                            readOnly: true,
                          ),
                        ),
                        // DropdownButtonFormField<String>(
                        //   initialValue: (_nocId ?? '').isEmpty ? null : _nocId,
                        DropdownButtonFormField<String>(
  value: (_nocId ?? '').isEmpty ? null : _nocId,
                          isExpanded: true,
                          decoration: _dec('NOC Engineer'),
                          items:
                              widget.nocs
                                  .map(
                                    (n) => DropdownMenuItem(
                                      value: n.id,
                                      child: Text(n.name),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) => setState(() => _nocId = v ?? ''),
                        ),
                      ),
                      const SizedBox(height: 15),

                      _row2(
                        // DropdownButtonFormField<String>(
                        //   initialValue: _status,
                        DropdownButtonFormField<String>(
  value: _status,
                          isExpanded: true,
                          decoration: _dec('Status'),
                          items:
                              _statusOptions
                                  .map(
                                    (s) => DropdownMenuItem(
                                      value: s,
                                      child: Text(s),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (v) => setState(() => _status = v),
                          validator:
                              (v) =>
                                  (v == null || v.isEmpty)
                                      ? 'Select Status'
                                      : null,
                        ),
                        TextFormField(
                          initialValue: _remarks,
                          onChanged: (v) => _remarks = v,
                          decoration: _dec('Remarks / Issue'),
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          if (widget.onDelete != null)
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.redAccent,
                                side: const BorderSide(color: Colors.redAccent),
                              ),
                              onPressed: widget.onDelete,
                              child: const Text('DELETE'),
                            ),
                          const Spacer(),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('CANCEL'),
                          ),
                          const SizedBox(width: 8),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppTheme.accentColor,
                              foregroundColor: Colors.black,
                            ),
                            onPressed: _handleSubmit,
                            child: const Text('UPDATE'),
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
      ),
    );
  }

  Widget _row2(Widget left, Widget right) {
    return LayoutBuilder(
      builder: (context, c) {
        if (c.maxWidth < 560) {
          return Column(children: [left, const SizedBox(height: 10), right]);
        }
        return Row(
          children: [
            Expanded(child: left),
            const SizedBox(width: 12),
            Expanded(child: right),
          ],
        );
      },
    );
  }

  Widget _dateField({
    required String label,
    required String valueText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: _dec(label),
        child: Row(
          children: [
            Expanded(
              child: Text(
                valueText.isEmpty ? 'dd/mm/yyyy' : valueText,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.calendar_today, size: 18),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationPicker(ColorScheme cs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // explicit labels for each dropdown
        CSCPickerPlus(
          layout: Layout.vertical,
          showStates: true,
          showCities: true,
          flagState: CountryFlag.SHOW_IN_DROP_DOWN_ONLY,
          dropdownDecoration: BoxDecoration(
            color: cs.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          disabledDropdownDecoration: BoxDecoration(
            color: cs.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cs.outlineVariant),
          ),
          countryDropdownLabel: "Country",
          stateDropdownLabel: "State / Region",
          cityDropdownLabel: "City",
          currentCountry: _country,
          currentState: _state,
          currentCity: _city,
          onCountryChanged:
              (v) => setState(() {
                _country = v;
                _state = null;
                _city = null;
              }),
          onStateChanged:
              (v) => setState(() {
                _state = v;
                _city = null;
              }),
          onCityChanged: (v) => setState(() => _city = v),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: _districtCtrl,
          decoration: _dec('District (optional)'),
        ),
      ],
    );
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    // FE/NOC lookups
    final fe = widget.fes.firstWhere(
      (f) => f.id == (_feId ?? ''),
      orElse: () => FieldEngineer(id: '', name: '', mobile: '', vendor: ''),
    );
    final noc = widget.nocs.firstWhere(
      (n) => n.id == (_nocId ?? ''),
      orElse: () => NocEngineer(id: '', name: ''),
    );

    // compute updated subProjectId (site selection always wins)
    final chosenSpId = _spIdFromKey.isNotEmpty ? _spIdFromKey : _subProjectId;

    final updated = Activity(
      id: widget.activity.id,
      tNo: _ticketNoCtrl.text,
      date: widget.activity.date, // unchanged
      completionDate: _fmtIso(_completionDate),
      projectId: widget.activity.projectId,
      project: _projectCtrl.text,
      subProject:
          widget.subProjects
              .firstWhere(
                (sp) => sp.id == chosenSpId,
                orElse: () => SubProject(id: '', name: ''),
              )
              .name,
      subProjectId:
          chosenSpId.isEmpty ? widget.activity.subProjectId : chosenSpId,
      activity: _activityCategory ?? widget.activity.activity,
      country: _country ?? widget.activity.country,
      state: _state ?? widget.activity.state,
      district:
          _districtCtrl.text.isEmpty
              ? widget.activity.district
              : _districtCtrl.text,
      city: _city ?? widget.activity.city,
      address: _addressCtrl.text,
      siteId: _siteIdFromKey.isEmpty ? widget.activity.siteId : _siteIdFromKey,
      siteName: _siteNameCtrl.text,
      pm: _pmCtrl.text,
      vendor: _vendorCtrl.text,
      fieldEngineerId:
          (_feId ?? '').isEmpty ? widget.activity.fieldEngineerId : _feId,
      feName: fe.name.isNotEmpty ? fe.name : widget.activity.feName,
      feMobile: fe.mobile.isNotEmpty ? fe.mobile : _feMobileCtrl.text,
      nocEngineerId:
          (_nocId ?? '').isEmpty ? widget.activity.nocEngineerId : _nocId,
      nocEngineer: noc.name.isNotEmpty ? noc.name : widget.activity.nocEngineer,
      remarks: _remarks ?? widget.activity.remarks,
      status: _status ?? widget.activity.status,
    );

    widget.onSubmit(updated);
    Navigator.pop(context);
  }
}
