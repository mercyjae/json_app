
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'aim.dart';
import 'joy.dart';

void main() {
  runApp(Aim());
}

class JsonApp extends StatefulWidget {
  const JsonApp({Key? key}) : super(key: key);

  @override
  _JsonAppState createState() => _JsonAppState();
}

class _JsonAppState extends State<JsonApp> {

  Future<List<User>> getUsers() async {
    var data = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    var jsonData = json.decode(data.body);
    List<User> users = [];
    for (var u in jsonData) {
      User user = User(u["userId"], u["id"], u["title"], u["body"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("Users")),
          ),
          body: Container(
            child: FutureBuilder(
              future: getUsers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                print(snapshot.data);
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text("LOADING"),
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(snapshot.data[index].title),
                        subtitle: Text(snapshot.data[index].body),);
                      });
                }
              },
            ),
          ),
        ));
  }
}
   class User{
  final int userId;
  final int id;
  final String title;
  final String body;
  User(this.userId,this.id,this.title,this.body);
}
