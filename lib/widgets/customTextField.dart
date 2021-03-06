import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObscure = true;

  CustomTextField({Key key, this.controller, this.data, this.hintText, this.isObscure})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
           _screenHeight = MediaQuery.of(context).size.width;

    return Container(
      width: _screenWidth * 0.8,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: EdgeInsets.all(3.0),
      margin: EdgeInsets.all(10),
      child: TextFormField(
        style: TextStyle(fontSize: 20),
        controller: controller,
        obscureText: isObscure,
        cursorColor: Theme.of(context).primaryColor,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            data,
            color: Colors.cyan,
          ),
          focusColor: Theme.of(context).primaryColor,
          hintText: hintText,
        ),
      ),
    );
  }
}
