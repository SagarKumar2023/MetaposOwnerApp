import 'dart:convert';

class LoginModel {
  int? error;
  User? user;
  List<RestaurantsList>? restaurantsList;
  String? accessToken;
  int? notify;

  LoginModel(
      {this.error,
        this.user,
        this.restaurantsList,
        this.accessToken,
        this.notify});

  LoginModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['restaurants_list'] != null) {
      restaurantsList = <RestaurantsList>[];
      json['restaurants_list'].forEach((v) {
        restaurantsList!.add(new RestaurantsList.fromJson(v));
      });
    }

    accessToken = json['access_token'];
    notify = json['notify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.restaurantsList != null) {
      data['restaurants_list'] =
          this.restaurantsList!.map((v) => v.toJson()).toList();
    }
    data['access_token'] = this.accessToken;
    data['notify'] = this.notify;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? address;
  String? phone;

  User({this.id, this.name, this.email, this.address, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    name = json['name']??"";
    email = json['email']??"";
    address = json['address']??"";
    phone = json['phone']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['phone'] = this.phone;
    return data;
  }
}

class RestaurantsList {
  int? id;
  String? createdAt;
  String? updatedAt;
  String? name;
  int? published;
  int? delivered;
  String? phone;
  String? mobilephone;
  String? address;
  String? lat;
  String? lng;
  int? imageid;
  String? desc;
  String? fee;
  int? percent;
  String? openTimeMonday;
  String? closeTimeMonday;
  String? openTimeTuesday;
  String? closeTimeTuesday;
  String? openTimeWednesday;
  String? closeTimeWednesday;
  String? openTimeThursday;
  String? closeTimeThursday;
  String? openTimeFriday;
  String? closeTimeFriday;
  String? openTimeSaturday;
  String? closeTimeSaturday;
  String? openTimeSunday;
  String? closeTimeSunday;
  int? area;
  String? minAmount;
  int? perkm;
  Null? city;
  String? rstOrderTakeStatus;
  int? ownerId;
  String? websiteUrl;
  String? email;
  Null? restCode;
  int? shipingFreeOrderAmount;
  int? acceptAnyTimeOrder;
  String? homeId;
  int? headerId;
  int? footerId;
  String? totalDaysOpenInWeek;
  String? businessCode;
  int? sslEnable;
  int? isOpenSunday;
  int? isOpenMonday;
  int? isOpenTuesday;
  int? isOpenWednesday;
  int? isOpenThursday;
  int? isOpenFriday;
  int? isOpenSaturday;
  int? isLandingPage;
  int? isMutipleTimings;

  RestaurantsList(
      {this.id,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.published,
        this.delivered,
        this.phone,
        this.mobilephone,
        this.address,
        this.lat,
        this.lng,
        this.imageid,
        this.desc,
        this.fee,
        this.percent,
        this.openTimeMonday,
        this.closeTimeMonday,
        this.openTimeTuesday,
        this.closeTimeTuesday,
        this.openTimeWednesday,
        this.closeTimeWednesday,
        this.openTimeThursday,
        this.closeTimeThursday,
        this.openTimeFriday,
        this.closeTimeFriday,
        this.openTimeSaturday,
        this.closeTimeSaturday,
        this.openTimeSunday,
        this.closeTimeSunday,
        this.area,
        this.minAmount,
        this.perkm,
        this.city,
        this.rstOrderTakeStatus,
        this.ownerId,
        this.websiteUrl,
        this.email,
        this.restCode,
        this.shipingFreeOrderAmount,
        this.acceptAnyTimeOrder,
        this.homeId,
        this.headerId,
        this.footerId,
        this.totalDaysOpenInWeek,
        this.businessCode,
        this.sslEnable,
        this.isOpenSunday,
        this.isOpenMonday,
        this.isOpenTuesday,
        this.isOpenWednesday,
        this.isOpenThursday,
        this.isOpenFriday,
        this.isOpenSaturday,
        this.isLandingPage,
        this.isMutipleTimings});

  RestaurantsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    published = json['published'];
    delivered = json['delivered'];
    phone = json['phone'];
    mobilephone = json['mobilephone'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    imageid = json['imageid'];
    desc = json['desc'];
    fee = json['fee'];
    percent = json['percent'];
    openTimeMonday = json['openTimeMonday'];
    closeTimeMonday = json['closeTimeMonday'];
    openTimeTuesday = json['openTimeTuesday'];
    closeTimeTuesday = json['closeTimeTuesday'];
    openTimeWednesday = json['openTimeWednesday'];
    closeTimeWednesday = json['closeTimeWednesday'];
    openTimeThursday = json['openTimeThursday'];
    closeTimeThursday = json['closeTimeThursday'];
    openTimeFriday = json['openTimeFriday'];
    closeTimeFriday = json['closeTimeFriday'];
    openTimeSaturday = json['openTimeSaturday'];
    closeTimeSaturday = json['closeTimeSaturday'];
    openTimeSunday = json['openTimeSunday'];
    closeTimeSunday = json['closeTimeSunday'];
    area = json['area'];
    minAmount = json['minAmount'];
    perkm = json['perkm'];
    city = json['city'];
    rstOrderTakeStatus = json['rst_order_take_status'];
    ownerId = json['owner_id'];
    websiteUrl = json['website_url'];
    email = json['email'];
    restCode = json['rest_code'];
    shipingFreeOrderAmount = json['shiping_free_order_amount'];
    acceptAnyTimeOrder = json['accept_any_time_order'];
    homeId = json['home_id'];
    headerId = json['header_id'];
    footerId = json['footer_id'];
    totalDaysOpenInWeek = json['total_days_open_in_week'];
    businessCode = json['business_code'];
    sslEnable = json['ssl_enable'];
    isOpenSunday = json['is_open_sunday'];
    isOpenMonday = json['is_open_monday'];
    isOpenTuesday = json['is_open_tuesday'];
    isOpenWednesday = json['is_open_wednesday'];
    isOpenThursday = json['is_open_thursday'];
    isOpenFriday = json['is_open_friday'];
    isOpenSaturday = json['is_open_saturday'];
    isLandingPage = json['is_landing_page'];
    isMutipleTimings = json['is_mutiple_timings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['published'] = this.published;
    data['delivered'] = this.delivered;
    data['phone'] = this.phone;
    data['mobilephone'] = this.mobilephone;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['imageid'] = this.imageid;
    data['desc'] = this.desc;
    data['fee'] = this.fee;
    data['percent'] = this.percent;
    data['openTimeMonday'] = this.openTimeMonday;
    data['closeTimeMonday'] = this.closeTimeMonday;
    data['openTimeTuesday'] = this.openTimeTuesday;
    data['closeTimeTuesday'] = this.closeTimeTuesday;
    data['openTimeWednesday'] = this.openTimeWednesday;
    data['closeTimeWednesday'] = this.closeTimeWednesday;
    data['openTimeThursday'] = this.openTimeThursday;
    data['closeTimeThursday'] = this.closeTimeThursday;
    data['openTimeFriday'] = this.openTimeFriday;
    data['closeTimeFriday'] = this.closeTimeFriday;
    data['openTimeSaturday'] = this.openTimeSaturday;
    data['closeTimeSaturday'] = this.closeTimeSaturday;
    data['openTimeSunday'] = this.openTimeSunday;
    data['closeTimeSunday'] = this.closeTimeSunday;
    data['area'] = this.area;
    data['minAmount'] = this.minAmount;
    data['perkm'] = this.perkm;
    data['city'] = this.city;
    data['rst_order_take_status'] = this.rstOrderTakeStatus;
    data['owner_id'] = this.ownerId;
    data['website_url'] = this.websiteUrl;
    data['email'] = this.email;
    data['rest_code'] = this.restCode;
    data['shiping_free_order_amount'] = this.shipingFreeOrderAmount;
    data['accept_any_time_order'] = this.acceptAnyTimeOrder;
    data['home_id'] = this.homeId;
    data['header_id'] = this.headerId;
    data['footer_id'] = this.footerId;
    data['total_days_open_in_week'] = this.totalDaysOpenInWeek;
    data['business_code'] = this.businessCode;
    data['ssl_enable'] = this.sslEnable;
    data['is_open_sunday'] = this.isOpenSunday;
    data['is_open_monday'] = this.isOpenMonday;
    data['is_open_tuesday'] = this.isOpenTuesday;
    data['is_open_wednesday'] = this.isOpenWednesday;
    data['is_open_thursday'] = this.isOpenThursday;
    data['is_open_friday'] = this.isOpenFriday;
    data['is_open_saturday'] = this.isOpenSaturday;
    data['is_landing_page'] = this.isLandingPage;
    data['is_mutiple_timings'] = this.isMutipleTimings;
    return data;
  }
}
