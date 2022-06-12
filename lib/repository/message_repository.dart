import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MessageRepository extends ChangeNotifier {
  Future<List>? getMessage() async {
    return await _getMessage();
  }

  Future<List> _getMessage() async {
    var response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      notifyListeners();
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }
}
