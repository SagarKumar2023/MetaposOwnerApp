import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/controller/owner_dashboard_controller.dart';
import 'package:metapos_owner/ui/bottomNavBar/home/setting/setting.dart';
import 'package:metapos_owner/utils/shared_preferences/prif_utils.dart';
import 'package:metapos_owner/widgets/container_widget.dart';
import 'package:metapos_owner/widgets/custom_widgets.dart';
import 'package:metapos_owner/widgets/hourly_graph_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../controller_model/controller/login_controller.dart';
import '../../../utils/color_utils.dart';
import '../../../widgets/text_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final loginController = Get.find<LoginController>();
   OwnerDashboardController ownerDashboardController = Get.put(OwnerDashboardController(),);

  String? selectedValue;
  String? selectedRestaurantId;

  var filterTime = [
    "Today",
    "Yesterday",
    "This Week",
    "Last Week",
    "Last Month",
    "This Year",
    "Custom",
  ];
  String? selectTime;

  /// custom date picker
  DateTime? customStartDate;
  DateTime? customEndDate;

  Future<void> pickCustomDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 7)),
        end: DateTime.now(),
      ),
    );

    if (picked != null) {
      setState(() {
        customStartDate = picked.start;
        customEndDate = picked.end;
      });
    }
  }

  Map<String, String> getDates(String? filter) {
    final now = DateTime.now();
    DateTime start;
    DateTime end = now;

    switch (filter) {
      case "Today":
        start = DateTime(now.year, now.month, now.day);
        end = DateTime(now.year, now.month, now.day);
        break;

      case "Yesterday":
        final y = now.subtract(const Duration(days: 1));
        start = DateTime(y.year, y.month, y.day);
        end = DateTime(y.year, y.month, y.day);
        break;

      case "This Week":
        start = now.subtract(Duration(days: now.weekday - 1));
        end = DateTime(now.year, now.month, now.day);
        break;

      case "Last Week":
        final lastWeekEnd = now.subtract(Duration(days: now.weekday));
        start = lastWeekEnd.subtract(const Duration(days: 6));
        end = lastWeekEnd;
        break;

      case "Last Month":
        final firstOfThisMonth = DateTime(now.year, now.month, 1);
        final lastMonthLastDay = firstOfThisMonth.subtract(
          const Duration(days: 1),
        );
        start = DateTime(lastMonthLastDay.year, lastMonthLastDay.month, 1);
        end = DateTime(
          lastMonthLastDay.year,
          lastMonthLastDay.month,
          lastMonthLastDay.day,
        );
        break;

      case "This Year":
        start = DateTime(now.year, 1, 1);
        end = DateTime(now.year, now.month, now.day);
        break;

      case "Custom":
        if (customStartDate != null && customEndDate != null) {
          start = customStartDate!;
          end = customEndDate!;
        } else {
          start = DateTime(now.year, now.month, now.day);
          end = DateTime(now.year, now.month, now.day);
        }
        break;

      default:
        start = DateTime(now.year, now.month, now.day);
        end = DateTime(now.year, now.month, now.day);
    }

    String fmt(DateTime d) =>
        "${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";

    return {"start_date": fmt(start), "end_date": fmt(end)};
  }

  String getFilterBy(String? filter) {
    switch (filter) {
      case "Today":
        return "1";

      case "Yesterday":
        return "1";

      case "This Week":
      case "Last Week":
        return "3";

      case "This Month":
      case "Last Month":
        return "4";

      case "This Year":
        return "5";

      default:
        return "1";
    }
  }

  void fetchDashboardData() async {
    if (ownerDashboardController.isLoading) return;
    final userId = prifUtils.getUserId();
    final dateRange = getDates(selectTime);
    var body = {
      'id': userId,
      'rest_id': selectedRestaurantId ?? "all",
      'start_date': dateRange["start_date"],
      'end_date': dateRange["end_date"],
      // 'start_date': "2025-12-17",
      // 'end_date': "2025-12-17",
      'order_by': 'desc',
      'number_of_orders': '10',
      'filter_by': getFilterBy(selectTime), //selectTime ?? "Today",  --- changes required here
    };

    print("Fetch Dashboard Data Body => $body");

    await ownerDashboardController.getOwnerDashboard(body);

    setState(() {});
  }

  var hourlySaleData = [
    FlSpot(5, 150),
    FlSpot(6.2, 150),
    FlSpot(8, 300),
    FlSpot(11, 500),
    FlSpot(14, 650),
    FlSpot(17, 800),
    FlSpot(20, 900),
    FlSpot(23, 950),
  ];

  @override
  void initState() {
    super.initState();
    selectTime = "Today";
    WidgetsBinding.instance.addPostFrameCallback((_) => fetchDashboardData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        surfaceTintColor: ColorUtils.appBarBackground,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorUtils.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Image(image: AssetImage("assets/icons/pos.webp")),
            ),
          ),
        ),
        title: TextWidget(
          title: "MetaPOS Pizzaria",
          textColor: ColorUtils.black,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Setting()),
                    );
                  },
                  child: Icon(Icons.settings, size: 27),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    CustomWidgets().showLogoutDialog(context);
                  },
                  child: Icon(Icons.power_settings_new, size: 27),
                ),
              ],
            ),
          ),
        ],
      ),
      body: GetBuilder<OwnerDashboardController>(
        builder: (controller) {
          if(controller.isLoading){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(color: ColorUtils.appBarBackground),
                child: Column(
                  children: [
                    Divider(color: ColorUtils.white, thickness: 0.3),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        left: 12,
                        bottom: 8,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// RESTAURANT SELECT
                          GestureDetector(
                            onTap: () async {
                              final result = await showModalBottomSheet<Map>(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return GetBuilder<OwnerDashboardController>(
                                    builder: (controller) {
                                      return SizedBox(
                                        height: 400,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 18,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                height: 5,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  color: ColorUtils.red,
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                              ),
                                              const SizedBox(height: 20),

                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextWidget(
                                                    title: "All Restaurant",
                                                    textColor: ColorUtils.red,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(
                                                        context,
                                                        null,
                                                      );
                                                    },
                                                    child: TextWidget(
                                                      title: "Reset",
                                                      textColor: ColorUtils.red,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Expanded(
                                                child: ListView.builder(
                                                  itemCount: loginController
                                                      .restaurantsList
                                                      .length,
                                                  itemBuilder: (context, index) {
                                                    final restaurantName =
                                                        loginController
                                                            .restaurantsList[index]
                                                            .name ??
                                                        "Unknown";
                                                    final selectedId =
                                                        loginController
                                                            .restaurantsList[index]
                                                            .id
                                                            .toString();
                                                    final isSelected =
                                                        selectedValue ==
                                                        restaurantName;
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            bottom: 10,
                                                          ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                          border: Border.all(
                                                            color: isSelected
                                                                ? ColorUtils.red
                                                                : ColorUtils
                                                                      .grey,
                                                            width: isSelected
                                                                ? 1.2
                                                                : 0.5,
                                                          ),
                                                        ),
                                                        child: RadioListTile<String>(
                                                          contentPadding:
                                                              EdgeInsets.zero,
                                                          value: restaurantName,
                                                          groupValue:
                                                              selectedValue,
                                                          activeColor:
                                                              ColorUtils.red,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              selectedValue =
                                                                  value;
                                                              selectedRestaurantId =
                                                                  selectedId;
                                                            });
                                                            fetchDashboardData();
                                                            Navigator.pop(
                                                              context,
                                                              {
                                                                "name":
                                                                    restaurantName,
                                                                "id":
                                                                    selectedId,
                                                              },
                                                            );
                                                          },
                                                          title: TextWidget(
                                                            title:
                                                                restaurantName,
                                                            textColor:
                                                                ColorUtils
                                                                    .black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                              if (result == null) {
                                setState(() {
                                  selectedValue = null;
                                  selectedRestaurantId = null;
                                });
                              } else {
                                setState(() {
                                  selectedValue = result["name"];
                                  selectedRestaurantId = result["id"];
                                });
                              }
                            },
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorUtils.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Center(
                                    child: Icon(Icons.arrow_drop_down),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                TextWidget(
                                  title: selectedValue ?? "All Restaurants",
                                  textColor: ColorUtils.black,
                                ),
                              ],
                            ),
                          ),

                          /// FILTER SELECT
                          GestureDetector(
                            onTap: () async {
                              final result = await showModalBottomSheet<String>(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 18,
                                      right: 18,
                                      bottom: 20,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          height: 5,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: ColorUtils.red,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextWidget(
                                              title: "Filters",
                                              textColor: ColorUtils.red,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pop(context, null);
                                              },
                                              child: TextWidget(
                                                title: "Reset",
                                                textColor: ColorUtils.red,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        Flexible(
                                          child: ListView.builder(
                                            physics: BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: filterTime.length,
                                            itemBuilder: (context, index) {
                                              final thisFilter =
                                                  filterTime[index];
                                              final isSelected =
                                                  selectTime == thisFilter;
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 10,
                                                ),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? ColorUtils.red
                                                          : ColorUtils.grey,
                                                      width: isSelected
                                                          ? 1.2
                                                          : 0.5,
                                                    ),
                                                  ),
                                                  child: RadioListTile<String>(
                                                    contentPadding:
                                                        EdgeInsets.zero,
                                                    value: thisFilter,
                                                    groupValue: selectTime,
                                                    activeColor: ColorUtils.red,
                                                    onChanged: (value) async {
                                                      if (value == "Custom") {
                                                        /// First close the sheet
                                                        Navigator.pop(
                                                          context,
                                                          value,
                                                        );

                                                        /// Then pick range
                                                        await pickCustomDateRange(
                                                          context,
                                                        );

                                                        /// Then update selected filter
                                                        setState(
                                                          () => selectTime =
                                                              "Custom",
                                                        );

                                                        /// And fire API
                                                        fetchDashboardData();
                                                      } else {
                                                        /// For normal filters
                                                        Navigator.pop(
                                                          context,
                                                          value,
                                                        );
                                                      }
                                                    },
                                                    title: TextWidget(
                                                      title: thisFilter,
                                                      textColor:
                                                          ColorUtils.black,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                              if (result == null) {
                                setState(() => selectTime = "Today");
                              } else if (result != "Custom") {
                                setState(() => selectTime = result);
                                fetchDashboardData();
                              }
                             // fetchDashboardData();
                            },
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorUtils.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(Icons.filter_alt_outlined),
                                ),
                                const SizedBox(width: 10),
                                TextWidget(
                                  title: selectTime ?? "Today",
                                  textColor: ColorUtils.black,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ContainerWidget(
                        color: ColorUtils.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 0),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ContainerWidget(
                                  margin: EdgeInsets.all(4.0),
                                  padding: EdgeInsets.all(8.0),
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(
                                    color: ColorUtils.black,
                                    width: 1,
                                  ),
                                  child: CustomWidgets().buildCardInfo(
                                    "Total Sale",
                                    "\$${controller.ownerData?.ordersCompleteAmount.toString() ?? '0.00'}",
                                  ),
                                ),
                                ContainerWidget(
                                  margin: EdgeInsets.all(4.0),
                                  padding: EdgeInsets.all(8.0),
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(
                                    color: ColorUtils.black,
                                    width: 1,
                                  ),
                                  child: CustomWidgets().buildCardInfo(
                                    "Total Order",
                                    controller.ownerData?.ordersCompleteCount.toString() ?? "7",
                                  ),
                                ),
                                ContainerWidget(
                                  margin: EdgeInsets.all(4.0),
                                  padding: EdgeInsets.all(8.0),
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(
                                    color: ColorUtils.black,
                                    width: 1,
                                  ),
                                  child: CustomWidgets().buildCardInfo(
                                    "Discount",
                                    "\$${controller.ownerData?.totalDiscountOrders.toString() ?? "0"}",
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            CustomWidgets().textWidget("Sale by order status"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ContainerWidget(
                                  margin: EdgeInsets.all(4.0),
                                  padding: EdgeInsets.all(8.0),
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(
                                    color: ColorUtils.black,
                                    width: 1,
                                  ),
                                  child: Column(
                                    children: [
                                      TextWidget(
                                        title: "Completed",
                                        textColor: ColorUtils.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      TextWidget(
                                        title:
                                            "\$${controller.ownerData?.ordersCompleteAmount.toString() ?? "0.00"}",
                                        textColor: ColorUtils.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      TextWidget(
                                        title:
                                            "Order: ${controller.ownerData?.ordersCompleteCount.toString() ?? "0"}",
                                        textColor: ColorUtils.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                ContainerWidget(
                                  margin: EdgeInsets.all(4.0),
                                  padding: EdgeInsets.all(8.0),
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(
                                    color: ColorUtils.black,
                                    width: 1,
                                  ),
                                  child: Column(
                                    children: [
                                      TextWidget(
                                        title: "Running",
                                        textColor: ColorUtils.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      TextWidget(
                                        title:
                                            "\$${controller.ownerData?.ordersRunningAmount.toString() ?? "10.00"}",
                                        textColor: ColorUtils.green,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      TextWidget(
                                        title:
                                            "Order: ${controller.ownerData?.ordersRunningCount.toString() ?? "1"}",
                                        textColor: ColorUtils.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                                ContainerWidget(
                                  margin: EdgeInsets.all(4.0),
                                  padding: EdgeInsets.all(8.0),
                                  color: ColorUtils.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: BoxBorder.all(
                                    color: ColorUtils.black,
                                    width: 1,
                                  ),
                                  child: Column(
                                    children: [
                                      TextWidget(
                                        title: "Cancelled",
                                        textColor: ColorUtils.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      TextWidget(
                                        title:
                                            "\$${controller.ownerData?.ordersCancelAmount.toString() ?? "4.00"}",
                                        textColor: ColorUtils.red,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      TextWidget(
                                        title:
                                            "order: ${controller.ownerData?.ordersCancelCount.toString() ?? "3"}",
                                        textColor: ColorUtils.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            /// Sales Graph
                            TextWidget(
                                title: "Hourly Sale",
                                fontWeight: FontWeight.w700,
                                textColor: ColorUtils.black,
                              ),
                            SizedBox(height: 20),
                            /// -----------GraphData --------------------------
                            // SizedBox(
                            //   height: 250,
                            //   child: GetBuilder<OwnerDashboardController>(
                            //       builder: (_){
                            //         return  HourlyGraphWidget(
                            //             ownerDashboardController: ownerDashboardController
                            //         );
                            //       }
                            //   ),
                            // ),

                            SizedBox(
                              height: 250,
                              child: HourlyGraphWidget(ownerDashboardController: controller),
                            )
                          ],
                        ),
                      ),
                      ContainerWidget(
                        width: double.infinity,
                        color: ColorUtils.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 0),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomWidgets().textWidget("All Restaurants"),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 300,
                              child: SfCartesianChart(
                                plotAreaBorderColor: Colors.black87,
                                plotAreaBorderWidth: 1.2,

                                /// ===== X AXIS =====
                                primaryXAxis: NumericAxis(
                                  axisLine: const AxisLine(
                                    width: 1,
                                    color: Colors.black87,
                                  ),
                                  minimum: 5,
                                  maximum: 23,
                                  interval: 1,
                                  title: AxisTitle(
                                    text: "(Hours)",
                                    textStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                    ),
                                  ),
                                  majorGridLines: const MajorGridLines(
                                    width: 1,
                                    color: Colors.black26,
                                  ),
                                  majorTickLines: const MajorTickLines(
                                    width: 0,
                                  ),
                                ),

                                /// ===== Y AXIS =====
                                primaryYAxis: NumericAxis(
                                  axisLine: const AxisLine(
                                    width: 1,
                                    color: Colors.black87,
                                  ),
                                  minimum: 100,
                                  maximum: 1000,
                                  interval: 100,
                                  majorGridLines: const MajorGridLines(
                                    width: 1,
                                    color: Colors.black26,
                                  ),
                                  majorTickLines: const MajorTickLines(
                                    width: 0,
                                  ),
                                ),

                                /// ===== SERIES =====
                                series: <CartesianSeries>[
                                  SplineAreaSeries<FlSpot, double>(
                                    name: "Sales",
                                    dataSource: hourlySaleData,
                                    xValueMapper: (FlSpot spot, _) => spot.x,
                                    yValueMapper: (FlSpot spot, _) => spot.y,
                                    splineType: SplineType.natural,
                                    color: Colors.blueAccent.withOpacity(0.2),
                                    borderColor: Colors.blueAccent,
                                    borderWidth: 2,
                                    animationDuration: 2500,
                                    markerSettings: const MarkerSettings(
                                      borderWidth: 5,
                                      isVisible: true,
                                      color: Colors.blueAccent,
                                      height: 6,
                                      width: 6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomWidgets().allRestaurant(
                                      ColorUtils.blue,
                                      "MetaPOS Pizzaria"
                                  ),
                                  CustomWidgets().allRestaurant(
                                      ColorUtils.green,
                                      "Restaurant Demo"
                                  ),
                                  CustomWidgets().allRestaurant(
                                      ColorUtils.yellow,
                                      "Retail Demo"
                                  ),
                                ]
                            ),
                            SizedBox(height: 20,),
                            CustomWidgets().allRestaurant(ColorUtils.orange, "MetaPOS Kiosk")
                          ],
                        ),
                      ),
                      ContainerWidget(
                        color: ColorUtils.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 0),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: "Sale by Order Type",
                              fontWeight: FontWeight.w700,
                              textColor: ColorUtils.black,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets().buildOrderType(
                                  ColorUtils.blue,
                                  "Dine-IN",
                                  "\$${controller.ownerData?.dineinOrdersAmount ?? 0.0}",
                                  "Order : ${controller.ownerData?.dineinOrders ?? 0}",
                                ),
                                CustomWidgets().buildOrderType(
                                  ColorUtils.green,
                                  "Take Away",
                                  "\$${controller.ownerData?.takeawayOrdersAmount ?? 0.0}",
                                  "Order : ${controller.ownerData?.takeawayOrders ?? 0}",
                                ),
                                CustomWidgets().buildOrderType(
                                  ColorUtils.yellow,
                                  "Delivery",
                                  "\$${controller.ownerData?.deliveryOrdersAmount ?? 0.0}",
                                  "Order : ${controller.ownerData?.deliveryOrders ?? 0}",
                                ),
                                CustomWidgets().buildOrderType(
                                  ColorUtils.red,
                                  "Others",
                                  "\$${controller.ownerData?.otherOrdersAmount ?? 0.0}",
                                  "Order : ${controller.ownerData?.otherOrders ?? 0}",
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            SizedBox(
                              height: 250,
                              child: PieChart(
                                PieChartData(
                                  borderData: FlBorderData(show: false),
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 20,
                                  sections: [
                                    PieChartSectionData(
                                      color: ColorUtils.blue,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.dineinOrdersAmount ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.dineinOrdersAmount ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.green,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.takeawayOrdersAmount ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.takeawayOrdersAmount ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.yellow,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.deliveryOrdersAmount ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.deliveryOrdersAmount ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.orange,
                                      value:
                                          (controller.ownerData?.otherOrdersAmount ?? 0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.otherOrdersAmount ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ContainerWidget(
                        color: ColorUtils.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 0),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: "Sale by Platform",
                              fontWeight: FontWeight.w700,
                              textColor: ColorUtils.black,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets().buildPlatform(
                                  ColorUtils.blue,
                                  " Website",
                                  "\$${controller.ownerData?.orderDataWebTotal ?? 0.00}",
                                  "Order: ${controller.ownerData?.orderDataWebCount ?? 0}",
                                ),
                                CustomWidgets().buildPlatform(
                                  ColorUtils.green,
                                  " App",
                                  "\$${controller.ownerData?.orderDataAppTotal ?? 0.00}",
                                  "Order: ${controller.ownerData?.orderDataAppCount ?? 0}",
                                ),
                                CustomWidgets().buildPlatform(
                                  ColorUtils.yellow,
                                  " Pos",
                                  "\$${controller.ownerData?.orderDataPosTotal ?? 0.00}",
                                  "Order: ${controller.ownerData?.orderDataPosCount ?? 0}",
                                ),
                                CustomWidgets().buildPlatform(
                                  ColorUtils.red,
                                  " QR-Code",
                                  "\$${controller.ownerData?.orderDataQrTotal ?? 0.00}",
                                  "Order: ${controller.ownerData?.orderDataQrCount ?? 0}",
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),
                            SizedBox(
                              height: 250,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 20,
                                  sections: [
                                    PieChartSectionData(
                                      color: ColorUtils.blue,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.orderDataWebTotal ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.orderDataWebTotal ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.green,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.orderDataAppTotal ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.orderDataAppTotal ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.yellow,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.orderDataPosTotal ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.orderDataPosTotal ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.red,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.orderDataQrTotal ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.orderDataQrTotal ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ContainerWidget(
                        color: ColorUtils.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 0),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: "Payment Type",
                              fontWeight: FontWeight.w700,
                              textColor: ColorUtils.black,
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets().buildPaymentType(
                                  ColorUtils.blue,
                                  " Cash",
                                  "\$${controller.ownerData?.cashOrderPaymentData ?? 0.0}",
                                  "order: ${controller.ownerData?.cashOrderTotalCountData ?? 0}",
                                ),
                                CustomWidgets().buildPaymentType(
                                  ColorUtils.green,
                                  " Card",
                                  "\$${controller.ownerData?.cardOrderPaymentData ?? 0.0}",
                                  "order: ${controller.ownerData?.cardOrderTotalCountData ?? 0}",
                                ),
                                CustomWidgets().buildPaymentType(
                                  ColorUtils.yellow,
                                  "Tyro",
                                  "\$${controller.ownerData?.tyroOrderPaymentData ?? 0.0}",
                                  "order: ${controller.ownerData?.tyroOrderTotalCountData ?? 0}",
                                ),
                                CustomWidgets().buildPaymentType(
                                  ColorUtils.red,
                                  " Other",
                                  "\$${controller.ownerData?.otherOrderPaymentData ?? 0.0}",
                                  "order: ${controller.ownerData?.otherOrderTotalCountData ?? 0}",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 250,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 0,
                                  sections: [
                                    PieChartSectionData(
                                      color: ColorUtils.blue,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.cashOrderPaymentData ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.cashOrderPaymentData ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.green,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.cardOrderPaymentData ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.cardOrderPaymentData ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.yellow,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.tyroOrderPaymentData ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.tyroOrderPaymentData ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.red,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.otherOrderPaymentData ??
                                                  0)
                                              .toDouble(),
                                      title:
                                          "\$${controller.ownerData?.otherOrderPaymentData ?? 0.0}",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ContainerWidget(
                        color: ColorUtils.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(1, 0),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: "Top Product",
                              fontWeight: FontWeight.w700,
                              textColor: ColorUtils.black,
                            ),
                            const SizedBox(height: 10),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child:  CustomWidgets().buildTopCategory("Name"),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child:  CustomWidgets().buildTopCategory("Order"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child:  CustomWidgets().buildTopCategory("Amount"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (controller.ownerData?.topSaleProdData != null &&
                                controller
                                    .ownerData!
                                    .topSaleProdData
                                    .isNotEmpty)
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller
                                    .ownerData!
                                    .topSaleProdData
                                    .length,
                                itemBuilder: (context, index) {
                                  final categoryTopProduct = controller
                                      .ownerData!
                                      .topSaleProdData[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                      horizontal: 4.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: TextWidget(
                                            title:
                                                categoryTopProduct.name ?? "_",
                                            fontSize: 12,
                                            textColor: ColorUtils.black,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: TextWidget(
                                              title:
                                                  "${categoryTopProduct.topSalling ?? 0}",
                                              fontSize: 12,
                                              textColor: ColorUtils.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: TextWidget(
                                              title:
                                                  "\$${categoryTopProduct.foodSallingAmount ?? 0}",
                                              fontSize: 12,
                                              textColor: ColorUtils.green,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: TextWidget(
                                    title: "No product data available",
                                    fontSize: 13,
                                    textColor: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      ContainerWidget(
                        color: ColorUtils.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(1, 0),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: "Table Bookings",
                              fontWeight: FontWeight.w700,
                              textColor: ColorUtils.black,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets().buildTableBooking(
                                  ColorUtils.blue,
                                  "New",
                                  "Count: ${controller.ownerData?.reservationDataNew != null && controller.ownerData!.reservationDataNew.isNotEmpty ? controller.ownerData!.reservationDataNew[0].count : 0}",
                                  "Cover: ${controller.ownerData?.reservationDataNew != null && controller.ownerData!.reservationDataNew.isNotEmpty ? controller.ownerData!.reservationDataNew[0].coverPeople : 0}",
                                ),
                                CustomWidgets().buildTableBooking(
                                  ColorUtils.green,
                                  "Accepted",
                                  "Count: ${controller.ownerData?.reservationDataAccepted != null && controller.ownerData!.reservationDataAccepted.isNotEmpty ? controller.ownerData!.reservationDataAccepted[0].count : 0}",
                                  "Cover: ${controller.ownerData?.reservationDataAccepted != null && controller.ownerData!.reservationDataAccepted.isNotEmpty ? controller.ownerData!.reservationDataAccepted[0].coverPeople : 0}",
                                ),
                                CustomWidgets().buildTableBooking(
                                  ColorUtils.yellow,
                                  "Confirmed",
                                  "Count: ${controller.ownerData?.reservationDataConfirmed != null && controller.ownerData!.reservationDataConfirmed.isNotEmpty ? controller.ownerData!.reservationDataConfirmed[0].count : 0}",
                                  "Cover: ${controller.ownerData?.reservationDataConfirmed != null && controller.ownerData!.reservationDataConfirmed.isNotEmpty ? controller.ownerData!.reservationDataConfirmed[0].coverPeople : 0}",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets().buildTableBooking(
                                  ColorUtils.orangeColor,
                                  " Completed",
                                  "Count: ${controller.ownerData?.reservationDataCompleted != null && controller.ownerData!.reservationDataCompleted.isNotEmpty ? controller.ownerData!.reservationDataCompleted[0].count : 0}",
                                  "Cover: ${controller.ownerData?.reservationDataCompleted != null && controller.ownerData!.reservationDataCompleted.isNotEmpty ? controller.ownerData!.reservationDataCompleted[0].coverPeople : 0}",
                                ),
                                CustomWidgets().buildTableBooking(
                                  ColorUtils.darkAppGreen,
                                  " Rejected",
                                  "Count: ${controller.ownerData?.reservationDataRejected != null && controller.ownerData!.reservationDataRejected.isNotEmpty ? controller.ownerData!.reservationDataRejected[0].count : 0}",
                                  "Cover: ${controller.ownerData?.reservationDataRejected != null && controller.ownerData!.reservationDataRejected.isNotEmpty ? controller.ownerData!.reservationDataRejected[0].coverPeople : 0}",
                                ),
                                CustomWidgets().buildTableBooking(
                                  ColorUtils.appBarBackground,
                                  " No Show",
                                  "Count: ${controller.ownerData?.reservationDataNoShow != null && controller.ownerData!.reservationDataNoShow.isNotEmpty ? controller.ownerData!.reservationDataNoShow[0].count : 0}",
                                  "Cover: ${controller.ownerData?.reservationDataNoShow != null && controller.ownerData!.reservationDataNoShow.isNotEmpty ? controller.ownerData!.reservationDataNoShow[0].coverPeople : 0}",
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 250,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0,
                                  centerSpaceRadius: 0,
                                  sections: [
                                    PieChartSectionData(
                                      color: ColorUtils.blue,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.reservationDataNew !=
                                                  null &&
                                              controller
                                                  .ownerData!
                                                  .reservationDataNew
                                                  .isNotEmpty
                                          ? controller
                                                .ownerData!
                                                .reservationDataNew[0]
                                                .count
                                                ?.toDouble()
                                          : 0.0),
                                      title:
                                          "${(controller.ownerData?.reservationDataNew != null && controller.ownerData!.reservationDataNew.isNotEmpty ? controller.ownerData!.reservationDataNew[0].count?.toDouble() : 0.0)}%",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.green,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.reservationDataAccepted !=
                                                  null &&
                                              controller
                                                  .ownerData!
                                                  .reservationDataAccepted
                                                  .isNotEmpty
                                          ? controller
                                                .ownerData!
                                                .reservationDataAccepted[0]
                                                .count
                                                ?.toDouble()
                                          : 0.0),
                                      title:
                                          "${(controller.ownerData?.reservationDataAccepted != null && controller.ownerData!.reservationDataAccepted.isNotEmpty ? controller.ownerData!.reservationDataAccepted[0].count?.toDouble() : 0.0)}%",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.yellow,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.reservationDataConfirmed !=
                                                  null &&
                                              controller
                                                  .ownerData!
                                                  .reservationDataConfirmed
                                                  .isNotEmpty
                                          ? controller
                                                .ownerData!
                                                .reservationDataConfirmed[0]
                                                .count
                                                ?.toDouble()
                                          : 0.0),
                                      title:
                                          "${(controller.ownerData?.reservationDataConfirmed != null && controller.ownerData!.reservationDataConfirmed.isNotEmpty ? controller.ownerData!.reservationDataConfirmed[0].count?.toDouble() : 0.0)}%",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.red,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.reservationDataCompleted !=
                                                  null &&
                                              controller
                                                  .ownerData!
                                                  .reservationDataCompleted
                                                  .isNotEmpty
                                          ? controller
                                                .ownerData!
                                                .reservationDataCompleted[0]
                                                .count
                                                ?.toDouble()
                                          : 0.0),
                                      title:
                                          "${(controller.ownerData?.reservationDataCompleted != null && controller.ownerData!.reservationDataCompleted.isNotEmpty ? controller.ownerData!.reservationDataCompleted[0].count?.toDouble() : 0.0)}%",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.darkAppGreen,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.reservationDataRejected !=
                                                  null &&
                                              controller
                                                  .ownerData!
                                                  .reservationDataRejected
                                                  .isNotEmpty
                                          ? controller
                                                .ownerData!
                                                .reservationDataRejected[0]
                                                .count
                                                ?.toDouble()
                                          : 0.0),
                                      title:
                                          "${(controller.ownerData?.reservationDataRejected != null && controller.ownerData!.reservationDataRejected.isNotEmpty ? controller.ownerData!.reservationDataRejected[0].count?.toDouble() : 0.0)}%",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                    PieChartSectionData(
                                      color: ColorUtils.appBarBackground,
                                      value:
                                          (controller
                                                      .ownerData
                                                      ?.reservationDataNoShow !=
                                                  null &&
                                              controller
                                                  .ownerData!
                                                  .reservationDataNoShow
                                                  .isNotEmpty
                                          ? controller
                                                .ownerData!
                                                .reservationDataNoShow[0]
                                                .count
                                                ?.toDouble()
                                          : 0.0),
                                      title:
                                          "${(controller.ownerData?.reservationDataNoShow != null && controller.ownerData!.reservationDataNoShow.isNotEmpty ? controller.ownerData!.reservationDataNoShow[0].count?.toDouble() : 0.0)}%",
                                      radius: 100,
                                      titleStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: ColorUtils.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ContainerWidget(
                        color: ColorUtils.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(1, 0),
                            blurStyle: BlurStyle.normal,
                          ),
                        ],
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              title: "Top Category",
                              fontWeight: FontWeight.w700,
                              textColor: ColorUtils.black,
                            ),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: CustomWidgets().buildTopCategory("Name"),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Center(
                                      child:  CustomWidgets().buildTopCategory("Order"),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child:  CustomWidgets().buildTopCategory("Amount"),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (controller.ownerData?.totalCategoryTopSailing !=
                                    null &&
                                controller
                                    .ownerData!
                                    .totalCategoryTopSailing
                                    .isNotEmpty)
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller
                                    .ownerData!
                                    .totalCategoryTopSailing
                                    .length,
                                itemBuilder: (context, index) {
                                  final category = controller
                                      .ownerData!
                                      .totalCategoryTopSailing[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                      horizontal: 4.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: TextWidget(
                                            title: category.name.toString(),
                                            fontSize: 12,
                                            textColor: ColorUtils.black,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: TextWidget(
                                              title: "${category.totalCount}",
                                              fontSize: 12,
                                              textColor: ColorUtils.black,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: TextWidget(
                                              title:
                                                  "\$${category.totalAmount}",
                                              fontSize: 12,
                                              textColor: ColorUtils.green,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Center(
                                  child: TextWidget(
                                    title: "No category data available",
                                    fontSize: 13,
                                    textColor: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

///=============================================================================
// 🔥 DATA LOADING COMPLETE → NOW REFRESH GRAPH
// setLeftTiles();
// setGraphData();
///=====
// List<FlSpot> plotGraphData= [];
//
// setGraphData(){
//   plotGraphData = [
//     FlSpot(1, getAmountOnYear('05')),
//     FlSpot(2, getAmountOnYear('06')),
//     FlSpot(3, getAmountOnYear('07')),
//     FlSpot(4, getAmountOnYear('08')),
//     FlSpot(5, getAmountOnYear('09')),
//     FlSpot(6, getAmountOnYear('10')),
//     FlSpot(7, getAmountOnYear('11')),
//     FlSpot(8, getAmountOnYear('12')),
//     FlSpot(9, getAmountOnYear('13')),
//     FlSpot(10, getAmountOnYear('14')),
//     FlSpot(11, getAmountOnYear('15')),
//     FlSpot(12, getAmountOnYear('16')),
//     FlSpot(13, getAmountOnYear('17')),
//     FlSpot(14, getAmountOnYear('18')),
//     FlSpot(15, getAmountOnYear('19')),
//     FlSpot(16, getAmountOnYear('20')),
//     FlSpot(17, getAmountOnYear('21')),
//     FlSpot(18, getAmountOnYear('22')),
//     FlSpot(19, getAmountOnYear('23')),
//   ];
//   setState(() {
//   });
// }

// String cleanHour(String hour) {
//   return hour.split(" ").first;
// }
//
// double getAmountOnYear(String hourName){
//   double amount = 0;
//   if(ownerDashboardController.ownerData != null){
//
//     var index = ownerDashboardController.ownerData!.hoursName
//         .indexWhere((h) => cleanHour(h) == hourName);
//
//     if(index != -1){
//       amount = double.tryParse(
//           ownerDashboardController.ownerData!.allHourAmount[index]
//       ) ?? 0;
//     }
//   }
//   print("jhgjhg $amount");
//   return amount;
// }

// double getAmountOnYear(String hourName){
//   double amount = 0;
//   var finder  = ownerDashboardController.ownerData[0].hoursName.where((element)
//   => element.toString().split(' ').first.toLowerCase() ==
//       hourName.toLowerCase()).toList();
//   if(finder.isNotEmpty){
//     var index = ownerDashboardController.ownerData[0].hoursName.indexWhere((element) =>
//         element.toString().split(' ').first.toLowerCase() == hourName.toLowerCase());
//     amount = double.parse(ownerDashboardController.ownerData[0].allHourAmount[index]);
//   }else {
//     amount = 0;
//   }
//   return amount/initialDivideValue;
// }
//
// List<String> leftTitles = ['100','200','300','400','500','600','700','800','900','1k'];
// int initialDivideValue = 100;
//
// setLeftTiles() {
//   final data = ownerDashboardController.ownerData;
//   if (data == null) return;
//   final maxAmount = data.maxAmount ?? 0;
//   final restMaxAmount = data.restMaxAmount ?? 0;
//
//   if (restMaxAmount > 100 && maxAmount < 1000) {
//     initialDivideValue = 100;
//     leftTitles = ['100','200','300','400','500','600','700','800','900','1k'];
//   } else if (maxAmount > 1000 && maxAmount < 2000) {
//     initialDivideValue = 200;
//     leftTitles = ['200','400','600','800','1k','1.2k','1.4k','1.6k','1.8k','2k'];
//   } else if (maxAmount > 2000 && maxAmount < 3000) {
//     initialDivideValue = 300;
//     leftTitles = ['300','600','900','1.2k','1.5k','1.8k','2.1k','2.4k','2.7k','3k'];
//   } else if (maxAmount > 3000 && maxAmount < 5000) {
//     initialDivideValue = 500;
//     leftTitles = ['500','1k','1.5k','2k','2.5k','3k','3.5k','4k','4.5k','5k'];
//   } else if (maxAmount > 5000 && maxAmount < 10000) {
//     initialDivideValue = 1000;
//     leftTitles = ['1k','2k','3k','4k','5k','6k','7k','8k','9k','10k'];
//   } else if (maxAmount > 10000 && maxAmount < 20000){
//     initialDivideValue = 2000;
//     leftTitles = ['2k','4k','6k','8k','10k','12k','14k','16k','18k','20k'];
//   } else if (maxAmount> 20000 && maxAmount < 50000){
//     initialDivideValue = 5000;
//     leftTitles = ['5k','10k','15k','20k','25k','30k','35k','40k','45k','50k'];
//   } else if (maxAmount > 50000 && maxAmount < 70000){
//     initialDivideValue = 7000;
//     leftTitles = ['7k','14k','21k','28k','35k','42k','49k','56k','63k','70k'];
//   } else if (maxAmount > 70000 && maxAmount < 100000){
//     initialDivideValue = 10000;
//     leftTitles = ['10k','20k','30k','40k','50k','60k','70k','80k','90k','100k'];
//   } else if (maxAmount > 100000 && maxAmount < 150000){
//     initialDivideValue = 15000;
//     leftTitles = ['15k','30k','45k','60k','75k','90k','105k','120k','135k','150k'];
//   } else if (maxAmount > 150000 && maxAmount < 200000){
//     initialDivideValue = 20000;
//     leftTitles = ['20k','40k','60k','80k','100k','120k','140k','160k','180k','200k'];
//   }else if (maxAmount > 200000 && maxAmount < 300000){
//     initialDivideValue = 30000;
//     leftTitles = ['30k','60k','90k','120k','150k','180k','210k','240k','270k','300k'];
//   } else if (maxAmount > 300000 && maxAmount < 500000){
//     initialDivideValue = 50000;
//     leftTitles = ['50k','100k','150k','200k','250k','300k','350k','400k','450k','500k'];
//   }
//   setGraphData();
// }
///-----------------------------------------------------------------------------
// SizedBox(
//   height: 300,
//   child: SfCartesianChart(
//     plotAreaBorderColor: Colors.black87,
//     plotAreaBorderWidth: 1.2,
//     /// ===== X AXIS =====
//     primaryXAxis: NumericAxis(
//       axisLine: const AxisLine(width: 1, color: Colors.black87),
//       minimum: 0,
//       maximum: 700,
//       interval: 100,
//       title: AxisTitle(
//         text: "(Hours)",
//         textStyle: const TextStyle(
//           fontSize: 12,
//           fontWeight: FontWeight.w700,
//           color: Colors.black,
//         ),
//       ),
//       majorGridLines: const MajorGridLines(width: 1, color: Colors.black26),
//       majorTickLines: const MajorTickLines(width: 0),
//     ),
//     /// ===== Y AXIS =====
//     primaryYAxis: NumericAxis(
//       axisLine: const AxisLine(width: 1, color: Colors.black87),
//       minimum: 100,
//       maximum: ownerDashboardController.ownerData?.maxAmount?.toDouble() ?? 1000,
//       interval: initialDivideValue.toDouble(),
//       axisLabelFormatter: (AxisLabelRenderDetails details) {
//         final value = details.value.toInt();
//         int index = (value / initialDivideValue).round() - 1;
//         if (index >= 0 && index < leftTitles.length) {
//           return ChartAxisLabel(leftTitles[index], null);
//         } else if (index >= leftTitles.length) {
//           return ChartAxisLabel(leftTitles.last, null);
//         }
//         return ChartAxisLabel(value.toString(), null);
//       },
//       majorGridLines: const MajorGridLines(width: 1, color: Colors.black26),
//       majorTickLines: const MajorTickLines(width: 0),
//     ),
//     /// ===== SERIES =====
//     series: <CartesianSeries>[
//       SplineAreaSeries<FlSpot, double>(
//         name: "Sales",
//         dataSource: plotGraphData,
//         xValueMapper: (FlSpot spot, _) => spot.x,
//         yValueMapper: (FlSpot spot, _) => spot.y,
//         splineType: SplineType.natural,
//         color: Colors.blueAccent.withOpacity(0.2),
//         borderColor: Colors.blueAccent,
//         borderWidth: 2,
//         animationDuration: 2500,
//         markerSettings: const MarkerSettings(
//           borderWidth: 5,
//           isVisible: true,
//           color: Colors.blueAccent,
//           height: 6,
//           width: 6,
//         ),
//       ),
//     ],
//   ),
// )