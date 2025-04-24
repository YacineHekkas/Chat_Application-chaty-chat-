
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:whatsapp_clone/Models/user_model.dart';

// Necessary for code-generation to work




// final getTalkedListProvider = Provider<>((ref) {
//   return getTalkedList();
// });
// @riverpod
Future<List> getTalkedList( ) async {


  Dio dio = Dio();

  String apiUrl = "http://localhost:5000/api/message/talkedList";
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  //await secureStorage.delete(key: 'userId');
  String?  authToken = await secureStorage.read(key: 'UserId');
  print (authToken);

  Map<String, dynamic> data = {
    'userId':authToken,

  };

  Response response = await dio.post(
    apiUrl,
    data: jsonEncode(data),
    options: Options(
      headers: {'Content-Type': 'application/json'},
    ),
  );
  print(response);
  return response.data;
}