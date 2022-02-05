import 'dart:convert';
import 'dart:io';
import 'package:produlacmovil/controller/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/loginPage.dart';

class IngresarEditarPersona extends StatefulWidget {
  int per_id;
  String per_nombre;
  String per_apellido;
  String per_usuario;
  String per_contrasena;
  String per_imagen;
  String per_cedula;
  String per_correo;
  String per_telefono;
  String per_direccion;
  int rol_id;
  List lista_rol;
  //

  IngresarEditarPersona(
    this.per_id,
    this.per_nombre,
    this.per_apellido,
    this.per_usuario,
    this.per_contrasena,
    this.per_imagen,
    this.per_cedula,
    this.per_correo,
    this.per_telefono,
    this.per_direccion,
    this.rol_id,
    this.lista_rol,
  );
  @override
  _IngresarEditarPersonaState createState() => _IngresarEditarPersonaState();
}

class _IngresarEditarPersonaState extends State<IngresarEditarPersona> {
  TextEditingController nombre = TextEditingController();
  TextEditingController apellido = TextEditingController();
  TextEditingController usuario = TextEditingController();
  TextEditingController contrasena = TextEditingController();
  TextEditingController imagen = TextEditingController();
  TextEditingController cedula = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController telefono = TextEditingController();
  TextEditingController direccion = TextEditingController();
  TextEditingController rol_id = TextEditingController();
  TextEditingController estado = TextEditingController();
  ControllerGenral controller_general = new ControllerGenral();

  File foto = File('assets/images/camera.png');

  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  String per_id_usuario_logeado = "";

  String _selectedDate = '';

  String select_rol_id = "";

  String nueva_url = "";

  List Lista_lista_roles = [];

  @override
  void initState() {
    super.initState();

    if (widget.per_id != 0) {
      nombre.text = widget.per_nombre;
      apellido.text = widget.per_apellido;
      usuario.text = widget.per_usuario;
      contrasena.text = widget.per_contrasena;
      imagen.text = widget.per_imagen;
      cedula.text = widget.per_cedula;
      correo.text = widget.per_correo;
      telefono.text = widget.per_telefono;
      direccion.text = widget.per_direccion;
      rol_id.text = widget.rol_id.toString();

      select_rol_id = widget.rol_id.toString();
    }

    if (rol_id_usuario_logeado == "1") {
      Lista_lista_roles = widget.lista_rol;
    } else {
      for (var item in widget.lista_rol) {
        if (item['rol_id'] != 1 && item['rol_id'] != 2) {
          Lista_lista_roles.add(item);
        }
      }
    }

    if (Lista_lista_roles.length >= 1) {
      select_rol_id = Lista_lista_roles[0]['rol_id'].toString();
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
                              Text(
                                widget.per_id == 0
                                    ? "AGREGAR PERSONA"
                                    : "ACTUALIZAR PERSONA",
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
                              widget.per_id == 0
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
                                          ? NetworkImage(widget.per_imagen)
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
                          buildTextField(
                              Icons.person, "Nombre", false, false, nombre),
                          const SizedBox(height: 15.0),
                          buildTextField(
                              Icons.person, "Apellido", false, false, apellido),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.account_circle_outlined,
                              "Usuario", false, false, usuario),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.assignment_ind_outlined,
                              "Cédula", false, true, cedula),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.email_outlined, "Correo", false,
                              false, correo),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.phone_iphone_outlined,
                              "Teléfono", false, true, telefono),
                          const SizedBox(height: 15.0),
                          buildTextField(Icons.import_contacts_outlined,
                              "Dirección", false, false, direccion),
                          buildTextField(Icons.lock, "Contraseña", true, false,
                              contrasena),
                          Container(
                              padding: EdgeInsets.only(top: 20),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Seleccione el Rol',
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
                                value: select_rol_id,
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
                                    select_rol_id = newValue!;
                                  });
                                },
                                items: Lista_lista_roles.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['rol_id'].toString(),
                                    child: Text(value['rol_nombre'].toString()),
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

  // void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
  //   setState(() {
  //     _selectedDate = DateFormat('yyyy-MM-dd').format(args.value);
  //   });
  // }

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

  guardar_datos() async {
    if (nombre.text == "" ||
        apellido.text == "" ||
        usuario.text == "" ||
        cedula.text == "" ||
        correo.text == "" ||
        telefono.text == "" ||
        direccion.text == "" ||
        contrasena.text == "") {
      dialog(context, "AGREGE TODOS LOS DATOS PORFAVOR", true);
    } else {
      ApiCloudinary api_cloudinary = new ApiCloudinary();

      if (_image != null) {
        dialog(context, "Guardando Imagen", false);
        nueva_url = await api_cloudinary.uploadFile(_image);
        Navigator.pop(context);
      } else {
        if (widget.per_imagen == "") {
          nueva_url = url_no_foto;
        } else {
          nueva_url = widget.per_imagen;
        }
      }
      String body = jsonEncode({
        "per_nombre": nombre.text,
        "per_apellido": apellido.text,
        "per_usuario": usuario.text,
        "per_contraseña": contrasena.text,
        "per_imagen": nueva_url,
        "per_cedula": cedula.text,
        "per_correo": correo.text,
        "per_telefono": telefono.text,
        "per_direccion": direccion.text,
        "rol_id": select_rol_id
      });
      List datos = [];
      if (widget.per_id == 0) {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "personas", "POST", body);

        if (rol_id_usuario_logeado == "2" &&
            datos[0]['per_id'] != null &&
            datos[0]['per_id'] != 0) {
          body = jsonEncode({
            "per_id": datos[0]['per_id'].toString(),
            "fin_id": fin_id_usuario_logeado,
          });
          datos = await controller_general.httpgeneral(
              ip_server + "fincaPersona", "POST", body);
        }
        Navigator.pop(context);
      } else {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "personas/" + widget.per_id.toString(), "PUT", body);
        Navigator.pop(context);
      }

      bool valida = controller_general.errorestoken(datos);
      if (valida) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
            ModalRoute.withName('/'));
      } else {
        Navigator.pop(context); //PARA SALIR DE LA VISTA DE EDITAR        
        if(widget.per_id!=0){
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
