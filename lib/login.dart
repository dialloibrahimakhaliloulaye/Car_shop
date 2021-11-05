import 'package:flutter/material.dart';
import 'package:icar/widgets/customTextField.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

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

                },
                child: Text("Connexion", style: TextStyle(color: Colors.white),),
              ),

            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}
