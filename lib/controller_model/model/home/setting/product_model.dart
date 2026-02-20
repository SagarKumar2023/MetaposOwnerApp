class ProductModel {
  String? error;
  String? message;
  List<Data>? data;

  ProductModel({this.error, this.message, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
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
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? oldId;
  int? ownerId;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? imageid;
  String? price;
  String? discountprice;
  String? desc;
  int? restaurant;
  int? category;
  String? ingredients;
  String? unit;
  int? packageCount;
  int? weight;
  int? canDelivery;
  int? stars;
  int? published;
  int? extras;
  int? nutritions;
  String? contains;
  int? sequence;
  int? soldOut;
  Null? images;
  int? showApp;
  int? showWeb;
  int? showPos;
  int? showQrcode;
  int? chooseNumberItems;
  int? isOwnProduct;
  int? prodQty;
  int? isTakeAway;
  int? isHaveInHere;
  int? inventoryOn;
  String? prodSku;
  String? barcodeType;
  String? productSegregatePrint;
  int? isWeighingMachine;
  String? measurementUnits;
  String? unitType;
  int? gstTaxPercentage;
  String? foodType;
  String? bgColor;
  String? purchaseCost;
  String? profitMargin;
  String? profitMarginPercentage;
  String? priceUpdateDate;
  String? productExpiryDate;
  int? isVariantInventoryOff;
  int? familyGroupId;
  int? isCatering;
  int? minimumQty;
  String? personText;
  int? isCouponNotApplied;
  String? orderBeforeTime;
  String? orderBeforeDay;
  String? forDays;
  String? productKdsDevicesId;
  Null? brand;
  String? supplier;
  int? showEntryMain;
  int? showCds;
  String? gstApplicable;
  String? variantName;
  int? variantId;
  String? variantPrice;
  String? catName;
  String? productType;
  String? variantProdSku;
  List<FoodBundlePrices>? foodBundlePrices;

  Data(
      {this.id,
        this.oldId,
        this.ownerId,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.imageid,
        this.price,
        this.discountprice,
        this.desc,
        this.restaurant,
        this.category,
        this.ingredients,
        this.unit,
        this.packageCount,
        this.weight,
        this.canDelivery,
        this.stars,
        this.published,
        this.extras,
        this.nutritions,
        this.contains,
        this.sequence,
        this.soldOut,
        this.images,
        this.showApp,
        this.showWeb,
        this.showPos,
        this.showQrcode,
        this.chooseNumberItems,
        this.isOwnProduct,
        this.prodQty,
        this.isTakeAway,
        this.isHaveInHere,
        this.inventoryOn,
        this.prodSku,
        this.barcodeType,
        this.productSegregatePrint,
        this.isWeighingMachine,
        this.measurementUnits,
        this.unitType,
        this.gstTaxPercentage,
        this.foodType,
        this.bgColor,
        this.purchaseCost,
        this.profitMargin,
        this.profitMarginPercentage,
        this.priceUpdateDate,
        this.productExpiryDate,
        this.isVariantInventoryOff,
        this.familyGroupId,
        this.isCatering,
        this.minimumQty,
        this.personText,
        this.isCouponNotApplied,
        this.orderBeforeTime,
        this.orderBeforeDay,
        this.forDays,
        this.productKdsDevicesId,
        this.brand,
        this.supplier,
        this.showEntryMain,
        this.showCds,
        this.gstApplicable,
        this.variantName,
        this.variantId,
        this.variantPrice,
        this.catName,
        this.productType,
        this.variantProdSku,
        this.foodBundlePrices});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldId = json['old_id'];
    ownerId = json['owner_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    imageid = json['imageid'];
    price = json['price'];
    discountprice = json['discountprice'];
    desc = json['desc'];
    restaurant = json['restaurant'];
    category = json['category'];
    ingredients = json['ingredients'];
    unit = json['unit'];
    packageCount = json['packageCount'];
    weight = json['weight'];
    canDelivery = json['canDelivery'];
    stars = json['stars'];
    published = json['published'];
    extras = json['extras'];
    nutritions = json['nutritions'];
    contains = json['contains'];
    sequence = json['sequence'];
    soldOut = json['sold_out'];
    images = json['images'];
    showApp = json['show_app'];
    showWeb = json['show_web'];
    showPos = json['show_pos'];
    showQrcode = json['show_qrcode'];
    chooseNumberItems = json['choose_number_items'];
    isOwnProduct = json['is_own_product'];
    prodQty = json['prod_qty'];
    isTakeAway = json['is_take_away'];
    isHaveInHere = json['is_have_in_here'];
    inventoryOn = json['inventory_on'];
    prodSku = json['prod_sku'];
    barcodeType = json['barcode_type'];
    productSegregatePrint = json['product_segregate_print'];
    isWeighingMachine = json['is_weighing_machine'];
    measurementUnits = json['measurement_units'];
    unitType = json['unit_type'];
    gstTaxPercentage = json['gst_tax_percentage'];
    foodType = json['food_type'];
    bgColor = json['bg_color'];
    purchaseCost = json['purchase_cost'];
    profitMargin = json['profit_margin'];
    profitMarginPercentage = json['profit_margin_percentage'];
    priceUpdateDate = json['price_update_date'];
    productExpiryDate = json['product_expiry_date'];
    isVariantInventoryOff = json['is_variant_inventory_off'];
    familyGroupId = json['family_group_id'];
    isCatering = json['is_catering'];
    minimumQty = json['minimum_qty'];
    personText = json['person_text'];
    isCouponNotApplied = json['is_coupon_not_applied'];
    orderBeforeTime = json['order_before_time'];
    orderBeforeDay = json['order_before_day'];
    forDays = json['for_days'];
    productKdsDevicesId = json['product_kds_devices_id'];
    brand = json['brand'];
    supplier = json['supplier'];
    showEntryMain = json['show_entry_main'];
    showCds = json['show_cds'];
    gstApplicable = json['gst_applicable'];
    variantName = json['variant_name'];
    variantId = json['variant_id'];
    variantPrice = json['variant_price'];
    catName = json['cat_name'];
    productType = json['product_type'];
    variantProdSku = json['variant_prod_sku'];
    if (json['food_bundle_prices'] != null) {
      foodBundlePrices = <FoodBundlePrices>[];
      json['food_bundle_prices'].forEach((v) {
        foodBundlePrices!.add(new FoodBundlePrices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_id'] = this.oldId;
    data['owner_id'] = this.ownerId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['imageid'] = this.imageid;
    data['price'] = this.price;
    data['discountprice'] = this.discountprice;
    data['desc'] = this.desc;
    data['restaurant'] = this.restaurant;
    data['category'] = this.category;
    data['ingredients'] = this.ingredients;
    data['unit'] = this.unit;
    data['packageCount'] = this.packageCount;
    data['weight'] = this.weight;
    data['canDelivery'] = this.canDelivery;
    data['stars'] = this.stars;
    data['published'] = this.published;
    data['extras'] = this.extras;
    data['nutritions'] = this.nutritions;
    data['contains'] = this.contains;
    data['sequence'] = this.sequence;
    data['sold_out'] = this.soldOut;
    data['images'] = this.images;
    data['show_app'] = this.showApp;
    data['show_web'] = this.showWeb;
    data['show_pos'] = this.showPos;
    data['show_qrcode'] = this.showQrcode;
    data['choose_number_items'] = this.chooseNumberItems;
    data['is_own_product'] = this.isOwnProduct;
    data['prod_qty'] = this.prodQty;
    data['is_take_away'] = this.isTakeAway;
    data['is_have_in_here'] = this.isHaveInHere;
    data['inventory_on'] = this.inventoryOn;
    data['prod_sku'] = this.prodSku;
    data['barcode_type'] = this.barcodeType;
    data['product_segregate_print'] = this.productSegregatePrint;
    data['is_weighing_machine'] = this.isWeighingMachine;
    data['measurement_units'] = this.measurementUnits;
    data['unit_type'] = this.unitType;
    data['gst_tax_percentage'] = this.gstTaxPercentage;
    data['food_type'] = this.foodType;
    data['bg_color'] = this.bgColor;
    data['purchase_cost'] = this.purchaseCost;
    data['profit_margin'] = this.profitMargin;
    data['profit_margin_percentage'] = this.profitMarginPercentage;
    data['price_update_date'] = this.priceUpdateDate;
    data['product_expiry_date'] = this.productExpiryDate;
    data['is_variant_inventory_off'] = this.isVariantInventoryOff;
    data['family_group_id'] = this.familyGroupId;
    data['is_catering'] = this.isCatering;
    data['minimum_qty'] = this.minimumQty;
    data['person_text'] = this.personText;
    data['is_coupon_not_applied'] = this.isCouponNotApplied;
    data['order_before_time'] = this.orderBeforeTime;
    data['order_before_day'] = this.orderBeforeDay;
    data['for_days'] = this.forDays;
    data['product_kds_devices_id'] = this.productKdsDevicesId;
    data['brand'] = this.brand;
    data['supplier'] = this.supplier;
    data['show_entry_main'] = this.showEntryMain;
    data['show_cds'] = this.showCds;
    data['gst_applicable'] = this.gstApplicable;
    data['variant_name'] = this.variantName;
    data['variant_id'] = this.variantId;
    data['variant_price'] = this.variantPrice;
    data['cat_name'] = this.catName;
    data['product_type'] = this.productType;
    data['variant_prod_sku'] = this.variantProdSku;
    if (this.foodBundlePrices != null) {
      data['food_bundle_prices'] =
          this.foodBundlePrices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodBundlePrices {
  int? id;
  int? foodId;
  String? qty;
  String? price;

  FoodBundlePrices({this.id, this.foodId, this.qty, this.price});

  FoodBundlePrices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodId = json['food_id'];
    qty = json['qty'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_id'] = this.foodId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    return data;
  }
}
