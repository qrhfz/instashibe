import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Created by qori.dev, with flutter 💙'),
            const SizedBox(
              height: 8,
            ),
            const Text('Pics of shibes are from shibe.online'),
            const SizedBox(
              height: 8,
            ),
            const Text('Shiba Vectors by Vecteezy'),
            const Text('https://www.vecteezy.com/free-vector/shiba')
          ],
        ),
      ),
    );
  }
}
