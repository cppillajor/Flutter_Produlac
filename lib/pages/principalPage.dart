//ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, file_names, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:produlacmovil/listas.dart';
import 'package:produlacmovil/models/ruta_backend.dart';

class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key? key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  double value = 0;

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarOpacity: 0.7,
        backgroundColor: Colors.blue[400],
        title: Text('Pagina Principal'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder(
                future: getUnaFinca(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  var _fincas = snapshot.data;

                  if (!snapshot.hasData) {
                    return Container(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if(rol_id_usuario_logeado!="1"){
                      
                    return ListView.builder(
                        itemCount: _fincas?.length,
                        itemBuilder: (BuildContext context, int index) {
                          String nombre = _fincas![index]["fin_nombre"];
                          String pais = _fincas[index]["fin_pais"];
                          String provincia = _fincas[index]["fin_provincia"];
                          String Dueno = _fincas[index]["tbl_persona"]
                                      ["per_nombre"]
                                  .toString() +
                              " " +
                              _fincas[index]["tbl_persona"]["per_apellido"]
                                  .toString();
                          String telefono =
                              _fincas[index]["fin_telefono"].toString();
                          String ciudad =
                              _fincas[index]["fin_ciudad"].toString();
                          String imagen =
                              _fincas[index]["fin_imagen"].toString();
                          String extencion =
                              _fincas[index]["fin_extension"].toString();

                          return Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 2 -50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0.0, 2.0),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                                  child: Image.network(
                                    imagen,
                                    width: MediaQuery.of(context).size.width,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      return loadingProgress == null
                                          ? child
                                          : Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.grey),
                                              ),
                                            );
                                    },
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(
                                nombre,
                                style: GoogleFonts.questrial(fontSize: 28),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(Dueno,
                                  style: GoogleFonts.questrial(fontSize: 28)),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(pais + "-" + provincia + "-" + ciudad,
                                  style: GoogleFonts.questrial(fontSize: 28)),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(extencion,
                                  style: GoogleFonts.questrial(fontSize: 28)),
                              SizedBox(
                                height: 20.0,
                              ),
                              Text(telefono,
                                  style: GoogleFonts.questrial(fontSize: 28)),
                              SizedBox(
                                height: 20.0,
                              ),
                            ],
                          );
                        });

                    }else{
                      return Column(
                        children: [
                          Container(
                            width: queryData.size.width,
                            height: queryData.size.height/2,
                            //color: Colors.blue[600],
                            padding: EdgeInsets.only(top: 55.0),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/usuario.png'),
                                  fit: BoxFit.fill),
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(40.0),
                                  bottomRight: Radius.circular(40.0)),
                            ),
                          ),

                          Text(
                            "BIENVENIDO ADMINISTRADOR: "+per_nombre_apellido_usuario_logeado,
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 30,
                              
                            ),
                            textAlign: TextAlign.center,
                          )
                        ],
                      );
                    }
                  }
                }),
          ),
        ],
      ),
    );
  }
}
