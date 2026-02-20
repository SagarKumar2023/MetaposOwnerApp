class CategoryModel {
  CategoryModel({
    required this.error,
    required this.message,
    required this.data,
    required this.otherData,
    required this.comboData,
    required this.halfNHalfData,
    required this.dealDataList,
    required this.specialDealDataList,
  });

  final String? error;
  final String? message;
  final List<Data> data;
  final List<OtherData> otherData;
  final List<ComboData> comboData;
  final List<HalfNHalfData> halfNHalfData;
  final List<DealDataList> dealDataList;
  final List<SpecialDealDataList> specialDealDataList;

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    return CategoryModel(
      error: json["error"],
      message: json["message"],
      data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
      otherData: json["other_data"] == null ? [] : List<OtherData>.from(json["other_data"]!.map((x) => OtherData.fromJson(x))),
      comboData: json["combo_data"] == null ? [] : List<ComboData>.from(json["combo_data"]!.map((x) => ComboData.fromJson(x))),
      halfNHalfData: json["half_n_half_data"] == null ? [] : List<HalfNHalfData>.from(json["half_n_half_data"]!.map((x) => HalfNHalfData.fromJson(x))),
      dealDataList: json["deal_data_list"] == null ? [] : List<DealDataList>.from(json["deal_data_list"]!.map((x) => DealDataList.fromJson(x))),
      specialDealDataList: json["special_deal_data_list"] == null ? [] : List<SpecialDealDataList>.from(json["special_deal_data_list"]!.map((x) => SpecialDealDataList.fromJson(x))),
    );
  }

}

class ComboData {
  ComboData({
    required this.id,
    required this.name,
    required this.discount,
    required this.noOfItems,
    required this.amount,
    required this.desc,
    required this.showApp,
    required this.showWeb,
    required this.showPos,
    required this.showQrcode,
    required this.deafultProductId,
    required this.deafultProductName,
    required this.allCategory,
    required this.categoryList,
    required this.allFoods,
    required this.foodList,
  });

  final int? id;
  final String? name;
  final String? discount;
  final int? noOfItems;
  final String? amount;
  final String? desc;
  final int? showApp;
  final int? showWeb;
  final int? showPos;
  final int? showQrcode;
  final int? deafultProductId;
  final String? deafultProductName;
  final int? allCategory;
  final List<dynamic> categoryList;
  final int? allFoods;
  final List<ComboDataFoodList> foodList;

  factory ComboData.fromJson(Map<String, dynamic> json){
    return ComboData(
      id: json["id"],
      name: json["name"],
      discount: json["discount"],
      noOfItems: json["no_of_items"],
      amount: json["amount"],
      desc: json["desc"],
      showApp: json["show_app"],
      showWeb: json["show_web"],
      showPos: json["show_pos"],
      showQrcode: json["show_qrcode"],
      deafultProductId: json["deafult_product_id"],
      deafultProductName: json["deafult_product_name"],
      allCategory: json["allCategory"],
      categoryList: json["Category_list"] == null ? [] : List<dynamic>.from(json["Category_list"]!.map((x) => x)),
      allFoods: json["allFoods"],
      foodList: json["food_list"] == null ? [] : List<ComboDataFoodList>.from(json["food_list"]!.map((x) => ComboDataFoodList.fromJson(x))),
    );
  }

}

class ComboDataFoodList {
  ComboDataFoodList({
    required this.id,
    required this.oldId,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    required this.imageid,
    required this.price,
    required this.discountprice,
    required this.desc,
    required this.restaurant,
    required this.category,
    required this.ingredients,
    required this.unit,
    required this.packageCount,
    required this.weight,
    required this.canDelivery,
    required this.stars,
    required this.published,
    required this.extras,
    required this.nutritions,
    required this.contains,
    required this.sequence,
    required this.soldOut,
    required this.images,
    required this.showApp,
    required this.showWeb,
    required this.showPos,
    required this.showQrcode,
    required this.chooseNumberItems,
    required this.isOwnProduct,
    required this.prodQty,
    required this.isTakeAway,
    required this.isHaveInHere,
    required this.inventoryOn,
    required this.prodSku,
    required this.barcodeType,
    required this.productSegregatePrint,
    required this.isWeighingMachine,
    required this.measurementUnits,
    required this.unitType,
    required this.gstTaxPercentage,
    required this.foodType,
    required this.bgColor,
    required this.purchaseCost,
    required this.profitMargin,
    required this.profitMarginPercentage,
    required this.priceUpdateDate,
    required this.productExpiryDate,
    required this.isVariantInventoryOff,
    required this.familyGroupId,
    required this.isCatering,
    required this.minimumQty,
    required this.personText,
    required this.isCouponNotApplied,
    required this.orderBeforeTime,
    required this.orderBeforeDay,
    required this.forDays,
    required this.productKdsDevicesId,
    required this.brand,
    required this.supplier,
    required this.showEntryMain,
    required this.showCds,
    required this.gstApplicable,
    required this.imagePath,
    required this.foodListWithDetails,
    required this.specialDealVariatsName,
    required this.specialDealVariatsId,
  });

