import 'dart:async';
import 'package:multi_quiz/screens/score_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/providers.dart';
import './home_screen.dart';


class QuizScreen extends StatefulWidget {

  final String url;
  QuizScreen({this.url});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}



class _QuizScreenState extends State<QuizScreen> {


  Timer _timer;
  int _start = 3;
  bool isiInit = true;
  bool isSelected = false;
  int index = 0;
  var questions;
  int score = 0;
  bool isLoading = false;




  /*
    This Widget responsible to build the time when we boot
    this screen
  */

    void startTimer() {
      const oneSec = const Duration(seconds: 1);
      _timer = new Timer.periodic(
        oneSec,
            (Timer timer) => setState(
              () {
            if (_start < 1) {
              timer.cancel();
              setState(() {

              });
            } else {
              _start = _start - 1;
            }
          },
        ),
      );
    }



  /* start the timer in the init State method. */

    @override
    void initState() {
      super.initState();
      startTimer();
    }



    /* Get the list of Questions from the provider class */

      @override
      void didChangeDependencies() {
        super.didChangeDependencies();
        if(isiInit){
          setState(() {
            isiInit = true;
          });
          Provider.of<Category>(context).getQuestion(widget.url).then((docs){
            questions = docs;
          });
          setState(() {
            isiInit = false;
          });
          //questions = Provider.of<Category>(context);
          isiInit = false;
        }
      }



    /* Dispose the time */

      @override
      void dispose() {
        _timer.cancel();
        super.dispose();
      }



    /* dismiss the dialog */
      _dismissDialog() {
        Navigator.pop(context);
      }




    /*
        This method call when we press the back
        button of the phone to show a dialog to
        make sure if the user want to exit the quiz.
    */

        Future<bool> _willPopCallback(BuildContext context) async {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Exit the quiz'),
                  content: Text('Are you sure?'),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          _dismissDialog();
                        },
                        child: Text('Close')),
                    FlatButton(
                      onPressed: () {
                        print('Yes');
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            HomeScreen()), (Route<dynamic> route) => false);
                        //_dismissDialog();
                      },
                      child: Text('Yes'),
                    )
                  ],
                );
              });
        }




        /* THE BUILD METHOD */

          @override
          Widget build(BuildContext context) {
            return WillPopScope(
              onWillPop: () => _willPopCallback(context),
              child: Scaffold(
                body: Center(
                  child: _start > 0
                    ? Text(
                        '$_start',
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold
                        ),
                      )
                    :  _buildColumnWidget()
                ),
              ),
            );
          }




          /*  This widget responsible to build the Question
              and the Answers
          */

            Widget _buildColumnWidget(){
              return isLoading ? CircularProgressIndicator() : ListView(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: Stack(
                          children: <Widget>[
                            _buildContentBlue(),
                            _buildCounterCircle(),
                          ],
                        )
                    ),
                    SizedBox(height: 30.0,),
                    _buildSingleQuestion(questions[index].answers[0]),
                    SizedBox(height: 20.0,),
                    _buildSingleQuestion(questions[index].answers[1]),
                    SizedBox(height: 20.0,),
                    _buildSingleQuestion(questions[index].answers[2]),
                    SizedBox(height: 20.0,),
                    _buildSingleQuestion(questions[index].answers[3]),
                    SizedBox(height: 30.0,),
                    index == 9 ? _buildFinishButton() : _buildButton()
                  ]
              );
            }




        Widget _buildContentBlue(){
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(100.0),
                  bottomRight: Radius.circular(100.0),
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.5),
                    Colors.blue
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  questions[index].question,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold
                  ),
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          );
        }




      Widget _buildCounterCircle(){
        return Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            height: 60.0,
            width: 60.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey,width: 2)
            ),
            child: RichText(
              text: TextSpan(
                text: '${index+1}',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
                ),
                children: [
                  TextSpan(
                    text: '/10',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13.0
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }




        Widget _buildSingleQuestion(String question){
          return InkWell(
            onTap: (){
              setState(() {
                isSelected = true;
                if(question == questions[index].correctAnswer)
                  score+=10;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.09,
              margin: EdgeInsets.only(left: 15.0,right: 15.0),
              padding: EdgeInsets.only(left: 15.0,right: 15.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 3
                  ),
                ],
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: !isSelected
                  ? Text(question)
                  : (question == questions[index].correctAnswer
                        ? AutoSizeText(
                            question,
                            style: TextStyle(color: Colors.green,fontSize: 17.0,fontWeight: FontWeight.bold),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                        )
                        : AutoSizeText(question,style: TextStyle(color: Colors.red),maxLines: 2,)
                    ),
            ),
          );
        }




          Widget _buildFinishButton(){
            return InkWell(
              onTap: (){
                if(index == 9)
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder:(context)=> ScoreScreen(newScore: score,))
                  );
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60.0,
                  width: 150.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        width: 150.0,
                        alignment: Alignment.center,
                        child: Text(
                          'Finish',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(10.0)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }




        Widget _buildButton(){
          return Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: (){
                  setState(() {
                    isSelected = true;
                  });
                  Timer(Duration(milliseconds: 1000),(){
                    setState(() {
                      isSelected = false;
                      if(index < 9)
                        index++;
                      if(index > 9)
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder:(context)=> ScoreScreen(newScore: score,))
                        );
                      print('idnex : $index');
                    });
                  });
                },
                child: Container(
                  height: 50.0,
                  width: 130.0,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0.0,
                        left: 15.0,
                        child: Container(
                          height: 40.0,//height
                          width: 40.0,//width
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Container(
                        height: 70.0,
                        width: 150.0,
                        alignment: Alignment.center,
                        child: Text(
                          'Next' ,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          );
        }
      }