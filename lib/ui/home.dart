import 'package:flutter/material.dart';
import 'package:notodo_app/ui/NotoDoScreen.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Not to Do"),
        backgroundColor: Colors.black54,
      ),
      body: new Notodo(),
    );
  }
}
