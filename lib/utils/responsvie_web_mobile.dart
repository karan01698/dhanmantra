import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResponsiveHelpers {
  static double w(double value) => kIsWeb ? value : value.w;

  static double h(double value) => kIsWeb ? value : value.h;

  static double sp(double value) => kIsWeb ? value : value.sp;

  static double r(double value) => kIsWeb ? value : value.r;
}