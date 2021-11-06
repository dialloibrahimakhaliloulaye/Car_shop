import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icar/dialogBox/errorDialog.dart';
import 'package:icar/homeScreen.dart';
import 'package:icar/widgets/customTextField.dart';
import 'package:icar/widgets/loadingDialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Image.asset("images/images/login.png",
                  height: 270.0,
                ),
              ),
            ),
            Form(
              key: _formkey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    data: Icons.person,
                    controller: _emailcontroller,
                    hintText: 'Email',
                    isObscure: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: _passwordcontroller,
                    hintText: 'Mot de passe',
                    isObscure: true,
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: _screenWidth*0.5,
              child: ElevatedButton(
                onPressed: (){
                  _emailcontroller.text.isNotEmpty && _passwordcontroller.text.isNotEmpty
                      ? _login() : showDialog(
                      context: context,
                      builder: (con){
                        return ErrorDialog(
                          message: "Veuillez saisir correctement le formulaire",
                        );
                      });
                },
                child: Text("Connexion", style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }

  void _login() async{
    showDialog(context: context, builder: (con){
      return LoadingDialog(
        message: 'Patienter SVP',
      );
    });
    User currentUser;

    await _auth.signInWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim(),
    ).then((auth){
      currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (con){
            return ErrorDialog(
              message: error.message.toString(),
            );
          });
    });
    if(currentUser != null){
      Navigator.pop(context);
      Route newRoute = MaterialPageRoute(builder: (context) => HomeScreen());
      Navigator.pushReplacement(context, newRoute);
    }
    else {
      print("error");
    }
  }

}
