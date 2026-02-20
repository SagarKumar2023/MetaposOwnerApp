import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:metapos_owner/controller_model/controller/login_controller.dart';
import 'package:metapos_owner/controller_model/controller/report_controller/food_track_controller.dart';
import 'package:metapos_owner/utils/shared_preferences/prif_utils.dart';

import '../../../../utils/color_utils.dart';
import '../../../../widgets/container_widget.dart';
import '../../../../widgets/text_widget.dart';

class FoodTrackReport extends StatefulWidget {
  const FoodTrackReport({super.key});

  @override
  State<FoodTrackReport> createState() => _FoodTrackReportState();
}

class _FoodTrackReportState extends State<FoodTrackReport> {

  LoginController loginController = Get.find<LoginController>();
  FoodTrackController foodTrackController = Get.put(FoodTrackController());

  String? selectedValue;
  String? selectedRestaurantId;

  String? selectedFilter;
  String? selectedDate;

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

  void getFoodTrackReport() async {
    if(foodTrackController.isLoading) return;

    final dateRange = getDates(selectTime);
    final ownerId = prifUtils.getUserId();

    var body = {
      'rest_id': selectedRestaurantId ?? 'all',
      'start_date': dateRange['start_date'],
      'end_date': dateRange['end_date'],
      'owner_id': ownerId,
      'order_by': 'desc',
      'user_type': '1',
      'filter_by': '4'
    };

    print("Fetch Food Track Data => $body");
    foodTrackController.getFoodTrackReport(body);

  }

  @override
  void initState() {
    super.initState();
    selectTime = "Today";
    getFoodTrackReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: TextWidget(
          title: "Track Food",
          textColor: ColorUtils.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: GetBuilder<FoodTrackController>(
          builder: (controller){
            if(controller.isLoading){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Column(
              children: [
                Container(
                  color: ColorUtils.appBarBackground,
                  child: Column(
                    children: [
                      Divider(thickness: 0.3, color: ColorUtils.white),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 12,
                          right: 12,
                          top: 8,
                          bottom: 8,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                                                  title: "All Restaurant",
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
                                                          getFoodTrackReport();
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
                                getFoodTrackReport();
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
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
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
                                              borderRadius: BorderRadius.circular(12),
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
                                                final thisFilter = filterTime[index];
                                                final isSelected =
                                                    selectTime == thisFilter;
                                                return Padding(
                                                  padding: const EdgeInsets.only(
                                                    bottom: 10,
                                                  ),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.circular(10),
                                                      border: Border.all(
                                                        color: isSelected
                                                            ? ColorUtils.red
                                                            : ColorUtils.grey,
                                                        width: isSelected ? 1.2 : 0.5,
                                                      ),
                                                    ),
                                                    child: RadioListTile<String>(
                                                      contentPadding: EdgeInsets.zero,
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
                                                                () =>
                                                            selectTime = "Custom",
                                                          );
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
                                                        textColor: ColorUtils.black,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.w600,
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
                                  getFoodTrackReport();
                                }
                                else if (result != "Custom") {
                                  setState(() => selectTime = result);
                                  getFoodTrackReport();
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
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          ContainerWidget(
                            color: ColorUtils.white,
                            padding: EdgeInsets.all(12),
                            borderRadius: BorderRadius.circular(5),
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
                                  title: "Track Foods",
                                  fontWeight: FontWeight.w800,
                                  textColor: ColorUtils.black,
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: _buildTopCategory("Name"),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: _buildTopCategory("Open"),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: _buildTopCategory("Close"),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: _buildTopCategory("Sale"),
                                        ),                              ),
                                      Expanded(
                                        flex: 2,
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: _buildTopCategory("New"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15,),
                                ListView.builder(
                                  shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.data.length,
                                    itemBuilder: (context,index){
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: _buildTopCategory(controller.data[index].foodName.toString()),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Center(
                                                    child: _buildTopCategoryGreen(controller.data[index].openingStock.toString()),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: _buildTopCategoryRed(controller.data[index].closingStock.toString()),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: _buildTopCategoryGreen(controller.data[index].saleItems.toString()),
                                                  ),                              ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Align(
                                                    alignment: Alignment.centerRight,
                                                    child: _buildTopCategoryGreen(controller.data[index].newAddedItem.toString()),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 5,),
                                            Divider(),
                                          ],
                                        ),
                                      );
                                    }
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ],
            );
          }
      )
    );
  }
  Widget _buildTopCategory(String title) {
    return TextWidget(
      title: title,
      textColor: ColorUtils.black,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildTopCategoryRed(String title) {
    return TextWidget(
      title: title,
      textColor: ColorUtils.red,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );
  }

  Widget _buildTopCategoryGreen(String title) {
    return TextWidget(
      title: title,
      textColor: ColorUtils.green,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );
  }


}
