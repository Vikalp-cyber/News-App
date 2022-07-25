import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutternews/Categories.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          height: 60,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              autofocus: true,
              controller: searchC,
              autocorrect: true,
              onSubmitted: (v) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryNews(
                        Categories: searchC.text,
                      ),
                    ));
              },
              style: const TextStyle(color: Colors.black),
              cursorColor: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
