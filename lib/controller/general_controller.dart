import 'package:produlacmovil/models/general_model.dart';
class ControllerGenral {  

  ModeloGenral modelo_general = new ModeloGenral();

  Future<List> httpgeneral(String url,String tipo,String body) async {
    List datos = await modelo_general.api_backend(url,tipo,body);
    return datos;
  }

  bool errorestoken(List datos) {
    if (datos[0] == 400 || datos[0] == 401 || datos[0] == 402) {
      return true;
    } else {
      return false;
    }
  }
}
