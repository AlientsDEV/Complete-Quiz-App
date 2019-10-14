import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles{


  static final kTitleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'CM Sans Serif',
    fontSize: ScreenUtil.instance.setSp(26.0),
    height: 1.5,
  );

  static final kSubtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: ScreenUtil.instance.setSp(14.0),
    height: 1.2,
  );


}