// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'ruta_backend.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ModeloGenral {
  Future<List> api_backend(String url, String tipo, String body) async {
    var response;
    if (tipo == "GET") {
      response = await http.get(Uri.parse(url), headers: {
        "x-token": token,
        "Content-Type": "application/json",
      });
    } else {
      if (tipo == "POST") {
        response = await http.post(Uri.parse(url),
            headers: {
              "x-token": token,
              "Content-Type": "application/json",
            },
            body: body);
      } else {
        if (tipo == "PUT") {
          response = await http.put(Uri.parse(url),
              headers: {
                "x-token": token,
                "Content-Type": "application/json",
              },
              body: body);
        } else {
          if (tipo == "DELETE") {
            response = await http.delete(Uri.parse(url), headers: {
              "x-token": token,
              "Content-Type": "application/json",
            });
          }
        }
      }
    }

    

    if (response.statusCode == 200) {
      var resultado = jsonDecode(response.body);
      if (resultado['token'] != null) {
        token = resultado['token'];
        per_id_usuario_logeado = resultado['dato'][0]['per_id'].toString();
        per_nombre_apellido_usuario_logeado =
            resultado['dato'][0]['per_nombre'].toString() +
                " " +
                resultado['dato'][0]['per_apellido'].toString();
        rol_id_usuario_logeado=resultado['dato'][0]['rol_id'].toString();
        per_imagen_usuario_logeado=resultado['dato'][0]['per_imagen'].toString();
      }

      
      if (resultado['dato'] != null) {
        return resultado['dato'];
      } else {
        return [];
      }
    } else {
      return resutadotoken(response);
    }
  }

  List resutadotoken(var response) {
    if (response.statusCode == 401) {
      return [
        401 //No hay token en la petición
      ];
    } else {
      if (response.statusCode == 400) {
        return [
          400 //Token no válido, el usuario no existe en la base de datos
        ];
      } else {
        if (response.statusCode == 402) {
          return [
            402 //Token inválido, quizás caducó
          ];
        }
      }
    }
    return [403];
  }
}
