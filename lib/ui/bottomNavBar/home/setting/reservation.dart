import 'package:flutter/material.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/text_widget.dart';

class Reservation extends StatefulWidget {
  const Reservation({super.key});

  @override
  State<Reservation> createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {

  TextEditingController search = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: TextWidget(
          title: "Reservation",
          textColor: ColorUtils.black,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
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
                              shrinkWrap: true,
                              itemCount: filterTime.length,
                              itemBuilder: (context, index) {
                                final selectedTime =
                                filterTime[index];
                                final isSelected =
                                    selectTime == selectedTime;
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
                                      value: selectedTime,
                                      groupValue: selectTime,
                                      activeColor: ColorUtils.red,
                                      onChanged: (value) {
                                        Navigator.pop(
                                          context,
                                          value,
                                        );
                                      },
                                      title: TextWidget(
                                        title: selectedTime,
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
                  setState(
                        () => selectTime = null,
                  ); // reset filter
                } else {
                  setState(() => selectTime = result);
                }
                //fetchDashboardData();
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
                    title:
                    selectTime ??
                        "Time", // show updated filter
                    textColor: ColorUtils.black,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormField(
              controller: search,
              decoration: InputDecoration(
                  isDense: true,
                  hintText: "Search",
                  hintStyle: TextStyle(
                    color: ColorUtils.black,
                    fontWeight: FontWeight.w600,
                  ),
                  suffixIcon: Icon(Icons.close,color: ColorUtils.red),
                  prefixIcon: Icon(Icons.search,color: ColorUtils.red,size: 20),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(),
                  ),
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 8,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(title: "Name",textColor: ColorUtils.red,fontWeight: FontWeight.w600,),
                TextWidget(title: "Date/Time",textColor: ColorUtils.red,fontWeight: FontWeight.w600,),
                TextWidget(title: "Type",textColor: ColorUtils.red,fontWeight: FontWeight.w600,),
                TextWidget(title: "People",textColor: ColorUtils.red,fontWeight: FontWeight.w600,),
                TextWidget(title: "Action",textColor: ColorUtils.red,fontWeight: FontWeight.w600,),
              ],
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
