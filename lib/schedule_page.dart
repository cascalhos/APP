import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String jsonDates = '''
    [
      "2022-01-10",
      "2022-01-15",
      "2022-01-20"
    ]
  ''';

  List<DateTime> filledDates = [];

  TextEditingController _dateController = TextEditingController();
  DateTime? selectedDate;

  List<DateTime> _parseDatesFromJson(String json) {
    List<dynamic> dateStrings = jsonDecode(json);
    return dateStrings.map((dateString) => DateTime.parse(dateString)).toList();
  }

  @override
  void initState() {
    super.initState();
    filledDates = _parseDatesFromJson(jsonDates);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final procedimento = args;

    return Scaffold(
        appBar: AppBar(
            toolbarHeight: 150,
            automaticallyImplyLeading: false,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(
                    80), // Define a borda arredondada na parte inferior
              ),
            ),
            actions: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(right: 130),
                  child: Text(
                    procedimento['nomeProcedimento'],
                    style: TextStyle(color: Colors.white, fontSize: 23),
                  ))
            ]),
        body: Stack(
          children: [
            DateTimePicker(
              type: DateTimePickerType.date,
              dateMask: 'dd-MMMM-yyyy',
              initialValue: '',
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(Duration(days: 365)),
              locale: Locale('pt', 'BR'),
              selectableDayPredicate: (date) {
                // Filtra as datas disponíveis com base nas datas preenchidas
                return !filledDates.contains(date);
              },
              onChanged: (date) {
                setState(() {
                  selectedDate = DateTime.parse(date);
                });
              },
              decoration: InputDecoration(
                labelText: 'Data',
                suffixIcon: Icon(Icons.calendar_today),
              ),
            )
          ],
        ));
  }
}
