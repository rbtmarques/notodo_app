import 'package:flutter/material.dart';

class NoDoItem extends StatelessWidget {
  String _itemName;
  String _dateCreated;
  int _id;

  NoDoItem(this._itemName,this._dateCreated);

  // Maping data to an actual object
  NoDoItem.map(dynamic obj){
    this._itemName = obj["itemName"];
    this._dateCreated = obj["dateCreated"];
    this._id = obj["id"];
  }

  String get itemName => _itemName;
  String get dateCreated => _dateCreated;
  int get id => _id;

  //Mapping objects we're getting from the database to the class instance variables
  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map["itemName"] = _itemName;
    map["dateCreated"] = _dateCreated;

    if (_id != null) {
      map["id"] = _id;

    }

    return map;
  }

  //Setting all the items that we're getting from the map to instance vars
  NoDoItem.fromMap(Map<String,dynamic> map){
    this._itemName = map["itemName"];
    this._dateCreated = map["dateCreated"];
    this._id = map["id"];

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child:  Row(
      //  crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(
             child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_itemName,
                    style: new TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.9
                    ),),

                  new Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text("Created on: $dateCreated",
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.5,
                          fontStyle: FontStyle.italic
                      ),),
                  )
                ],
              ),
            )


          ],
      ),
    );
  }
}
