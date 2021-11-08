import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icar/functions.dart';
import 'package:icar/globalVar.dart';
import 'package:icar/homeScreen.dart';
import 'package:timeago/timeago.dart' as tAgo;

class ProfileScreen extends StatefulWidget {
  //const ProfileScreen({Key? key}) : super(key: key);

  String sellerId;
  ProfileScreen({this.sellerId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  FirebaseAuth auth = FirebaseAuth.instance;
  String userName;
  String userNumber;
  String carPrice;
  String carModel;
  String carColor;
  String carLocation;
  String description;
  String urlImage;
  QuerySnapshot cars;

  CarMethods carObj = CarMethods();

  Future<bool> showDialogForUpdateData(selectedDoc) async{
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Modifier cette annonce", style: TextStyle(fontFamily: "Bebas", fontSize: 24, letterSpacing: 2.0),),
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
                child: Text("Modifier"),
                onPressed: (){
                  Navigator.pop(context);
                  Map<String, dynamic> carData = {
                    'userNama': userName,
                    'userNumber': userNumber,
                    'carPrice': carPrice,
                    'carModel': carModel,
                    'carColor': carColor,
                    'carLocation': carLocation,
                    'description': description,
                    'urlImage': urlImage,
                  };
                  carObj.updataData(selectedDoc, carData).then((value){
                    print("Annonce Modifiée avec succès");
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext c) => HomeScreen()));
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

  Widget _buildBackButton(){
    return IconButton(
        onPressed: (){
          Route newRoute = MaterialPageRoute(builder: (_) => HomeScreen());
          Navigator.pushReplacement(context, newRoute);
        },
        icon: Icon(Icons.arrow_back, color: Colors.white,)
    );
  }

  Widget _buildUserImage(){
    return Container(
      width: 50,
      height: 40,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: NetworkImage(adUserImageUrl,),
              fit: BoxFit.fill
          )
      ),
    );
  }

  getResults(){
    FirebaseFirestore.instance.collection('cars').where('uId', isEqualTo: widget.sellerId)
        .get().then((results){
          setState(() {
            cars = results;
            adUserName = (cars.docs[0].data() as Map)['userNama'];
            adUserImageUrl = (cars.docs[0].data() as Map)['imgPro'];
          });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getResults();
  }

  Widget showCarsList(){
    if(cars != null){
      return ListView.builder(
        itemCount: cars.docs.length,
        padding: EdgeInsets.all(8.0),
        itemBuilder: (context, i){
          return Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                    leading: GestureDetector(
                      onTap: (){
                        Route newRoute = MaterialPageRoute(builder: (_) => ProfileScreen(
                          sellerId: (cars.docs[i].data() as Map)['uId'],
                        ));
                        Navigator.pushReplacement(context, newRoute);
                      },
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage((cars.docs[i].data() as Map)['imgPro'],),
                                fit: BoxFit.fill
                            )
                        ),
                      ),
                    ),
                    title: GestureDetector(
                      onTap: (){
                        Route newRoute = MaterialPageRoute(builder: (_) => ProfileScreen(
                          sellerId: (cars.docs[i].data() as Map)['uId'],
                        ));
                        Navigator.pushReplacement(context, newRoute);
                      },
                      child: Text((cars.docs[i].data() as Map)['userNama']?? "-"),
                    ),
                    subtitle: GestureDetector(
                      onTap: (){

                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            (cars.docs[i].data() as Map)['carLocation']?? "-",
                            style: TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                          SizedBox(width: 4.0,),
                          Icon(Icons.location_pin, color: Colors.grey,)
                        ],
                      ),
                    ),
                    trailing: (cars.docs[i].data() as Map)['uId'] == userId ?
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: (){
                            if((cars.docs[i].data() as Map)['uId'] == userId){
                              showDialogForUpdateData(cars.docs[i].id);
                            }
                          },
                          child: Icon(Icons.edit_outlined,),
                        ),
                        SizedBox(width: 20,),
                        GestureDetector(
                          onTap: (){
                            if((cars.docs[i].data() as Map)['uId'] == userId){
                              carObj.deleteData(cars.docs[i].id);
                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext c) => HomeScreen()));
                            }
                          },
                          child: Icon(Icons.delete_forever_sharp,),
                        ),
                      ],
                    )
                        : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network((cars.docs[i].data() as Map)['urlImage']?? "-", fit: BoxFit.fill,),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    (cars.docs[i].data() as Map)['carPrice'] +' FCFA',
                    style: TextStyle(fontFamily: 'Bebas', letterSpacing: 2.0, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.directions_car),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              child: Text((cars.docs[i].data() as Map)['carModel']?? "-"),
                              alignment: Alignment.topLeft,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.watch_later_outlined),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              child: Text(tAgo.format(((cars.docs[i].data() as Map)['time']?? "-").toDate())),
                              alignment: Alignment.topLeft,
                            ),

                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.brush_outlined),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              child: Text((cars.docs[i].data() as Map)['carColor']?? "-"),
                              alignment: Alignment.topLeft,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.phone_android),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Align(
                              child: Text((cars.docs[i].data() as Map)['userNumber']?? "-"),
                              alignment: Alignment.topRight,
                            ),

                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 15.0),
                  child: Text(
                    (cars.docs[i].data() as Map)['description']?? "-",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                ),
                SizedBox(height: 10.0,),
              ],
            ),
          );
        },
      );
    }
    else{
      return Text("En chargement");
    }
  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width,
        _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: _buildBackButton(),
        title: Row(
          children: [
            _buildUserImage(),
            SizedBox(width: 10,),
            Text(adUserName),
          ],
        ),
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
      ),
      body: Center(
        child: Container(
          width: _screenWidth * 0.8,
          child: showCarsList(),
        ),
      ),
    );
  }
}
