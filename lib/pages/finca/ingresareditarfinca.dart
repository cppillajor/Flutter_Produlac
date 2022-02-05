import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:produlacmovil/controller/cloudinary.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:produlacmovil/pages/loginPage.dart';
import 'package:produlacmovil/pages/views/fincaView.dart';

class IngresarEditarFinca extends StatefulWidget {
  int fin_id;
  String fin_nombre;
  String fin_extencion;
  String fin_imagen;
  String fin_pais;
  String fin_provincia;
  String fin_ciudad;
  String fin_telefono;
  String fin_per_id;
  List lista_personas;
  IngresarEditarFinca(
      this.fin_id,
      this.fin_nombre,
      this.fin_extencion,
      this.fin_imagen,
      this.fin_pais,
      this.fin_provincia,
      this.fin_ciudad,
      this.fin_telefono,
      this.fin_per_id,
      this.lista_personas);

  @override
  _IngresarEditarFincaState createState() => _IngresarEditarFincaState();
}

class _IngresarEditarFincaState extends State<IngresarEditarFinca> {
  TextEditingController nombre = new TextEditingController();
  TextEditingController extencion = new TextEditingController();
  TextEditingController pais = new TextEditingController();
  TextEditingController provincia = new TextEditingController();
  TextEditingController ciudad = new TextEditingController();
  TextEditingController telefono = new TextEditingController();
  ControllerGenral controller_general = new ControllerGenral();

  String per_id = "";

  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  File foto = new File('assets/images/camera.png');

  String nueva_url = "";

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.fin_id != 0) {
      nombre.text = widget.fin_nombre;
      extencion.text = widget.fin_extencion;
      pais.text = widget.fin_pais;
      provincia.text = widget.fin_provincia;
      ciudad.text = widget.fin_ciudad;
      telefono.text = widget.fin_telefono;
    }

    if (widget.fin_id != 0) {
      per_id = widget.fin_per_id;
    } else {
      if (widget.lista_personas.length >= 1) {
        per_id = widget.lista_personas[0]['per_id'].toString();
      }
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
                                widget.fin_id == 0
                                    ? "AGREGAR FINCA"
                                    : "ACTUALIZAR FINCA",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              widget.fin_id == 0
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
                                          ? NetworkImage(widget.fin_imagen)
                                          : FileImage(foto) as ImageProvider),
                              InkWell(
                                onTap: _onAlertPress,
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                        color: Colors.black),
                                    margin: EdgeInsets.only(top: 70),
                                    child: Icon(
                                      Icons.photo_camera,
                                      size: 25,
                                      color: Colors.white,
                                    )),
                              ),
                            ],
                          ),
                          SizedBox(height: 15.0),
                          buildTextField(Icons.person, "Nombre de la Finca",
                              false, false, nombre),
                          const SizedBox(height: 10.0),
                          buildTextField(Icons.person, "Extensión", false, true,
                              extencion),
                          const SizedBox(height: 10.0),
                          buildTextField(
                              Icons.person, "Pais", false, false, pais),
                          const SizedBox(height: 10.0),
                          buildTextField(Icons.person, "Provincia", false,
                              false, provincia),
                          const SizedBox(height: 10.0),
                          buildTextField(Icons.email_outlined, "Ciudad", false,
                              false, ciudad),
                          const SizedBox(height: 10.0),
                          buildTextField(
                              Icons.lock, "Telefono", false, true, telefono),
                          const SizedBox(height: 10.0),
                          Container(
                            //width: MediaQuery.of(context).size.width - 40,
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
                                value: per_id,
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
                                    per_id = newValue!;
                                  });
                                },
                                items: widget.lista_personas.map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value['per_id'].toString(),
                                    child: Text(value['per_nombre'].toString() +
                                        " " +
                                        value['per_apellido'].toString()),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
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

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 50,
                    ),
                    Text('Galeria'),
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
                    Text('Abrir Camara'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

  guardar_datos() async {
    if (nombre.text == "" ||
        extencion.text == "" ||
        pais.text == "" ||
        provincia.text == "" ||
        ciudad.text == "" ||
        telefono.text == "") {
      dialog(context, "AGREGE TODOS LOS DATOS PORFAVOR", true);
    } else {
      ApiCloudinary api_cloudinary = new ApiCloudinary();

      if (_image != null) {
        dialog(context, "Guardando Imagen", false);
        nueva_url = await api_cloudinary.uploadFile(_image);
        Navigator.pop(context);
      } else {
        if (widget.fin_imagen == "") {
          nueva_url = url_no_foto;
        } else {
          nueva_url = widget.fin_imagen;
        }
      }

      String body_finca = jsonEncode({
        "fin_nombre": nombre.text,
        "fin_extension": extencion.text,
        "fin_imagen": nueva_url,
        "fin_pais": pais.text,
        "fin_provincia": provincia.text,
        "fin_ciudad": ciudad.text,
        "fin_telefono": telefono.text,
        "per_id": per_id
      });

      
      List datos = [];
      if (widget.fin_id == 0) {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "fincas", "POST", body_finca);
        Navigator.pop(context);
      } else {
        dialog(context, "Enviando Datos", false);
        datos = await controller_general.httpgeneral(
            ip_server + "fincas/" + widget.fin_id.toString(),
            "PUT",
            body_finca);
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
        if(widget.fin_id!=0){
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
