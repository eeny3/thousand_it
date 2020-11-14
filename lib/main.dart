import 'package:flutter/material.dart';
import 'feed_screen.dart';

bool showSpinner = false;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FeedScreen(),
    );
  }
}