import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screens/creat_account_screen.dart';
import '../widgets/onboarding_item.dart';



class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}



class _OnboardingScreenState extends State<OnboardingScreen> {

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;


  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.1, 0.4, 0.7, 0.9],
              colors: [
                Color(0xFF3594DD),
                Color(0xFF4563DB),
                Color(0xFF5036D5),
                Color(0xFF5B16D0),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildPageView(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? _buildNextButton()
                     : Text(''),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1
          ? _buildGetStartedButton()
          : Text(''),
    );
  }




  /*
    This Widget responsible to build the Page view
    in the first that the user see when he install
    the app.
  */

    Widget _buildPageView(){
      return Container(
        height: MediaQuery.of(context).size.height * 0.80,
        child: PageView(
          physics: BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: <Widget>[
            OnboadingItem(
              pathImage: 'assets/images/onboarding0.png',
              title: 'Hey YA!',
              subTitle: 'Welcome to the community of the best quiz app that you can find',
            ),
            OnboadingItem(
              pathImage: 'assets/images/onboarding1.png',
              title: 'Live your life smarter\nwith us!',
              subTitle: 'In our app you can learn a lot of new things that can help in your daily life and also your business',
            ),
            OnboadingItem(
              pathImage: 'assets/images/onboarding2.png',
              title: 'Get a new experience\nof imagination',
              subTitle: 'It\'s time to go for new experience and improve your imagination',
            ),
          ],
        ),
      );
    }




  /*
    This Widget responsible to build the Page Indicator
    and return it as a list.
  */

    List<Widget> _buildPageIndicator() {
      List<Widget> list = [];
      for (int i = 0; i < _numPages; i++) {
        list.add(i == _currentPage ? _indicator(true) : _indicator(false));
      }
      return list;
    }




  /*
    This Widget responsible to build the next button
    in the bottom right of the screen (he is stable
    because just the page view that fit 80% of the
    screen scroll).
  */

    Widget _buildNextButton(){
      return Expanded(
        child: Align(
          alignment: FractionalOffset.bottomRight,
          child: FlatButton(
            onPressed: () {
              _pageController.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil.instance.setSp(54),
                  ),
                ),
                SizedBox(width: 10.0),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 20.0,
                ),
              ],
            ),
          ),
        ),
      );
    }




  /*
    This Widget responsible to build the get started button
    (we have a ternary expression in the build method to
     show this button just if we are in the last screen)
  */

    Widget _buildGetStartedButton(){
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new CreatAccountScreen()));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          width: double.infinity,
          color: Colors.white,
          alignment: Alignment.center,
          child: Center(
            child: Text(
              'Get started',
              style: TextStyle(
                color: Color(0xFF5B16D0),
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }




  /*
    This Widget responsible to build the animation of
    the indicators.
  */

    Widget _indicator(bool isActive) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        height: 8.0,
        width: isActive ? 24.0 : 16.0,
        decoration: BoxDecoration(
          color: isActive ? Colors.white : Color(0xFF7B51D3),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      );
    }

}