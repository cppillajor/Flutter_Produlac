//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:produlacmovil/components/chartdefault.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/pages/produccion/ingresar_editar_produccion_global.dart';

class ProduccionPage extends StatefulWidget {
  List lista_fecha_litros;
  int litros_totales;
  ProduccionPage(this.lista_fecha_litros,this.litros_totales);

  @override
  _ProduccionPageState createState() => _ProduccionPageState();
}

class _ProduccionPageState extends State<ProduccionPage> {
  double value = 0;

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
            height: size.height * 0.5852,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Card(
              color: Colors.white,
              elevation: 5,
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: chartDefault(widget.lista_fecha_litros),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              top: 250.0,
            ),
            child: Text("Total de litros: "+widget.litros_totales.toString()) ,
          )
        ],
      ),
    );
  }
}