  final int? id;
  final int? oldId;
  final int? ownerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? name;
  final String? imageid;
  final String? price;
  final String? discountprice;
  final String? desc;
  final int? restaurant;
  final int? category;
  final String? ingredients;
  final String? unit;
  final int? packageCount;
  final int? weight;
  final int? canDelivery;
  final int? stars;
  final int? published;
  final int? extras;
  final int? nutritions;
  final String? contains;
  final int? sequence;
  final int? soldOut;
  final dynamic images;
  final int? showApp;
  final int? showWeb;
  final int? showPos;
  final int? showQrcode;
  final int? chooseNumberItems;
  final int? isOwnProduct;
  final int? prodQty;
  final int? isTakeAway;
  final int? isHaveInHere;
  final int? inventoryOn;
  final String? prodSku;
  final String? barcodeType;
  final String? productSegregatePrint;
  final int? isWeighingMachine;
  final String? measurementUnits;
  final String? unitType;
  final int? gstTaxPercentage;
  final String? foodType;
  final String? bgColor;
  final String? purchaseCost;
  final String? profitMargin;
  final String? profitMarginPercentage;
  final DateTime? priceUpdateDate;
  final DateTime? productExpiryDate;
  final int? isVariantInventoryOff;
  final int? familyGroupId;
  final int? isCatering;
  final int? minimumQty;
  final String? personText;
  final int? isCouponNotApplied;
  final String? orderBeforeTime;
  final String? orderBeforeDay;
  final String? forDays;
  final String? productKdsDevicesId;
  final dynamic brand;
  final String? supplier;
  final int? showEntryMain;
  final int? showCds;
  final String? gstApplicable;
  final String? imagePath;
  final FoodListWithDetails? foodListWithDetails;
  final String? specialDealVariatsName;
  final int? specialDealVariatsId;

