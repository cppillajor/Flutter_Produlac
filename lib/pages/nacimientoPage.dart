//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

import 'package:flutter/material.dart';

class NacimientoPage extends StatefulWidget {
  NacimientoPage({Key? key}) : super(key: key);

  @override
  _NacimientoPageState createState() => _NacimientoPageState();
}

class _NacimientoPageState extends State<NacimientoPage> {
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
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Text('pantlla nacimiento'),
        ],
      ),
    );
  }
}
