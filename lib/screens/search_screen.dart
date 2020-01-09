import 'package:flutter/material.dart';

import 'package:floating_search_bar/floating_search_bar.dart';



class SearchBar extends StatefulWidget {
  static const String id='search_screen.dart';
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FloatingSearchBar.builder(
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
        trailing: CircleAvatar(
          child: Image(image:AssetImage('images/lib.jpg')),
        ),
        drawer: Drawer(
          child: Container(),
        ),
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Search from Database",
        ),
      ),
    );
  }
}