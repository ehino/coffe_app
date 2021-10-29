import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_and_firebase/home/brew_tile.dart';
import 'package:flutter_and_firebase/models/brew.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';


class BrewList extends StatefulWidget {

  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {

    final brews = Provider.of<List<Brew>> (context) ?? [];

    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (context, index) {
        return BrewTile (brew: brews[index]);
      },

    );
  }
}
