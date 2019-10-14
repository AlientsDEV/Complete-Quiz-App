import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../screens/home_screen.dart';



class CreatAccountScreen extends StatefulWidget{

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  _CreatAccountScreenState createState() => _CreatAccountScreenState();
}



class _CreatAccountScreenState extends State<CreatAccountScreen> {

  bool isLoad = true;
  String userName;


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildImage(),
            //SizedBox(height: 20.0,),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      'Username',
                      style: TextStyle(
                        color: Colors.purple
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0,),
                  _buildForm(),
                  SizedBox(height: 25.0,),
                  isLoad
                    ? _buildStartButton()
                    : Center(child:CircularProgressIndicator())
                ],
              ),
            )
          ],
        ),
      )
    );
  }


  /*
    this widget responsible to get the username
  */

    Widget _buildForm(){
      return Form(
        key: CreatAccountScreen._formKey,
        child: TextFormField(
          initialValue: '',
          decoration: InputDecoration(
            fillColor: Colors.purpleAccent,
            hoverColor: Colors.purpleAccent,
            hintText: 'Must be at least 5 characters',
            border: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.purple,width: 2.0),
              borderRadius: BorderRadius.circular(3.0),
            ),
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.grey
            ),
          ),
          onSaved: (String value) {
            userName = value;
          },
          validator: (String value) {
           if(value.trim() == null)
             return 'empty fields';
           if(value.trim().length < 5)
             return 'username smal than 5 character';
           if(value.trim().length > 12)
             return 'Username too long';
           return null;
          },
        ),
      );
    }


  /*
    This method responsible to handle the submit functionality
    when th user click to the start button.
  */

    void submit(){
      final form = CreatAccountScreen._formKey.currentState;
      if(form.validate()) {
       setState(() {
         isLoad = false;
       });
       form.save();
       Timer(Duration(seconds: 2,),()async{
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('username', userName);
        form.reset();
        Navigator.of(context).pushReplacement(
            new MaterialPageRoute(builder: (context) => new HomeScreen()));
        setState(() {
          isLoad = true;
        });
       });
      }
    }



  /*
    Build the start button
  */

    Widget _buildStartButton(){
      return GestureDetector(
        onTap: submit,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 50.0,
          child: Text(
            'START',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.deepPurple
                ],
              ),
              color: Colors.purpleAccent,
              borderRadius: BorderRadius.circular(5.0)
          ),
        ),
      );
    }



  /*
      This widget is responsible to build
      the Image in top of the scree
  */

     Widget _buildImage(){
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.67,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/creat_account_image.jpg',),
              //fit: BoxFit.cover,
            ),
          ),
        );
     }
}