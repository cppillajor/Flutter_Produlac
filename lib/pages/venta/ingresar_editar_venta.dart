import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:produlacmovil/pages/loginPage.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/material.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

class IngresarEditarVenta extends StatefulWidget {
  int ven_id;
  int ani_id;
  String ven_fecha;
  int per_idvendedor;
  String ven_comprador;
  String ven_telcomprador;
  String ven_cedulacomprador;
  String ven_direccioncomprador;
  String ven_valor;
  List lista_animal;
  //

  IngresarEditarVenta(
      this.ven_id,
      this.ani_id,
      this.ven_fecha,
      this.per_idvendedor,
      this.ven_comprador,
      this.ven_telcomprador,
      this.ven_cedulacomprador,
      this.ven_direccioncomprador,
      this.ven_valor,
      this.lista_animal);
  @override
  _IngresarEditarVentaState createState() => _IngresarEditarVentaState();
}

class _IngresarEditarVentaState extends State<IngresarEditarVenta> {
  TextEditingController id = TextEditingController();
  TextEditingController id_animal = TextEditingController();
  TextEditingController fecha = TextEditingController();
  TextEditingController idvendedor = TextEditingController();
  TextEditingController comprador = TextEditingController();
  TextEditingController telcomprador = TextEditingController();
  TextEditingController cedulacomprador = TextEditingController();
  TextEditingController direccioncomprador = TextEditingController();
  TextEditingController valor = TextEditingController();
  ControllerGenral controller_general = new ControllerGenral();

  String select_ani_id = "";

  String _selectedDate_a_enviar = "";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();

    if (widget.ven_id != 0) {
      id.text = widget.ven_id.toString();
      id_animal.text = widget.ani_id.toString();
      fecha.text = widget.ven_fecha;
      idvendedor.text = widget.per_idvendedor.toString();
      comprador.text = widget.ven_comprador;
      telcomprador.text = widget.ven_telcomprador;
      cedulacomprador.text = widget.ven_cedulacomprador;
      direccioncomprador.text = widget.ven_direccioncomprador;
      valor.text = widget.ven_valor;

      select_ani_id = widget.ani_id.toString();
      if (widget.ven_fecha != "") {
        selectedDate = DateTime.parse(widget.ven_fecha);
      }
    } else {
      if (widget.lista_animal.length >= 1) {
        select_ani_id = widget.lista_animal[0]['ani_id'].toString();
      }
    }
    if (widget.ani_id != 0) {
      select_ani_id = widget.ani_id.toString();
    }

    idvendedor.text = per_nombre_apellido_usuario_logeado;
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
                              Text(
                                widget.ven_id == 0
                                    ? "AGREGAR VENTA"
                                    : "ACTUALIZAR VENTA",
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
                                items: widget.lista_animal.map((value) {
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
                          buildTextField1(
                              Icons.sell, "Vendedor", false, false, idvendedor),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.badge_outlined, "Comprador",
                              false, false, comprador),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.person, "Telefono Comprador",
                              false, true, telcomprador),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.important_devices_sharp,
                              "Cédula Comprador", false, true, cedulacomprador),
                          const SizedBox(height: 15.0),
                          buildTextField(
                              Icons.add_rounded,
                              "Dirección Comprador",
                              false,
                              false,
                              direccioncomprador),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.monetization_on, "Valor", false,
                              true, valor),
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

  guardar_datos() async {
    if (_selectedDate_a_enviar == "") {
      _selectedDate_a_enviar = DateFormat('yyyy-MM-dd').format(selectedDate);
    }
    if (select_ani_id == "" ||
        _selectedDate_a_enviar == "" ||
        comprador.text == "" ||
        telcomprador.text == "" ||
        cedulacomprador.text == "" ||
        direccioncomprador.text == "" ||
        valor.text == "") {
      dialog(context, "AGREGE TODOS LOS DATOS PORFAVOR", true);
    } else {
      if (_selectedDate_a_enviar == "") {
        _selectedDate_a_enviar = widget.ven_fecha;
      }

      String body = jsonEncode({
        "ani_id": select_ani_id,
        "ven_fecha": _selectedDate_a_enviar,
        "per_idvendedor": per_id_usuario_logeado,
        "ven_comprador": comprador.text,
        "ven_telcomprador": telcomprador.text,
        "ven_cedulacomprador": cedulacomprador.text,
        "ven_direccioncomprador": direccioncomprador.text,
        "ven_valor": valor.text
      });
      List datos = [];
      if (widget.ven_id == 0) {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "ventas", "POST", body);
        Navigator.pop(context);
      } else {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "ventas/" + widget.ven_id.toString(), "PUT", body);
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
        if(widget.ven_id!=0){
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

  Widget buildTextField1(IconData icon, String hintText, bool isPassword,
      bool isNumber, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          enabled: false,
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
