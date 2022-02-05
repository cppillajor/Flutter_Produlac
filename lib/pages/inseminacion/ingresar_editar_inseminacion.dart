import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:produlacmovil/pages/loginPage.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

class IngresarEditarInseminacion extends StatefulWidget {
  int ins_id;
  String ins_fecha_inseminacion;
  int per_id;
  int ani_id;
  String ins_fecha_comprobacion;
  String ins_cargada;
  String ins_tipo_inseminacion;
  int ani_id_padre;
  int ins_num_pajuela;
  String ins_descripcion;
  List lista_personas;
  List lista_animales;

  IngresarEditarInseminacion(
    this.ins_id,
    this.ins_fecha_inseminacion,
    this.per_id,
    this.ani_id,
    this.ins_fecha_comprobacion,
    this.ins_cargada,
    this.ins_tipo_inseminacion,
    this.ani_id_padre,
    this.ins_num_pajuela,
    this.ins_descripcion,
    this.lista_personas,
    this.lista_animales,
  );
  @override
  _IngresarEditarInseminacionState createState() =>
      _IngresarEditarInseminacionState();
}

class _IngresarEditarInseminacionState
    extends State<IngresarEditarInseminacion> {
  TextEditingController tipo_inseminacion = new TextEditingController();
  TextEditingController num_pajuela = new TextEditingController();
  TextEditingController descripcion = new TextEditingController();

  ControllerGenral controller_general = new ControllerGenral();

  String select_per_id = "";
  String select_ani_id_padre = "";
  String select_ani_id = "";

  String _selectedDate_a_enviar_fecha_comprobacion = "";
  DateTime? selectedDate_fecha_comprobacion;

  String _selectedDate_a_enviar_fecha_inseminacion = "";
  DateTime selectedDate_fecha_inseminacion = DateTime.now();


  List lista_cargada=["SI","NO","(vacío)"];
  String select_cargada="SI";
  

  @override
  void initState() {
    super.initState();

    if (widget.ins_id != 0) {
      tipo_inseminacion.text = widget.ins_tipo_inseminacion;
      num_pajuela.text = widget.ins_num_pajuela.toString();
      descripcion.text = widget.ins_descripcion;

      select_cargada=widget.ins_cargada;
      select_per_id = widget.per_id.toString();
      select_ani_id_padre = widget.ani_id_padre.toString();
      select_ani_id = widget.ani_id.toString();

      if (widget.ins_fecha_comprobacion != "" &&
          widget.ins_fecha_comprobacion != "0000-00-00" &&
          widget.ins_fecha_comprobacion != null) {
        selectedDate_fecha_comprobacion =
            DateTime.parse(widget.ins_fecha_comprobacion);
      }
      if (widget.ins_fecha_inseminacion != "") {
        selectedDate_fecha_inseminacion =
            DateTime.parse(widget.ins_fecha_inseminacion);
      }
    } else {
      if (widget.lista_animales.length >= 1) {
        select_ani_id_padre = widget.lista_animales[0]['ani_id'].toString();
        select_ani_id = widget.lista_animales[0]['ani_id'].toString();
      }
      if (widget.lista_personas.length >= 1) {
        select_per_id = widget.lista_personas[0]['per_id'].toString();
      }
      if (widget.ani_id != 0) {
        select_ani_id = widget.ani_id.toString();
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
            child: Container(
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
                              Text(
                                widget.ins_id == 0
                                    ? "AGREGAR INSEMINACIÓN"
                                    : "ACTUALIZAR INSEMINACIÓN",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF09126C)),
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
                            children: [
                              Text(
                                'Fecha Inseminacion',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Card(
                            color: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            child: SfDateRangePicker(
                              initialDisplayDate:
                                  selectedDate_fecha_inseminacion,
                              initialSelectedDate:
                                  selectedDate_fecha_inseminacion,
                              onSelectionChanged:
                                  _onSelectionChanged_fecha_inseminacion,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seleccione Animal',
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
                                value: select_ani_id,
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
                                    select_ani_id = newValue!;
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
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seleccione Padre',
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
                                value: select_ani_id_padre,
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
                                    select_ani_id_padre = newValue!;
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
                          const SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Fecha Comprobación',
                                style: TextStyle(color: Colors.black45),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Card(
                            color: Colors.white,
                            elevation: 5,
                            shadowColor: Colors.grey,
                            child: SfDateRangePicker(
                              initialDisplayDate:
                                  selectedDate_fecha_comprobacion,
                              initialSelectedDate:
                                  selectedDate_fecha_comprobacion,
                              onSelectionChanged:
                                  _onSelectionChanged_fecha_comprobacion,
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
                                value: select_cargada,
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
                                    select_cargada = newValue!;
                                  });
                                },
                                items: lista_cargada.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.toString(),
                                    child: Text(value.toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.list, "Tipo de Inseminacón",
                              false, false, tipo_inseminacion),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.format_list_numbered_rtl,
                              "Número Pajuela", false, true, num_pajuela),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.description, "Descripción",
                              false, false, descripcion),
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

  void _onSelectionChanged_fecha_inseminacion(
      DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _selectedDate_a_enviar_fecha_inseminacion =
          DateFormat('yyyy-MM-dd').format(args.value);
    });
  }

  void _onSelectionChanged_fecha_comprobacion(
      DateRangePickerSelectionChangedArgs args) {
    setState(() {
      _selectedDate_a_enviar_fecha_comprobacion =
          DateFormat('yyyy-MM-dd').format(args.value);
    });
  }

  guardar_datos() async {
    if (_selectedDate_a_enviar_fecha_inseminacion == "") {
      _selectedDate_a_enviar_fecha_inseminacion =
          DateFormat('yyyy-MM-dd').format(selectedDate_fecha_inseminacion);
    }

    if (select_cargada==""||
        _selectedDate_a_enviar_fecha_inseminacion == "" ||
        tipo_inseminacion.text == "" ||
        num_pajuela.text == "" ||
        descripcion.text == "") {
      dialog(context, "AGREGE TODOS LOS DATOS PORFAVOR", true);
    } else {
      if (_selectedDate_a_enviar_fecha_inseminacion == "") {
        _selectedDate_a_enviar_fecha_inseminacion =
            widget.ins_fecha_inseminacion;
      }

      if (_selectedDate_a_enviar_fecha_comprobacion == "") {
        _selectedDate_a_enviar_fecha_comprobacion =
            widget.ins_fecha_comprobacion;
      }

      String body = jsonEncode({
        "ins_fechainseminacion": _selectedDate_a_enviar_fecha_inseminacion,
        "per_id": per_id_usuario_logeado,
        "ani_id": select_ani_id,
        "ins_fechacomprobacion": _selectedDate_a_enviar_fecha_comprobacion,
        "ins_cargada": select_cargada,
        "ins_tipoinseminacion": tipo_inseminacion.text,
        "ani_idpadre": select_ani_id_padre,
        "ins_numpajuela": num_pajuela.text,
        "ins_descripcion": descripcion.text,
      });
      print(body);
      List datos = [];
      if (widget.ins_id == 0) {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "inseminacion", "POST", body);
        Navigator.pop(context);
      } else {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "inseminacion/" + widget.ins_id.toString(),
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
        Navigator.pop(context); 
        if(widget.ins_id!=0){
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
