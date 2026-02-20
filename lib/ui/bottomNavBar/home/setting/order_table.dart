import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/container_widget.dart';
import '../../../../widgets/text_widget.dart';

class OrderTable extends StatefulWidget {
  const OrderTable({super.key});

  @override
  State<OrderTable> createState() => _OrderTableState();
}

class _OrderTableState extends State<OrderTable> {

  TextEditingController Surcharge = TextEditingController();
  TextEditingController percentage = TextEditingController();

  bool _isOnlineOrderingOn = true;
  bool _isSurchargeOn = true;
  bool _isTableBookingOn = true;

  bool _inPercentage = true;
  
  @override
  void initState() {
    super.initState();
    _loadSwitchStates();
  }

  Future<void> _loadSwitchStates() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isOnlineOrderingOn = prefs.getBool('online_ordering_state') ?? true;
      _isSurchargeOn = prefs.getBool('surcharge_state') ?? true;
      _isTableBookingOn = prefs.getBool('table_booking_state') ?? true;
    });
  }

  Future<void> _saveSwitchState(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        centerTitle: true,
        title: TextWidget(
          title: "Order/Table Setting",
          textColor: ColorUtils.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Column(
        children: [
          _buildSwitchTile(
            title: "Online Ordering",
            isOn: _isOnlineOrderingOn,
            onChanged: (value) {
              setState(() => _isOnlineOrderingOn = value);
              _saveSwitchState('online_ordering_state', value);
            },
          ),

          _buildSwitchTileSurcharge(
            title: "Surcharge",
            isOn: _isSurchargeOn,
            onChanged: (value) {
              setState(() => _isSurchargeOn = value);
              _saveSwitchState('surcharge_state', value);
            },
          ),

          _buildSwitchTile(
            title: "Table Booking",
            isOn: _isTableBookingOn,
            onChanged: (value) {
              setState(() => _isTableBookingOn = value);
              _saveSwitchState('table_booking_state', value);
            },
          ),
        ],
      ),
    );
  }

  /// Reusable switch widget
  Widget _buildSwitchTile({
    required String title,
    required bool isOn,
    required ValueChanged<bool> onChanged,
  }) {
    return ContainerWidget(
      color: ColorUtils.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.all(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.4),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(1, 1),
        ),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            title: title,
            textColor: ColorUtils.black,
            fontWeight: FontWeight.w600,
          ),
          Row(
            children: [
              TextWidget(
                title: isOn ? "Open" : "Closed",
                textColor: isOn ? ColorUtils.green : ColorUtils.red,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
              const SizedBox(width: 10),
              CupertinoSwitch(
                activeTrackColor: ColorUtils.green,
                inactiveTrackColor: ColorUtils.red,
                value: isOn,
                onChanged: onChanged,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchTileSurcharge({
    required String title,
    required bool isOn,
    required ValueChanged<bool> onChanged,
  }) {
    return ContainerWidget(
      color: ColorUtils.white,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.all(8),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.4),
          spreadRadius: 1,
          blurRadius: 2,
          offset: const Offset(1, 1),
        ),
      ],
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                title: title,
                textColor: ColorUtils.black,
                fontWeight: FontWeight.w600,
              ),
              Row(
                children: [
                  TextWidget(
                    title: isOn ? "Open" : "Closed",
                    textColor: isOn ? ColorUtils.green : ColorUtils.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  const SizedBox(width: 10),
                  CupertinoSwitch(
                    activeTrackColor: ColorUtils.green,
                    inactiveTrackColor: ColorUtils.red,
                    value: isOn,
                    onChanged: onChanged,
                  ),
                ],
              ),
            ],
          ),
          Divider(thickness: 0.5,color: ColorUtils.grey,),
          TextFormField(
            controller: Surcharge,
            decoration: InputDecoration(
              isDense: true,
              hintText: "Surcharge",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide()
              )
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: percentage,
            decoration: InputDecoration(
                isDense: true,
                hintText: "10",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: BorderSide(width: 2)
                )
            ),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    activeColor: ColorUtils.red,
                      value: _inPercentage,
                      onChanged: (value){
                        setState(() {
                          _inPercentage = value!;
                        });
                      },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity(horizontal: -4,vertical: -4),
                  ),
                  SizedBox(width: 10,),
                  TextWidget(title: "In Percentage",
                    textColor: ColorUtils.black,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
              ElevatedButton(
              style: ElevatedButton.styleFrom(
              backgroundColor: ColorUtils.green,
              ),
                  onPressed: (){},
                  child: TextWidget(title: "Update",
                    textColor: ColorUtils.white,
                    fontWeight: FontWeight.bold,)
              ),
            ],
          ),
        ],
      ),
    );
  }
}