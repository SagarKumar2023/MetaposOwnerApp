class StaffReportModel {
  String? error;
  List<StaffData>? staffData;
  int? totalCount;

  StaffReportModel({this.error, this.staffData, this.totalCount});

  StaffReportModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['staff_data'] != null) {
      staffData = <StaffData>[];
      json['staff_data'].forEach((v) {
        staffData!.add(new StaffData.fromJson(v));
      });
    }
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.staffData != null) {
      data['staff_data'] = this.staffData!.map((v) => v.toJson()).toList();
    }
    data['total_count'] = this.totalCount;
    return data;
  }
}

class StaffData {
  int? id;
  String? empCode;
  String? name;
  String? uniqueId;
  String? restName;
  int? restId;
  String? hourlyRate;
  double? totalHours;

  StaffData(
      {this.id,
        this.empCode,
        this.name,
        this.uniqueId,
        this.restName,
        this.restId,
        this.hourlyRate,
        this.totalHours});

  StaffData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    empCode = json['emp_code'];
    name = json['name'];
    uniqueId = json['unique_id'];
    restName = json['rest_name'];
    restId = json['rest_id'];
    hourlyRate = json['hourly_rate'];
    totalHours = double.parse("${json['total_hours']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['emp_code'] = this.empCode;
    data['name'] = this.name;
    data['unique_id'] = this.uniqueId;
    data['rest_name'] = this.restName;
    data['rest_id'] = this.restId;
    data['hourly_rate'] = this.hourlyRate;
    data['total_hours'] = this.totalHours;
    return data;
  }
}
