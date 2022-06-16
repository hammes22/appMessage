import 'package:flutter/material.dart';
import 'package:message_app/models/message_model.dart';
import 'package:message_app/repository/message_repository.dart';

class MessageProvider extends ChangeNotifier {
  late List<MessageModel> messages;
  Future<List<MessageModel>> getMessage() async {
    // if (messages.isNotEmpty) {
    //   notifyListeners();
    //   return messages;
    // }
    var services = MessageRepository();
    messages = await services.getMessage();
    notifyListeners();

    return messages;
  }

  Future<List<MessageModel>> refreshUser() async {
    var services = MessageRepository();
    messages = await services.getMessage();
    notifyListeners();
    return messages;
  }
}
