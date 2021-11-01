import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Aim extends StatefulWidget {
  const Aim({Key? key}) : super(key: key);

  @override
  _AimState createState() => _AimState();
}

class _AimState extends State<Aim> {
  Future<List<Album>> getAlbums() async{
    var data = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var albumBook = json.decode(data.body);
    List <Album> albums =[];
    for (var y in albumBook){
      Album album = Album(y["albumId"], y["id"], y["title"], y["url"], y["thumbnailUrl"]);
      albums.add(album);
    }
    return albums;
  }

  @override
  void initState() {
    getAlbums();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Album Book",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
        ),
        body: Container(
            child: FutureBuilder(
                future: getAlbums(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Sending....")));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    snapshot.data[index].thumbnailUrl),
                              ),
                              title: Text(snapshot.data[index].id.toString()),
                              subtitle: Text(
                                snapshot.data[index].title,
                              ));
                        });
      }})
    ),),);
  }
}
class Album{
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;
  Album(this.albumId,this.id,this.title,this.url,this.thumbnailUrl);
}