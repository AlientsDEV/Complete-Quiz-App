import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_quiz/utilities/styles.dart';


class OnboadingItem extends StatelessWidget{

  final String pathImage;
  final String title;
  final String subTitle;
  OnboadingItem({this.subTitle,this.title,this.pathImage});


  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image(
              image: AssetImage(pathImage,),
              height: MediaQuery.of(context).size.width * 0.6,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
          SizedBox(height: 40.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'CM Sans Serif',
              fontSize: ScreenUtil.instance.setSp(75.0),
              //height: 1.5,
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: ScreenUtil.instance.setSp(40.0),
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

}