import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:message_app/repository/message_repository.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Future<List> getMessage() async {
    var response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Erro ao carregar dados');
    }
  }

  @override
  Widget build(BuildContext context) {
    late MessageRepository tab = context.watch<MessageRepository>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Lista de  Mensagens"),
      ),
      body: FutureBuilder<List>(
        future: tab.getMessage(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar dados'),
            );
          }
          if (snapshot.hasData) {
            return ListView.separated(
              itemCount: snapshot.data!.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Usuário Nº ${snapshot.data![index]["userId"]}\n'
                      '\nTitulo: ${snapshot.data![index]["title"]}\n'),
                  isThreeLine: true,
                  subtitle: Text(
                    '${snapshot.data![index]["body"]}\n'
                    'Mensagem nº${snapshot.data![index]["id"]}',
                    style: TextStyle(color: Colors.black.withOpacity(0.6)),
                  ),
                  leading: const Icon(
                    Icons.account_circle_sharp,
                    size: 40,
                    color: Colors.blue,
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
