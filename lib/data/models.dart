class ProjectDto {
  final String id;
  final String name;
  ProjectDto({required this.id, required this.name});
  factory ProjectDto.fromJson(Map<String, dynamic> j) =>
      ProjectDto(id: j['id']?.toString() ?? '', name: j['project_name'] ?? '');
}

class SiteApiDto {
  final String projectId, projectName, siteId, siteName, address, pincode, poc,
      country, state, district, city;
  final String? subProjectId, subProjectName;

  SiteApiDto({
    required this.projectId,
    required this.projectName,
    required this.siteId,
    required this.siteName,
    required this.address,
    required this.pincode,
    required this.poc,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    this.subProjectId,
    this.subProjectName,
  });

  factory SiteApiDto.fromJson(Map<String, dynamic> j) => SiteApiDto(
    projectId: j['project_id'] ?? '',
    projectName: j['project_name'] ?? '',
    siteId: j['site_id'] ?? '',
    siteName: j['site_name'] ?? '',
    address: j['address'] ?? '',
    pincode: j['pincode'] ?? '',
    poc: j['poc'] ?? '',
    country: j['country'] ?? '',
    state: j['state'] ?? '',
    district: j['district'] ?? '',
    city: j['city'] ?? '',
    subProjectId: j['sub_project_id']?.toString(),
    subProjectName: j['sub_project_name'],
  );
}

class FeDto {
  final String id, fullName, mobile, vendor;
  FeDto({required this.id, required this.fullName, required this.mobile, required this.vendor});
  factory FeDto.fromJson(Map<String, dynamic> j) => FeDto(
    id: j['id']?.toString() ?? '',
    fullName: j['full_name'] ?? '',
    mobile: j['contact_no']?.toString() ?? '',
    vendor: j['contact_person'] ?? '',
  );
}

class NocDto {
  final String id, fullName;
  NocDto({required this.id, required this.fullName});
  factory NocDto.fromJson(Map<String, dynamic> j) =>
      NocDto(id: j['id']?.toString() ?? '', fullName: j['full_name'] ?? '');
}

class SubProjectDto {
  final String id, name;
  SubProjectDto({required this.id, required this.name});
  factory SubProjectDto.fromJson(Map<String, dynamic> j) =>
      SubProjectDto(id: j['id']?.toString() ?? '', name: j['name'] ?? j['sub_project_name'] ?? '');
}

class ActivityRow {
  final String id;
  final String tNo;
  final String date;           // ISO (yyyy-mm-dd)
  final String completionDate; // ISO
  final String projectId;
  final String project;
  final String? subProjectId;
  final String? subProject;
  final String activity;
  final String country, state, district, city, address;
  final String siteId, siteName;
  final String pm, vendor;
  final String? feId, feName, feMobile;
  final String? nocId, nocName;
  final String remarks, status;

  ActivityRow({
    required this.id,
    required this.tNo,
    required this.date,
    required this.completionDate,
    required this.projectId,
    required this.project,
    required this.subProjectId,
    required this.subProject,
    required this.activity,
    required this.country,
    required this.state,
    required this.district,
    required this.city,
    required this.address,
    required this.siteId,
    required this.siteName,
    required this.pm,
    required this.vendor,
    required this.feId,
    required this.feName,
    required this.feMobile,
    required this.nocId,
    required this.nocName,
    required this.remarks,
    required this.status,
  });
}
