import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../models/categoryItem.dart';
import '../screens/quiz_screen.dart';
import '../models/providers.dart';


class HomeScreen extends StatefulWidget{

  @override
  _Home2State createState() => _Home2State();
}


class _Home2State extends State<HomeScreen> {

  String username;
  TextStyle firstTextStyle;
  int score = 0;
  int level = 1;



  @override
  void initState() {
    super.initState();
    getUser();
    getScoreAndLevel();
  }



  /*
    This method responsible to get the score and the level
    from the SharedPreferences and store it variables after
    check if exist or not.
  */

    getScoreAndLevel()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if(prefs.getInt('score') == null)
        score= 0;
      else
        score = prefs.getInt('score');
      if(prefs.getInt('level') == null)
        level = 0;
      else
        level = prefs.getInt('level');
    }



  /*
    This method responsible to get the username from
    the SharedPreferences
  */

    getUser()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        username = prefs.getString('username');
      });
    }




  /*  This build method */

    @override
    Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    firstTextStyle = TextStyle(
      fontSize: MediaQuery.of(context).size.width * 0.065,
      letterSpacing: 1.1,
      color: Colors.white,
      height: 1.3,
      fontFamily: 'VarelaRound Regular',
    );

    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Column(
              children: <Widget>[
                _buildBlueContainer(),
                SizedBox(height: 15.0,),
                _chooseCategoryText(),
                _buildGridItem(),
                SizedBox(height: 20.0,),
              ],
            ),
          ],
        ),
      ),
    );
  }




  /*
    This method responsible to draw the Blue Container
    with the circles and the WELCOME text in the left,
    and also the white Container that contain the level
    and the score of the user,
  */

    Widget _buildBlueContainer(){
      return Container(
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                  ),
                  color: Colors.lightBlueAccent,
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20.0,top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 5.0,
                        height: MediaQuery.of(context).size.height * 0.15,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0)
                        ),
                      ),
                      SizedBox(width: 10.0,),
                      _buildFirstText(),
                    ],
                  ),
                ),
              ),
              _buildCircles(-30.0, -30.0, 150.0, 150.0),
              _buildCircles(-30.0, -50.0, 100.0, 100.0),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 2.0),
                    alignment: Alignment.center,
                    height: MediaQuery.of(context).size.height * 0.12,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              spreadRadius: 5
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _buildScoreAndLevel('Level', "10"),
                        Container(
                          width: 1.0,
                          height: 20.0,
                          color: Colors.blue,
                        ),
                        _buildScoreAndLevel('Score', '3520')
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
      );
    }




  /*
    This method responsible to build the circles in
    the blue container based on the values passed to it.
  */

    Widget _buildCircles(double right, double top , double width, double height){
      return Positioned(
        right: right,//-30.0
        top: top,//-30.0
        child: Container(
          height: height,//height
          width: width,//width
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.3),
              shape: BoxShape.circle
          ),
        ),
      );
    }




  /*
    This method responsible to build a Single Column
    that inside the white container in the center of
    the blue Container.
    Ex =>(Level , 05)
  */

    Widget _buildScoreAndLevel(String text, String value){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                fontSize: 12.0,
                color: Colors.blue.shade200
            ),
          ),
          Text(
            value,
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade400
            ),
          )
        ],
      );
    }




  /*
    This method responsible to build the first text
    (the welcome text with the name of the user).
  */

    Widget _buildFirstText(){
      return RichText(
        text: TextSpan(
          text: 'Hello ',
          style: firstTextStyle,
          children: <TextSpan>[
            TextSpan(
                text: username,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.065,//ScreenUtil.instance.setSp(70.0),
                  letterSpacing: 1.1,
                  color: Colors.black,
                  height: 1.3,
                  fontFamily: 'VarelaRound Regular',
                ),
              ),
            TextSpan(
              text: '\nwhat would you\nlike to play?',
              style: firstTextStyle
            )
          ]
        ),
      );
    }




  /*
    This widget responsible to build choose Category text
  */

    Widget _chooseCategoryText(){
      return Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'Choose your categories',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }




  /*
    This widget responsible to build the Grid view
    in the center of the screen
  */

  Widget _buildGridItem(){
    return GridView.builder(
        padding: const EdgeInsets.only(left: 20.0,right: 20.0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.height > 800 ? 3 : 2 ,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.0
        ),
        itemCount: listOfCategories.length,
        itemBuilder: (context,index){
          return GestureDetector(
            onTap: (){
              Provider.of<Category>(context).getQuestion(listOfCategories[index].url);
              setState(() {
                listOfCategories[index].isSelected = true;
              });
              Timer(Duration(milliseconds: 200),(){
                Navigator.of(context).push(
                    new MaterialPageRoute(builder: (context) => new QuizScreen(url: listOfCategories[index].url,)));
                setState(() {
                  listOfCategories[index].isSelected = false;
                });
              });
            },
            child: Container(
              margin: EdgeInsets.all(5.0),
              decoration:  BoxDecoration(
                  gradient: listOfCategories[index].isSelected
                    ? LinearGradient(
                        colors: [
                          Colors.lightBlue.withOpacity(0.9),
                          Colors.lightBlueAccent .withOpacity(0.2)
                        ],
                        begin: Alignment.bottomLeft,
                        end: Alignment.centerRight
                      )
                    : LinearGradient(
                        colors: [
                         Colors.white,
                          Colors.white,
                        ],
                      ),
                  borderRadius: BorderRadius.circular(10.0),
                  color:  listOfCategories[index].isSelected ? Colors.white : Colors.white ,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 3
                    ),
                  ]
              ),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    listOfCategories[index].pathImage,
                    height: 60.0,
                    width: 60.0,
                  ),
                  SizedBox(height: 25.0,),
                  Text(
                    listOfCategories[index].title,
                    style: TextStyle(
                        fontSize: 13.0,
                        fontFamily: 'Ubuntu Regular'
                    ),
                    //style: ,
                  )
                ],
              ),
            ),
          );
        }
    );
  }
}


