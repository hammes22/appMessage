import 'package:flutter/material.dart';
import 'package:message_app/pages/message_page.dart';
import 'package:message_app/providers/message_provider.dart';
import 'package:message_app/repository/message_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MessageProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mensagens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MessagePage(),
    );
  }
}
