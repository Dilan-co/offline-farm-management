import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/configs/string.dart';
import 'package:farm_management/controller/state_controller.dart';

final StateController stateController = Get.find();

Future<bool> sendMultipartFormRequest({
  required String url,
  required String token,
  required String recordId,
  required String modelName,
  required String fieldName,
  required String fileType,
  required String? fileName,
}) async {
  try {
    // Creating a multipart request
    var uri = Uri.parse(url);
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = 'Bearer $token';

    // Add form fields using variables
    request.fields['record_id'] = recordId;
    request.fields['model_name'] = modelName;
    request.fields['field_name'] = fieldName;
    request.fields['type'] = fileType;

    String signatureSubFolderPath =
        '${stateController.getDocumentsDirectoryPath()}/${CFGString().signatureSubfolderName}';
    String documentsDirectoryPath =
        '${stateController.getDocumentsDirectoryPath()}';

    // Prepare the file path based on fileType
    String filePath;
    if (fileType == 'signature') {
      filePath = '$signatureSubFolderPath/$fileName';
    } else {
      filePath = '$documentsDirectoryPath/$fileName';
    }

    // Sending the request

    if (fileName != null && fileName != '') {
      // Add the file to the request
      var file = await http.MultipartFile.fromPath('file', filePath);
      request.files.add(file);
      var response = await request.send();

      // Handling the response
      if (response.statusCode == 201 || response.statusCode == 200) {
        debugPrint('Response: ${response.reasonPhrase}');
        return true;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}');
        return false;
      }
    } else {
      return true;
    }
  } catch (e) {
    debugPrint('Error: $e');
    return false;
  }
}