  factory ComboDataFoodList.fromJson(Map<String, dynamic> json){
    return ComboDataFoodList(
      id: json["id"],
      oldId: json["old_id"],
      ownerId: json["owner_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      name: json["name"],
      imageid: json["imageid"],
      price: json["price"],
      discountprice: json["discountprice"],
      desc: json["desc"],
      restaurant: json["restaurant"],
      category: json["category"],
      ingredients: json["ingredients"],
      unit: json["unit"],
      packageCount: json["packageCount"],
      weight: json["weight"],
      canDelivery: json["canDelivery"],
      stars: json["stars"],
      published: json["published"],
      extras: json["extras"],
      nutritions: json["nutritions"],
      contains: json["contains"],
      sequence: json["sequence"],
      soldOut: json["sold_out"],
      images: json["images"],
      showApp: json["show_app"],
      showWeb: json["show_web"],
      showPos: json["show_pos"],
      showQrcode: json["show_qrcode"],
      chooseNumberItems: json["choose_number_items"],
      isOwnProduct: json["is_own_product"],
      prodQty: json["prod_qty"],
      isTakeAway: json["is_take_away"],
      isHaveInHere: json["is_have_in_here"],
      inventoryOn: json["inventory_on"],
      prodSku: json["prod_sku"],
      barcodeType: json["barcode_type"],
      productSegregatePrint: json["product_segregate_print"],
      isWeighingMachine: json["is_weighing_machine"],
      measurementUnits: json["measurement_units"],
      unitType: json["unit_type"],
      gstTaxPercentage: json["gst_tax_percentage"],
      foodType: json["food_type"],
      bgColor: json["bg_color"],
      purchaseCost: json["purchase_cost"],
      profitMargin: json["profit_margin"],
      profitMarginPercentage: json["profit_margin_percentage"],
      priceUpdateDate: DateTime.tryParse(json["price_update_date"] ?? ""),
      productExpiryDate: DateTime.tryParse(json["product_expiry_date"] ?? ""),
      isVariantInventoryOff: json["is_variant_inventory_off"],
      familyGroupId: json["family_group_id"],
      isCatering: json["is_catering"],
      minimumQty: json["minimum_qty"],
      personText: json["person_text"],
      isCouponNotApplied: json["is_coupon_not_applied"],
      orderBeforeTime: json["order_before_time"],
      orderBeforeDay: json["order_before_day"],
      forDays: json["for_days"],
      productKdsDevicesId: json["product_kds_devices_id"],
      brand: json["brand"],
      supplier: json["supplier"],
      showEntryMain: json["show_entry_main"],
      showCds: json["show_cds"],
      gstApplicable: json["gst_applicable"],
      imagePath: json["image_path"],
      foodListWithDetails: json["food_list_with_details"] == null ? null : FoodListWithDetails.fromJson(json["food_list_with_details"]),
      specialDealVariatsName: json["special_deal_variats_name"],
      specialDealVariatsId: json["special_deal_variats_id"],
    );
  }

}

class FoodListWithDetails {
  FoodListWithDetails({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.discountprice,
    required this.desc,
    required this.soldOut,
    required this.prodQty,
    required this.isWeighingMachine,
    required this.inventoryOn,
    required this.isVariantInventoryOff,
    required this.ingredients,
    required this.variantDataArray,
    required this.containsData,
    required this.contains,
    required this.foodAddons,
    required this.addonsDataArray,
    required this.catId,
    required this.catName,
    required this.unitTypes,
    required this.measurementUnits,
    required this.type,
    required this.makemyown,
    required this.isTakeAway,
    required this.isHaveInHere,
    required this.chooseNumberItems,
    required this.gstTaxPercentage,
    required this.isCouponNotApplied,
    required this.showEntryMain,
    required this.bgColor,
    required this.foodBundlePrices,
  });

  final int? id;
  final String? name;
  final String? imagePath;
  final String? price;
  final String? discountprice;
  final String? desc;
  final int? soldOut;
  final int? prodQty;
  final int? isWeighingMachine;
  final int? inventoryOn;
  final int? isVariantInventoryOff;
  final List<String> ingredients;
  final List<VariantDataArray> variantDataArray;
  final List<String> containsData;
  final String? contains;
  final String? foodAddons;
  final List<AddonsDataArray> addonsDataArray;
  final int? catId;
  final String? catName;
  final String? unitTypes;
  final String? measurementUnits;
  final String? type;
  final int? makemyown;
  final int? isTakeAway;
  final int? isHaveInHere;
  final int? chooseNumberItems;
  final int? gstTaxPercentage;
  final int? isCouponNotApplied;
  final int? showEntryMain;
  final String? bgColor;
  final List<FoodBundlePrice> foodBundlePrices;

  factory FoodListWithDetails.fromJson(Map<String, dynamic> json){
    return FoodListWithDetails(
      id: json["id"],
      name: json["name"],
      imagePath: json["image_path"],
      price: json["price"],
      discountprice: json["discountprice"],
      desc: json["desc"],
      soldOut: json["sold_out"],
      prodQty: json["prod_qty"],
      isWeighingMachine: json["is_weighing_machine"],
      inventoryOn: json["inventory_on"],
      isVariantInventoryOff: json["is_variant_inventory_off"],
      ingredients: json["ingredients"] == null ? [] : List<String>.from(json["ingredients"]!.map((x) => x)),
      variantDataArray: json["variantDataArray"] == null ? [] : List<VariantDataArray>.from(json["variantDataArray"]!.map((x) => VariantDataArray.fromJson(x))),
      containsData: json["contains_data"] == null ? [] : List<String>.from(json["contains_data"]!.map((x) => x)),
      contains: json["contains"],
      foodAddons: json["food_addons"],
      addonsDataArray: json["addonsDataArray"] == null ? [] : List<AddonsDataArray>.from(json["addonsDataArray"]!.map((x) => AddonsDataArray.fromJson(x))),
      catId: json["cat_id"],
      catName: json["cat_name"],
      unitTypes: json["unit_types"],
      measurementUnits: json["measurement_units"],
      type: json["type"],
      makemyown: json["makemyown"],
      isTakeAway: json["is_take_away"],
      isHaveInHere: json["is_have_in_here"],
      chooseNumberItems: json["choose_number_items"],
      gstTaxPercentage: json["gst_tax_percentage"],
      isCouponNotApplied: json["is_coupon_not_applied"],
      showEntryMain: json["show_entry_main"],
      bgColor: json["bg_color"],
      foodBundlePrices: json["food_bundle_prices"] == null ? [] : List<FoodBundlePrice>.from(json["food_bundle_prices"]!.map((x) => FoodBundlePrice.fromJson(x))),
    );
  }

}

class AddonsDataArray {
  AddonsDataArray({
    required this.addonsId,
    required this.addonsName,
    required this.addonsPrice,
  });

