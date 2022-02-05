// ignore_for_file: non_constant_identifier_names, must_be_immutable, use_key_in_widget_constructors, prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:produlacmovil/controller/cloudinary.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/pages/animalPage.dart';
import 'package:produlacmovil/pages/loginPage.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

class IngresarEditarAnimal extends StatefulWidget {
  int ani_id;
  String ani_codigo;
  String ani_nombre;
  String ani_sexo;
  String ani_fecha_nacimiento;
  String ani_imagen;
  String ani_raza;
  String ite_idetapa;
  int ani_idpadre;
  int ani_idmadre;
  String ani_pesonacer;
  int ite_idespecie;
  int fin_id;
  int ite_idtipoestado;
  List lista_animales;
  List lista_especie_animal;
  List lista_fincas;
  List list_tipo_estado;
  List lista_etapa;
  //

  IngresarEditarAnimal(
      this.ani_id,
      this.ani_codigo,
      this.ani_nombre,
      this.ani_sexo,
      this.ani_fecha_nacimiento,
      this.ani_imagen,
      this.ani_raza,
      this.ite_idetapa,
      this.ani_idpadre,
      this.ani_idmadre,
      this.ani_pesonacer,
      this.ite_idespecie,
      this.fin_id,
      this.ite_idtipoestado,
      this.lista_animales,
      this.lista_especie_animal,
      this.lista_fincas, //TRAER LAS FINCAS SEGUN EL PER_ID
      this.list_tipo_estado,
      this.lista_etapa);
  @override
  _IngresarEditarAnimalState createState() => _IngresarEditarAnimalState();
}

class _IngresarEditarAnimalState extends State<IngresarEditarAnimal> {
  TextEditingController codigo = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController fecha_nacimiento = TextEditingController();

  // TextEditigController imagen = new TextEditingController();
  TextEditingController raza = TextEditingController();
  TextEditingController idpadre = TextEditingController();
  TextEditingController idmadre = TextEditingController();

  TextEditingController peso_nacer = TextEditingController();
  TextEditingController id_especie = TextEditingController();
  TextEditingController id_finca = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController id_tipo_estado = TextEditingController();

  ControllerGenral controller_general = ControllerGenral();

  List Lista_sexo = ["Macho", "Hembra"];
  String select_Sexo = "Macho";

  String select_ani_id_padre = " ";
  String select_ani_id_madre = " ";
  String select_ite_idespecie = "";
  String select_fin_id = "";
  String select_ite_tipo_estado = "";
  String select_ite_idetapa = "";

  String nueva_url = "";

  String dropdownValue = "";

  File foto = File('assets/images/camera.png');

  ImagePicker _picker = ImagePicker();
  XFile? _image;

  String _selectedDate_a_enviar = "";
  DateTime selectedDate = DateTime.now();

  List lista_animal_macho = [];
  List lista_animal_hembra = [];

