class StaffListModel {
  int? error;
  List<Data>? data;

  StaffListModel({this.error, this.data});

  StaffListModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? inTime;
  String? outTime;
  String? waiterUniqueId;
  int? restId;
  String? attTime;
  String? restName;
  String? staffName;

  Data(
      {this.inTime,
        this.outTime,
        this.waiterUniqueId,
        this.restId,
        this.attTime,
        this.restName,
        this.staffName});

  Data.fromJson(Map<String, dynamic> json) {
    inTime = json['in_time'];
    outTime = json['out_time'];
    waiterUniqueId = json['waiter_unique_id'];
    restId = json['rest_id'];
    attTime = json['att_time'];
    restName = json['rest_name'];
    staffName = json['staff_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['in_time'] = this.inTime;
    data['out_time'] = this.outTime;
    data['waiter_unique_id'] = this.waiterUniqueId;
    data['rest_id'] = this.restId;
    data['att_time'] = this.attTime;
    data['rest_name'] = this.restName;
    data['staff_name'] = this.staffName;
    return data;
  }
}
