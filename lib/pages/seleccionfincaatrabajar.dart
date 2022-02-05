// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'package:produlacmovil/pages/drawer/navigation_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

class SeleccioneFincaATrabajar extends StatefulWidget {
  List lista_fincas;
  SeleccioneFincaATrabajar(this.lista_fincas);
  @override
  _SeleccioneFincaATrabajarState createState() =>
      _SeleccioneFincaATrabajarState();
}

class _SeleccioneFincaATrabajarState extends State<SeleccioneFincaATrabajar> {
  String select_fin_id = "";

  @override
  void initState() {
    super.initState();

    if (widget.lista_fincas.length >= 1) {
      select_fin_id = widget.lista_fincas[0]['fin_id'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFECF3F9),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: size.width * 0.439,
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 8),
                color: const Color(0xFF2E90FF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ),
          buildBottomHalfContainer(true),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: 100,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: size.height - 600,
              padding: const EdgeInsets.all(20),
              width: size.width - 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "Seleccione la finca",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF000000)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: size.height * 0.0029,
                                width: size.width * 0.1336,
                                color: Colors.orange,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color:
                            Colors.white, //background color of dropdown button
                        border: Border.all(
                            color:
                                Color(0XFFA7BCC7)), //border of dropdown button
                        borderRadius: BorderRadius.all(Radius.circular(35.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: DropdownButton<String>(
                          value: select_fin_id,
                          icon: const Icon(Icons.arrow_downward),
                          isExpanded: true,
                          elevation: 16,
                          style: const TextStyle(
                              color: Color.fromRGBO(76, 172, 230, 1)),
                          underline: Container(),
                          iconEnabledColor: Color.fromRGBO(76, 172, 230, 1),
                          onChanged: (String? newValue) {
                            setState(() {
                              select_fin_id = newValue!;
                            });
                          },
                          items: widget.lista_fincas.map((value) {
                            return DropdownMenuItem<String>(
                              value: value['fin_id'].toString(),
                              child: Text(value['fin_nombre'].toString()),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Trick to add the submit button

          buildBottomHalfContainer(false),
        ],
      ),
    );
  }

  guardar_datos() async {
    if (select_fin_id != "") {
      fin_id_usuario_logeado = select_fin_id;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => NavigationHomeScreen(),
        ),
      );
    } else {
      dialog(context, "seleccione finca", true);
    }
  }

  Future<dynamic> dialog(
      BuildContext context, String mensaje, bool activar_acciones) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actions: [
          activar_acciones
              ? TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'))
              : Container()
        ],
        content: Container(
          width: 200,
          height: 100,
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                child: activar_acciones == false
                    ? CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    : Icon(
                        Icons.warning_sharp,
                        color: Colors.yellow,
                        size: 70,
                      ),
              ),
              Container(
                  padding: EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          mensaje,
                          style:
                              TextStyle(color: Color.fromRGBO(76, 172, 230, 1)),
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: MediaQuery.of(context).size.height - 550,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              boxShadow: [
                if (showShadow)
                  BoxShadow(
                    color: Colors.black.withOpacity(.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                  )
              ]),
          child: !showShadow
              ? Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.orange, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(0, 1))
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      guardar_datos();
                    },
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                )
              : Center(),
        ),
      ),
    );
  }

  Widget buildTextField(IconData icon, String hintText, bool isPassword,
      bool isNumber, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: const Color(0xFFB6C7D1),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFA7BCC7)),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFA7BCC7)),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: const EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14, color: Color(0XFFA7BCC7)),
        ),
      ),
    );
  }
}
