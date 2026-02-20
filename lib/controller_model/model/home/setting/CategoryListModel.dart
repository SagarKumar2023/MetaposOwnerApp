class CategoryListModel {
  String error;

  String message;

  List<CatData> data;

  List<CatOtherData> otherData;

  List<CatComboData> comboData;

  List<CatHalfNHalfData> halfNHalfData;

  List<CatDealDataList> dealDataList;

  List<CatSpecialDealDataList> specialDealDataList;

  CategoryListModel({
    required this.error,
    required this.message,
    required this.data,
    required this.otherData,
    required this.comboData,
    required this.halfNHalfData,
    required this.dealDataList,
    required this.specialDealDataList,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic> json) {
    return CategoryListModel(
      error: json['error']?.toString() ?? "0",
      message: json['message']?.toString() ?? "",
      data: (json['data'] as List? ?? [])
          .map((e) => CatData.fromJson(e))
          .toList(),
      otherData: (json['other_data'] as List? ?? [])
          .map((e) => CatOtherData.fromJson(e))
          .toList(),
      comboData: (json['combo_data'] as List? ?? [])
          .map((e) => CatComboData.fromJson(e))
          .toList(),
      halfNHalfData: (json['half_n_half_data'] as List? ?? [])
          .map((e) => CatHalfNHalfData.fromJson(e))
          .toList(),
      dealDataList: (json['deal_data_list'] as List? ?? [])
          .map((e) => CatDealDataList.fromJson(e))
          .toList(),
      specialDealDataList: (json['special_deal_data_list'] as List? ?? [])
          .map((e) => CatSpecialDealDataList.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": error,
      "message": message,
      "data": data.map((e) => e.toJson()).toList(),
      "other_data": otherData.map((e) => e.toJson()).toList(),
      "combo_data": comboData.map((e) => e.toJson()).toList(),
      "half_n_half_data": halfNHalfData.map((e) => e.toJson()).toList(),
      "deal_data_list": dealDataList.map((e) => e.toJson()).toList(),
      "special_deal_data_list":
      specialDealDataList.map((e) => e.toJson()).toList(),
    };
  }

}

class CatData  {
  int id;


  String name;


  String type;


  int sequence;

  List<CatSubCategory> subCategory;

  String bgColor;

  CatData({
    required this.id,
    required this.name,
    required this.type,
    required this.sequence,
    required this.subCategory,
    required this.bgColor,
  });

  factory CatData.fromJson(Map<String, dynamic> json) {
    return CatData(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? "",
      type: json['type']?.toString() ?? "",
      sequence: json['sequence'] ?? 0,
      subCategory: (json['sub_category'] as List? ?? [])
          .map((e) => CatSubCategory.fromJson(e))
          .toList(),
      bgColor: json['bg_color']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "sequence": sequence,
      "sub_category": subCategory.map((e) => e.toJson()).toList(),
      "bg_color": bgColor,
    };
  }

}

class CatSubCategory  {
  int id;

  String name;

  int sequence;

  String type;

  String bgColor;

  CatSubCategory({
    required this.id,
    required this.name,
    required this.sequence,
    required this.type,
    required this.bgColor,
  });

  factory CatSubCategory.fromJson(Map<String, dynamic> json) {
    return CatSubCategory(
      id: json['id'] ?? 0,
      name: json['name']?.toString() ?? "",
      sequence: json['sequence'] ?? 0,
      type: json['type']?.toString() ?? "",
      bgColor: json['bg_color']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "sequence": sequence,
      "type": type,
      "bg_color": bgColor,
    };
  }
}

class CatOtherData {
  int id;

  String name;

  String type;

  int sequence;
  List<CatSubCategoryNew> subCategoryNew;

  List<CatOtherDataFoodList> foodList;

  String bgColor;

  CatOtherData({
    required this.id,
    required this.name,
    required this.type,
    required this.sequence,
    required this.subCategoryNew,
    required this.foodList,
    required this.bgColor,
  });

  factory CatOtherData.fromJson(Map<String, dynamic> json) {
    return CatOtherData(
      id: json["id"] ?? 0,
      name: json["name"]?.toString() ?? "",
      type: json["type"]?.toString() ?? "",
      sequence: json["sequence"] ?? 0,
      subCategoryNew: (json["sub_category_new"] as List? ?? [])
          .map((e) => CatSubCategoryNew.fromJson(e))
          .toList(),
      foodList: (json["food_list"] as List? ?? [])
          .map((e) => CatOtherDataFoodList.fromJson(e))
          .toList(),
            // .map((e) => CatOtherDataFoodList.[ya pe indicatekar raha hai ]fromJson(e))
      bgColor: json["bg_color"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "sequence": sequence,
      "sub_category_new": subCategoryNew.map((e) => e.toJson()).toList(),
      "food_list": foodList.map((e) => e.toJson()).toList(),
      "bg_color": bgColor,
    };
  }
}

class CatSubCategoryNew{
  int id;
  String name;
  String type;
  int sequence;
  List<CatOtherDataFoodList> foodList;
  String bgColor;

  CatSubCategoryNew({
    required this.id,
    required this.name,
    required this.type,
    required this.sequence,
    required this.foodList,
    required this.bgColor,
  });

  factory CatSubCategoryNew.fromJson(Map<String, dynamic> json) {
    return CatSubCategoryNew(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      type: json['type'] ?? "",
      sequence: json['sequence'] ?? 0,
      foodList: (json['food_list'] as List? ?? [])
          .map((e) => CatOtherDataFoodList.fromJson(e))
          .toList(),
      bgColor: json['bg_color'] ?? "#FFFFFF",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "type": type,
      "sequence": sequence,
      "food_list": foodList.map((e) => e.toJson()).toList(),
      "bg_color": bgColor,
    };
  }
}

class CatOtherDataFoodList {
  CatOtherDataFoodList({
    required this.id,
    this.oldId,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.imageid,
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
    this.contains,
    required this.sequence,
    required this.soldOut,
    this.images,
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
    this.barcodeType,
    required this.productSegregatePrint,
    required this.isWeighingMachine,
    this.measurementUnits,
    this.unitType,
    this.gstTaxPercentage,
    this.foodType,
    this.bgColor,
    required this.purchaseCost,
    required this.profitMargin,
    required this.profitMarginPercentage,
    this.priceUpdateDate,
    this.productExpiryDate,
    required this.isVariantInventoryOff,
    required this.familyGroupId,
    required this.isCatering,
    required this.minimumQty,
    this.personText,
    required this.orderBeforeTime,
    required this.orderBeforeDay,
    required this.forDays,
    required this.isCouponNotApplied,
    required this.productKdsDevicesId,
    this.imagePath,
    required this.foodListWithDetails,
    this.brand,
    this.supplier,
    required this.options,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.days,
    required this.showEntryMain,
    required this.showCds,
    required this.gstApplicable,
  });
  late final int id;
  String? oldId;
  late final int ownerId;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  String? imageid;
  late final String price;
  late final String discountprice;
  late final String desc;
  late final int restaurant;
  late final int category;
  late final String ingredients;
  late final String unit;
  late final int packageCount;
  late final int weight;
  late final int canDelivery;
  late final int stars;
  late final int published;
  late final int extras;
  late final int nutritions;
  String? contains;
  late final int sequence;
  late final int soldOut;
  String? images;
  late final int showApp;
  late final int showWeb;
  late final int showPos;
  late final int showQrcode;
  late final int chooseNumberItems;
  late final int isOwnProduct;
  late final int prodQty;
  late final int isTakeAway;
  late final int isHaveInHere;
  late final int inventoryOn;
  late final String prodSku;
  late final String? barcodeType;
  late final String productSegregatePrint;
  late final int isWeighingMachine;
  late final String? measurementUnits;
  late final String? unitType;
  late final int? gstTaxPercentage;
  String? foodType;
  late final String? bgColor;
  late final String purchaseCost;
  late final String profitMargin;
  late final String profitMarginPercentage;
  String? priceUpdateDate;
  String? productExpiryDate;
  late final int isVariantInventoryOff;
  late final int familyGroupId;
  late final int isCatering;
  late final int minimumQty;
  String? personText;
  late final String orderBeforeTime;
  late final String orderBeforeDay;
  late final String forDays;
  late final int isCouponNotApplied;
  late final String productKdsDevicesId;
  String? brand;
  String? supplier;
  late final int options;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? days;
  late final int showEntryMain;
  late final int showCds;
  String? gstApplicable;
  String? imagePath;
  CatOtherDataFoodListWithDetails? foodListWithDetails;

  CatOtherDataFoodList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    oldId = json['old_id']?.toString();
    ownerId = json['owner_id']??0;
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
    name = json['name'];
    imageid = null;
    price = json['price'].toString();
    discountprice = json['discountprice'] ?? '';
    desc = json['desc'] ?? '';
    restaurant = json['restaurant']??0;
    category = json['category']??0;
    ingredients = json['ingredients'] ?? '';
    unit = json['unit']??'';
    packageCount = json['packageCount']??0;
    weight = json['weight']??0;
    canDelivery = json['canDelivery']??0;
    stars = json['stars']??0;
    published = json['published']??0;
    extras = json['extras']??0;
    nutritions = json['nutritions']??0;
    contains = json['contains']?.toString();
    sequence = json['sequence']??0;
    soldOut = json['sold_out'] ?? '';
    images = json['images']?.toString();
    showApp = json['show_app']??0;
    showWeb = json['show_web']??0;
    showPos = json['show_pos']??0;
    showQrcode = json['show_qrcode']??0;
    chooseNumberItems = json['choose_number_items'] ?? '';
    isOwnProduct = json['is_own_product']??0;
    prodQty = json['prod_qty'] ?? 0;
    isTakeAway = json['is_take_away']??0;
    isHaveInHere = json['is_have_in_here']??0;
    inventoryOn = json['inventory_on']??0;
    prodSku = json['prod_sku']??'';
    barcodeType = null;
    productSegregatePrint = json['product_segregate_print']??'';
    isWeighingMachine = json['is_weighing_machine']??0;
    measurementUnits = null;
    unitType = null;
    gstTaxPercentage = null;
    foodType = json['food_type']?.toString();
    bgColor = null;
    purchaseCost = json['purchase_cost']??'';
    profitMargin = json['profit_margin']??'';
    profitMarginPercentage = json['profit_margin_percentage']??'';
    priceUpdateDate = json['price_update_date']?.toString();
    productExpiryDate = json['product_expiry_date']?.toString();
    isVariantInventoryOff = json['is_variant_inventory_off']??0;
    familyGroupId = json['family_group_id']??0;
    isCatering = json['is_catering']??0;
    minimumQty = json['minimum_qty']??0;
    personText = json['person_text']?.toString();
    orderBeforeTime = json['order_before_time']??'';
    orderBeforeDay = json['order_before_day']??'';
    forDays = json['for_days']??'';
    isCouponNotApplied = json['is_coupon_not_applied']??0;
    productKdsDevicesId = json['product_kds_devices_id']??'';
    brand = json['brand']?.toString();
    options = json['options']??0;
    supplier = json['supplier']?.toString();
    startDate = json['start_date']?.toString();
    startTime = json['start_time']?.toString();
    endDate = json['end_date']?.toString();
    endTime = json['end_time']?.toString();
    days = json['days']?.toString();
    showEntryMain = json['show_entry_main']??0;
    showCds = json['show_cds'] ?? 0;
    gstApplicable = json['gst_applicable']?.toString();
    imagePath = json['image_path'];
    foodListWithDetails = json['food_list_with_details'] != null
        ? CatOtherDataFoodListWithDetails.fromJson(json['food_list_with_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['old_id'] = oldId;
    _data['owner_id'] = ownerId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['imageid'] = imageid;
    _data['price'] = price;
    _data['discountprice'] = discountprice;
    _data['desc'] = desc;
    _data['restaurant'] = restaurant;
    _data['category'] = category;
    _data['ingredients'] = ingredients;
    _data['unit'] = unit;
    _data['packageCount'] = packageCount;
    _data['weight'] = weight;
    _data['canDelivery'] = canDelivery;
    _data['stars'] = stars;
    _data['published'] = published;
    _data['extras'] = extras;
    _data['nutritions'] = nutritions;
    _data['contains'] = contains;
    _data['sequence'] = sequence;
    _data['sold_out'] = soldOut;
    _data['images'] = images;
    _data['show_app'] = showApp;
    _data['show_web'] = showWeb;
    _data['show_pos'] = showPos;
    _data['show_qrcode'] = showQrcode;
    _data['choose_number_items'] = chooseNumberItems;
    _data['is_own_product'] = isOwnProduct;
    _data['prod_qty'] = prodQty;
    _data['is_take_away'] = isTakeAway;
    _data['is_have_in_here'] = isHaveInHere;
    _data['inventory_on'] = inventoryOn;
    _data['prod_sku'] = prodSku;
    _data['barcode_type'] = barcodeType;
    _data['product_segregate_print'] = productSegregatePrint;
    _data['is_weighing_machine'] = isWeighingMachine;
    _data['measurement_units'] = measurementUnits;
    _data['unit_type'] = unitType;
    _data['gst_tax_percentage'] = gstTaxPercentage;
    _data['food_type'] = foodType;
    _data['bg_color'] = bgColor;
    _data['purchase_cost'] = purchaseCost;
    _data['profit_margin'] = profitMargin;
    _data['profit_margin_percentage'] = profitMarginPercentage;
    _data['price_update_date'] = priceUpdateDate;
    _data['product_expiry_date'] = productExpiryDate;
    _data['is_variant_inventory_off'] = isVariantInventoryOff;
    _data['family_group_id'] = familyGroupId;
    _data['is_catering'] = isCatering;
    _data['minimum_qty'] = minimumQty;
    _data['person_text'] = personText;
    _data['order_before_time'] = orderBeforeTime;
    _data['order_before_day'] = orderBeforeDay;
    _data['for_days'] = forDays;
    _data['is_coupon_not_applied'] = isCouponNotApplied;
    _data['product_kds_devices_id'] = productKdsDevicesId;
    _data['brand'] = brand;
    _data['supplier'] = supplier;
    _data['options'] = options;
    _data['start_date'] = startDate;
    _data['start_time'] = startTime;
    _data['end_date'] = endDate;
    _data['end_time'] = endTime;
    _data['days'] = days;
    _data['show_entry_main'] = showEntryMain;
    _data['gst_applicable'] = gstApplicable;
    _data['show_cds'] = showCds;
    _data['image_path'] = imagePath;
    _data['food_list_with_details'] = foodListWithDetails != null ? foodListWithDetails!.toJson() : null;
    return _data;
  }
}

class CatOtherDataFoodListWithDetails  {
  CatOtherDataFoodListWithDetails({
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
    required this.bgColor,
    required this.foodBundlePrices,
    required this.isCouponNotApplied,
    required this.familyGroupId,
    required this.showEntryMain,
    required this.gstApplicable,
  });
  late final int id;
  late final String name;
  late final String imagePath;
  late final String price;
  late final String discountprice;
  late final String desc;
  late final int soldOut;
  late final int prodQty;
  late final int isWeighingMachine;
  late final int inventoryOn;
  late final int isVariantInventoryOff;
  late final List<String> ingredients;
  List<CatVariantDataArray>? variantDataArray;
  List<String>? containsData;
  late final String contains;
  late final String foodAddons;
  List<CatAddonsDataArray>? addonsDataArray;
  late final int catId;
  late final String catName;
  late final String unitTypes;
  late final String measurementUnits;
  late final String type;
  late final int makemyown;
  late final int isTakeAway;
  late final int isHaveInHere;
  late final int chooseNumberItems;
  late final int gstTaxPercentage;
  late final String bgColor;
  late final List<dynamic> foodBundlePrices;
  late final int isCouponNotApplied;
  late final int familyGroupId;
  late final int showEntryMain;
  String? gstApplicable;
  CatOtherDataFoodListWithDetails.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imagePath = json['image_path'];
    price = json['price'];
    discountprice = json['discountprice'];
    desc = json['desc'];
    soldOut = json['sold_out'];
    prodQty = json['prod_qty'];
    isWeighingMachine = json['is_weighing_machine'];
    inventoryOn = json['inventory_on'];
    isVariantInventoryOff = json['is_variant_inventory_off'];
    ingredients = List.castFrom<dynamic, String>(json['ingredients']);
    variantDataArray = json['variantDataArray'] != null
        ? (json['variantDataArray'] as List)
        .map((e) => CatVariantDataArray.fromJson(e))
        .toList()
        : [];
    containsData = json['contains_data'] != null
        ? List<String>.from(json['contains_data'])
        : [];
    contains = json['contains'];
    foodAddons = json['food_addons'];
    addonsDataArray = json['addons_data_array'] != null
        ? (json['addons_data_array'] as List)
        .map((e) => CatAddonsDataArray.fromJson(e))
        .toList()
        : [];
    catId = json['cat_id'];
    catName = json['cat_name'];
    unitTypes = json['unit_types'];
    measurementUnits = json['measurement_units'];
    type = json['type'];
    makemyown = json['makemyown'];
    isTakeAway = json['is_take_away'];
    isHaveInHere = json['is_have_in_here'];
    chooseNumberItems = json['choose_number_items'];
    gstTaxPercentage = json['gst_tax_percentage'];
    bgColor = json['bg_color'];
    foodBundlePrices = List.castFrom<dynamic, dynamic>(json['food_bundle_prices']);
    isCouponNotApplied = json['is_coupon_not_applied'];
    familyGroupId = json['family_group_id'] ?? 0;
    showEntryMain = json['show_entry_main'];
    gstApplicable = json['gst_applicable']?.toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image_path'] = imagePath;
    _data['price'] = price;
    _data['discountprice'] = discountprice;
    _data['desc'] = desc;
    _data['sold_out'] = soldOut;
    _data['prod_qty'] = prodQty;
    _data['is_weighing_machine'] = isWeighingMachine;
    _data['inventory_on'] = inventoryOn;
    _data['is_variant_inventory_off'] = isVariantInventoryOff;
    _data['ingredients'] = ingredients;
    _data['variantDataArray'] = variantDataArray!.map((e)=>e.toJson()).toList();
    _data['contains_data'] = containsData;
    _data['contains'] = contains;
    _data['food_addons'] = foodAddons;
    _data['addonsDataArray'] = addonsDataArray;
    _data['cat_id'] = catId;
    _data['cat_name'] = catName;
    _data['unit_types'] = unitTypes;
    _data['measurement_units'] = measurementUnits;
    _data['type'] = type;
    _data['makemyown'] = makemyown;
    _data['is_take_away'] = isTakeAway;
    _data['is_have_in_here'] = isHaveInHere;
    _data['choose_number_items'] = chooseNumberItems;
    _data['gst_tax_percentage'] = gstTaxPercentage;
    _data['bg_color'] = bgColor;
    _data['food_bundle_prices'] = foodBundlePrices;
    _data['is_coupon_not_applied'] = isCouponNotApplied;
    _data['family_group_id'] = familyGroupId;
    _data['show_entry_main'] = showEntryMain;
    _data['gst_applicable'] = gstApplicable;
    return _data;
  }
}

class CatComboData {
  CatComboData({
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
  late final int id;
  late final String name;
  late final String discount;
  late final int noOfItems;
  late final String amount;
  late final String desc;
  late final int showApp;
  late final int showWeb;
  late final int showPos;
  late final int showQrcode;
  late final int deafultProductId;
  late final String deafultProductName;
  late final int allCategory;
  late final List<CatCategoryList> categoryList;
  late final int allFoods;
  late final List<CatHalfNHalfFoodList> foodList;

  CatComboData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    discount = json['discount'];
    noOfItems = json['no_of_items'];
    amount = json['amount'];
    desc = json['desc'];
    showApp = json['show_app'];
    showWeb = json['show_web'];
    showPos = json['show_pos'];
    showQrcode = json['show_qrcode'];
    deafultProductId = json['deafult_product_id'];
    deafultProductName = json['deafult_product_name'];
    allCategory = json['allCategory'];
    categoryList = List.from(json['Category_list']).map((e)=>CatCategoryList.fromJson(e)).toList();
    allFoods = json['allFoods'];
    foodList = List.from(json['food_list']).map((e)=>CatHalfNHalfFoodList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['discount'] = discount;
    _data['no_of_items'] = noOfItems;
    _data['amount'] = amount;
    _data['desc'] = desc;
    _data['show_app'] = showApp;
    _data['show_web'] = showWeb;
    _data['show_pos'] = showPos;
    _data['show_qrcode'] = showQrcode;
    _data['deafult_product_id'] = deafultProductId;
    _data['deafult_product_name'] = deafultProductName;
    _data['allCategory'] = allCategory;
    _data['Category_list'] = categoryList.map((e)=>e.toJson()).toList();
    _data['allFoods'] = allFoods;
    _data['food_list'] = foodList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CatCategoryList{
  CatCategoryList({
    required this.id,
    required this.ownerId,
    required this.oldId,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurantId,
    required this.name,
    required this.imageid,
    required this.sequence,
    required this.desc,
    required this.visible,
    required this.parent,
    required this.type,
    required this.showApp,
    required this.showWeb,
    required this.showPos,
    required this.showQrcode,
    required this.segregatePrint,
    required this.bgColor,
    required this.isCatering,
  });
  late final int id;
  late final int ownerId;
  late final int oldId;
  late final String createdAt;
  late final String updatedAt;
  late final String restaurantId;
  late final String name;
  late final int imageid;
  late final int sequence;
  late final String desc;
  late final int visible;
  late final int parent;
  late final String type;
  late final int showApp;
  late final int showWeb;
  late final int showPos;
  late final int showQrcode;
  late final int segregatePrint;
  late final String bgColor;
  late final int isCatering;

  CatCategoryList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    ownerId = json['owner_id'];
    oldId = json['old_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    restaurantId = json['restaurant_id'];
    name = json['name'];
    imageid = json['imageid'];
    sequence = json['sequence'];
    desc = json['desc'];
    visible = json['visible'];
    parent = json['parent'];
    type = json['type'];
    showApp = json['show_app'];
    showWeb = json['show_web'];
    showPos = json['show_pos'];
    showQrcode = json['show_qrcode'];
    segregatePrint = json['segregate_print'];
    bgColor = json['bg_color'];
    isCatering = json['is_catering'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['owner_id'] = ownerId;
    _data['old_id'] = oldId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['restaurant_id'] = restaurantId;
    _data['name'] = name;
    _data['imageid'] = imageid;
    _data['sequence'] = sequence;
    _data['desc'] = desc;
    _data['visible'] = visible;
    _data['parent'] = parent;
    _data['type'] = type;
    _data['show_app'] = showApp;
    _data['show_web'] = showWeb;
    _data['show_pos'] = showPos;
    _data['show_qrcode'] = showQrcode;
    _data['segregate_print'] = segregatePrint;
    _data['bg_color'] = bgColor;
    _data['is_catering'] = isCatering;
    return _data;
  }
}

class CatHalfNHalfData {
  CatHalfNHalfData({
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
  late final int id;
  late final String name;
  late final String desc;
  late final double offeredPrice;
  late final int thisPrice;
  late final int showApp;
  late final int showWeb;
  late final int showPos;
  late final int showQrcode;
  late final String variant;
  late final int allFoods;
  late final List<CatHalfNHalfFoodList> foodList;
  late final List<dynamic> allBase;

  CatHalfNHalfData.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    offeredPrice = double.parse("${json['offered_price']}");
    thisPrice = json['this_price'];
    showApp = json['show_app'];
    showWeb = json['show_web'];
    showPos = json['show_pos'];
    showQrcode = json['show_qrcode'];
    variant = json['variant'];
    allFoods = json['allFoods'];
    foodList = List.from(json['food_list']).map((e)=>CatHalfNHalfFoodList.fromJson(e)).toList();
    allBase = List.castFrom<dynamic, dynamic>(json['all_base']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['desc'] = desc;
    _data['offered_price'] = offeredPrice;
    _data['this_price'] = thisPrice;
    _data['show_app'] = showApp;
    _data['show_web'] = showWeb;
    _data['show_pos'] = showPos;
    _data['show_qrcode'] = showQrcode;
    _data['variant'] = variant;
    _data['allFoods'] = allFoods;
    _data['food_list'] = foodList.map((e)=>e.toJson()).toList();
    _data['all_base'] = allBase;
    return _data;
  }
}

class CatHalfNHalfFoodList  {
  CatHalfNHalfFoodList({
    required this.id,
    required this.name,
    this.imagePath,
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
  late final int id;
  late final String name;
  String? imagePath;
  late final String price;
  late final String discountprice;
  late final String desc;
  late final int prodQty;
  late final int soldOut;
  late final String ingredients;
  List<CatVariantDataArray>? variantDataArray;
  List<String>? containsData;
  String? contains;
  late final String foodAddons;
  late final List<CatAddonsDataArray> addonsDataArray;
  late final int catId;
  late final String catName;
  late final String type;
  late final int makemyown;
  late final int chooseNumberItems;

  CatHalfNHalfFoodList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    imagePath = json['image_path'];
    price = json['price'].toString();
    discountprice = json['discountprice'];
    desc = json['desc'];
    prodQty = json['prod_qty'];
    soldOut = json['sold_out'];
    ingredients = json['ingredients'];
    variantDataArray = json['variantDataArray'] != null
        ? (json['variantDataArray'] as List)
        .map((e) => CatVariantDataArray.fromJson(e))
        .toList()
        : [];
    containsData = json['contains_data'] != null
        ? List<String>.from(json['contains_data'])
        : [];
    contains = json['contains']?.toString() ?? "";
    foodAddons = json['food_addons']?.toString() ?? "";
    addonsDataArray = json['addonsDataArray'] != null
        ? (json['addonsDataArray'] as List)
        .map((e) => CatAddonsDataArray.fromJson(e))
        .toList()
        : [];
    catId = json['cat_id'] ?? 0;
    catName = json['cat_name']?.toString() ?? "";
    type = json['type']?.toString() ?? "";
    makemyown = json['makemyown'] ?? 0;
    chooseNumberItems = json['choose_number_items'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['image_path'] = imagePath;
    _data['price'] = price;
    _data['discountprice'] = discountprice;
    _data['desc'] = desc;
    _data['prod_qty'] = prodQty;
    _data['sold_out'] = soldOut;
    _data['ingredients'] = ingredients;
    _data['variantDataArray'] = variantDataArray!.map((e)=>e.toJson()).toList();
    _data['contains_data'] = containsData;
    _data['contains'] = contains;
    _data['food_addons'] = foodAddons;
    _data['addonsDataArray'] = addonsDataArray;
    _data['cat_id'] = catId;
    _data['cat_name'] = catName;
    _data['type'] = type;
    _data['makemyown'] = makemyown;
    _data['choose_number_items'] = chooseNumberItems;
    return _data;
  }
}


class CatDealDataList{
  CatDealDataList({
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
  late final int id;
  late final String name;
  late final String amount;
  late final String desc;
  late final int showApp;
  late final int showWeb;
  late final int showPos;
  late final int showQrcode;
  late final List<CatDealData> dealData;

  CatDealDataList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    desc = json['desc'];
    showApp = json['show_app'];
    showWeb = json['show_web'];
    showPos = json['show_pos'];
    showQrcode = json['show_qrcode'];
    dealData = List.from(json['deal_data']).map((e)=>CatDealData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['amount'] = amount;
    _data['desc'] = desc;
    _data['show_app'] = showApp;
    _data['show_web'] = showWeb;
    _data['show_pos'] = showPos;
    _data['show_qrcode'] = showQrcode;
    _data['deal_data'] = dealData.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CatDealData {
  CatDealData({
    required this.numberOfItem,
    required this.category,
    required this.variantName,
    required this.foodList,
    required this.defaultProduct,
  });
  late final String numberOfItem;
  late final String category;
  late final String variantName;
  late final List<CatDealDataFoodList> foodList;
  late final String defaultProduct;

  CatDealData.fromJson(Map<String, dynamic> json){
    numberOfItem = json['number_of_item'];
    category = json['category'];
    variantName = json['variant_name'];
    foodList = List.from(json['food_list']).map((e)=>CatDealDataFoodList.fromJson(e)).toList();
    defaultProduct = json['default_product'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['number_of_item'] = numberOfItem;
    _data['category'] = category;
    _data['variant_name'] = variantName;
    _data['food_list'] = foodList.map((e)=>e.toJson()).toList();
    _data['default_product'] = defaultProduct;
    return _data;
  }
}

class CatDealDataFoodList{
  CatDealDataFoodList({
    required this.id,
    this.oldId,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.imageid,
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
    this.contains,
    required this.sequence,
    required this.soldOut,
    this.images,
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
    this.barcodeType,
    required this.productSegregatePrint,
    required this.isWeighingMachine,
    this.measurementUnits,
    this.unitType,
    this.gstTaxPercentage,
    this.foodType,
    this.bgColor,
    required this.purchaseCost,
    required this.profitMargin,
    required this.profitMarginPercentage,
    this.priceUpdateDate,
    this.productExpiryDate,
    required this.isVariantInventoryOff,
    required this.familyGroupId,
    required this.isCatering,
    required this.minimumQty,
    this.personText,
    required this.orderBeforeTime,
    required this.orderBeforeDay,
    required this.forDays,
    required this.isCouponNotApplied,
    required this.productKdsDevicesId,
    this.brand,
    this.supplier,
    required this.options,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.days,
    required this.showEntryMain,
    required this.showCds,
    required this.gstApplicable,
  });
  late final int id;
  String? oldId;
  late final int ownerId;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final Null imageid;
  late final String price;
  late final String discountprice;
  late final String desc;
  late final int restaurant;
  late final int category;
  late final String ingredients;
  late final String unit;
  late final int packageCount;
  late final int weight;
  late final int canDelivery;
  late final int stars;
  late final int published;
  late final int extras;
  late final int nutritions;
  String? contains;
  late final int sequence;
  late final int soldOut;
  String? images;
  late final int showApp;
  late final int showWeb;
  late final int showPos;
  late final int showQrcode;
  late final int chooseNumberItems;
  late final int isOwnProduct;
  late final int prodQty;
  late final int isTakeAway;
  late final int isHaveInHere;
  late final int inventoryOn;
  late final String prodSku;
  late final String? barcodeType;
  late final String productSegregatePrint;
  late final int isWeighingMachine;
  late final String? measurementUnits;
  late final String? unitType;
  late final int? gstTaxPercentage;
  String? foodType;
  late final String? bgColor;
  late final String purchaseCost;
  late final String profitMargin;
  late final String profitMarginPercentage;
  String? priceUpdateDate;
  String? productExpiryDate;
  late final int isVariantInventoryOff;
  late final int familyGroupId;
  late final int isCatering;
  late final int minimumQty;
  String? personText;
  late final String orderBeforeTime;
  late final String orderBeforeDay;
  late final String forDays;
  late final int isCouponNotApplied;
  late final String productKdsDevicesId;
  String? brand;
  String? supplier;
  late final int options;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? days;
  late final int showEntryMain;
  late final int showCds;
  String? gstApplicable;

  CatDealDataFoodList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    oldId = json['old_id']?.toString();
    ownerId = json['owner_id']??0;
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
    name = json['name'];
    imageid = null;
    price = json['price'].toString();
    discountprice = json['discountprice'];
    desc = json['desc'];
    restaurant = json['restaurant']??0;
    category = json['category']??0;
    ingredients = json['ingredients'];
    unit = json['unit']??'';
    packageCount = json['packageCount']??0;
    weight = json['weight']??0;
    canDelivery = json['canDelivery']??0;
    stars = json['stars']??0;
    published = json['published']??0;
    extras = json['extras']??0;
    nutritions = json['nutritions']??0;
    contains = json['contains']?.toString();
    sequence = json['sequence']??0;
    soldOut = json['sold_out'];
    images = json['images']?.toString();
    showApp = json['show_app']??0;
    showWeb = json['show_web']??0;
    showPos = json['show_pos']??0;
    showQrcode = json['show_qrcode']??0;
    chooseNumberItems = json['choose_number_items'];
    isOwnProduct = json['is_own_product']??0;
    prodQty = json['prod_qty'];
    isTakeAway = json['is_take_away']??0;
    isHaveInHere = json['is_have_in_here']??0;
    inventoryOn = json['inventory_on']??0;
    prodSku = json['prod_sku']??'';
    barcodeType = null;
    productSegregatePrint = json['product_segregate_print']??'';
    isWeighingMachine = json['is_weighing_machine']??0;
    measurementUnits = null;
    unitType = null;
    gstTaxPercentage = null;
    foodType = json['food_type']?.toString();
    bgColor = null;
    purchaseCost = json['purchase_cost']??'';
    profitMargin = json['profit_margin']??'';
    profitMarginPercentage = json['profit_margin_percentage']??'';
    priceUpdateDate = json['price_update_date']?.toString();
    productExpiryDate = json['product_expiry_date']?.toString();
    isVariantInventoryOff = json['is_variant_inventory_off']??0;
    familyGroupId = json['family_group_id']??0;
    isCatering = json['is_catering']??0;
    minimumQty = json['minimum_qty']??0;
    personText = json['person_text']?.toString();
    orderBeforeTime = json['order_before_time']??'';
    orderBeforeDay = json['order_before_day']??'';
    forDays = json['for_days']??'';
    isCouponNotApplied = json['is_coupon_not_applied']??0;
    productKdsDevicesId = json['product_kds_devices_id']??'';
    brand = json['brand']?.toString();
    supplier = json['supplier']?.toString();
    options = json['options']??0;
    startDate = json['start_date']?.toString();
    startTime = json['start_time']?.toString();
    endDate = json['end_date']?.toString();
    endTime = json['end_time']?.toString();
    days = json['days']?.toString();
    showEntryMain = json['show_entry_main']??0;
    showCds = json['show_cds'] ?? 0;
    gstApplicable = json['gst_applicable']?.toString();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['old_id'] = oldId;
    _data['owner_id'] = ownerId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['imageid'] = imageid;
    _data['price'] = price;
    _data['discountprice'] = discountprice;
    _data['desc'] = desc;
    _data['restaurant'] = restaurant;
    _data['category'] = category;
    _data['ingredients'] = ingredients;
    _data['unit'] = unit;
    _data['packageCount'] = packageCount;
    _data['weight'] = weight;
    _data['canDelivery'] = canDelivery;
    _data['stars'] = stars;
    _data['published'] = published;
    _data['extras'] = extras;
    _data['nutritions'] = nutritions;
    _data['contains'] = contains;
    _data['sequence'] = sequence;
    _data['sold_out'] = soldOut;
    _data['images'] = images;
    _data['show_app'] = showApp;
    _data['show_web'] = showWeb;
    _data['show_pos'] = showPos;
    _data['show_qrcode'] = showQrcode;
    _data['choose_number_items'] = chooseNumberItems;
    _data['is_own_product'] = isOwnProduct;
    _data['prod_qty'] = prodQty;
    _data['is_take_away'] = isTakeAway;
    _data['is_have_in_here'] = isHaveInHere;
    _data['inventory_on'] = inventoryOn;
    _data['prod_sku'] = prodSku;
    _data['barcode_type'] = barcodeType;
    _data['product_segregate_print'] = productSegregatePrint;
    _data['is_weighing_machine'] = isWeighingMachine;
    _data['measurement_units'] = measurementUnits;
    _data['unit_type'] = unitType;
    _data['gst_tax_percentage'] = gstTaxPercentage;
    _data['food_type'] = foodType;
    _data['bg_color'] = bgColor;
    _data['purchase_cost'] = purchaseCost;
    _data['profit_margin'] = profitMargin;
    _data['profit_margin_percentage'] = profitMarginPercentage;
    _data['price_update_date'] = priceUpdateDate;
    _data['product_expiry_date'] = productExpiryDate;
    _data['is_variant_inventory_off'] = isVariantInventoryOff;
    _data['family_group_id'] = familyGroupId;
    _data['is_catering'] = isCatering;
    _data['minimum_qty'] = minimumQty;
    _data['person_text'] = personText;
    _data['order_before_time'] = orderBeforeTime;
    _data['order_before_day'] = orderBeforeDay;
    _data['for_days'] = forDays;
    _data['is_coupon_not_applied'] = isCouponNotApplied;
    _data['product_kds_devices_id'] = productKdsDevicesId;
    _data['brand'] = brand;
    _data['supplier'] = supplier;
    _data['options'] = options;
    _data['start_date'] = startDate;
    _data['start_time'] = startTime;
    _data['end_date'] = endDate;
    _data['end_time'] = endTime;
    _data['days'] = days;
    _data['show_entry_main'] = showEntryMain;
    _data['show_cds'] = showCds;
    _data['gst_applicable'] = gstApplicable;
    return _data;
  }
}

class CatSpecialDealData{
  CatSpecialDealData({
    required this.numberOfItem,
    required this.category,
    required this.categoryId,
    required this.variantName,
    required this.variantId,
    required this.selectedVariantList,
    required this.foodList,
    required this.defaultProduct,
  });

  late final String numberOfItem;

  late final String category;

  late final String categoryId;

  late final String variantName;

  late final String variantId;

  late final List<dynamic> selectedVariantList;

  late final List<CatSpecialDealDataFoodList> foodList;

  late final String defaultProduct;

  CatSpecialDealData.fromJson(Map<String, dynamic> json) {
    numberOfItem = json['number_of_item'] ?? '';
    category = json['category'] ?? '';
    categoryId = json['category_id']?.toString() ?? '';
    variantName = json['variant_name'] ?? '';
    variantId = json['variant_id'] ?? '';
    selectedVariantList = json['selected_variant_list'] ?? [];
    foodList = (json['food_list'] as List<dynamic>? ?? [])
        .map((e) => CatSpecialDealDataFoodList.fromJson(e))
        .toList();
    defaultProduct = json['default_product'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['number_of_item'] = numberOfItem;
    data['category'] = category;
    data['category_id'] = categoryId;
    data['variant_name'] = variantName;
    data['variant_id'] = variantId;
    data['selected_variant_list'] = selectedVariantList;
    data['food_list'] = foodList.map((e) => e.toJson()).toList();
    data['default_product'] = defaultProduct;
    return data;
  }
}

class CatSpecialDealDataFoodList {
  CatSpecialDealDataFoodList({
    required this.id,
    this.oldId,
    required this.ownerId,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
    this.imageid,
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
    this.contains,
    required this.sequence,
    required this.soldOut,
    this.images,
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
    this.barcodeType,
    required this.productSegregatePrint,
    required this.isWeighingMachine,
    this.measurementUnits,
    this.unitType,
    this.gstTaxPercentage,
    this.foodType,
    this.bgColor,
    required this.purchaseCost,
    required this.profitMargin,
    required this.profitMarginPercentage,
    this.priceUpdateDate,
    this.productExpiryDate,
    required this.isVariantInventoryOff,
    required this.familyGroupId,
    required this.isCatering,
    required this.minimumQty,
    this.personText,
    required this.orderBeforeTime,
    required this.orderBeforeDay,
    required this.forDays,
    required this.isCouponNotApplied,
    required this.productKdsDevicesId,
    this.brand,
    this.supplier,
    required this.options,
    this.startDate,
    this.startTime,
    this.endDate,
    this.endTime,
    this.days,
    required this.showEntryMain,
    required this.showCds,
    required this.gstApplicable,
    required this.addonsDataArray,
    required this.variantDataArray,
    required this.containsData,
    required this.foodAddons,
    required this.specialDealVariantName,
    required this.specialDealVariantId,
  });
  late final int id;
  String? oldId;
  late final int ownerId;
  late final String createdAt;
  late final String updatedAt;
  late final String name;
  late final Null imageid;
  late final String price;
  late final String discountprice;
  late final String desc;
  late final int restaurant;
  late final int category;
  late final String ingredients;
  late final String unit;
  late final int packageCount;
  late final int weight;
  late final int canDelivery;
  late final int stars;
  late final int published;
  late final int extras;
  late final int nutritions;
  String? contains;
  late final int sequence;
  late final int soldOut;
  String? images;
  late final int showApp;
  late final int showWeb;
  late final int showPos;
  late final int showQrcode;
  late final int chooseNumberItems;
  late final int isOwnProduct;
  late final int prodQty;
  late final int isTakeAway;
  late final int isHaveInHere;
  late final int inventoryOn;
  late final String prodSku;
  late final String? barcodeType;
  late final String productSegregatePrint;
  late final int isWeighingMachine;
  late final String? measurementUnits;
  late final String? unitType;
  late final int? gstTaxPercentage;
  String? foodType;
  late final String? bgColor;
  late final String purchaseCost;
  late final String profitMargin;
  late final String profitMarginPercentage;
  String? priceUpdateDate;
  String? productExpiryDate;
  late final int isVariantInventoryOff;
  late final int familyGroupId;
  late final int isCatering;
  late final int minimumQty;
  String? personText;
  late final String orderBeforeTime;
  late final String orderBeforeDay;
  late final String forDays;
  late final int isCouponNotApplied;
  late final String productKdsDevicesId;
  String? brand;
  String? supplier;
  late final int options;
  String? startDate;
  String? startTime;
  String? endDate;
  String? endTime;
  String? days;
  late final int showEntryMain;
  late final int showCds;
  String? gstApplicable;
  List<CatVariantDataArray>? variantDataArray;
  List<CatAddonsDataArray>? addonsDataArray;
  List<String>? containsData;
  late final String foodAddons;
  late final String specialDealVariantName;
  late final int specialDealVariantId;

  CatSpecialDealDataFoodList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    oldId = json['old_id']?.toString();
    ownerId = json['owner_id']??0;
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
    name = json['name'];
    imageid = null;
    price = json['price'].toString();
    discountprice = json['discountprice'];
    desc = json['desc'];
    restaurant = json['restaurant']??0;
    category = json['category']??0;
    ingredients = json['ingredients'];
    unit = json['unit']??'';
    packageCount = json['packageCount']??0;
    weight = json['weight']??0;
    canDelivery = json['canDelivery']??0;
    stars = json['stars']??0;
    published = json['published']??0;
    extras = json['extras']??0;
    nutritions = json['nutritions']??0;
    contains = json['contains']?.toString();
    sequence = json['sequence']??0;
    soldOut = json['sold_out'];
    images = json['images']?.toString();
    showApp = json['show_app']??0;
    showWeb = json['show_web']??0;
    showPos = json['show_pos']??0;
    showQrcode = json['show_qrcode']??0;
    chooseNumberItems = json['choose_number_items'];
    isOwnProduct = json['is_own_product']??0;
    prodQty = json['prod_qty'];
    isTakeAway = json['is_take_away']??0;
    isHaveInHere = json['is_have_in_here']??0;
    inventoryOn = json['inventory_on']??0;
    prodSku = json['prod_sku']??'';
    barcodeType = null;
    productSegregatePrint = json['product_segregate_print']??'';
    isWeighingMachine = json['is_weighing_machine']??0;
    measurementUnits = null;
    unitType = null;
    gstTaxPercentage = null;
    foodType = json['food_type']?.toString();
    bgColor = null;
    purchaseCost = json['purchase_cost']??'';
    profitMargin = json['profit_margin']??'';
    profitMarginPercentage = json['profit_margin_percentage']??'';
    priceUpdateDate = json['price_update_date']?.toString();
    productExpiryDate = json['product_expiry_date']?.toString();
    isVariantInventoryOff = json['is_variant_inventory_off']??0;
    familyGroupId = json['family_group_id']??0;
    isCatering = json['is_catering']??0;
    minimumQty = json['minimum_qty']??0;
    personText = json['person_text']?.toString();
    orderBeforeTime = json['order_before_time']??'';
    orderBeforeDay = json['order_before_day']??'';
    forDays = json['for_days']??'';
    isCouponNotApplied = json['is_coupon_not_applied']??0;
    productKdsDevicesId = json['product_kds_devices_id']??'';
    brand = json['brand']?.toString();
    supplier = json['supplier']?.toString();
    options = json['options']??0;
    startDate = json['start_date']?.toString();
    startTime = json['start_time']?.toString();
    endDate = json['end_date']?.toString();
    endTime = json['end_time']?.toString();
    days = json['days']?.toString();
    showEntryMain = json['show_entry_main']??0;
    showCds = json['show_cds'] ?? 0;
    gstApplicable = json['gst_applicable']?.toString();
    variantDataArray = json['variantDataArray'] != null
        ? (json['variantDataArray'] as List)
        .map((e) => CatVariantDataArray.fromJson(e))
        .toList()
        : [];
    addonsDataArray = json['addons_data_array'] != null
        ? (json['addons_data_array'] as List)
        .map((e) => CatAddonsDataArray.fromJson(e))
        .toList()
        : [];
    containsData = json['contains_data'] != null
        ? List<String>.from(json['contains_data'])
        : [];
    foodAddons = json['food_addons'] ?? "";
    specialDealVariantName = json['special_deal_variats_name'] ?? "";
    specialDealVariantId = json['special_deal_variats_id'] ?? 0;

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['old_id'] = oldId;
    _data['owner_id'] = ownerId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['name'] = name;
    _data['imageid'] = imageid;
    _data['price'] = price;
    _data['discountprice'] = discountprice;
    _data['desc'] = desc;
    _data['restaurant'] = restaurant;
    _data['category'] = category;
    _data['ingredients'] = ingredients;
    _data['unit'] = unit;
    _data['packageCount'] = packageCount;
    _data['weight'] = weight;
    _data['canDelivery'] = canDelivery;
    _data['stars'] = stars;
    _data['published'] = published;
    _data['extras'] = extras;
    _data['nutritions'] = nutritions;
    _data['contains'] = contains;
    _data['sequence'] = sequence;
    _data['sold_out'] = soldOut;
    _data['images'] = images;
    _data['show_app'] = showApp;
    _data['show_web'] = showWeb;
    _data['show_pos'] = showPos;
    _data['show_qrcode'] = showQrcode;
    _data['choose_number_items'] = chooseNumberItems;
    _data['is_own_product'] = isOwnProduct;
    _data['prod_qty'] = prodQty;
    _data['is_take_away'] = isTakeAway;
    _data['is_have_in_here'] = isHaveInHere;
    _data['inventory_on'] = inventoryOn;
    _data['prod_sku'] = prodSku;
    _data['barcode_type'] = barcodeType;
    _data['product_segregate_print'] = productSegregatePrint;
    _data['is_weighing_machine'] = isWeighingMachine;
    _data['measurement_units'] = measurementUnits;
    _data['unit_type'] = unitType;
    _data['gst_tax_percentage'] = gstTaxPercentage;
    _data['food_type'] = foodType;
    _data['bg_color'] = bgColor;
    _data['purchase_cost'] = purchaseCost;
    _data['profit_margin'] = profitMargin;
    _data['profit_margin_percentage'] = profitMarginPercentage;
    _data['price_update_date'] = priceUpdateDate;
    _data['product_expiry_date'] = productExpiryDate;
    _data['is_variant_inventory_off'] = isVariantInventoryOff;
    _data['family_group_id'] = familyGroupId;
    _data['is_catering'] = isCatering;
    _data['minimum_qty'] = minimumQty;
    _data['person_text'] = personText;
    _data['order_before_time'] = orderBeforeTime;
    _data['order_before_day'] = orderBeforeDay;
    _data['for_days'] = forDays;
    _data['is_coupon_not_applied'] = isCouponNotApplied;
    _data['product_kds_devices_id'] = productKdsDevicesId;
    _data['brand'] = brand;
    _data['supplier'] = supplier;
    _data['options'] = options;
    _data['start_date'] = startDate;
    _data['start_time'] = startTime;
    _data['end_date'] = endDate;
    _data['end_time'] = endTime;
    _data['days'] = days;
    _data['show_entry_main'] = showEntryMain;
    _data['show_cds'] = showCds;
    _data['gst_applicable'] = gstApplicable;
    _data['variantDataArray'] = variantDataArray!.map((e)=>e.toJson()).toList();
    _data['addonsDataArray'] = addonsDataArray;
    _data['contains_data'] = containsData;
    _data['food_addons'] = foodAddons;
    _data['special_deal_variats_name'] = specialDealVariantName;
    _data['special_deal_variats_id'] = specialDealVariantId;
    return _data;
  }
}

class CatSpecialDealDataList  {
  CatSpecialDealDataList({
    required this.id,
    required this.name,
    required this.amount,
    required this.desc,
    required this.showApp,
    required this.showWeb,
    required this.showPos,
    required this.showQrcode,
    required this.dealData,
    required this.options,
    this.startDate,
    this.startTime,
    this.endTime,
    this.days,
  });

  late int id;

  late String name;

  late String amount;

  late String desc;

  late int showApp;

  late int showWeb;

  late int showPos;

  late int showQrcode;

  late List<CatSpecialDealData> dealData;

  late int options;

  String? startDate;

  String? startTime;

  String? endTime;

  String? days;

  CatSpecialDealDataList.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name']?.toString() ?? "";
    amount = json['amount']?.toString() ?? "";
    desc = json['desc']?.toString() ?? "";
    showApp = json['show_app'] ?? 0;
    showWeb = json['show_web'] ?? 0;
    showPos = json['show_pos'] ?? 0;
    showQrcode = json['show_qrcode'] ?? 0;
    var dealDataJson = json['deal_data'];
    if (dealDataJson is List) {
      dealData = dealDataJson
          .map((e) => CatSpecialDealData.fromJson(e))
          .toList();
    } else {
      dealData = [];
    }

    options = json['options'] ?? 0;

    startDate = json['start_date']?.toString();
    startTime = json['start_time']?.toString();
    endTime = json['end_time']?.toString();
    days = json['days']?.toString();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'desc': desc,
      'show_app': showApp,
      'show_web': showWeb,
      'show_pos': showPos,
      'show_qrcode': showQrcode,
      'deal_data': dealData.map((e) => e.toJson()).toList(),
      'options': options,
      'start_date': startDate,
      'start_time': startTime,
      'end_time': endTime,
      'days': days,
    };
  }
}

class CatVariantDataArray {
  CatVariantDataArray({
    required this.variantName,
    required this.variantDetail,
  });
  late final String variantName;
  late final List<CatVariantDetail> variantDetail;

  CatVariantDataArray.fromJson(Map<String, dynamic> json){
    variantName = json['variant_name'];
    variantDetail = List.from(json['variant_detail']).map((e)=>CatVariantDetail.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['variant_name'] = variantName;
    _data['variant_detail'] = variantDetail.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class CatVariantDetail {
  CatVariantDetail({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.food,
    required this.name,
    required this.variantType,
    required this.imageid,
    required this.prod_qty,
    required this.price,
    required this.dprice,
  });
  late final int id;
  late final String createdAt;
  late final String updatedAt;
  late final int food;
  late final String name;
  late final String variantType;
  late final int imageid;
  late final int prod_qty;
  late final String price;
  late final String dprice;

  CatVariantDetail.fromJson(Map<String, dynamic> json){
    id = json['id'];
    createdAt = json['created_at']??'';
    updatedAt = json['updated_at']??'';
    food = json['food'] ?? 0;
    prod_qty = json['prod_qty'] ?? 0;
    name = json['name']?? "";
    variantType = json['variant_type'] ?? "";
    imageid = json['imageid'] ?? 0;
    price = json['price'] ?? "";
    dprice = json['dprice'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['food'] = food;
    _data['name'] = name;
    _data['variant_type'] = variantType;
    _data['imageid'] = imageid;
    _data['price'] = price;
    _data['dprice'] = dprice;
    return _data;
  }
}

class CatAddonsDataArray  {
  CatAddonsDataArray({
    this.addonsName,
    this.addonsPrice,
    this.addonsId,
  });
  String? addonsName;
  String ?addonsPrice;
  int? addonsId;

  CatAddonsDataArray.fromJson(Map<String, dynamic> json){
    addonsName = json['addons_name'] ?? "";
    addonsPrice = json['addons_price'] ?? "";
    addonsId = json['addons_id'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['addons_name'] = addonsName;
    _data['addons_price'] = addonsPrice;
    _data['addons_id'] = addonsId;
    return _data;
  }
}