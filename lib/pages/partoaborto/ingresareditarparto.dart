import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/loginPage.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class IngresarEditarParto extends StatefulWidget {
  int par_id;
  String fecha;
  String ani_id_madre;
  String ani_id_hijo;
  List lista_animales;
  IngresarEditarParto(this.par_id, this.fecha, this.ani_id_madre,
      this.ani_id_hijo, this.lista_animales);
  @override
  _IngresarEditarPartoState createState() => _IngresarEditarPartoState();
}

class _IngresarEditarPartoState extends State<IngresarEditarParto> {
  String ani_id_madre = "";
  String ani_id_hijo = "";
  // String ite_id_parto_aborto = "";

 

  String _selectedDate_a_enviar = "";
  DateTime selectedDate = DateTime.now();
  ControllerGenral controller_general = new ControllerGenral();
  TextEditingController controller_descripcion = TextEditingController();
  @override
  void initState() {
    super.initState();
    

    if (widget.lista_animales.length >= 1) {
      ani_id_hijo = widget.lista_animales[0]['ani_id'].toString();
      ani_id_madre = widget.lista_animales[0]['ani_id'].toString();
    }
    // if (widget.lista_parto_aborto.length >= 1) {
    //   ite_id_parto_aborto = widget.lista_parto_aborto[0]['ite_id'].toString();
    // }

    if (widget.fecha != "") {
      selectedDate = DateTime.parse(widget.fecha);
    }

    if (widget.par_id != 0) {
      ani_id_madre = widget.ani_id_madre;
      ani_id_hijo = widget.ani_id_hijo;
      // ite_id_parto_aborto = widget.ite_id_parto_aborto_viejo;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFECF3F9),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Container(
              height: size.width * 0.439,
              child: Container(
                padding: EdgeInsets.only(top: 90, left: 8),
                color: Color(0xFF2E90FF).withOpacity(.85),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 700),
            curve: Curves.bounceInOut,
            top: 50,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: size.height - 120,
              padding: EdgeInsets.all(20),
              width: size.width - 40,
              margin: EdgeInsets.symmetric(horizontal: 20),
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
                                widget.par_id == 0
                                    ? "AGREGAR PARTO"
                                    : "ACTUALIZAR PARTO",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF09126C)),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            child: SfDateRangePicker(
                              initialDisplayDate: selectedDate,
                              initialSelectedDate: selectedDate,
                              onSelectionChanged: _onSelectionChanged,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seleccione Madre',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, //background color of dropdown button
                              border: Border.all(
                                  color: Color(
                                      0XFFA7BCC7)), //border of dropdown button
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35.0)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: DropdownButton<String>(
                                value: ani_id_madre,
                                icon: const Icon(Icons.arrow_downward),
                                isExpanded: true,
                                elevation: 16,
                                style: const TextStyle(
                                    color: Color.fromRGBO(76, 172, 230, 1)),
                                underline: Container(),
                                iconEnabledColor:
                                    Color.fromRGBO(76, 172, 230, 1),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    ani_id_madre = newValue!;
                                  });
                                },
                                items: widget.lista_animales.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['ani_id'].toString(),
                                    child: Text("Nombre: " +
                                        value['ani_nombre'].toString() +
                                        " Codigo: " +
                                        value['ani_codigo'].toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seleccione Hijo',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, //background color of dropdown button
                              border: Border.all(
                                  color: Color(
                                      0XFFA7BCC7)), //border of dropdown button
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35.0)),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: DropdownButton<String>(
                                value: ani_id_hijo,
                                icon: const Icon(Icons.arrow_downward),
                                isExpanded: true,
                                elevation: 16,
                                style: const TextStyle(
                                    color: Color.fromRGBO(76, 172, 230, 1)),
                                underline: Container(),
                                iconEnabledColor:
                                    Color.fromRGBO(76, 172, 230, 1),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    ani_id_hijo = newValue!;
                                  });
                                },
                                items: widget.lista_animales.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['ani_id'].toString(),
                                    child: Text("Nombre: " +
                                        value['ani_nombre'].toString() +
                                        " Codigo: " +
                                        value['ani_codigo'].toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Descripción del parto',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          buildTextField(
                              Icons.description,
                              'Ingrese la descripción',
                              false,
                              false,
                              controller_descripcion),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(
                          //       'Seleccione',
                          //       style: TextStyle(color: Colors.black45),
                          //     ),
                          //   ],
                          // ),
                          // Container(
                          //   decoration: BoxDecoration(
                          //     color: Colors
                          //         .white, //background color of dropdown button
                          //     border: Border.all(
                          //         color: Color(
                          //             0XFFA7BCC7)), //border of dropdown button
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(35.0)),
                          //   ),
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 30),
                          //     child: DropdownButton<String>(
                          //       value: 'Descripcion del aborto',
                          //       icon: const Icon(Icons.arrow_downward),
                          //       isExpanded: true,
                          //       elevation: 16,
                          //       style: const TextStyle(
                          //           color: Color.fromRGBO(76, 172, 230, 1)),
                          //       underline: Container(),
                          //       iconEnabledColor:
                          //           Color.fromRGBO(76, 172, 230, 1),
                          //       onChanged: (String? newValue) {
                          //         setState(() {
                          //           // ite_id_parto_aborto = newValue!;
                          //         });
                          //       },
                          //       items: widget.lista_parto_aborto.map((value) {
                          //         return DropdownMenuItem<String>(
                          //           value: value['ite_id'].toString(),
                          //           child: Text(value['ite_nombre'].toString()),
                          //         );
                          //       }).toList(),
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          buildBottomHalfContainer(false),
        ],
      ),
    );
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: MediaQuery.of(context).size.height - 100,
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
            color: Color(0xFFB6C7D1),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFA7BCC7)),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0XFFA7BCC7)),
            borderRadius: BorderRadius.all(Radius.circular(35.0)),
          ),
          contentPadding: EdgeInsets.all(10),
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14, color: Color(0XFFA7BCC7)),
        ),
      ),
    );
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _selectedDate_a_enviar = DateFormat('yyyy-MM-dd').format(args.value);
    });
  }

  guardar_datos() async {
    if (_selectedDate_a_enviar == "") {
      _selectedDate_a_enviar = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    if (ani_id_hijo == "" ||
        ani_id_madre == "" ||
        // ite_id_parto_aborto == "" ||
        _selectedDate_a_enviar == "") {
      dialog(context, "AGREGE TODOS LOS DATOS PORFAVOR", true);
    } else {
      if (_selectedDate_a_enviar == "") {
        _selectedDate_a_enviar = widget.fecha;
      }
      String body = jsonEncode({
        "par_fecha": _selectedDate_a_enviar,
        "ani_idmadre": ani_id_madre,
        "ani_idhijo": ani_id_hijo,
        "par_descripcion": controller_descripcion.text,
      });
      List datos = [];
      if (widget.par_id == 0) {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "parto", "POST", body);
        Navigator.pop(context);
      } else {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "parto/" + widget.par_id.toString(), "PUT", body);
        Navigator.pop(context);
      }

      bool valida = controller_general.errorestoken(datos);
      if (valida) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            ModalRoute.withName('/'));
      } else {
        Navigator.pop(
            context);
            if(widget.par_id!=0){
              Navigator.pop(
            context);
            }
        
      }
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
}
