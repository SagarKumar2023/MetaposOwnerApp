class TerminalReportModel {
  int? error;
  List<Data>? data;

  TerminalReportModel({this.error, this.data});

  // TerminalReportModel.fromJson(Map<String, dynamic> json) {
  //   error = json['error'];
  //   if (json['data'] != null) {
  //     data = <Data>[];
  //     json['data'].forEach((v) {
  //       data!.add(new Data.fromJson(v));
  //     });
  //   }
  // }

  TerminalReportModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];

    if (json['data'] != null && json['data'] is List) {
      data = (json['data'] as List)
          .map((e) => Data.fromJson(e))
          .toList();
    } else {
      data = [];
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

  // Data.fromJson(Map<String, dynamic> json) {
  //   totalOrder = json['total_order'] ;
  //   managerName = json['manager_name'];
  //   date = json['date'];
  //   payMethod = json['pay_method'];
  //   amount = json['amount'];
  // }

  Data.fromJson(Map<String, dynamic> json) {
    totalOrder = json['total_order'] is int
        ? json['total_order']
        : int.tryParse(json['total_order'].toString()) ?? 0;

    managerName = json['manager_name']?.toString() ?? "";
    date = json['date']?.toString() ?? "";
    payMethod = json['pay_method']?.toString() ?? "";

    // safe conversion
    amount = json['amount'] == null
        ? 0.0
        : double.tryParse(json['amount'].toString()) ?? 0.0;
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
