import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
class ApiCloudinary{
  Uri apiUrl = Uri.parse('https://api.cloudinary.com/v1_1/dzu2egwsg/image/upload?upload_preset=produlac');

  Future<String> uploadFile(XFile? archivo1) async {
    File archivo = File(archivo1!.path);
    final mimeTypeData = lookupMimeType(archivo.path).toString().split('/');
    final archivoUploadRequest = http.MultipartRequest('POST', apiUrl);
    final file = await http.MultipartFile.fromPath('file', archivo.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
    archivoUploadRequest.files.add(file);

    try {
      final streamedResponse = await archivoUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return "ERROR DIFERENTE DE 200";
      }
      final responseData = json.decode(response.body);
      return responseData['secure_url'];
    } catch (e) {
      return "ERROR  TRY CATCH";
    }
  }
}