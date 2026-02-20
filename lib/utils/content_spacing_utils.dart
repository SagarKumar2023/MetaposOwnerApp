import 'package:flutter/cupertino.dart';

class VerticalSpace extends StatelessWidget {
  final double height ;
  const VerticalSpace({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HorizontalSpace extends StatelessWidget {
  final double width ;
  const HorizontalSpace({super.key, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width,);
  }
}

class HorizontalVerticalSpace extends StatelessWidget {
  final double height ;
  final double width ;
  const HorizontalVerticalSpace({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height,width: width,);
  }
}

