import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/controller/home_controller/setting/restaurant_timing_controller.dart';
import 'package:metapos_owner/utils/shared_preferences/prif_utils.dart';
import '../../../../controller_model/model/home/setting/restaurant_timing_model.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/container_widget.dart';
import '../../../../widgets/text_widget.dart';

class RestaurantTiming extends StatefulWidget {
  final int restaurantId;

  const RestaurantTiming({super.key, required this.restaurantId});

  @override
  State<RestaurantTiming> createState() => _RestaurantTimingState();
}

class _RestaurantTimingState extends State<RestaurantTiming> {
  final RestaurantTimingController controller = Get.put(RestaurantTimingController());

  RestaurantsList? restaurant;

  /// Separate status for each day (1 = Open, 2 = Close)
  List<int> dayStatus = List.filled(7, 2);

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  @override
  void initState() {
    super.initState();
    _loadRestaurantTiming();
  }

  Future<void> _loadRestaurantTiming() async {
    final ownerId = prifUtils.getUserId();
    if (ownerId != null && ownerId.isNotEmpty) {
      await controller.getRestaurantTiming({'owner_id': ownerId});
      final result = controller.getRestaurantTimingById(widget.restaurantId);

      if (mounted && result != null) {
        setState(() {
          restaurant = result;

          dayStatus = [
            restaurant!.isOpenMonday ?? 2,    // 1 = Open, 2 = Closed
            restaurant!.isOpenTuesday ?? 2,
            restaurant!.isOpenWednesday ?? 2,
            restaurant!.isOpenThursday ?? 2,
            restaurant!.isOpenFriday ?? 2,
            restaurant!.isOpenSaturday ?? 2,
            restaurant!.isOpenSunday ?? 2,
          ];

          // Initialize dayStatus per API (assuming published = 1 means open, 2 = closed)
          // If your API returns per day status in the model, you can set accordingly
         // dayStatus = List.filled(7, restaurant!.published ?? 2); // 1 = Open, 2 = Close
        });
      }
    }
  }

  /// Helper to convert dayStatus to bool for switch
  bool _isOpen(int index) => dayStatus[index] == 1;

  /// Save switch changes (optional)
  void _saveDayStatus() async {
    // If you want to save locally
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString("dayStatus_${widget.restaurantId}", jsonEncode(dayStatus));
  }

  @override
  Widget build(BuildContext context) {
    if (restaurant == null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorUtils.appBarBackground,
          centerTitle: true,
          title: const TextWidget(
            title: "Restaurant Timings (ON/OFF)",
            fontWeight: FontWeight.w600,
            fontSize: 16,
            textColor: Colors.black,
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final timings = [
      ["Monday", restaurant!.openTimeMonday, restaurant!.closeTimeMonday],
      ["Tuesday", restaurant!.openTimeTuesday, restaurant!.closeTimeTuesday],
      ["Wednesday", restaurant!.openTimeWednesday, restaurant!.closeTimeWednesday],
      ["Thursday", restaurant!.openTimeThursday, restaurant!.closeTimeThursday],
      ["Friday", restaurant!.openTimeFriday, restaurant!.closeTimeFriday],
      ["Saturday", restaurant!.openTimeSaturday, restaurant!.closeTimeSaturday],
      ["Sunday", restaurant!.openTimeSunday, restaurant!.closeTimeSunday],
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        centerTitle: true,
        title: const TextWidget(
          title: "Restaurant Timings (ON/OFF)",
          fontWeight: FontWeight.w600,
          fontSize: 16,
          textColor: Colors.black,
        ),
      ),
      body: ListView.builder(
        itemCount: timings.length,
        itemBuilder: (context, index) {
          final day = timings[index][0];
          final open = timings[index][1] ?? "00:00";
          final close = timings[index][2] ?? "00:00";
          return ContainerWidget(
            color: ColorUtils.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextWidget(
                    title: "$day ($open - $close)",
                    textColor: ColorUtils.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    TextWidget(
                      title: _isOpen(index) ? "Open" : "Closed",
                      textColor: _isOpen(index) ? ColorUtils.green : ColorUtils.red,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                    const SizedBox(width: 10),
                    CupertinoSwitch(
                      value: dayStatus[index] == 1,
                      onChanged: (value) async {
                        setState(() {
                          dayStatus[index] = value ? 1 : 2;
                        });
                        // Update API
                        bool success = await controller.updateRestaurantTiming(
                          restaurantId: widget.restaurantId,
                          published: value ? 1 : 2,
                        );
                        if (!success) {
                          setState(() {
                            dayStatus[index] = value ? 2 : 1; // revert
                          });
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}