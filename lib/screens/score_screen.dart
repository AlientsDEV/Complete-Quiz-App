import 'package:flutter/material.dart';
import 'package:multi_quiz/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ScoreScreen extends StatefulWidget{

  final int newScore;
  ScoreScreen({this.newScore});

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {


  String pathImage = '';
  int level = 1;
  int score = 0;
  bool isLoading = false;
  String subTitle = '';



      @override
      void initState() {
        super.initState();
        setState(() {
          isLoading = true;
        });
        setScore();
        configureScreenByScore();
        setState(() {
          isLoading = false;
        });
      }



      setScore()async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        int previousScore= 0;
        if(prefs.getInt('score') == null) {
          previousScore = 0;
        }else {
          previousScore = prefs.getInt('score');
        }
        int stableScore = previousScore + widget.newScore;
        prefs.setInt('score', stableScore);
        checkLevel(stableScore);
      }



      checkLevel(int score) async{
        if(score > 80)
          level = 1;
        if(score> 150)
          level = 2;
        if(score> 300)
          level = 3;
        if(score > 500)
          level = 4;
        if(score > 750)
          level = 5;
        if(score > 1100)
          level = 6;
        if(score > 1500)
          level = 7;
        if(score > 2000)
          level = 8;
        if(score > 2700)
          level = 9;
        if(score > 3500)
          level = 10;
        setState(() {

        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('level', level);
      }



      configureScreenByScore(){
        if(widget.newScore == 0){
          pathImage = 'assets/images/try_again.png';
          subTitle = 'Try next time';
        }
        else if(widget.newScore <= 30){
          pathImage = 'assets/images/copper.png';
          subTitle = 'You are close';
        }
        else if(widget.newScore > 30 && widget.newScore <= 70) {
          pathImage = 'assets/images/silver.png';
          subTitle = 'Great Job';
        }
        else if(widget.newScore > 70){
          pathImage = 'assets/images/gold.png';
          subTitle = 'Congratulations';
        }
      }



      @override
      Widget build(BuildContext context) {

        return WillPopScope(
          child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.blue.withOpacity(0.5)
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      pathImage,
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                    SizedBox(height: 20.0,),
                    Text(
                      '$subTitle',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                        fontFamily: 'PlayfairDisplay Regular',
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1,
                      ),
                    ),
                    SizedBox(height: 40.0,),
                    _buildResult(),
                    SizedBox(height: 30.0,),
                    FlatButton.icon(
                      padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 10.0),
                      icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
                      label: Text(
                        'Go home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                    )
                  ],
                ),
              ),
            )
          ),
          onWillPop: (){
              return;
          },
        );
      }



      Widget _buildResult(){
        return Align(
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
                _buildScoreAndLevel('Level', level.toString()),
                Container(
                  width: 1.0,
                  height: 20.0,
                  color: Colors.blue,
                ),
                _buildScoreAndLevel('Score', widget.newScore.toString())
              ],
            ),
          ),
        );
      }



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
}