  final int? addonsId;
  final String? addonsName;
  final String? addonsPrice;

  factory AddonsDataArray.fromJson(Map<String, dynamic> json){
    return AddonsDataArray(
      addonsId: json["addons_id"],
      addonsName: json["addons_name"],
      addonsPrice: json["addons_price"],
    );
  }

}

class FoodBundlePrice {
  FoodBundlePrice({
    required this.id,
    required this.foodId,
    required this.qty,
    required this.price,
  });

  final int? id;
  final int? foodId;
  final String? qty;
  final String? price;

  factory FoodBundlePrice.fromJson(Map<String, dynamic> json){
    return FoodBundlePrice(
      id: json["id"],
      foodId: json["food_id"],
      qty: json["qty"],
      price: json["price"],
    );
  }

}

class VariantDataArray {
  VariantDataArray({
    required this.variantName,
    required this.variantDetail,
  });

  final String? variantName;
  final List<VariantDetail> variantDetail;

  factory VariantDataArray.fromJson(Map<String, dynamic> json){
    return VariantDataArray(
      variantName: json["variant_name"],
      variantDetail: json["variant_detail"] == null ? [] : List<VariantDetail>.from(json["variant_detail"]!.map((x) => VariantDetail.fromJson(x))),
    );
  }

}

class VariantDetail {
  VariantDetail({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.food,
    required this.name,
    required this.variantType,
    required this.imageid,
    required this.price,
    required this.dprice,
    required this.prodQty,
    required this.prodSku,
    required this.mainImage,
    required this.varintAddonsDataArray,
  });

  final int? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? food;
  final String? name;
  final String? variantType;
  final int? imageid;
  final String? price;
  final String? dprice;
  final int? prodQty;
  final String? prodSku;
  final String? mainImage;
  final List<AddonsDataArray> varintAddonsDataArray;

  factory VariantDetail.fromJson(Map<String, dynamic> json){
    return VariantDetail(
      id: json["id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      food: json["food"],
      name: json["name"],
      variantType: json["variant_type"],
      imageid: json["imageid"],
      price: json["price"],
      dprice: json["dprice"],
      prodQty: json["prod_qty"],
      prodSku: json["prod_sku"],
      mainImage: json["main_image"],
      varintAddonsDataArray: json["varintAddonsDataArray"] == null ? [] : List<AddonsDataArray>.from(json["varintAddonsDataArray"]!.map((x) => AddonsDataArray.fromJson(x))),
    );
  }

}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.type,
    required this.sequence,
    required this.subCategory,
    required this.bgColor,
    required this.foodList,
  });

  final int? id;
  final String? name;
  final String? type;
  final int? sequence;
  final List<Data> subCategory;
  final String? bgColor;
  final List<ComboDataFoodList> foodList;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      sequence: json["sequence"],
      subCategory: json["sub_category"] == null ? [] : List<Data>.from(json["sub_category"]!.map((x) => Data.fromJson(x))),
      bgColor: json["bg_color"],
      foodList: json["food_list"] == null ? [] : List<ComboDataFoodList>.from(json["food_list"]!.map((x) => ComboDataFoodList.fromJson(x))),
    );
  }

}

class DealDataList {
  DealDataList({
    required this.id,
    required this.name,
    required this.amount,
    required this.desc,
    required this.showApp,
    required this.showWeb,
    required this.showPos,
    required this.showQrcode,
    required this.dealData,
  });

  final int? id;
  final String? name;
  final String? amount;
  final String? desc;
  final int? showApp;
  final int? showWeb;
  final int? showPos;
  final int? showQrcode;
  final List<DealDataListDealData> dealData;

