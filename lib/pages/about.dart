import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Created by qori.dev, with flutter 💙'),
            SizedBox(
              height: 8,
            ),
            Text('Pics of shibes are from shibe.online'),
            SizedBox(
              height: 8,
            ),
            Text('Shiba Vectors by Vecteezy'),
            Text('https://www.vecteezy.com/free-vector/shiba')
          ],
        ),
      ),
    );
  }
}
