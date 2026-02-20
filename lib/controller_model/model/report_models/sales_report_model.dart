class SalesReportModel {
  SalesReportModel({
    required this.error,
    required this.totalOrder,
    required this.totalAmount,
    required this.totalDiscount,
    required this.totalTax,
    required this.minOrder,
    required this.maxOrder,
    required this.averageOrder,
    required this.overAllPercentage,
    required this.totalDrinkOrderFilter,
    required this.totalFoodOrderFilter,
    required this.totalAmountDrinkOrderFilter,
    required this.totalAmountFoodOrderFilter,
    required this.totalCancelledItems,
    required this.totalCancelledOrders,
    required this.allCategory,
    required this.orderType,
    required this.paymentType,
    required this.tableBookingData,
    required this.orderPlatforms,
    required this.ordersCompleteCount,
    required this.ordersCompleteAmount,
    required this.ordersReceiveCount,
    required this.ordersReceiveAmount,
    required this.ordersCancelCount,
    required this.ordersCancelAmount,
  });

  final String? error;
  final int? totalOrder;
  final int? totalAmount;
  final int? totalDiscount;
  final int? totalTax;
  final int? minOrder;
  final int? maxOrder;
  final int? averageOrder;
  final int? overAllPercentage;
  final int? totalDrinkOrderFilter;
  final int? totalFoodOrderFilter;
  final int? totalAmountDrinkOrderFilter;
  final int? totalAmountFoodOrderFilter;
  final int? totalCancelledItems;
  final int? totalCancelledOrders;
  final List<AllCategory> allCategory;
  final List<dynamic> orderType;
  final List<dynamic> paymentType;
  final TableBookingData? tableBookingData;
  final OrderPlatforms? orderPlatforms;
  final int? ordersCompleteCount;
  final int? ordersCompleteAmount;
  final int? ordersReceiveCount;
  final int? ordersReceiveAmount;
  final int? ordersCancelCount;
  final int? ordersCancelAmount;

  factory SalesReportModel.fromJson(Map<String, dynamic> json){
    return SalesReportModel(
      error: json["error"],
      totalOrder: json["total_order"],
      totalAmount: json["total_amount"],
      totalDiscount: json["total_discount"],
      totalTax: json["total_tax"],
      minOrder: json["min_order"],
      maxOrder: json["max_order"],
      averageOrder: json["average_order"],
      overAllPercentage: json["over_all_percentage"],
      totalDrinkOrderFilter: json["total_drink_order_filter"],
      totalFoodOrderFilter: json["total_food_order_filter"],
      totalAmountDrinkOrderFilter: json["total_amount_drink_order_filter"],
      totalAmountFoodOrderFilter: json["total_amount_food_order_filter"],
      totalCancelledItems: json["total_cancelled_items"],
      totalCancelledOrders: json["total_cancelled_orders"],
      allCategory: json["all_category"] == null ? [] : List<AllCategory>.from(json["all_category"]!.map((x) => AllCategory.fromJson(x))),
      orderType: json["order_type"] == null ? [] : List<dynamic>.from(json["order_type"]!.map((x) => x)),
      paymentType: json["payment_type"] == null ? [] : List<dynamic>.from(json["payment_type"]!.map((x) => x)),
      tableBookingData: json["table_booking_data"] == null ? null : TableBookingData.fromJson(json["table_booking_data"]),
      orderPlatforms: json["order_platforms"] == null ? null : OrderPlatforms.fromJson(json["order_platforms"]),
      ordersCompleteCount: json["orders_complete_count"],
      ordersCompleteAmount: json["orders_complete_amount"],
      ordersReceiveCount: json["orders_receive_count"],
      ordersReceiveAmount: json["orders_receive_amount"],
      ordersCancelCount: json["orders_cancel_count"],
      ordersCancelAmount: json["orders_cancel_amount"],
    );
  }

}

class AllCategory {
  AllCategory({
    required this.name,
    required this.totalCount,
  });

  final String? name;
  final double? totalCount;

  factory AllCategory.fromJson(Map<String, dynamic> json){
    return AllCategory(
      name: json["name"],
      totalCount: double.parse("${json["total_count"]}"),
    );
  }

}

class OrderPlatforms {
  OrderPlatforms({
    required this.posOrders,
    required this.posOrdersAmount,
    required this.websiteOrders,
    required this.websiteOrdersAmount,
    required this.qrOrders,
    required this.qrOrdersAmount,
    required this.appOrders,
    required this.appOrdersAmount,
  });

  final int? posOrders;
  final String? posOrdersAmount;
  final int? websiteOrders;
  final double? websiteOrdersAmount;
  final int? qrOrders;
  final double? qrOrdersAmount;
  final int? appOrders;
  final double? appOrdersAmount;

  factory OrderPlatforms.fromJson(Map<String, dynamic> json){
    return OrderPlatforms(
      posOrders: json["pos_orders"],
      posOrdersAmount: json["pos_orders_amount"],
      websiteOrders: json["website_orders"],
      websiteOrdersAmount: double.parse("${json["website_orders_amount"]}"),
      qrOrders: json["qr_orders"],
      qrOrdersAmount: double.parse("${json["qr_orders_amount"]}"),
      appOrders: json["app_orders"],
      appOrdersAmount: double.parse("${json["app_orders_amount"]}"),
    );
  }

}

class TableBookingData {
  TableBookingData({
    required this.totalTableCount,
    required this.posTableCount,
    required this.websiteTableCount,
    required this.walkingTableCount,
    required this.totalCoverPeople,
    required this.posCoverPeople,
    required this.websiteCoverPeople,
    required this.walkingCoverPeople,
    required this.completedTable,
    required this.noShowTable,
    required this.cancelledTable,
  });

  final int? totalTableCount;
  final int? posTableCount;
  final int? websiteTableCount;
  final int? walkingTableCount;
  final int? totalCoverPeople;
  final int? posCoverPeople;
  final int? websiteCoverPeople;
  final int? walkingCoverPeople;
  final int? completedTable;
  final int? noShowTable;
  final int? cancelledTable;

  factory TableBookingData.fromJson(Map<String, dynamic> json){
    return TableBookingData(
      totalTableCount: json["total_table_count"],
      posTableCount: json["pos_table_count"],
      websiteTableCount: json["website_table_count"],
      walkingTableCount: json["walking_table_count"],
      totalCoverPeople: json["total_cover_people"],
      posCoverPeople: json["pos_cover_people"],
      websiteCoverPeople: json["website_cover_people"],
      walkingCoverPeople: json["walking_cover_people"],
      completedTable: json["completed_table"],
      noShowTable: json["no_show_table"],
      cancelledTable: json["cancelled_table"],
    );
  }

}