  factory DealDataList.fromJson(Map<String, dynamic> json){
    return DealDataList(
      id: json["id"],
      name: json["name"],
      amount: json["amount"],
      desc: json["desc"],
      showApp: json["show_app"],
      showWeb: json["show_web"],
      showPos: json["show_pos"],
      showQrcode: json["show_qrcode"],
      dealData: json["deal_data"] == null ? [] : List<DealDataListDealData>.from(json["deal_data"]!.map((x) => DealDataListDealData.fromJson(x))),
    );
  }

}

class DealDataListDealData {
  DealDataListDealData({
    required this.numberOfItem,
    required this.category,
    required this.variantName,
    required this.foodList,
    required this.defaultProduct,
  });

  final String? numberOfItem;
  final String? category;
  final String? variantName;
  final List<ComboDataFoodList> foodList;
  final String? defaultProduct;

  factory DealDataListDealData.fromJson(Map<String, dynamic> json) {
    return DealDataListDealData(
      numberOfItem: json["number_of_item"],
      category: json["category"],
      variantName: json["variant_name"],
      defaultProduct: json["default_product"],
      foodList: json["food_list"] == null
          ? []
          : List<ComboDataFoodList>.from(
          json["food_list"]!.map((x) => ComboDataFoodList.fromJson(x))),
    );
  }
}

class HalfNHalfData {
  HalfNHalfData({
    required this.id,
    required this.name,
    required this.desc,
    required this.offeredPrice,
    required this.thisPrice,
    required this.showApp,
    required this.showWeb,
    required this.showPos,
    required this.showQrcode,
    required this.variant,
    required this.allFoods,
    required this.foodList,
    required this.allBase,
  });

  final int? id;
  final String? name;
  final String? desc;
  final int? offeredPrice;
  final int? thisPrice;
  final int? showApp;
  final int? showWeb;
  final int? showPos;
  final int? showQrcode;
  final String? variant;
  final int? allFoods;
  final List<HalfNHalfDatumFoodList> foodList;
  final List<dynamic> allBase;

  factory HalfNHalfData.fromJson(Map<String, dynamic> json){
    return HalfNHalfData(
      id: json["id"],
      name: json["name"],
      desc: json["desc"],
      offeredPrice: json["offered_price"],
      thisPrice: json["this_price"],
      showApp: json["show_app"],
      showWeb: json["show_web"],
      showPos: json["show_pos"],
      showQrcode: json["show_qrcode"],
      variant: json["variant"],
      allFoods: json["allFoods"],
      foodList: json["food_list"] == null ? [] : List<HalfNHalfDatumFoodList>.from(json["food_list"]!.map((x) => HalfNHalfDatumFoodList.fromJson(x))),
      allBase: json["all_base"] == null ? [] : List<dynamic>.from(json["all_base"]!.map((x) => x)),
    );
  }

}

class HalfNHalfDatumFoodList {
  HalfNHalfDatumFoodList({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.price,
    required this.discountprice,
    required this.desc,
    required this.prodQty,
    required this.soldOut,
    required this.ingredients,
    required this.variantDataArray,
    required this.containsData,
    required this.contains,
    required this.foodAddons,
    required this.addonsDataArray,
    required this.catId,
    required this.catName,
    required this.type,
    required this.makemyown,
    required this.chooseNumberItems,
  });

  final int? id;
  final String? name;
  final String? imagePath;
  final int? price;
  final String? discountprice;
  final String? desc;
  final int? prodQty;
  final int? soldOut;
  final String? ingredients;
  final List<VariantDataArray> variantDataArray;
  final List<String> containsData;
  final String? contains;
  final String? foodAddons;
  final List<AddonsDataArray> addonsDataArray;
  final int? catId;
  final String? catName;
  final String? type;
  final int? makemyown;
  final int? chooseNumberItems;

