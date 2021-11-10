import 'package:flutter/material.dart';
import 'package:car_shop/widgets/loadingWidget.dart';

class LoadingDialog extends StatelessWidget {

  final String message;
  const LoadingDialog({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          circularProgress(),
          SizedBox(
            height: 10,
          ),
          Text("Connexion en cours, veuillez patienter..."),
        ],
      ),
    );
  }
}
