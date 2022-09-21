import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chrono',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Chrono'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool chrono = false;
  Icon iconStart = Icon(Icons.play_arrow);

  int sec = 0;
  int min = 0;
  start() async {
    if (!chrono) {
      chrono = true;
      setState(() {
        iconStart = Icon(Icons.pause);
      });

      while (chrono) {
        await Future.delayed(Duration(seconds: 1));
        sec++;
        if (sec >= 60) {
          min++;
          sec = 0;
        }
        setState(() {});
      }
    }else{
      chrono = false;
      setState(() {
        iconStart = Icon(Icons.play_arrow);
      });

    }
  }

  String chronoString() {
    String csec = "";
    if (sec < 10) {
      csec = "0$sec";
    } else {
      csec = sec.toString();
    }
    String cmin = "";
    if (min < 10) {
      cmin = "0$min";
    } else {
      cmin = min.toString();
    }
    return "$cmin:$csec";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              chronoString(),
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'digi',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: iconStart,
                  onPressed: () {
                    start();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    setState(() {
                      sec = 0;
                      min = 0;
                      chrono = false;
                    });
                  }
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
