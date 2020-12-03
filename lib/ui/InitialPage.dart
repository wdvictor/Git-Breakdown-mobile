import 'package:flutter/material.dart';

class InitPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              child: Image.asset('assets/logo_fundo_br.png'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              'Git Breakdown',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
          ),
          Expanded(
            child: Center(child: Text('V 1.0')),
          ),
        ],
      ),
    );
  }
}
