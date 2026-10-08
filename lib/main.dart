import 'package:flutter/material.dart';

void main() {
  runApp(const ConnectMeApp());
}

class ConnectMeApp extends StatelessWidget {
  const ConnectMeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ConnectMe',
      home: Scaffold(
        body: Center(child: Text('ConnectMe', style: TextStyle(fontSize: 28))),
      ),
    );
  }
}
