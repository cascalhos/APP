import 'package:agendamento/contact_page.dart';
import 'package:agendamento/login_page.dart';
import 'package:agendamento/my_data_page.dart';
import 'package:agendamento/sessions_page.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Larissa Pontes Estética',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 188, 156, 116)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(255, 188, 156, 116),
            titleTextStyle: TextStyle(color: Colors.white)),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => MyHomePage(),
        '/sessions': (context) => SessionsPage(),
        '/datas': (context) => MyDataPage(),
        '/contacts': (context) => ContactPage(),
      },
    );
  }
}
