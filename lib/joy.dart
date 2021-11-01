import 'package:flutter/material.dart';

class Lists extends StatefulWidget {
  @override
  _ListsState createState() => _ListsState();
}

class _ListsState extends State<Lists> {
  List<ItemLists> items = [
    ItemLists(
      title: 'Best Music of the Year',
      discription: 'Davido',
      favorite: false,
    ),
    ItemLists(
      title: 'Best Album Cover design',
      discription: 'Brighter Press',
      favorite: false,
    ),
    ItemLists(
      title: 'Best Vocalist',
      discription: 'Simi-Sola',
      favorite: false,
    ),
    ItemLists(
      title: 'Best Danced',
      discription: 'Black Camaru',
      favorite: true,
    ),
    ItemLists(
      title: 'Best Performance',
      discription: 'ShofeniWere',
      favorite: true,
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:
      Container(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Dismissible(
              key: ObjectKey(items[index]),
              child: Card(
                  child: ListTile(
                    leading: new IconButton(
                        icon: Icon(
                          Icons.star,
                          color: items[index].favorite == true ? Colors.green : Colors.grey,
                        ),
                        tooltip: 'Add to Favorite',
                        onPressed: () {
                          setState(() {
                            items[index].favorite = !items[index].favorite;
                          });
                        }),
                    title: Text('${items[index].title}'),
                    subtitle: Text('${items[index].discription}'),
                    trailing:
                    IconButton(icon: Icon(Icons.calendar_today), onPressed: null),
                  )),
            );
          },
        ),
      ),
    );
  }
}
class ItemLists {
  String title;
  String discription;
  bool favorite;

  ItemLists({required this.title, required this.discription, required this.favorite});
}