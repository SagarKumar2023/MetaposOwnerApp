import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:metapos_owner/controller_model/controller/owner_dashboard_controller.dart';
import 'package:metapos_owner/utils/color_utils.dart';

class HourlyGraphWidget extends StatefulWidget {
  final OwnerDashboardController ownerDashboardController;
  const HourlyGraphWidget({
    super.key,
    required this.ownerDashboardController,
  });

  @override
  State<HourlyGraphWidget> createState() => _HourlyGraphWidgetState();
}

class _HourlyGraphWidgetState extends State<HourlyGraphWidget> {

  List<Color> gradientColors = [
    ColorUtils.orange,
    ColorUtils.green,
    ColorUtils.blue,
  ];

  List<FlSpot> plotGraphData = [];

  int initialDivideValue = 100;

  /// 🔁 Runs whenever dependency / controller updates
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.ownerDashboardController.ownerData != null) {
      setLeftTiles();
    }
  }

  /// ---------------- GRAPH DATA ----------------------------------------------
/// change
  void setGraphData() {
    plotGraphData.clear();

    for (int i = 0; i < bottomTitle.length; i++) {
      final hour = bottomTitle[i]; // "05", "06", ...
      final yValue = getAmountOnYear(hour);
      plotGraphData.add(
        FlSpot(i.toDouble(), yValue),
      );
      log("PLOT => X:$i  HOUR:$hour  Y:$yValue");
    }

    setState(() {});
  }


  double getAmountOnYear(String hourName) {
    ///double amount = 0;

    final hours = widget.ownerDashboardController.ownerData!.hoursName;
    final amounts = widget.ownerDashboardController.ownerData!.allHourAmount;

    final index = hours.indexWhere((e) => e.toString().split(' ').first == hourName,);

    if (index != -1) {
      return (double.tryParse(amounts[index].toString()) ?? 0) / initialDivideValue;
      /// amount = amounts[index];
    }
    return 0;
  }

  /// ---------------- AXIS SCALE ----------------
  double getMaxY() {
    return leftTitles.length.toDouble();
  }

  void setLeftTiles() {
    final max = widget.ownerDashboardController.ownerData!.maxAmount!;
    if (max <= 1000) {
      initialDivideValue = 100;
      leftTitles = ['100','200','300','400','500','600','700','800','900','1k'];
    } else if (max <= 2000) {
      initialDivideValue = 200;
      leftTitles = ['200','400','600','800','1k','1.2k','1.4k','1.6k','1.8k','2k'];
    } else if (max <= 5000) {
      initialDivideValue = 500;
      leftTitles = ['500','1k','1.5k','2k','2.5k','3k','3.5k','4k','4.5k','5k'];
    } else if (max <= 10000) {
      initialDivideValue = 1000;
      leftTitles = ['1k','2k','3k','4k','5k','6k','7k','8k','9k','10k'];
    } else if (max <= 20000){
      initialDivideValue = 2000;
      leftTitles = ['2k','4k','6k','8k','10k','12k','14k','16k','18k','20k'];
    }else if (max <= 50000) {
      initialDivideValue = 5000;
      leftTitles = ['5k', '10k', '15k', '20k', '25k', '30k', '35k', '40k', '45k', '50k'];
    }else if (max <= 70000){
      initialDivideValue = 7000;
      leftTitles = ['7k','14k','21k','28k','35k','42k','49k','56k','63k','70k'];
    }else if (max <= 100000){
      initialDivideValue = 10000;
      leftTitles = ['10k','20k','30k','40k','50k','60k','70k','80k','90k','100k'];
    }else if (max <= 150000){
      initialDivideValue = 15000;
      leftTitles = ['15k','30k','45k','60k','75k','90k','105k','120k','135k','150k'];
    }else if (max <= 200000) {
      initialDivideValue = 20000;
      leftTitles = ['20k','40k','60k','80k','100k','120k','140k','160k','180k','200k'];
    }else if (max <= 300000) {
      initialDivideValue = 30000;
      leftTitles = ['30k','60k','90k','120k','100k','120k','140k','160k','180k','200k'];
    }else if (max <= 500000) {
      initialDivideValue = 50000;
      leftTitles = ['50k','100k','150k','200k','250k','300k','350k','400k','450k','500k'];
    }

    log("---------------   GRAPH DATA   --------------------------");
    for (var spot in plotGraphData) {
      print("X: ${spot.x}  Y: ${spot.y}");
    }

    setGraphData();
  }

  /// ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    if (plotGraphData.isEmpty) {
      return const SizedBox(height: 220);
    }

    return SizedBox(
      height: 220,
      child: LineChart(mainData()),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      lineTouchData: LineTouchData(
          enabled: false,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
         horizontalInterval: 0.3,
         verticalInterval: 0.4,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.grey,
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: Colors.grey, strokeWidth: 0.5);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            //reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: -1,
      //maxX:  bottomTitle.length.toDouble(),
      maxX:  (bottomTitle.length-1).toDouble(),
      minY: 0,
      maxY: getMaxY(),
      lineBarsData: [
        LineChartBarData(
          isStrokeJoinRound: true,
          show: true,
          spots: plotGraphData,
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  /// ---------------- TITLES ----------------

  List<String> bottomTitle = [
    '05','06','07','08','09',
    '10','11','12','13','14',
    '15','16','17','18','19',
    '20','21','22','23',
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    //final index = value.toInt() - 1;
    final index = value.toInt();

    if (index < 0 || index >= bottomTitle.length) {
      return const SizedBox();
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(
        bottomTitle[index],
        style: const TextStyle(fontSize: 10),
      ),
    );
  }

  List<String> leftTitles = [
    '100','200','300','400','500',
    '600','700','800','900','1k'
  ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final index = value.toInt() - 1;
    if (index < 0 || index >= leftTitles.length) {
      return const SizedBox();
    }
    return Text(leftTitles[index], style: const TextStyle(fontSize: 10));
  }

}

///
///=============================================================================
// import 'dart:developer';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:metapos_owner/controller_model/controller/owner_dashboard_controller.dart';
// import 'package:metapos_owner/utils/color_utils.dart';
//
// class HourlyGraphWidget extends StatefulWidget {
//   final OwnerDashboardController ownerDashboardController;
//   const HourlyGraphWidget({
//     Key? key,
//     required this.ownerDashboardController,
//   }) : super(key: key);
//
//   @override
//   State<HourlyGraphWidget> createState() => _HourlyGraphWidgetState();
// }
//
// class _HourlyGraphWidgetState extends State<HourlyGraphWidget> {
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.ownerDashboardController.ownerData != null) {
//         setLeftTiles();
//       }
//     });
//   }
//
//
//   List<Color> gradientColors = [
//     ColorUtils.orange,
//     ColorUtils.green,
//     ColorUtils.blue,
//   ];
//
//   List<FlSpot> plotGraphData = [];
//
//   int initialDivideValue = 100;
//
//   /// 🔁 Runs whenever dependency / controller updates
//   // @override
//   // void didChangeDependencies() {
//   //   super.didChangeDependencies();
//   //   if (widget.ownerDashboardController.ownerData != null) {
//   //     setLeftTiles();
//   //   }
//   // }
//
//   @override
//   void didUpdateWidget(covariant HourlyGraphWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     if (widget.ownerDashboardController.ownerData !=
//         oldWidget.ownerDashboardController.ownerData) {
//       setLeftTiles(); // 🔥 rebuild graph when filter/restaurant changes
//     }
//   }
//
//
//
//   /// ---------------- GRAPH DATA ----------------------------------------------
//   /// change
//   void setGraphData() {
//     plotGraphData.clear();
//
//     for (int i = 0; i < bottomTitle.length; i++) {
//       final hour = bottomTitle[i]; // "05", "06", ...
//       final yValue = getAmountOnYear(hour);
//       plotGraphData.add(
//         FlSpot(i.toDouble(), yValue),
//       );
//
//       log("PLOT => X:$i  HOUR:$hour  Y:$yValue");
//     }
//
//     setState(() {});
//   }
//
//
//   // double getAmountOnYear(String hourName) {
//   //   ///double amount = 0;
//   //
//   //   final hours = widget.ownerDashboardController.ownerData!.hoursName;
//   //   final amounts = widget.ownerDashboardController.ownerData!.allHourAmount;
//   //
//   //   final index = hours.indexWhere((e) => e.toString().split(' ').first == hourName,);
//   //
//   //   if (index != -1) {
//   //     return (double.tryParse(amounts[index].toString()) ?? 0) / initialDivideValue;
//   //     /// amount = amounts[index];
//   //   }
//   //   return 0;
//   // }
//
//   double getAmountOnYear(String hourName) {
//     final hours = widget.ownerDashboardController.ownerData!.hoursName;
//     final amounts = widget.ownerDashboardController.ownerData!.allHourAmount;
//
//     final index = hours.indexWhere((e) {
//       final h = e.toString().split(' ').first.padLeft(2, '0');
//       return h == hourName;
//     });
//
//     if (index != -1) {
//       return (double.tryParse(amounts[index].toString()) ?? 0) /
//           initialDivideValue;
//     }
//     return 0;
//   }
//
//   /// ---------------- AXIS SCALE ----------------
//   double getMaxY() {
//     return leftTitles.length.toDouble();
//   }
//
//
//   void setLeftTiles() {
//     final max = widget.ownerDashboardController.ownerData!.maxAmount!;
//     if (max <= 1000) {
//       initialDivideValue = 100;
//       leftTitles = ['100','200','300','400','500','600','700','800','900','1k'];
//     } else if (max <= 2000) {
//       initialDivideValue = 200;
//       leftTitles = ['200','400','600','800','1k','1.2k','1.4k','1.6k','1.8k','2k'];
//     } else if (max <= 5000) {
//       initialDivideValue = 500;
//       leftTitles = ['500','1k','1.5k','2k','2.5k','3k','3.5k','4k','4.5k','5k'];
//     } else if (max <= 10000) {
//       initialDivideValue = 1000;
//       leftTitles = ['1k','2k','3k','4k','5k','6k','7k','8k','9k','10k'];
//     } else if (max <= 20000){
//       initialDivideValue = 2000;
//       leftTitles = ['2k','4k','6k','8k','10k','12k','14k','16k','18k','20k'];
//     }else if (max <= 50000) {
//       initialDivideValue = 5000;
//       leftTitles = ['5k', '10k', '15k', '20k', '25k', '30k', '35k', '40k', '45k', '50k'];
//     }else if (max <= 70000){
//       initialDivideValue = 7000;
//       leftTitles = ['7k','14k','21k','28k','35k','42k','49k','56k','63k','70k'];
//     }else if (max <= 100000){
//       initialDivideValue = 10000;
//       leftTitles = ['10k','20k','30k','40k','50k','60k','70k','80k','90k','100k'];
//     }else if (max <= 150000){
//       initialDivideValue = 15000;
//       leftTitles = ['15k','30k','45k','60k','75k','90k','105k','120k','135k','150k'];
//     }else if (max <= 200000) {
//       initialDivideValue = 20000;
//       leftTitles = ['20k','40k','60k','80k','100k','120k','140k','160k','180k','200k'];
//     }else if (max <= 300000) {
//       initialDivideValue = 30000;
//       leftTitles = ['30k','60k','90k','120k','100k','120k','140k','160k','180k','200k'];
//     }else if (max <= 500000) {
//       initialDivideValue = 50000;
//       leftTitles = ['50k','100k','150k','200k','250k','300k','350k','400k','450k','500k'];
//     }
//
//     log("---------------   GRAPH DATA   --------------------------");
//     for (var spot in plotGraphData) {
//       print("X: ${spot.x}  Y: ${spot.y}");
//     }
//
//     setGraphData();
//   }
//
//   /// ---------------- UI ----------------
//
//   @override
//   Widget build(BuildContext context) {
//     if (plotGraphData.isEmpty) {
//       return const SizedBox(height: 220);
//     }
//
//     return SizedBox(
//       height: 220,
//       child: LineChart(mainData()),
//     );
//   }
//
//   LineChartData mainData() {
//     return LineChartData(
//       lineTouchData: LineTouchData(
//         enabled: false,
//       ),
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 0.3,
//         verticalInterval: 0.4,
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: Colors.grey,
//             strokeWidth: 0.5,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return FlLine(color: Colors.grey, strokeWidth: 0.5);
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             //reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 30,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: -1,
//       //maxX:  bottomTitle.length.toDouble(),
//       maxX:  (bottomTitle.length-1).toDouble(),
//       minY: 0,
//       maxY: getMaxY(),
//
//       lineBarsData: [
//         LineChartBarData(
//           isStrokeJoinRound: true,
//           show: true,
//           spots: plotGraphData,
//           isCurved: false,
//           gradient: LinearGradient(
//             colors: gradientColors,
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: true,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   /// ---------------- TITLES ----------------
//
//   List<String> bottomTitle = [
//     '05','06','07','08','09',
//     '10','11','12','13','14',
//     '15','16','17','18','19',
//     '20','21','22','23'
//   ];
//
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     //final index = value.toInt() - 1;
//     final index = value.toInt();
//
//     if (index < 0 || index >= bottomTitle.length) {
//       return const SizedBox();
//     }
//
//     return SideTitleWidget(
//       meta: meta,
//       child: Text(
//         bottomTitle[index],
//         style: const TextStyle(fontSize: 10),
//       ),
//     );
//   }
//
//   List<String> leftTitles = [
//     '100','200','300','400','500',
//     '600','700','800','900','1k'
//   ];
//
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     final index = value.toInt() - 1;
//     if (index < 0 || index >= leftTitles.length) {
//       return const SizedBox();
//     }
//     return Text(leftTitles[index], style: const TextStyle(fontSize: 10));
//   }
//
// }

// extension on String {
//   operator -(int other) {}
// }
///-----------------------------------------------------------------------------
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:metapos_owner/controller_model/controller/owner_dashboard_controller.dart';
// import 'package:metapos_owner/utils/color_utils.dart';
// class HourlyGraphWidget extends StatefulWidget {
//   final OwnerDashboardController ownerDashboardController;
//   const HourlyGraphWidget({Key? key,required this.ownerDashboardController}) : super(key: key);
//
//   @override
//   State<HourlyGraphWidget> createState() => _HourlyGraphWidgetState();
// }
//
// class _HourlyGraphWidgetState extends State<HourlyGraphWidget> {
//
//   List<Color> gradientColors = [
//     ColorUtils.orange,
//     ColorUtils.green,
//     ColorUtils.blue,
//   ];
//
//   List<FlSpot> plotGraphData= [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.ownerDashboardController.ownerData != null) {
//         setLeftTiles();
//       }
//     });
//   }
//
//   @override
//   void didUpdateWidget(covariant HourlyGraphWidget oldWidget) {
//     super.didUpdateWidget(oldWidget);
//
//     if (widget.ownerDashboardController.ownerData != null) {
//       setLeftTiles(); // 🔁 refresh graph on every data update
//     }
//   }
//
//
//   setGraphData(){
//     plotGraphData = [
//
//       FlSpot(1, getAmountOnYear('05')),
//       FlSpot(2, getAmountOnYear('06')),
//       FlSpot(3, getAmountOnYear('07')),
//       FlSpot(4, getAmountOnYear('08')),
//       FlSpot(5, getAmountOnYear('09')),
//       FlSpot(6, getAmountOnYear('10')),
//       FlSpot(7, getAmountOnYear('11')),
//       FlSpot(8, getAmountOnYear('12')),
//       FlSpot(9, getAmountOnYear('13')),
//       FlSpot(10, getAmountOnYear('14')),
//       FlSpot(11, getAmountOnYear('15')),
//       FlSpot(12, getAmountOnYear('16')),
//       FlSpot(13, getAmountOnYear('17')),
//       FlSpot(14, getAmountOnYear('18')),
//       FlSpot(15, getAmountOnYear('19')),
//       FlSpot(16, getAmountOnYear('20')),
//       FlSpot(17, getAmountOnYear('21')),
//       FlSpot(18, getAmountOnYear('22')),
//       FlSpot(19, getAmountOnYear('23')),
//     ];
//     setState(() {
//
//     });
//   }
//
//   double getAmountOnYear(String hourname){
//     double amount = 0;
//     var finder = widget.ownerDashboardController.ownerData!.hoursName.where((element) => element.toString().split(' ').first.toLowerCase() == hourname.toLowerCase()).toList();
//     print(finder);
//     if(finder.isNotEmpty){
//       var index = widget.ownerDashboardController.ownerData!.hoursName.indexWhere((element) => element.toString().split(' ').first.toLowerCase() == hourname.toLowerCase());
//       amount = widget.ownerDashboardController.ownerData!.allHourAmount[index];
//       print(amount);
//       return amount/initialDivideValue;
//     }else{
//       amount = 0;
//     }
//
//     return amount/initialDivideValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return plotGraphData.isNotEmpty?LineChart(
//       mainData(),
//     ):SizedBox.shrink();
//
//     // return ElevatedButton(onPressed: (){getAmountOnYear("");}, child: Text("Get amount"));
//   }
//
//   LineChartData mainData() {
//     return LineChartData(
//       lineTouchData: LineTouchData(
//           enabled: false
//       ),
//       gridData: FlGridData(
//         show: true,
//         drawVerticalLine: true,
//         horizontalInterval: 0.5,
//         verticalInterval: 0.5,
//         getDrawingHorizontalLine: (value) {
//           return FlLine(
//             color: Colors.grey,
//             strokeWidth: 0.5,
//           );
//         },
//         getDrawingVerticalLine: (value) {
//           return FlLine(color: Colors.grey, strokeWidth: 0.5);
//         },
//       ),
//       titlesData: FlTitlesData(
//         show: true,
//         rightTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         topTitles: AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),
//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             reservedSize: 30,
//             interval: 1,
//             getTitlesWidget: bottomTitleWidgets,
//           ),
//         ),
//         leftTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 1,
//             getTitlesWidget: leftTitleWidgets,
//             reservedSize: 30,
//           ),
//         ),
//       ),
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(color: const Color(0xff37434d)),
//       ),
//       minX: 0,
//       maxX: 19,
//       minY: 0,
//       maxY: 10,
//
//       lineBarsData: [
//         LineChartBarData(
//           spots: plotGraphData,
//           isCurved: false,
//           gradient: LinearGradient(
//             colors: gradientColors,
//           ),
//           barWidth: 5,
//           isStrokeCapRound: true,
//           dotData: FlDotData(
//             show: true,
//           ),
//           belowBarData: BarAreaData(
//             show: true,
//             gradient: LinearGradient(
//               colors: gradientColors
//                   .map((color) => color.withOpacity(0.3))
//                   .toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//         fontWeight: FontWeight.normal,
//         fontSize: 8,
//         color: Colors.black
//     );
//     Widget text;
//     switch (value.toInt()) {
//
//       case 1:
//         text = const Text('05', style: style);
//         break;
//       case 2:
//         text = const Text('06', style: style);
//         break;
//       case 3:
//         text = const Text('07', style: style);
//         break;
//       case 4:
//         text = const Text('08', style: style);
//         break;
//       case 5:
//         text = const Text('09', style: style);
//         break;
//       case 6:
//         text = const Text('10', style: style);
//         break;
//       case 7:
//         text = const Text('11', style: style);
//         break;
//       case 8:
//         text = const Text('12', style: style);
//         break;
//       case 9:
//         text = const Text('13', style: style);
//         break;
//       case 10:
//         text = const Text('14', style: style);
//         break;
//       case 11:
//         text = const Text('15', style: style);
//         break;
//       case 12:
//         text = const Text('16', style: style);
//         break;
//       case 13:
//         text = const Text('17', style: style);
//         break;
//       case 14:
//         text = const Text('18', style: style);
//         break;
//       case 15:
//         text = const Text('19', style: style);
//         break;
//       case 16:
//         text = const Text('20', style: style);
//         break;
//       case 17:
//         text = const Text('21', style: style);
//         break;
//       case 18:
//         text = const Text('22', style: style);
//         break;
//       case 19:
//         text = const Text('23', style: style);
//         break;
//
//       default:
//         text = const Text('', style: style);
//         break;
//     }
//
//     return SideTitleWidget(
//       //axisSide: meta.axisSide,
//       meta: meta,
//       child: text,
//     );
//   }
//
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.normal,
//       fontSize: 12,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = leftTitles[0];
//         break;
//       case 2:
//         text = leftTitles[1];
//         break;
//       case 3:
//         text = leftTitles[2];
//         break;
//       case 4:
//         text = leftTitles[3];
//         break;
//       case 5:
//         text = leftTitles[4];
//         break;
//       case 6:
//         text = leftTitles[5];
//         break;
//       case 7:
//         text = leftTitles[6];
//         break;
//       case 8:
//         text = leftTitles[7];
//         break;
//       case 9:
//         text = leftTitles[8];
//         break;
//
//       case 10:
//         text = leftTitles[9];
//         break;
//
//       default:
//         return Container();
//     }
//
//     return Text(text, style: style, textAlign: TextAlign.left);
//   }
//
//   List<String> leftTitles = ['100','200','300','400','500','600','700','800','900','1k'];
//
//   int initialDivideValue = 100;
//
//   setLeftTiles(){
//     if(widget.ownerDashboardController.ownerData!.maxAmount!>0 && widget.ownerDashboardController.ownerData!.maxAmount!<1000){
//       initialDivideValue = 100;
//       leftTitles = ['100','200','300','400','500','600','700','800','900','1k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>1000 && widget.ownerDashboardController.ownerData!.maxAmount!<2000){
//       initialDivideValue = 200;
//       leftTitles = ['200','400','600','800','1k','1.2k','1.4k','1.6k','1.8k','2k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>2000 && widget.ownerDashboardController.ownerData!.maxAmount!<3000){
//       initialDivideValue = 300;
//       leftTitles = ['300','600','900','1.2k','1.5k','1.8k','2.1k','2.4k','2.7k','3k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>3000 && widget.ownerDashboardController.ownerData!.maxAmount!<5000){
//       initialDivideValue = 500;
//       leftTitles = ['500','1k','1.5k','2k','2.5k','3k','3.5k','4k','4.5k','5k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>5000 && widget.ownerDashboardController.ownerData!.maxAmount!<10000){
//       initialDivideValue = 1000;
//       leftTitles = ['1k','2k','3k','4k','5k','6k','7k','8k','9k','10k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>10000 && widget.ownerDashboardController.ownerData!.maxAmount!<20000){
//       initialDivideValue = 2000;
//       leftTitles = ['2k','4k','6k','8k','10k','12k','14k','16k','18k','20k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>20000 && widget.ownerDashboardController.ownerData!.maxAmount!<50000){
//       initialDivideValue = 5000;
//       leftTitles = ['5k','10k','15k','20k','25k','30k','35k','40k','45k','50k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>50000 && widget.ownerDashboardController.ownerData!.maxAmount!<70000){
//       initialDivideValue = 7000;
//       leftTitles = ['7k','14k','21k','28k','35k','42k','49k','56k','63k','70k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>70000 && widget.ownerDashboardController.ownerData!.maxAmount!<100000){
//       initialDivideValue = 10000;
//       leftTitles = ['10k','20k','30k','40k','50k','60k','70k','80k','90k','100k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>100000 && widget.ownerDashboardController.ownerData!.maxAmount!<150000){
//       initialDivideValue = 15000;
//       leftTitles = ['15k','30k','45k','60k','75k','90k','105k','120k','135k','150k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>150000 && widget.ownerDashboardController.ownerData!.maxAmount!<200000){
//       initialDivideValue = 20000;
//       leftTitles = ['20k','40k','60k','80k','100k','120k','140k','160k','180k','200k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>200000 && widget.ownerDashboardController.ownerData!.maxAmount!<300000){
//       initialDivideValue = 30000;
//       leftTitles = ['30k','60k','90k','120k','150k','180k','210k','240k','270k','300k'];
//     }else if(widget.ownerDashboardController.ownerData!.maxAmount!>300000 && widget.ownerDashboardController.ownerData!.maxAmount!<500000){
//       initialDivideValue = 50000;
//       leftTitles = ['50k','100k','150k','200k','250k','300k','350k','400k','450k','500k'];
//     }
//     setGraphData();
//   }
//
// }
