import 'package:flutter/material.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  Widget _body(procedimento) {
    return SingleChildScrollView(
        child: SizedBox(
      child: Align(
        alignment: Alignment.center,
        child: Column(children: [
          Container(
              child: Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Text(procedimento['nomeProcedimento']),
          )),
        ]),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final procedimento = args;
    return Scaffold(
        body: Stack(
      children: [_body(procedimento)],
    ));
  }
}
