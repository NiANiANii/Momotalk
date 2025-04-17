import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const MomoTalkApp());
}

class MomoTalkApp extends StatelessWidget {
  const MomoTalkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MomoTalk',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      home: const HomePage(),
    );
  }
}
