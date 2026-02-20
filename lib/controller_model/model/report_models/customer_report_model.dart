class CustomerReportModel {
  CustomerReportModel({
    required this.error,
    required this.topFiveOrderingCustomer,
    required this.returningCustomers,
    required this.nonReturningCustomers,
    required this.totalCount,
  });

  final int? error;
  final List<TopFiveOrderingCustomer> topFiveOrderingCustomer;
  final int? returningCustomers;
  final int? nonReturningCustomers;
  final int? totalCount;

  factory CustomerReportModel.fromJson(Map<String, dynamic> json){
    return CustomerReportModel(
      error: json["error"],
      topFiveOrderingCustomer: json["top_five_ordering_customer"] == null ? [] : List<TopFiveOrderingCustomer>.from(json["top_five_ordering_customer"]!.map((x) => TopFiveOrderingCustomer.fromJson(x))),
      returningCustomers: json["returning_customers"],
      nonReturningCustomers: json["non_returning_customers"],
      totalCount: json["total_count"],
    );
  }

}

class TopFiveOrderingCustomer {
  TopFiveOrderingCustomer({
    required this.id,
    required this.name,
    required this.totalOrders,
  });

  final int? id;
  final String? name;
  final int? totalOrders;

  factory TopFiveOrderingCustomer.fromJson(Map<String, dynamic> json){
    return TopFiveOrderingCustomer(
      id: json["id"],
      name: json["name"],
      totalOrders: json["total_orders"],
    );
  }

}
