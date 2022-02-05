// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:produlacmovil/controller/general_controller.dart';
import 'package:produlacmovil/models/ruta_backend.dart';
import 'package:intl/intl.dart';

ControllerGenral controller_general = ControllerGenral();

Future<List<dynamic>> listaFincasSegunPerID() async {
  List lista_fincas_segun_per_id = await controller_general.httpgeneral(
      ip_server +
          "fincaPersona/fincasPorPersona/" +
          per_id_usuario_logeado.toString(),
      "GET",
      "");
  return lista_fincas_segun_per_id;
}

Future<List<dynamic>> listaTipoEstado() async {
  List lista_tipo_estado = await controller_general.httpgeneral(
      ip_server + "items/categoria/3", "GET", "");
  return lista_tipo_estado;
}

Future<List<dynamic>> listaEspecieAnimal() async {
  List lista_especie_animal = await controller_general.httpgeneral(
      ip_server + "items/categoria/7", "GET", "");
  return lista_especie_animal;
}

Future<List<dynamic>> listaAnimales() async {
  List lista_animales =
      await controller_general.httpgeneral(ip_server + "animales", "GET", "");
  return lista_animales;
}

Future<List<dynamic>> listaAnimalesporfinca() async {
  List lista_animales = await controller_general.httpgeneral(
      ip_server + "animales/finca/" + fin_id_usuario_logeado, "GET", "");
  return lista_animales;
}

List<dynamic> listaFincasPerId(List<dynamic> lista_fincas_segun_per_id) {
  List lista_fincas_per_id = [];
  if(lista_fincas_segun_per_id.length>=1){
    for (var item in lista_fincas_segun_per_id) {
    if(item!=null){
      if(item['tbl_finca']!=null){
      lista_fincas_per_id.add(item['tbl_finca']);
    }
    }
    
  }
  }
  
  return lista_fincas_per_id;
}

Future<List<dynamic>> listaIngresoEgreso() async {
  List lista_ingresoEgreso = await controller_general.httpgeneral(
      ip_server + "items/categoria/4", "GET", "");
  return lista_ingresoEgreso;
}

Future<List<dynamic>> listaprodIndividual(String ani_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "prodIndividual/" + ani_id, "POST", "");
  return lista;
}

Future<List<dynamic>> listaprodGlobal(String fin_id ,String fecha_inicio, String fecha_fin) async {
  String body = jsonEncode({
    "fin_id": fin_id,
    "fecha_inicio": fecha_inicio,
    "fecha_fin": fecha_fin,        
  });
  List lista = await controller_general.httpgeneral(
      ip_server + "prodGlobal/fechas", "POST", body);
  return lista;
}

Future<List<dynamic>> listapersonas() async {
  List lista =
      await controller_general.httpgeneral(ip_server + "personas", "GET", "");
  return lista;
}

Future<List<dynamic>> listaTodaslasfincas() async {
  List lista =
      await controller_general.httpgeneral(ip_server + "fincas", "GET", "");
  return lista;
}

Future<List<dynamic>> getRoles() async {
  List lista =
      await controller_general.httpgeneral(ip_server + "rol", "GET", "");
  return lista;
}

Future<List<dynamic>> getTodosCatalogos() async {
  List lista =
      await controller_general.httpgeneral(ip_server + "catalogos", "GET", "");
  return lista;
}

Future<List<dynamic>> getTodosFincasPersonas() async {
  List lista = await controller_general.httpgeneral(
      ip_server + "fincaPersona", "GET", "");
  return lista;
}

Future<List<dynamic>> getTodosFincasPersonadeunafinca(String fin_id) async {

  
  List lista = await controller_general.httpgeneral(
      ip_server + "fincaPersona/personasPorFinca/" + fin_id, "GET", "");
  return lista;
}

Future<List<dynamic>> getlistaHorario() async {
  List lista = await controller_general.httpgeneral(
      ip_server + "items/categoria/1", "GET", "");
  return lista;
}

Future<List<dynamic>> getEtapaAnimal() async {
  List lista = await controller_general.httpgeneral(
      ip_server + "items/categoria/6", "GET", "");
  return lista;
}

Future<List<dynamic>> getInseminacionporanimal(String ani_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "inseminacion/animal/"+ani_id, "GET", "");
  return lista;
}

Future<List<dynamic>> getPartoporanimal(String ani_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "parto/animal/"+ani_id, "GET", "");
  return lista;
}

Future<List<dynamic>> getAbortoporanimal(String ani_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "aborto/animal/"+ani_id, "GET", "");
  return lista;
}

Future<List<dynamic>> getDecesoporFinca(String fin_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "decesos/finca/"+fin_id, "GET", "");
      return lista;
}

Future<List<dynamic>> getTratamientoPorAnimal(String ani_id) async {  
  List lista = await controller_general.httpgeneral(
      ip_server + "tratamientos/animal/$ani_id", "GET", "");
  return lista;
}

Future<List<dynamic>> getVacunaPorAnimal(String ani_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "vacunas/animal/$ani_id", "GET", "");
  return lista;
}

Future<List<dynamic>> getVentasPorFinca(String fin_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "ventas/finca/$fin_id", "GET", "");
  return lista;
}

Future<List<dynamic>> getIngresosEgresosPorFinca(String fin_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "ingresosEgresos/finca/$fin_id", "GET", "");
  return lista;
}

Future<List<dynamic>> getItems() async {
  List lista = await controller_general.httpgeneral(
      ip_server + "items", "GET", "");
  return lista;
}

Future<List<dynamic>> getListaProdGlobalporfinca(String fin_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "prodGlobal/editar/"+fin_id, "GET", "");
  return lista;
}

Future<List<dynamic>> getListaProdIndividualporfinca(String fin_id) async {
  List lista = await controller_general.httpgeneral(
      ip_server + "prodIndividual/finca/"+fin_id, "GET", "");
      if(lista.length>=1){
        return lista[0];
      }else{
        return [];
      }
  
}

Future<List<dynamic>> getUnaFinca() async {  
  List lista = await controller_general.httpgeneral(
      ip_server + "fincas/"+fin_id_usuario_logeado, "GET", "");
  return lista;
}

Future<List<dynamic>> getInseminacionPorFinca() async {
  List lista = await controller_general.httpgeneral(
      ip_server + "inseminacion/finca/"+fin_id_usuario_logeado, "GET", "");
  return lista;
}

Future<List<dynamic>> getPartoPorFinca() async {
  List lista = await controller_general.httpgeneral(
      ip_server + "parto/finca/"+fin_id_usuario_logeado, "GET", "");
  return lista;
}



