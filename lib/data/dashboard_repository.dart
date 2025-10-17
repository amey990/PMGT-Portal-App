import 'package:collection/collection.dart';
import 'api_client.dart';
import 'models.dart';

class DashboardRepository {
  final ApiClient api;
  DashboardRepository(this.api);

  Future<List<ProjectDto>> getProjects() async {
    final r = await api.get('/api/projects');
    final data = r.data;
    final list = (data is List ? data : data?['projects'] as List? ?? []);
    return list.map<ProjectDto>((e) => ProjectDto.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<List<SiteApiDto>> getProjectSites() async {
    final r = await api.get('/api/project-sites');
    final list = (r.data as List?) ?? [];
    return list.map<SiteApiDto>((e) => SiteApiDto.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<List<FeDto>> getFieldEngineers() async {
    final r = await api.get('/api/field-engineers');
    final raw = r.data;
    final list = raw is List ? raw : (raw?['field_engineers'] as List? ?? []);
    return list.map<FeDto>((e) => FeDto.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<List<NocDto>> getNocs() async {
    final r = await api.get('/api/nocs');
    final list = (r.data as List?) ?? [];
    return list.map<NocDto>((e) => NocDto.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<List<SubProjectDto>> getSubProjects(String projectId) async {
    final r = await api.get('/api/projects/$projectId/sub-projects');
    final raw = r.data;
    final list = raw is List
        ? raw
        : (raw?['sub_projects'] as List? ??
           raw?['data'] as List? ??
           []);
    return list.map<SubProjectDto>((e) => SubProjectDto.fromJson(Map<String, dynamic>.from(e))).toList();
  }

  Future<List<ActivityRow>> getActivities({
    required List<ProjectDto> projects,
    required List<SiteApiDto> sites,
    required List<FeDto> fes,
    required List<NocDto> nocs,
    String? projectId,
    String? subProjectId,
  }) async {
    final params = <String, dynamic>{'page': 1, 'limit': 1000};
    if (projectId != null) params['projectId'] = projectId;
    if (subProjectId != null) params['subProjectId'] = subProjectId;

    final r = await api.get('/api/activities', query: params);
    final raw = r.data;
    final acts = raw is List ? raw : (raw?['activities'] as List? ?? []);

    return acts.map<ActivityRow>((aRaw) {
      final a = Map<String, dynamic>.from(aRaw as Map);

      // find matching references
      final site = sites.firstWhereOrNull((s) =>
          s.projectId == (a['project_id'] ?? '') &&
          s.siteId == (a['site_id'] ?? '') &&
          ((a['sub_project_id'] != null)
              ? s.subProjectId == a['sub_project_id']?.toString()
              : (s.subProjectId == null)));

      final projName = projects.firstWhereOrNull((p) => p.id == a['project_id'])?.name ?? '';

      final fe = fes.firstWhereOrNull((f) => f.id == (a['field_engineer_id']?.toString() ?? ''));
      final noc = nocs.firstWhereOrNull((n) => n.id == (a['noc_engineer_id']?.toString() ?? ''));

      return ActivityRow(
        id: a['id']?.toString() ?? '',
        tNo: a['ticket_no'] ?? '',
        date: (a['activity_date'] ?? '').toString().substring(0,10),
        completionDate: (a['completion_date'] ?? '').toString().substring(0,10),
        projectId: a['project_id'] ?? '',
        project: projName,
        subProjectId: a['sub_project_id']?.toString(),
        subProject: a['sub_project_name'] ?? a['sub_project'],
        activity: a['activity_category'] ?? '',
        country: a['country'] ?? site?.country ?? '',
        state: a['state'] ?? site?.state ?? '',
        district: a['district'] ?? site?.district ?? '',
        city: a['city'] ?? site?.city ?? '',
        address: a['address'] ?? site?.address ?? '',
        siteId: a['site_id'] ?? '',
        siteName: a['site_name'] ?? site?.siteName ?? '',
        pm: a['project_manager'] ?? '',
        vendor: a['vendor'] ?? '',
        feId: a['field_engineer_id']?.toString(),
        feName: fe?.fullName ?? (a['vendor'] ?? ''),
        feMobile: fe?.mobile ?? (a['fe_mobile'] ?? ''),
        nocId: a['noc_engineer_id']?.toString(),
        nocName: noc?.fullName ?? '',
        remarks: a['remarks'] ?? '',
        status: a['status'] ?? '',
      );
    }).toList()
      // sort like web (by numeric part of ticket)
      ..sort((a, b) {
        int n(String t) {
          final parts = t.split('-');
          return int.tryParse(parts.length > 1 ? parts[1] : parts[0]) ?? 0;
        }
        return n(a.tNo).compareTo(n(b.tNo));
      })
      // unique by id
      ..retainWhere((r) {
        final seen = <String>{};
        return (seen.add(r.id));
      });
  }
}
