class ProductReportModel {
  ProductReportModel({
    required this.error,
    required this.topProducts,
    required this.totalCount,
  });

  final int? error;
  final List<TopProduct> topProducts;
  final int? totalCount;

  factory ProductReportModel.fromJson(Map<String, dynamic> json){
    return ProductReportModel(
      error: json["error"],
      topProducts: json["top_products"] == null ? [] : List<TopProduct>.from(json["top_products"]!.map((x) => TopProduct.fromJson(x))),
      totalCount: json["total_count"],
    );
  }

}

class TopProduct {
  TopProduct({
    required this.topSalling,
    required this.foodSallingAmount,
    required this.name,
  });

  final int? topSalling;
  final double? foodSallingAmount;
  final String? name;

  factory TopProduct.fromJson(Map<String, dynamic> json){
    return TopProduct(
      topSalling: json["top_salling"],
      foodSallingAmount: double.parse("${json["food_salling_amount"]}"),
      name: json["name"],
    );
  }

}