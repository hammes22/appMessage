import 'package:flutter/material.dart';
import 'package:message_app/models/message_model.dart';
import 'package:message_app/providers/message_provider.dart';
import 'package:provider/provider.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    // late MessageProvider tab = context.watch<MessageProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mensagens"),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Flexible(
          child: _listMessage(),
        )
      ],
    );
  }

  Widget _listMessage() {
    final messageProvider = Provider.of<MessageProvider>(context);
    return FutureBuilder(
      future: messageProvider.getMessage(),
      builder: (_, AsyncSnapshot<List<MessageModel>> snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data;
          return ListView.separated(
              itemCount: user!.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
              itemBuilder: (_, int i) {
                return _card(user[i]);
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _card(MessageModel message) {
    return ListTile(
      title: Text('Usuário Nº ${message.userId}\n'
          '\nTitulo: ${message.title}\n'),
      isThreeLine: true,
      subtitle: Text(
        '${message.body}\n'
        'Mensagem nº${message.id}',
        style: TextStyle(color: Colors.black.withOpacity(0.6)),
      ),
      leading: const Icon(
        Icons.account_circle_sharp,
        size: 40,
        color: Colors.blue,
      ),
    );
  }
}
