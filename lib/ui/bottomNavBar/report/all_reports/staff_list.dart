import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:metapos_owner/controller_model/controller/login_controller.dart';
import 'package:metapos_owner/controller_model/controller/report_controller/staff_list_controller.dart';
import 'package:metapos_owner/utils/shared_preferences/prif_utils.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/container_widget.dart';
import '../../../../widgets/text_widget.dart';

class StaffList extends StatefulWidget {
  const StaffList({super.key});

  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {

  LoginController loginController = Get.find<LoginController>();
  StaffListController staffListController = Get.put(StaffListController());

  var name = [
    "Front Staff",
    "Front Staff",
    "Front Staff",
    "Front Staff",
    "Front Staff",
    "Front Staff",
    "Front Staff",
  ];
  var clockIn = [
    "7:31 AM",
    "6:34 AM",
    "8:31 AM",
    "7:28 AM",
    "8:23 AM",
    "8:31 AM",
    "7:35 AM",
  ];
  var clockOut = [
    "4:31 PM",
    "6:34 PM",
    "5:31 PM",
    "5:28 PM",
    "5:23 PM",
    "4:31 PM",
    "6:35 PM",
  ];

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

  void getStaffAttendanceList() async {
    if(staffListController.isLoading) return;

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

    print("Fetch Staff Attendance List => $body");
    staffListController.getStaffListData(body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectTime = 'Today';
    getStaffAttendanceList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: TextWidget(
          title: "Staff Attendance List",
          textColor: ColorUtils.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: GetBuilder<StaffListController>(
          builder: (controller){
            if(controller.isLoading) {
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
                                                          getStaffAttendanceList();
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
                                getStaffAttendanceList();
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
                                  getStaffAttendanceList();
                                }
                                else if (result != "Custom") {
                                  setState(() => selectTime = result);
                                  getStaffAttendanceList();
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
                    child: Column(
                      children: [
                        ContainerWidget(
                          color: ColorUtils.white,
                          padding: EdgeInsets.all(8),
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
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: _buildTopCategory("Name"),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: _buildTopCategory("Clock IN"),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: _buildTopCategory("Clock OUT"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.data.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6.0,
                                      horizontal: 4.0,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextWidget(
                                            title:controller.data[index].staffName.toString(),
                                            fontSize: 14,
                                            textColor: ColorUtils.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Center(
                                            child: TextWidget(
                                              title:controller.data[index].inTime.toString(),
                                              fontSize: 14,
                                              textColor: ColorUtils.green,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Align(
                                            alignment: Alignment.centerRight,
                                            child: TextWidget(
                                              title:controller.data[index].outTime.toString(),
                                              fontSize: 14,
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
                            ],
                          ),
                        ),  /// Customers
                      ],
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

}
