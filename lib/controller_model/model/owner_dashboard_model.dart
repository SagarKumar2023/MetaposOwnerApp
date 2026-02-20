class OwnerDashboardModel {
  OwnerDashboardModel({
    required this.error,
    required this.data,
  });

  final int? error;
  final Data? data;

  factory OwnerDashboardModel.fromJson(Map<String, dynamic> json){
    return OwnerDashboardModel(
      error: json["error"],
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

}

class Data {
  Data({
    required this.orderDataAppCount,
    required this.orderDataWebCount,
    required this.orderDataQrCount,
    required this.orderDataPosCount,
    required this.orderDataAppTotal,
    required this.orderDataWebTotal,
    required this.orderDataQrTotal,
    required this.orderDataPosTotal,
    required this.dineinOrders,
    required this.dineinOrdersAmount,
    required this.takeawayOrders,
    required this.takeawayOrdersAmount,
    required this.deliveryOrders,
    required this.deliveryOrdersAmount,
    required this.otherOrders,
    required this.otherOrdersAmount,
    required this.cashOrderPaymentData,
    required this.cardOrderPaymentData,
    required this.tyroOrderPaymentData,
    required this.otherOrderPaymentData,
    required this.cashOrderTotalCountData,
    required this.cardOrderTotalCountData,
    required this.tyroOrderTotalCountData,
    required this.otherOrderTotalCountData,
    required this.cancelOrderAmount,
    required this.totalDiscountOrders,
    required this.cancelOrders,
    required this.soldItems,
    required this.hoursName,
    required this.allHourAmount,
    required this.maxAmount,
    required this.restMaxAmount,
    required this.allTotalSale,
    required this.topSaleProdData,
    required this.totalCategoryTopSailing,
    required this.allRestData,
    required this.tableBookingData,
    required this.reservationDataNew,
    required this.reservationDataAccepted,
    required this.reservationDataRejected,
    required this.reservationDataCompleted,
    required this.reservationDataNoShow,
    required this.reservationDataConfirmed,
    required this.ordersCompleteCount,
    required this.ordersCompleteAmount,
    required this.ordersRunningCount,
    required this.ordersRunningAmount,
    required this.ordersCancelCount,
    required this.ordersCancelAmount,
    required this.halfNHalfData,
    required this.comboData,
    required this.dealData,
  });

  final int? orderDataAppCount;
  final int? orderDataWebCount;
  final int? orderDataQrCount;
  final int? orderDataPosCount;
  final double? orderDataAppTotal;
  final double? orderDataWebTotal;
  final double? orderDataQrTotal;
  final double? orderDataPosTotal;
  final int? dineinOrders;
  final double? dineinOrdersAmount;
  final int? takeawayOrders;
  final double? takeawayOrdersAmount;
  final int? deliveryOrders;
  final double? deliveryOrdersAmount;
  final int? otherOrders;
  final double? otherOrdersAmount;
  final double? cashOrderPaymentData;
  final double? cardOrderPaymentData;
  final double? tyroOrderPaymentData;
  final double? otherOrderPaymentData;
  final int? cashOrderTotalCountData;
  final int? cardOrderTotalCountData;
  final int? tyroOrderTotalCountData;
  final int? otherOrderTotalCountData;
  final double? cancelOrderAmount;
  final double? totalDiscountOrders;
  final int? cancelOrders;
  final int? soldItems;
  final List<String> hoursName;
  final List<double> allHourAmount;
  final double? maxAmount;
  final double? restMaxAmount;
  final List<int> allTotalSale;
  final List<TopSaleProdDatum> topSaleProdData;
  final List<TotalCategoryTopSaling> totalCategoryTopSailing;
  final List<AllRestDatum> allRestData;
  final List<dynamic> tableBookingData;
  final List<ReservationDatas> reservationDataNew;
  final List<ReservationDatas> reservationDataAccepted;
  final List<ReservationDatas> reservationDataRejected;
  final List<ReservationDatas> reservationDataCompleted;
  final List<ReservationDatas> reservationDataNoShow;
  final List<ReservationDatas> reservationDataConfirmed;
  final int? ordersCompleteCount;
  final double? ordersCompleteAmount;
  final int? ordersRunningCount;
  final double? ordersRunningAmount;
  final int? ordersCancelCount;
  final double? ordersCancelAmount;
  final List<dynamic> halfNHalfData;
  final List<dynamic> comboData;
  final List<dynamic> dealData;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      orderDataAppCount: json["order_data_app_count"],
      orderDataWebCount: json["order_data_web_count"],
      orderDataQrCount: json["order_data_qr_count"],
      orderDataPosCount: json["order_data_pos_count"],
      orderDataAppTotal: double.parse("${json["order_data_app_total"]}"),
      orderDataWebTotal: double.parse("${json["order_data_web_total"]}"),
      orderDataQrTotal: double.parse("${json["order_data_qr_total"]}"),
      orderDataPosTotal: double.parse("${json["order_data_pos_total"]??0}"),
      dineinOrders: json["dinein_orders"],
      dineinOrdersAmount: double.parse("${json["dinein_orders_amount"]}"),
      takeawayOrders: json["takeaway_orders"],
      takeawayOrdersAmount:  double.parse("${json["takeaway_orders_amount"]}"),
      deliveryOrders: json["delivery_orders"],
      deliveryOrdersAmount: double.parse("${json["delivery_orders_amount"]}"),
      otherOrders: json["other_orders"],
      otherOrdersAmount: double.parse("${json["other_orders_amount"]}"),
      cashOrderPaymentData: double.parse("${ json["cash_order_payment_data"]}"),
      cardOrderPaymentData: double.parse("${json["card_order_payment_data"]}"),
      tyroOrderPaymentData: double.parse("${json["tyro_order_payment_data"]}"),
      otherOrderPaymentData:double.parse("${ json["other_order_payment_data"]}"),
      cashOrderTotalCountData: json["cash_order_total_count_data"],
      cardOrderTotalCountData: json["card_order_total_count_data"],
      tyroOrderTotalCountData: json["tyro_order_total_count_data"],
      otherOrderTotalCountData: json["other_order_total_count_data"],
      cancelOrderAmount: double.parse("${json["cancel_order_amount"]}"),
      totalDiscountOrders: double.parse("${json["total_discount_orders"]}"),
      cancelOrders: json["cancel_orders"],
      soldItems: json["sold_items"],
      hoursName: json["hours_name"] == null ? [] : List<String>.from(json["hours_name"]!.map((x) => x)),
      allHourAmount: json["all_hour_amount"] == null ? [] : List<double>.from(json["all_hour_amount"].map((x) => double.parse("$x")),),
      maxAmount: double.tryParse("${json["max_amount"]}") ?? 0,
      restMaxAmount: double.tryParse("${json["rest_max_amount"]}") ?? 0,
      allTotalSale: json["all_total_sale"] == null ? [] : List<int>.from(json["all_total_sale"]!.map((x) => x)),
      topSaleProdData: json["top_sale_prod_data"] == null ? [] : List<TopSaleProdDatum>.from(json["top_sale_prod_data"]!.map((x) => TopSaleProdDatum.fromJson(x))),
      totalCategoryTopSailing: json["total_category_top_saling"] == null ? [] : List<TotalCategoryTopSaling>.from(json["total_category_top_saling"]!.map((x) => TotalCategoryTopSaling.fromJson(x))),
      allRestData: json["all_rest_data"] == null ? [] : List<AllRestDatum>.from(json["all_rest_data"]!.map((x) => AllRestDatum.fromJson(x))),
      tableBookingData: json["table_booking_data"] == null ? [] : List<dynamic>.from(json["table_booking_data"]!.map((x) => x)),
      reservationDataNew: json["reservation_datas_new"] == null ? [] : List<ReservationDatas>.from(json["reservation_datas_new"]!.map((x) => ReservationDatas.fromJson(x))),
      reservationDataAccepted: json["reservation_datas_accepted"] == null ? [] : List<ReservationDatas>.from(json["reservation_datas_accepted"]!.map((x) => ReservationDatas.fromJson(x))),
      reservationDataRejected: json["reservation_datas_rejected"] == null ? [] : List<ReservationDatas>.from(json["reservation_datas_rejected"]!.map((x) => ReservationDatas.fromJson(x))),
      reservationDataCompleted: json["reservation_datas_completed"] == null ? [] : List<ReservationDatas>.from(json["reservation_datas_completed"]!.map((x) => ReservationDatas.fromJson(x))),
      reservationDataNoShow: json["reservation_datas_noshow"] == null ? [] : List<ReservationDatas>.from(json["reservation_datas_noshow"]!.map((x) => ReservationDatas.fromJson(x))),
      reservationDataConfirmed: json["reservation_datas_confirmed"] == null ? [] : List<ReservationDatas>.from(json["reservation_datas_confirmed"]!.map((x) => ReservationDatas.fromJson(x))),
      ordersCompleteCount: json["orders_complete_count"],
      ordersCompleteAmount: double.parse("${json["orders_complete_amount"]}"),
      ordersRunningCount: json["orders_runnig_count"],
      ordersRunningAmount: double.parse("${json["orders_runnig_amount"]}"),
      ordersCancelCount: json["orders_cancel_count"],
      ordersCancelAmount: double.parse("${json["orders_cancel_amount"]}"),
      halfNHalfData: json["half_n_half_data"] == null ? [] : List<dynamic>.from(json["half_n_half_data"]!.map((x) => x)),
      comboData: json["combo_data"] == null ? [] : List<dynamic>.from(json["combo_data"]!.map((x) => x)),
      dealData: json["deal_data"] == null ? [] : List<dynamic>.from(json["deal_data"]!.map((x) => x)),
    );
  }

}

