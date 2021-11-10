import 'package:flutter/material.dart';
import 'package:car_shop/login.dart';
import 'package:car_shop/register.dart';

class AuthenticationScreen extends StatefulWidget {

  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.amber,
                    Colors.green,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp
                )
              ),
            ),
            title: Text("Car Shop",
              style: TextStyle(fontSize: 60.0, color: Colors.white, fontFamily: "Lobster"),
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.lock, color: Colors.white,),
                  text: "Se connecter",
                ),
                Tab(
                  icon: Icon(Icons.person, color: Colors.white,),
                  text: "S'inscrire",
                )
              ],
              indicatorColor: Colors.white38,
              indicatorWeight: 5.0,

            ),
          ),
          body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.green,
                        Colors.amber,
                      ],
                  )
              ),
            child: TabBarView(
              children: [
                Login(),
                Register(),
              ],
            ),
          ),
        )
    );
  }
}
