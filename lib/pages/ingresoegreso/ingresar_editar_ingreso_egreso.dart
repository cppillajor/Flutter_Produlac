import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:produlacmovil/pages/loginPage.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

class IngresarEditarIngresoEgreso extends StatefulWidget {
  int ing_id;
  int ing_monto;
  int ite_ingreso_egreso;
  int fin_id;
  String ing_descripcion;
  String ing_fecha;
  List lista_ingreso_egreso;
  List lista_fincas;

  IngresarEditarIngresoEgreso(
      this.ing_id,
      this.ing_monto,
      this.ite_ingreso_egreso,
      this.fin_id,
      this.ing_descripcion,
      this.ing_fecha,
      this.lista_ingreso_egreso,
      this.lista_fincas);
  @override
  _IngresarEditarIngresoEgresoState createState() =>
      _IngresarEditarIngresoEgresoState();
}

class _IngresarEditarIngresoEgresoState
    extends State<IngresarEditarIngresoEgreso> {
  TextEditingController monto = TextEditingController();
  TextEditingController descripcion = TextEditingController();

  ControllerGenral controller_general = new ControllerGenral();

  String _select_fin_id = "";
  String _select_ite_idingreso_egreso = "";

  String _selectedDate_a_enviar = "";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.ing_id != 0) {
      monto.text = widget.ing_monto.toString();
      descripcion.text = widget.ing_descripcion.toString();

      _select_fin_id = widget.fin_id.toString();
      _select_ite_idingreso_egreso = widget.ite_ingreso_egreso.toString();

      if (widget.ing_fecha != "") {
        selectedDate = DateTime.parse(widget.ing_fecha);
      }
    } else {
      if (widget.lista_fincas.length >= 1) {
        _select_fin_id = widget.lista_fincas[0]['fin_id'].toString();
      }
      if (widget.lista_ingreso_egreso.length >= 1) {
        _select_ite_idingreso_egreso =
            widget.lista_ingreso_egreso[0]['ite_id'].toString();
      }
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
            child: SizedBox(
              height: size.width * 0.439,
              child: Container(
                padding: const EdgeInsets.only(top: 90, left: 8),
                color: const Color(0xFF2E90FF).withOpacity(.85),
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
            top: 50,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 700),
              curve: Curves.bounceInOut,
              height: size.height - 120,
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
                    //Cabecera
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Column(
                            children: [
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Text(
                                  widget.ing_id == 0
                                      ? "AGREGAR INGRESO EGRESO"
                                      : "ACTUALIZAR INGRESO EGRESO",
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF09126C)),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 3),
                                height: 2,
                                width: 55,
                                color: Colors.orange,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    //Foto
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 20,
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seleccione',
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
                                value: _select_fin_id,
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
                                    _select_fin_id = newValue!;
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
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seleccione',
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
                                value: _select_ite_idingreso_egreso,
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
                                    _select_ite_idingreso_egreso = newValue!;
                                  });
                                },
                                items: widget.lista_ingreso_egreso.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['ite_id'].toString(),
                                    child: Text(value['ite_nombre'].toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15.0),
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
                          buildTextField(Icons.calendar_today_outlined, "Monto",
                              false, true, monto),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.calendar_today_outlined,
                              "Descripción", false, false, descripcion),
                          const SizedBox(
                            height: 40,
                          )
                        ],
                      ),
                    )
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

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _selectedDate_a_enviar = DateFormat('yyyy-MM-dd').format(args.value);
    });
  }

  Widget buildBottomHalfContainer(bool showShadow) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 700),
      curve: Curves.bounceInOut,
      top: MediaQuery.of(context).size.height - 100,
      right: 0,
      left: 0,
      child: Center(
        child: Container(
          height: 90,
          width: 90,
          padding: const EdgeInsets.all(15),
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
                      gradient: const LinearGradient(
                          colors: [Colors.orange, Colors.red],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1))
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
              : const Center(),
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

  guardar_datos() async {
    if (_selectedDate_a_enviar == "") {
      _selectedDate_a_enviar = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    if (monto.text == "" ||
        _selectedDate_a_enviar == "" ||
        descripcion.text == "" ||
        _select_fin_id == "" ||
        _select_ite_idingreso_egreso == "") {
      dialog(context, "AGREGE TODOS LOS DATOS PORFAVOR", true);
    } else {
      if (_selectedDate_a_enviar == "") {
        _selectedDate_a_enviar = widget.ing_fecha;
      }

      String body = jsonEncode({
        "ing_monto": monto.text,
        "ite_idingresoegreso": _select_ite_idingreso_egreso,
        "fin_id": _select_fin_id,
        "ing_descripcion": descripcion.text,
        "ing_fecha": _selectedDate_a_enviar
      });
      List datos = [];
      if (widget.ing_id == 0) {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "ingresosEgresos", "POST", body);
        Navigator.pop(context);
      } else {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "ingresosEgresos/" + widget.ing_id.toString(),
            "PUT",
            body);
        Navigator.pop(context);
      }

      bool valida = controller_general.errorestoken(datos);
      if (valida) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            ModalRoute.withName('/'));
      } else {
        Navigator.pop(context); //PARA SALIR DE LA VISTA DE EDITAR, AGREGAR FINCA
        if(widget.ing_id!=0){
          Navigator.pop(context);
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
