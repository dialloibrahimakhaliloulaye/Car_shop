import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icar/functions.dart';
import 'package:icar/globalVar.dart';
import 'package:icar/homeScreen.dart';

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
  String description;
  String urlImage;
  QuerySnapshot cars;

  CarMethods carObj = CarMethods();

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

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
