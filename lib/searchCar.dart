import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icar/homeScreen.dart';

class SearchCar extends StatefulWidget {
  //const SearchCar({Key? key}) : super(key: key);

  @override
  _SearchCarState createState() => _SearchCarState();
}

class _SearchCarState extends State<SearchCar> {

  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  String carModel;
  String carColor;
  QuerySnapshot cars;

  Widget _buildSearchField(){
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Cherchez ici...",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white30),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  List<Widget> _buildActions(){
    if(_isSearching){
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: (){
            if(_searchQueryController == null || _searchQueryController.text.isEmpty){
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        )
      ];
    }
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.search),
        onPressed: _startSearch,
      )
    ];
  }

  _startSearch(){
    ModalRoute.of(context).addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _isSearching = true;
    });
  }

  _stopSearching(){
    _clearSearchQuery();
    setState(() {
      _isSearching = false;
    });
  }

  _clearSearchQuery(){
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }

  _buildTitle(BuildContext context){
    return Text("Rechercher une voiture");
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

  updateSearchQuery(String newQuery){
    setState(() {
      getResults();
      searchQuery = newQuery;
    });
  }

  getResults(){
    FirebaseFirestore.instance.collection('cars')
        .where('carModel', isGreaterThanOrEqualTo: _searchQueryController.text.trim()).get().then((results){
       setState(() {
         cars = results;
         print("Ceci est le resultat de recherche ...");
         print("resultat = " + (cars.docs[0].data() as Map)['carModel']);
       });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isSearching ? const BackButton() : _buildBackButton(),
        title: _isSearching ? _buildSearchField() : _buildTitle(context),
        actions: _buildActions(),
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
