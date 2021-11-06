import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.refresh, color: Colors.white,),
          onPressed: (){

          },
        ),
        actions: <Widget>[
          TextButton(
              onPressed: (){

              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.person, color: Colors.white,),
              )
          ),
          TextButton(
              onPressed: (){

              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.search, color: Colors.white,),
              )
          ),
          TextButton(
              onPressed: (){

              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.login_outlined, color: Colors.white,),
              )
          )
        ],
        flexibleSpace: Container(
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
        ),
        title: Text("Accueil"),
      ),
      body: Center(
        child: Container(

        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Ajouter l'annonce",
        child: Icon(Icons.add),
        onPressed: (){

        },
      ),
    );
  }
}
