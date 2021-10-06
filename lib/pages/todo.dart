import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Todo extends StatefulWidget {
  const Todo({Key? key}) : super(key: key);

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  List _todoList = [];
  String _tempListElement = "";

  void initFireBase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  @override
  void initState() {
    super.initState();
    initFireBase();

    _todoList
        .addAll(['Buy milk', 'Buy bread', 'Make some work', 'Пограй футбол']);
  }

  void _openMenu() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(title: Text('Меню')),
          body: Row(
            children: [
              Column(
                children: [
                  ElevatedButton(
                      child: Text('На головну'),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      }),
                ],
              ),
            ],
          ));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: Text('Список справ'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.menu), onPressed: _openMenu)],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('todo_items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData) return Text('Немає записів');
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(snapshot.data!.docs[index].id),
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data!.docs[index].get('item')),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.deepOrange),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('todo_items').doc(snapshot.data!.docs[index].id).delete();
                          },
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      FirebaseFirestore.instance.collection('todo_items').doc(snapshot.data!.docs[index].id).delete();
                    });
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Додати елемент',
                      textAlign: TextAlign.center,
                    ),
                    content: TextField(
                      onChanged: (String value) {
                        _tempListElement = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            FirebaseFirestore.instance.collection('todo_items').add(
                                {
                                  'item': _tempListElement
                                });

                            Navigator.of(context).pop();
                          },
                          child: Text('Додати елемент'))
                    ],
                  );
                });
          },
          child: Icon(Icons.add_box_outlined, color: Colors.deepOrange)),
    );
  }
}
