class AppUrl {

  ///baseUrl
  static const String _baseUrl = "http://pizzaria.metapos.com.au/backoffice/public/";

  ///endPoint
  static const String ownerLogin = "${_baseUrl}api/owner/owner-login";
  static const String ownerDashboard = "${_baseUrl}api/owner/owner-dashboard";
  static const String salesReport = "${_baseUrl}api/owner/sales-report";
  static const String productReport = "${_baseUrl}api/owner/product-report";
  static const String customerReport = "${_baseUrl}api/owner/customer-report";
  static const String staffList = "${_baseUrl}api/owner/staff-list";
  static const String staffSalesReport = "${_baseUrl}api/owner/staff-report";
  static const String terminalReport = "${_baseUrl}api/owner/manager-report";
  static const String foodTrack = "${_baseUrl}api/owner/track-food";
  static const String staffAttendanceList = "${_baseUrl}api/owner/staff-attendance-list";
  static const String cashDrawer = "${_baseUrl}api/owner/get_cash_drawer_data";
  static const String categoryData = "${_baseUrl}api/qrpos/getCategory";
  static const String getProduct = "${_baseUrl}api/qrpos/getbarcodeProduct";
  static const String restaurantTiming = "${_baseUrl}api/owner/restaurants-list";
}