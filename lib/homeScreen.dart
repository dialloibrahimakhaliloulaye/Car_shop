import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:icar/functions.dart';
import 'package:icar/globalVar.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  String userName;
  String userNumber;
  String carPrice;
  String carModel;
  String carColor;
  String description;
  String urlImage;
  String carLocation;
  QuerySnapshot cars;

  CarMethods carObj = CarMethods();

  Future<bool> ShowDialogForAddingData() async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Ajouter Une annonce", style: TextStyle(fontFamily: "Bebas", fontSize: 24, letterSpacing: 2.0),),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "Votre prénom et nom"),
                  onChanged: (value){
                    userName=value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: "Votre numéro téléphone"),
                  onChanged: (value){
                    userNumber=value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: "Prix de la voiture"),
                  onChanged: (value){
                    carPrice=value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: "Marque/Model de la voiture"),
                  onChanged: (value){
                    carModel=value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: "Couler de la voiture"),
                  onChanged: (value){
                    carColor=value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: "Adresse"),
                  onChanged: (value){
                    carLocation=value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: "description de la voiture"),
                  onChanged: (value){
                    description=value;
                  },
                ),
                SizedBox(height: 5.0,),
                TextField(
                  decoration: InputDecoration(hintText: "Image de la voiture"),
                  onChanged: (value){
                    urlImage=value;
                  },
                ),
                SizedBox(height: 5.0,),
              ],
            ),
            actions: [
              ElevatedButton(
                child: Text("Annuler"),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
              ElevatedButton(
                child: Text("Ajouter"),
                onPressed: (){
                  Map<String, dynamic> carData = {
                    'userNama': userName,
                    'uId': userId,
                    'userNumber': userNumber,
                    'carPrice': carPrice,
                    'carModel': carModel,
                    'carColor': carColor,
                    'carLocation': carLocation,
                    'description': description,
                    'urlImage': urlImage,
                    'imgPro': userImageUrl,
                    'time': DateTime.now(),
                  };
                  carObj.addData(carData).then((value){
                    print("Annonce ajoutée avec succès");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).catchError((e){
                    print(e);
                  });
                },
              )
            ],
          );
        }
    );
  }

  getMyData(){
    FirebaseFirestore.instance.collection('users').doc(userId).get().then((results){
      setState(() {
        userImageUrl = results.data()['imgPro'];
        getUserName = results.data()['userName'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userId = FirebaseAuth.instance.currentUser.uid;
    userEmail = FirebaseAuth.instance.currentUser.email;
    getMyData();
  }

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
          ShowDialogForAddingData();
        },
      ),
    );
  }
}
