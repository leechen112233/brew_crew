import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/brew.dart';
import 'brew_tile.dart';

class BrewList extends StatefulWidget {
  const BrewList({super.key});

  @override
  State<BrewList> createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context);
    
    return ListView.builder(
      itemCount: brews.length,
      itemBuilder: (BuildContext context, int index) { 
        return BrewTile(brew: brews[index]);
       },
      
    );
  }
}