//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:produlacmovil/components/chartdefault.dart';
import 'package:produlacmovil/components/chartdefaultprodindividual.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';

class ProduccionIndividualPage extends StatefulWidget {
  List lista;
  ProduccionIndividualPage(this.lista) ;

  @override
  _ProduccionIndividualPageState createState() => _ProduccionIndividualPageState();
}

class _ProduccionIndividualPageState extends State<ProduccionIndividualPage> {
  double value = 0;

  DateTime selectedDate = DateTime.now();
  String _selectedDate_a_enviar="";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Produccion'),
      ),
      body: Stack(
        children: [
          Container(
            //height: 400.0,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Card(
                  color: Colors.white,
                  elevation: 5,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: chartDefaultProdIndividual(widget.lista),
                ),
                
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }
  
}