class AllRestDatum {
  AllRestDatum({
    required this.restaurantName,
    required this.restWiseSales,
  });

  final String? restaurantName;
  final List<RestWiseSale> restWiseSales;

  factory AllRestDatum.fromJson(Map<String, dynamic> json){
    return AllRestDatum(
      restaurantName: json["restaurant_name"],
      restWiseSales: json["rest_wise_sales"] == null ? [] : List<RestWiseSale>.from(json["rest_wise_sales"]!.map((x) => RestWiseSale.fromJson(x))),
    );
  }

}

class RestWiseSale {
  RestWiseSale({
    required this.amount,
    required this.totalSale,
    required this.name,
  });

  final String? amount;
  final int? totalSale;
  final String? name;

  factory RestWiseSale.fromJson(Map<String, dynamic> json){
    return RestWiseSale(
      amount: json["amount"],
      totalSale: json["total_sale"],
      name: json["name"],
    );
  }

}

class ReservationDatas {
  ReservationDatas({
    required this.status,
    required this.count,
    required this.coverPeople,
  });

  final dynamic status;
  final int? count;
  final dynamic coverPeople;

  factory ReservationDatas.fromJson(Map<String, dynamic> json){
    return ReservationDatas(
      status: json["status"],
      count: json["count"],
      coverPeople: json["cover_people"],
    );
  }

}

class TopSaleProdDatum {
  TopSaleProdDatum({
    required this.topSalling,
    required this.foodSallingAmount,
    required this.name,
  });

  final int? topSalling;
  final double? foodSallingAmount;
  final String? name;

  factory TopSaleProdDatum.fromJson(Map<String, dynamic> json){
    return TopSaleProdDatum(
      topSalling: json["top_salling"],
      foodSallingAmount: double.parse("${json["food_salling_amount"]}"),
      name: json["name"],
    );
  }

}

class TotalCategoryTopSaling {
  TotalCategoryTopSaling({
    required this.name,
    required this.totalCount,
    required this.totalAmount,
  });

  final String? name;
  final double? totalCount;
  final double? totalAmount;

  factory TotalCategoryTopSaling.fromJson(Map<String, dynamic> json){
    return TotalCategoryTopSaling(
      name: json["name"],
      totalCount:double.parse("${ json["total_count"]}"),
      totalAmount: double.parse("${json["total_amount"]}"),
    );
  }

}
