//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names
import 'dart:math';
import 'package:flutter/material.dart';

class SaludPage extends StatefulWidget {
  SaludPage({Key? key}) : super(key: key);

  @override
  _SaludPageState createState() => _SaludPageState();
}

class _SaludPageState extends State<SaludPage> {
  double value = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Pagina Principal'),
      ),
      body: Stack(
        children: [
          Text('pantlla Salud'),
        ],
      ),
    );
  }
}
