import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          title: Text('Список справ'),
          centerTitle: true,
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Твій TODO список!', style: TextStyle(color: Colors.white, fontSize: 25)),
                Padding(padding: EdgeInsets.only(top: 10)),
                ElevatedButton(onPressed: () {
                  Navigator.pushReplacementNamed(context, '/todo');
                }, child: Text('Перейти далі!'))
              ],
            )
          ],
        ));
  }
}
