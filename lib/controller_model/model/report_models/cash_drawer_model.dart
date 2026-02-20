class CashDrawerModel {
  String? error;
  List<Data>? data;

  CashDrawerModel({this.error, this.data});

  CashDrawerModel.fromJson(Map<String, dynamic> json) {
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
  Null? cashDrawerIp;
  String? dateTimeOpen;
  String? userName;
  String? staffName;
  String? createdAt;

  Data(
      {this.cashDrawerIp,
        this.dateTimeOpen,
        this.userName,
        this.staffName,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    cashDrawerIp = json['cash_drawer_ip'];
    dateTimeOpen = json['date_time_open'];
    userName = json['user_name'];
    staffName = json['staff_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cash_drawer_ip'] = this.cashDrawerIp;
    data['date_time_open'] = this.dateTimeOpen;
    data['user_name'] = this.userName;
    data['staff_name'] = this.staffName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
