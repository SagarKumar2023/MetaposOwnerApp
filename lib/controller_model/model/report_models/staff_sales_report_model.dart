class StaffSalesReportModel {
  int? error;
  List<Data>? data;

  StaffSalesReportModel({this.error, this.data});

  StaffSalesReportModel.fromJson(Map<String, dynamic> json) {
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
  int? totalOrder;
  String? managerName;
  String? date;
  String? payMethod;
  double? amount;

  Data(
      {this.totalOrder,
        this.managerName,
        this.date,
        this.payMethod,
        this.amount});

  Data.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'];
    managerName = json['manager_name'];
    date = json['date'];
    payMethod = json['pay_method'];
    amount = double.parse("${json['amount']}");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_order'] = this.totalOrder;
    data['manager_name'] = this.managerName;
    data['date'] = this.date;
    data['pay_method'] = this.payMethod;
    data['amount'] = this.amount;
    return data;
  }
}