  @override
  void initState() {
    super.initState();
    print(widget.ite_idetapa);
    if (widget.ani_id != 0) {
      codigo.text = widget.ani_codigo;
      nombre.text = widget.ani_nombre;
      select_Sexo = widget.ani_sexo;
      raza.text = widget.ani_raza;
      peso_nacer.text = widget.ani_pesonacer;
      id_finca.text = widget.fin_id.toString();
      id_tipo_estado.text = widget.ite_idtipoestado.toString();

      select_ite_idespecie = widget.ite_idespecie.toString();
      select_fin_id = widget.fin_id.toString();

      select_ite_tipo_estado = widget.ite_idtipoestado.toString();

      select_ite_idetapa = widget.ite_idetapa.toString();

      if (widget.ani_fecha_nacimiento != "") {
        selectedDate = DateTime.parse(widget.ani_fecha_nacimiento);
      }

      if (widget.lista_animales.length >= 1) {
        for (var item in widget.lista_animales) {
          if (item['ani_sexo'] == "Macho") {
            lista_animal_macho.add(item);
            if (widget.ani_idpadre == item["ani_id"]) {
              select_ani_id_padre = widget.ani_idpadre.toString();
            }
          } else {
            if (item['ani_sexo'] == "Hembra") {
              lista_animal_hembra.add(item);
              if (widget.ani_idmadre == item["ani_id"]) {
                select_ani_id_madre = widget.ani_idmadre.toString();
              }
            }
          }
        }
      }
      
      if (select_ani_id_padre == " ") {
        var Lista_animal_a_editar;
        for (var item in widget.lista_animales) {
          if (item["ani_id"] == widget.ani_id) {
            Lista_animal_a_editar = item;
          }
        }
        if (Lista_animal_a_editar != null) {
          if (Lista_animal_a_editar["ani_id_padre_nombre"] != null &&
              Lista_animal_a_editar["ani_id_padre"] != null) {
            lista_animal_macho.add({
              "ani_id": Lista_animal_a_editar["ani_id_padre"],
              "ani_nombre": Lista_animal_a_editar["ani_id_padre_nombre"],
              "ani_codigo": Lista_animal_a_editar["ani_id_padre_codigo"]
            });
            select_ani_id_padre =
                Lista_animal_a_editar["ani_id_padre"].toString();
          }
        }
      }
      
      if (select_ani_id_madre == " ") {
        var Lista_animal_a_editar;
        for (var item in widget.lista_animales) {
          if (item["ani_id"] == widget.ani_id) {
            Lista_animal_a_editar = item;
          }
        }
        if (Lista_animal_a_editar != null) {
          if (Lista_animal_a_editar["ani_id_madre_nombre"] != null &&
              Lista_animal_a_editar["ani_id_madre"] != null) {
            lista_animal_hembra.add({
              "ani_id": Lista_animal_a_editar["ani_id_madre"],
              "ani_nombre": Lista_animal_a_editar["ani_id_madre_nombre"],
              "ani_codigo": Lista_animal_a_editar["ani_id_madre_codigo"]
            });
            select_ani_id_madre =
                Lista_animal_a_editar["ani_id_madre"].toString();
          }
        }
      }

      if (select_ani_id_madre == " " && lista_animal_hembra.length >= 1) {
        select_ani_id_madre = lista_animal_hembra[0]['ani_id'].toString();
      }
      if (select_ani_id_padre == " " && lista_animal_macho.length >= 1) {
        select_ani_id_padre = lista_animal_macho[0]['ani_id'].toString();
      }

      
      
    } else {
      for (var item in widget.lista_animales) {
          if (item['ani_sexo'] == "Macho") {
            lista_animal_macho.add(item);
          } else {
            if (item['ani_sexo'] == "Hembra") {
              lista_animal_hembra.add(item);
            }
          }
        }
      if (select_ani_id_madre == " " && lista_animal_hembra.length >= 1) {
        select_ani_id_madre = lista_animal_hembra[0]['ani_id'].toString();
      }
      if (select_ani_id_padre == " " && lista_animal_macho.length >= 1) {
        select_ani_id_padre = lista_animal_macho[0]['ani_id'].toString();
      }

      if (widget.lista_especie_animal.length >= 1) {
        select_ite_idespecie =
            widget.lista_especie_animal[0]['ite_id'].toString();
      }
      if (widget.lista_fincas.length >= 1) {
        select_fin_id = widget.lista_fincas[0]['fin_id'].toString();
      }
      if (widget.list_tipo_estado.length >= 1) {
        select_ite_tipo_estado =
            widget.list_tipo_estado[0]['ite_id'].toString();
      }
      if (widget.lista_etapa.length >= 1) {
        select_ite_idetapa = widget.lista_etapa[0]['ite_id'].toString();
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
                                widget.fin_id == 0
                                    ? "AGREGAR ANIMAL"
                                    : "ACTUALIZAR ANIMAL",
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
                    //Foto
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              widget.ani_id == 0
                                  ? CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 50.0,
                                      backgroundImage: _image == null
                                          ? NetworkImage(url_no_foto)
                                          : FileImage(foto) as ImageProvider)
                                  : CircleAvatar(
                                      backgroundColor: Colors.red,
                                      radius: 50.0,
                                      backgroundImage: _image == null
                                          ? NetworkImage(widget.ani_imagen)
                                          : FileImage(foto) as ImageProvider),
                              InkWell(
                                onTap: _onAlertPress,
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.black),
                                    margin: const EdgeInsets.only(top: 70),
                                    child: const Icon(
                                      Icons.photo_camera,
                                      size: 25,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.pets_outlined,
                              "Nombre del Animal", false, false, nombre),
                          const SizedBox(height: 10.0),
                          buildTextField(
                              Icons.qr_code, "Codigo", false, false, codigo),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Text(
                                'Seleccione Sexo',
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
                                value: select_Sexo,
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
                                    select_Sexo = newValue!;
                                  });
                                },
                                items: Lista_sexo.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.toString(),
                                    child: Text(value.toString()),
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
                          buildTextField(
                              Icons.recommend, "Raza", false, false, raza),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // ignore: prefer_const_literals_to_create_immutables
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
                                value: select_ite_idetapa,
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
                                    select_ite_idetapa = newValue!;
                                  });
                                },
                                items: widget.lista_etapa.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['ite_id'].toString(),
                                    child: Text(value['ite_nombre'].toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
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
                                items: lista_animal_macho.map((value) {
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
                          const SizedBox(height: 10.0),
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
                                value: select_ani_id_madre,
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
                                    select_ani_id_madre = newValue!;
                                  });
                                },
                                items: lista_animal_hembra.map((value) {
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
                          buildTextField(Icons.line_weight_outlined,
                              "Peso al nacer", false, true, peso_nacer),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seleccione Especie del animal',
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
                                value: select_ite_idespecie,
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
                                    select_ite_idespecie = newValue!;
                                  });
                                },
                                items: widget.lista_especie_animal.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['ite_id'].toString(),
                                    child: Text(value['ite_nombre'].toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Seleccione la finca',
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
                                value: select_fin_id,
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
                          Container(
                              padding: EdgeInsets.only(top: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Seleccione el tipo estado del animal',
                                      style: TextStyle(color: Colors.black45),
                                    ),
                                  ],
                                ),
                              )),
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
                                value: select_ite_tipo_estado,
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
                                    select_ite_tipo_estado = newValue!;
                                  });
                                },
                                items: widget.list_tipo_estado.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['ite_id'].toString(),
                                    child: Text(value['ite_nombre'].toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
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

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 50,
                    ),
                    const Text('Galeria'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/camera.png',
                      width: 50,
                    ),
                    const Text('Abrir Camara'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
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
    if (nombre.text == "" ||
        _selectedDate_a_enviar == "" ||
        raza.text == "" ||
        select_ite_idetapa == "" ||
        peso_nacer.text == "" ||
        codigo.text == "") {
      dialog(context, "AGREGE TODOS LOS DATOS PORFAVOR", true);
    } else {
      if (_selectedDate_a_enviar == "") {
        _selectedDate_a_enviar = widget.ani_fecha_nacimiento;
      }
      ApiCloudinary api_cloudinary = ApiCloudinary();

      if (_image != null) {
        dialog(context, "Guardando Imagen", false);
        nueva_url = await api_cloudinary.uploadFile(_image);
        Navigator.pop(context);
      } else {
        if (widget.ani_imagen == "") {
          nueva_url = url_no_foto;
        } else {
          nueva_url = widget.ani_imagen;
        }
      }
      String body = jsonEncode({
        "ani_codigo": codigo.text,
        "ani_nombre": nombre.text,
        "ani_sexo": select_Sexo,
        "ani_fechanacimiento": _selectedDate_a_enviar,
        "ani_imagen": nueva_url,
        "ani_raza": raza.text,
        "ite_idetapa": select_ite_idetapa,
        "ani_idpadre": select_ani_id_padre,
        "ani_idmadre": select_ani_id_madre,
        "ani_pesonacer": peso_nacer.text,
        "ite_idespecie": select_ite_idespecie,
        "fin_id": select_fin_id,
        "ite_idtipoestado": select_ite_tipo_estado
      });

      List datos = [];
      if (widget.ani_id == 0) {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "animales", "POST", body);
        Navigator.pop(context);
      } else {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "animales/" + widget.ani_id.toString(), "PUT", body);
        Navigator.pop(context);
      }

      bool valida = controller_general.errorestoken(datos);
      if (valida) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            ModalRoute.withName('/'));
      } else {
        /*List lista_animales=[];
        if(rol_id_usuario_logeado=="1"){
          lista_animales=await listaAnimales();
        }else{
          lista_animales=await listaAnimalesporfinca();
        }*/
        Navigator.pop(context);
        /*
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    AnimalPAge(lista_animales)));*/ //PARA SALIR DE LA VISTA DE EDITAR, AGREGAR FINCA
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

  Future getCameraImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      if (image != null) {
        foto = File(image.path);
      }
      Navigator.pop(context);
    });
  }

  Future getGalleryImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      if (image != null) {
        foto = File(image.path);
      }
      Navigator.pop(context);
    });
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
