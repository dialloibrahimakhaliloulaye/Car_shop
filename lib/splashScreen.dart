import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icar/authenticationScreen.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTimer(){
    Timer(Duration(seconds: 3), () async{
      Route newRoute=MaterialPageRoute(builder: (context) => AuthenticationScreen());
      Navigator.pushReplacement(context, newRoute);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber,
            Colors.green
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp
        )
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("images/images/logo.png"),
            SizedBox(height: 20.0,),
            Text("Car Shop", style: TextStyle(fontSize: 55, color: Colors.white, fontFamily: "Lobster"),)
          ],
        ),
      ),
    );
  }
}
