import 'package:flutter/material.dart';
import 'package:icar/dialogBox/errorDialog.dart';
import 'package:icar/homeScreen.dart';
import 'package:icar/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'globalVar.dart';

class Register extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final TextEditingController _namecontroller = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _passwordconfirmcontroller = TextEditingController();
  final TextEditingController _phoneconfirmcontroller = TextEditingController();
  final TextEditingController _imagecontroller = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(height: 10.0,),
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset("images/images/register.png",
                  height: 270.0,
                ),
              ),
            ),
            SizedBox(height: 8.0,),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    data: Icons.person,
                    controller: _namecontroller,
                    hintText: 'Prenom et Nom',
                    isObscure: false,
                  ),
                  CustomTextField(
                    data: Icons.phone,
                    controller: _phoneconfirmcontroller,
                    hintText: 'Téléphone',
                    isObscure: false,
                  ),
                  CustomTextField(
                    data: Icons.email,
                    controller: _emailcontroller,
                    hintText: 'Email',
                    isObscure: false,
                  ),
                  CustomTextField(
                    data: Icons.camera_alt_outlined,
                    controller: _imagecontroller,
                    hintText: 'Photo',
                    isObscure: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: _passwordcontroller,
                    hintText: 'Mot de passe',
                    isObscure: true,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: _passwordconfirmcontroller,
                    hintText: 'Confirmer mot de passe',
                    isObscure: true,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(width: MediaQuery.of(context).size.width*0.5,
              child: ElevatedButton(
                onPressed: (){
                  _register();
                },
                child: Text("S'inscrire", style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }

  void saveUserData(){
    Map<String, dynamic> userData = {
      'userName': _namecontroller.text.trim(),
      'uId': userId,
      'userNumber': _phoneconfirmcontroller.text.trim(),
      'imgPro': _imagecontroller.text.trim(),
      'time': DateTime.now(),
    };
    FirebaseFirestore.instance.collection('users').doc(userId).set(userData);
  }

  void _register() async{
    User currentUser;
    await _auth.createUserWithEmailAndPassword(email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim())
        .then((auth){
      currentUser = auth.user;
      userId = currentUser.uid;
      userEmail = currentUser.email;
      getUserName = _namecontroller.text.trim();

      saveUserData();
    }).catchError((error){
      Navigator.pop(context);
      showDialog(context: context, builder: (con){
        return ErrorDialog(
          message: error.message.toString(),
        );
      });
    });
    if(currentUser != null){
      Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    }
  }

}
