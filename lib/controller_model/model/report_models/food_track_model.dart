class FoodTrackModel {
  int? error;
  List<Data>? data;

  FoodTrackModel({this.error, this.data});

  FoodTrackModel.fromJson(Map<String, dynamic> json) {
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
  String? newAddedItem;
  int? closingStock;
  int? openingStock;
  String? saleItems;
  String? foodName;
  String? date;

  Data(
      {this.newAddedItem,
        this.closingStock,
        this.openingStock,
        this.saleItems,
        this.foodName,
        this.date});

  Data.fromJson(Map<String, dynamic> json) {
    newAddedItem = json['new_added_item'];
    closingStock = json['closing_stock'];
    openingStock = json['opening_stock'];
    saleItems = json['sale_items'];
    foodName = json['food_name'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_added_item'] = this.newAddedItem;
    data['closing_stock'] = this.closingStock;
    data['opening_stock'] = this.openingStock;
    data['sale_items'] = this.saleItems;
    data['food_name'] = this.foodName;
    data['date'] = this.date;
    return data;
  }
}