  factory HalfNHalfDatumFoodList.fromJson(Map<String, dynamic> json){
    return HalfNHalfDatumFoodList(
      id: json["id"],
      name: json["name"],
      imagePath: json["image_path"],
      price: json["price"],
      discountprice: json["discountprice"],
      desc: json["desc"],
      prodQty: json["prod_qty"],
      soldOut: json["sold_out"],
      ingredients: json["ingredients"],
      variantDataArray: json["variantDataArray"] == null ? [] : List<VariantDataArray>.from(json["variantDataArray"]!.map((x) => VariantDataArray.fromJson(x))),
      containsData: json["contains_data"] == null ? [] : List<String>.from(json["contains_data"]!.map((x) => x)),
      contains: json["contains"],
      foodAddons: json["food_addons"],
      addonsDataArray: json["addonsDataArray"] == null ? [] : List<AddonsDataArray>.from(json["addonsDataArray"]!.map((x) => AddonsDataArray.fromJson(x))),
      catId: json["cat_id"],
      catName: json["cat_name"],
      type: json["type"],
      makemyown: json["makemyown"],
      chooseNumberItems: json["choose_number_items"],
    );
  }

}

class OtherData {
  OtherData({
    required this.id,
    required this.name,
    required this.type,
    required this.sequence,
    required this.subCategoryNew,
    required this.foodList,
    required this.bgColor,
  });

  final int? id;
  final String? name;
  final String? type;
  final int? sequence;
  final List<Data> subCategoryNew;
  final List<ComboDataFoodList> foodList;
  final String? bgColor;

  factory OtherData.fromJson(Map<String, dynamic> json){
    return OtherData(
      id: json["id"],
      name: json["name"],
      type: json["type"],
      sequence: json["sequence"],
      subCategoryNew: json["sub_category_new"] == null ? [] : List<Data>.from(json["sub_category_new"]!.map((x) => Data.fromJson(x))),
      foodList: json["food_list"] == null ? [] : List<ComboDataFoodList>.from(json["food_list"]!.map((x) => ComboDataFoodList.fromJson(x))),
      bgColor: json["bg_color"],
    );
  }

}

class SpecialDealDataList {
  SpecialDealDataList({
    required this.id,
    required this.name,
    required this.amount,
    required this.isThisPrice,
    required this.saveAmount,
    required this.desc,
    required this.showApp,
    required this.showWeb,
    required this.showPos,
    required this.showQrcode,
    required this.dealData,
    required this.options,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.days,
  });

  final int? id;
  final String? name;
  final String? amount;
  final int? isThisPrice;
  final String? saveAmount;
  final String? desc;
  final int? showApp;
  final int? showWeb;
  final int? showPos;
  final int? showQrcode;
  final List<SpecialDealDataListDealDatum> dealData;
  final int? options;
  final String? startDate;
  final String? startTime;
  final String? endTime;
  final String? days;

  factory SpecialDealDataList.fromJson(Map<String, dynamic> json){
    return SpecialDealDataList(
      id: json["id"],
      name: json["name"],
      amount: json["amount"],
      isThisPrice: json["is_this_price"],
      saveAmount: json["save_amount"],
      desc: json["desc"],
      showApp: json["show_app"],
      showWeb: json["show_web"],
      showPos: json["show_pos"],
      showQrcode: json["show_qrcode"],
      dealData: json["deal_data"] == null ? [] : List<SpecialDealDataListDealDatum>.from(json["deal_data"]!.map((x) => SpecialDealDataListDealDatum.fromJson(x))),
      options: json["options"],
      startDate: json["start_date"],
      startTime: json["start_time"],
      endTime: json["end_time"],
      days: json["days"],
    );
  }

}

class SpecialDealDataListDealDatum {
  SpecialDealDataListDealDatum({
    required this.numberOfItem,
    required this.category,
    required this.categoryId,
    required this.variantName,
    required this.variatsId,
    required this.selectedVariantList,
    required this.foodList,
    required this.defaultProduct,
  });

  final String? numberOfItem;
  final String? category;
  final int? categoryId;
  final String? variantName;
  final String? variatsId;
  final List<int> selectedVariantList;
  final List<ComboDataFoodList> foodList;
  final String? defaultProduct;

  factory SpecialDealDataListDealDatum.fromJson(Map<String, dynamic> json){
    return SpecialDealDataListDealDatum(
      numberOfItem: json["number_of_item"],
      category: json["category"],
      categoryId: json["category_id"],
      variantName: json["variant_name"],
      variatsId: json["variats_id"],
      selectedVariantList: json["selected_variant_list"] == null ? [] : List<int>.from(json["selected_variant_list"]!.map((x) => x)),
      foodList: json["food_list"] == null ? [] : List<ComboDataFoodList>.from(json["food_list"]!.map((x) => ComboDataFoodList.fromJson(x))),
      defaultProduct: json["default_product"],
    );
  }

}
