import 'package:flutter/material.dart';
import 'package:slideshow/pages/slideshow_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'SlideShow',
      home: SlideShowPage(),
    );
  }
}
