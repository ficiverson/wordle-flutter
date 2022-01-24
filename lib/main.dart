
import 'package:flutter/material.dart';
import 'package:wordleconvivientes/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Wordle Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShowLoadingPage(),
    );
  }
}




//TODO
//configurar juegos remotos en gp y app

//palbra contenida en el array o no evaluar???