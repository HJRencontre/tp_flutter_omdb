import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart' as lorem;

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text(lorem.lorem(paragraphs: 3, words: 50))));
  }
}
