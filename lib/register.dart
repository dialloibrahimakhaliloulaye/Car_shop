import 'package:flutter/material.dart';
import 'package:icar/widgets/customTextField.dart';

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
                    controller: _namecontroller,
                    hintText: 'Photo',
                    isObscure: false,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: _namecontroller,
                    hintText: 'Mot de passe',
                    isObscure: true,
                  ),
                  CustomTextField(
                    data: Icons.lock,
                    controller: _namecontroller,
                    hintText: 'Confirmer mot de passe',
                    isObscure: false,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(width: MediaQuery.of(context).size.width*0.5,
              child: ElevatedButton(
                onPressed: (){

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
}
