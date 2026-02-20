import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/controller/login_controller.dart';
import 'package:metapos_owner/ui/bottomNavBar/home/setting/category.dart';
import 'package:metapos_owner/ui/bottomNavBar/home/setting/order_table.dart';
import 'package:metapos_owner/ui/bottomNavBar/home/setting/product.dart';
import 'package:metapos_owner/ui/bottomNavBar/home/setting/reservation.dart';
import 'package:metapos_owner/ui/bottomNavBar/home/setting/restaurant_timing.dart';
import 'package:metapos_owner/utils/color_utils.dart';
import 'package:metapos_owner/widgets/container_widget.dart';
import 'package:metapos_owner/widgets/text_widget.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  LoginController loginController = Get.find<LoginController>();

  String? selectedValue;

  @override
  void initState() {
    super.initState();
    if (loginController.restaurantsList.isNotEmpty) {
      selectedValue = loginController.restaurantsList[0].name; // first restaurant select by default
    }
  }

  var leadingIcon = [
    "assets/icons/cutlery.png",
    "assets/icons/order.png",
    "assets/icons/category.png",
    "assets/icons/management.png",
    "assets/icons/management.png",
  ];
  var titleName = [
    "Restaurant Timing(ON/OFF)",
    "Order and Table(ON/OFF)",
    "Category Management",
    "Product Management",
    "Table Management",
  ];
  var trailingButton = [
    Icon(Icons.arrow_forward_ios, color: ColorUtils.appBarBackground),
    Icon(Icons.arrow_forward_ios, color: ColorUtils.appBarBackground),
    Icon(Icons.arrow_forward_ios, color: ColorUtils.appBarBackground),
    Icon(Icons.arrow_forward_ios, color: ColorUtils.appBarBackground),
    Icon(Icons.arrow_forward_ios, color: ColorUtils.appBarBackground),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextWidget(
          title: "Settings",
          textColor: ColorUtils.black,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              final result = await showModalBottomSheet<String>(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Column(
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
                          Expanded(
                            child: ListView.builder(
                              itemCount: loginController.restaurantsList.length,
                              itemBuilder: (context, index) {
                                final restaurant =
                                loginController.restaurantsList[index];
                                final restaurantName =
                                    restaurant.name;
                                final isSelected =
                                    selectedValue == restaurantName;
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: isSelected
                                            ? ColorUtils.red
                                            : ColorUtils.grey,
                                        width: isSelected ? 1.2 : 0.5,
                                      ),
                                    ),
                                    child: RadioListTile<String>(
                                      contentPadding: EdgeInsets.zero,
                                      value: restaurantName.toString(),
                                      groupValue: selectedValue,
                                      activeColor: ColorUtils.red,
                                      onChanged: (value) {
                                        Navigator.pop(context, value);
                                      },
                                      title: TextWidget(
                                        title: restaurantName.toString(),
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
                    ),
                  );
                },
              );
              setState(() => selectedValue = result);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  TextWidget(
                    title: selectedValue ?? "All Restaurants",
                    textColor: ColorUtils.black,
                  ),
                  const SizedBox(width: 10),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(child: Icon(Icons.arrow_drop_down)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // MAIN LIST
      body: ListView.builder(
        itemCount: leadingIcon.length,
        itemBuilder: (context, index) {
          return ContainerWidget(
            color: ColorUtils.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(1, 0),
              ),
            ],
            child: GestureDetector(
              onTap: () {
                switch (index) {
                  case 0:
                    if (selectedValue == null) {
                       Get.snackbar("Select", "Please select a restaurant");
                       return;
                    }
                    final selectedRestaurant =
                    loginController.restaurantsList.firstWhere(
                          (r) => r.name == selectedValue,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RestaurantTiming(
                          restaurantId: selectedRestaurant.id!, // FIXED
                        ),
                      ),
                    );
                    break;

                  case 1:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => OrderTable()));
                    break;

                  case 2:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Category()));
                    break;

                  case 3:
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Product()));
                    break;

                  case 4:
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Reservation()));
                    break;
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    children: [
                      ImageIcon(
                        AssetImage(leadingIcon[index]),
                        size: 25,
                        color: ColorUtils.appBarBackground,
                      ),
                      const SizedBox(width: 20),
                      TextWidget(
                        title: titleName[index],
                        textColor: ColorUtils.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  trailingButton[index],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}