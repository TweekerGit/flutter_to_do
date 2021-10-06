import 'package:flutter/material.dart';
import 'package:to_do_list/pages/todo.dart';
import 'package:to_do_list/pages/main_screen.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.deepPurple),
    initialRoute: '/',
    routes: {
      '/': (context) => MainScreen(),
      '/todo': (context) => Todo(),
    },
));
