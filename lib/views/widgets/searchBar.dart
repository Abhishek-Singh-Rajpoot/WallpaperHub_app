import 'package:flutter/material.dart';
import 'package:wallpaper/views/screens/search.dart';
import 'package:flutter/services.dart';

class Searchbar extends StatelessWidget {
  Searchbar({super.key});

  TextEditingController _serchControlaer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 21),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(29)),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _serchControlaer,
              decoration:
                  InputDecoration(border: InputBorder.none, hintText: 'Search'),
            ),
          ),
          InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchPage(query: _serchControlaer.text)));
              },
              child: Icon(Icons.search))
        ],
      ),
    );
  }
}
