import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:farm_management/controller/state_controller.dart';

final StateController stateController = Get.find();

class SuperAdminApiService {
  String get superAdminLoginUrl => '${stateController.baseUrl}/site/login';
  final String fetchUserUrl = 'http://192.168.1.2:8080/fetch_data.php';

  Future<bool> superAdminLogin(
      {required String username, required String pin}) async {
    final Map<String, String> body = {
      "username": username,
      "pin_code": pin,
    };
    debugPrint("===================");
    try {
      final response = await http.post(
        Uri.parse(superAdminLoginUrl),
        body: body,
      );
      debugPrint(
          "Response status code from superAdminLogin post -->> ${response.statusCode}");
      if (response.statusCode == 200) {
        var responseDecoded = await json.decode(response.body);
        debugPrint(
            "Response from superAdminLogin post Decoded-->> $responseDecoded");
        String token = responseDecoded['data']['access_token'];
        stateController.setAccessToken(token);
        return true;
      } else {
        throw Exception('Super Admin Login Failed');
      }
    } catch (e) {
      debugPrint("SignIn Error : $e");
      return false;
    }
  }

  Future<List<dynamic>> fetchUsers() async {
    debugPrint("===================");
    final response = await http.get(Uri.parse(fetchUserUrl));
    debugPrint(
        "Response status code from http get -->> ${response.statusCode}");
    debugPrint("Response from http get -->> $response");
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> createUser(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$fetchUserUrl/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create user');
    }
  }
}
