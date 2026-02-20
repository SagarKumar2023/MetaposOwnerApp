import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:metapos_owner/controller_model/controller/home_controller/setting/product_controller.dart';
import 'package:metapos_owner/utils/app_url.dart';
import 'package:metapos_owner/widgets/container_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/text_widget.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  TextEditingController search = TextEditingController();
  ProductController productController = Get.put(ProductController());

  var checkListName = [
    "Show POS",
    "Show App",
    "Show Website",
    "Show QRCode",
  ];

  List<bool> isPublished = [];
  List<bool> isAvailable = [];
  List<List<bool>> categoryFilters = []; // Dynam

  Offset tapPosition = Offset.zero;
  void _storePosition(TapDownDetails details) {
    tapPosition = details.globalPosition;
  }

  /// Publish/Unpublish and Available/UnAvailable Dialog
  void showPopupMenu(BuildContext context, int index) async {
    final selected = await showMenu(
      color: ColorUtils.white,
      context: context,
      position: RelativeRect.fromLTRB(
        tapPosition.dx,
        tapPosition.dy,
        tapPosition.dx + 1,
        tapPosition.dy + 1,
      ),
      items: [
        PopupMenuItem(
          value: "publish",
          child: Column(
            children: [
              Text(isPublished[index] ? " Mark UnPublish" : "Mark Publish",style: TextStyle(fontSize: 16),),
              SizedBox(height: 5,),
              Divider(
                color: ColorUtils.red,thickness: 0.3,
              )
            ],
          ),
        ),
        PopupMenuItem(
          value: "available",
          child: Column(
            children: [
              Text(isAvailable[index] ? "Mark Sold Out" : " Mark Available",style: TextStyle(fontSize: 16),),
              Divider(
                color: Colors.transparent,
              )
            ],
          ),

        ),
      ],
    );

    if (selected == "publish") {
      setState(() {
        isPublished[index] = !isPublished[index];
      });
      saveStatus();
    } else if (selected == "available") {
      setState(() {
        isAvailable[index] = !isAvailable[index];
      });
      saveAvailableStatus();
    }
  }

  /// Load Publish/Unpublish status
  void loadStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? saved = prefs.getStringList("category_status");

    if (saved != null) {
      isPublished = saved.map((e) => e == "1").toList();
    } else {
      isPublished = List.generate(productController.data.length, (index) => true);
    }

    if (mounted) setState(() {});
  }

  /// Save Publish/Unpublish status
  void saveStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      "category_status",
      isPublished.map((e) => e ? "1" : "0").toList(),
    );
  }

  void saveAvailableStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      "available_status",
      isAvailable.map((e) => e ? "1" : "0").toList(),
    );
  }

  void loadAvailableStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? saved = prefs.getStringList("available_status");

    if (saved != null) {
      isAvailable = saved.map((e) => e == "1").toList();
    } else {
      isAvailable = List.generate(productController.data.length, (index) => true);
    }

    if (mounted) setState(() {});
  }

  ///=============================================================================

  /// Checkbox filter dialog
  void showStatusFilter(BuildContext context, int index) {
    List<bool> tempFilters = List.from(categoryFilters[index]);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: StatefulBuilder(
            builder: (context, setStateDialog) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(4, (i) {
                  return CheckboxListTile(
                    value: tempFilters[i],
                    onChanged: (val) {
                      setStateDialog(() {
                        tempFilters[i] = val!;
                      });
                    },
                    title: TextWidget(
                      title: checkListName[i], // ✅ left name
                      textColor: ColorUtils.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                    controlAffinity:
                    ListTileControlAffinity.leading, // ✅ checkbox left side
                  );
                }),
              );
            },
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorUtils.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  setState(() {
                    categoryFilters[index] = List.from(tempFilters);
                  });
                  saveFilters(); // ✅ persist changes
                  Navigator.pop(context);
                },
                child: TextWidget(
                  title: "SUBMIT",
                  textColor: ColorUtils.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Save checkbox filters
  void saveFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("category_filters", jsonEncode(categoryFilters));
  }

  /// Load checkbox filters
  void loadFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? saved = prefs.getString("category_filters");
    if (saved != null) {
      List decoded = jsonDecode(saved);
      categoryFilters = decoded
          .map<List<bool>>(
              (e) => (e as List).map<bool>((x) => x as bool).toList())
          .toList();
    } else {
      categoryFilters =
          List.generate(productController.data.length, (index) => [false, false, false, false]);
    }
    if (mounted) setState(() {});
  }

  void getProductData() async {
    if(productController.isLoading)return;

    var body = {
      "type": "pos"
    };

    print("Fetch response Data => ${AppUrl.getProduct}");
    productController.getProductReport(body);
  }

  @override
  void initState() {
    super.initState();
    isPublished = [];
    isAvailable = [];
    categoryFilters = [];
    loadFilters();
    loadStatus();
    loadAvailableStatus();
    productController.getProductReport({"type":"pos"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: TextWidget(
          title: "Products",
          textColor: ColorUtils.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      body:GetBuilder<ProductController>(
          builder: (controller){
            if(controller.isLoading){
              return Center(child: CircularProgressIndicator(),);
            }
            if (isPublished.length != controller.data.length) {
              isPublished = List.generate(controller.data.length, (index) => true);
            }

            if (isAvailable.length != controller.data.length) {
              isAvailable = List.generate(controller.data.length, (index) => true);
            }

            if (categoryFilters.length != controller.data.length) {
              categoryFilters =
                  List.generate(controller.data.length, (index) => [false, false, false, false]);
            }
            return  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: search,
                    onChanged: (val){
                      controller.onSearch(val);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      hintText: "Search Product/Category",
                      hintStyle: TextStyle(
                        color: ColorUtils.grey,
                        fontWeight: FontWeight.w500,
                      ),
                      suffixIcon: InkWell(
                        onTap: (){
                          search.text = "";
                          setState(() {

                          });
                          controller.onSearch("");
                        },
                          child: Icon(Icons.close, color: ColorUtils.red)),
                      prefixIcon: Icon(
                        Icons.search,
                        color: ColorUtils.red,
                        size: 20,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.data.length,
                      itemBuilder: (context, index) {
                        return ContainerWidget(
                          padding: EdgeInsets.all(10),
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
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTapDown: _storePosition,
                                    onTap: () {
                                      if (isPublished.length > index && isAvailable.length > index) {
                                        showPopupMenu(context, index);
                                      }
                                    },
                                    child: Icon(
                                      Icons.menu,
                                      color: ColorUtils.red,
                                      size: 25,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextWidget(
                                        title: controller.data[index].name.toString(),
                                        textColor: ColorUtils.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          TextWidget(
                                            title: isPublished[index] ? "Publish":"Unpublished",
                                            textColor: isPublished[index] ? ColorUtils.green : ColorUtils.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          TextWidget(
                                            title: " / ",
                                            textColor: ColorUtils.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          TextWidget(
                                            title: isAvailable[index] ? "Available":"Sold Out",
                                            textColor: isAvailable[index] ? ColorUtils.green : ColorUtils.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          SizedBox(width: 10),
                                          GestureDetector(
                                            onTap: (){
                                              showStatusFilter(context, index);
                                            },
                                            child: Icon(
                                              Icons.info_rounded,
                                              color: ColorUtils.blue,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextWidget(
                                    title: "QRT",
                                    textColor: ColorUtils.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                  TextWidget(
                                    title: "Price",
                                    textColor: ColorUtils.red,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: ContainerWidget(
                                      height: 40,
                                      margin: EdgeInsets.zero,
                                      color: ColorUtils.white,
                                      border: BoxBorder.all(width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                      child: Center(
                                        child: TextWidget(
                                          title: controller.data[index].prodQty.toString(),
                                          textColor: ColorUtils.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: ContainerWidget(
                                      height: 40,
                                      margin: EdgeInsets.zero,
                                      color: ColorUtils.white,
                                      border: BoxBorder.all(width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                      child: Center(
                                        child: TextWidget(
                                          title: controller.data[index].price.toString(),
                                          textColor: ColorUtils.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }
}
