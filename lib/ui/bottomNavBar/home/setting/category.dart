import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:metapos_owner/controller_model/controller/home_controller/setting/category_controller.dart';
import 'package:metapos_owner/utils/app_url.dart';
import 'package:metapos_owner/widgets/container_widget.dart';
import '../../../../utils/color_utils.dart';
import '../../../../widgets/text_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  TextEditingController categorySearch = TextEditingController();
  CategoryController categoryController = Get.put(CategoryController());

  var checkListName = [
    "Show POS",
    "Show App",
    "Show Website",
    "Show QRCode",
  ];

  List<bool> status = [];
  List<List<bool>> categoryFilters = [];

  /// LOAD STATUS (with dynamic length support)
  void loadStatus(int length) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? saved = prefs.getStringList("category_status");

    if (saved != null && saved.length == length) {
      status = saved.map((e) => e == "1").toList();
    } else {
      status = List.generate(length, (index) => true);
    }

    if (mounted) setState(() {});
  }

  void saveStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
      "category_status",
      status.map((e) => e ? "1" : "0").toList(),
    );
  }

  /// LOAD FILTERS (with dynamic length support)
  void loadFilters(int length) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? saved = prefs.getString("category_filters");

    if (saved != null) {
      List decoded = jsonDecode(saved);
      if (decoded.length == length) {
        categoryFilters = decoded
            .map<List<bool>>(
                (e) => (e as List).map<bool>((x) => x as bool).toList())
            .toList();
      } else {
        categoryFilters =
            List.generate(length, (index) => [false, false, false, false]);
      }
    } else {
      categoryFilters =
          List.generate(length, (index) => [false, false, false, false]);
    }

    if (mounted) setState(() {});
  }

  void saveFilters() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("category_filters", jsonEncode(categoryFilters));
  }

  void showStatusFilter(BuildContext context, int index) {
    List<bool> tempFilters = List.from(categoryFilters[index]);

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: StatefulBuilder(builder: (context, setStateDialog) {
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
                    title: checkListName[i],
                    textColor: ColorUtils.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }),
            );
          }),
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
                  saveFilters();
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

  void showStatusDialog(BuildContext context, bool isPublished, int index) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            isPublished ? "Mark as Unpublish?" : "Mark as Publish?",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  status[index] = !isPublished;
                });
                saveStatus();
                Navigator.pop(context);
              },
              child: Text(isPublished ? "Unpublish" : "Publish"),
            ),
          ],
        );
      },
    );
  }

  void getCategoryData() async {
    if(categoryController.isLoading) return;

    var body = {
      "type": "pos"
    };

    print("Fetch response data: ${AppUrl.categoryData}");
    categoryController.getCategoryData(body);
  }

  @override
  void initState() {
    super.initState();
    categoryController.getCategoryData({"type": "pos"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorUtils.appBarBackground,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: TextWidget(
          title: "Category",
          textColor: ColorUtils.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      /// GET BUILDER
      body: GetBuilder<CategoryController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (status.isEmpty || status.length != controller.data.length) {
            loadStatus(controller.data.length);
            return Center(child: CircularProgressIndicator());
          }
          if (categoryFilters.isEmpty ||
              categoryFilters.length != controller.data.length) {
            loadFilters(controller.data.length);
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              /// Search box
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: categorySearch,
                  autofocus: true,
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
                        categorySearch.text = "";
                        setState(() {

                        });
                        controller.onSearch("");
                      },
                        child: Icon(Icons.close, color: ColorUtils.red)),
                    prefixIcon: Icon(Icons.search,
                        color: ColorUtils.red, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.data.length,
                    itemBuilder: (context, index) {
                      return ContainerWidget(
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.all(5),
                        color: ColorUtils.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                showStatusDialog(
                                    context, status[index], index);
                              },
                              child: Icon(Icons.menu,
                                  size: 25, color: ColorUtils.red),
                            ),
                            SizedBox(width: 10),
                            /// Category Name + Status + Filter Icon
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  title: controller.data[index].name.toString(),
                                  textColor: ColorUtils.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                Row(
                                  children: [
                                    TextWidget(
                                      title:
                                      status[index] ? "Published" : "Unpublished",
                                      textColor: status[index]
                                          ? ColorUtils.green
                                          : ColorUtils.red,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        showStatusFilter(context, index);
                                      },
                                      child: Icon(Icons.info,
                                          size: 25, color: ColorUtils.blue),
                                    ),
                                  ],
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
        },
      ),
    );
  }
}
