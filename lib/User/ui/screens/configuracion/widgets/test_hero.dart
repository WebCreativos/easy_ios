import 'package:flutter/material.dart';

class TestHero extends StatefulWidget {
  @override
  _TestHeroState createState() => _TestHeroState();
}

class _TestHeroState extends State<TestHero> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Hero(
            tag: "test",
            child: Text("23"),
          ),
        ),
      ),
    );
  }
}
