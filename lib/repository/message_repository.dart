import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:message_app/global/environment.dart';
import 'package:message_app/models/message_model.dart';

class MessageRepository {
  Future<List<MessageModel>> getMessage() async {
    return await _getMessageAll();
  }

  Future<List<MessageModel>> _getMessageAll() async {
    final response = await http.get(Uri.parse(Environment.apiUrl));
    if (response.statusCode == 200) {
      final decoded = await jsonDecode(utf8.decode(response.bodyBytes));
      List<MessageModel> messages = decoded.map<MessageModel>((users) {
        return MessageModel.fromJson(users);
      }).toList();

      return messages;
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }
}
