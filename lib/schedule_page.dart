import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import 'app_styles.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String jsonDates = '''
    [
      "2023-06-10",
      "2023-06-15",
      "2023-06-20"
    ]
  ''';

  List<DateTime> filledDates = [];
  String? selectedTime;
  String? selectedProduct;
  DateTime? selectedDate;

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  List<DateTime> _parseDatesFromJson(String json) {
    List<dynamic> dateStrings = jsonDecode(json);
    return dateStrings.map((dateString) => DateTime.parse(dateString)).toList();
  }

  @override
  void initState() {
    super.initState();
    filledDates = _parseDatesFromJson(jsonDates);
    _timeController.text = '';
  }

  bool isDateSelectable(DateTime date) {
    return !filledDates.contains(date);
  }

  Future<List<String>> fetchAvailableTimes(DateTime selectedDate) async {
    // Lógica para buscar os horários disponíveis no backend com base na data selecionada
    // Implemente sua lógica de chamada ao backend aqui
    // Neste exemplo, retornamos uma lista fixa de horários disponíveis

    List<String> availableTimes = [
      '9:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00'
    ];
    List<String> filledTimes = [
      '10:00',
      '12:00',
      '14:00'
    ]; // Exemplo de horários já preenchidos

    List<String> filteredTimes =
        availableTimes.where((time) => !filledTimes.contains(time)).toList();
    await Future.delayed(
        Duration(seconds: 2)); // Simulação de uma chamada assíncrona ao backend
    return filteredTimes;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      // selectableDayPredicate: isDateSelectable,
      locale: const Locale('pt', 'BR'),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        selectedTime = '';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (selectedDate != null) {
      List<String> availableTimes = await fetchAvailableTimes(selectedDate!);

      final selectedTime = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selecione um horário'),
            content: SingleChildScrollView(
              child: ListBody(
                children: availableTimes
                    .map(
                      (time) => ListTile(
                        title: Text(time),
                        onTap: () {
                          Navigator.of(context).pop(time);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      );

      if (selectedTime != null) {
        setState(() {
          this.selectedTime = selectedTime;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selecione uma data'),
            content: Text(
                'Por favor, selecione uma data antes de escolher um horário.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _selectProduct(
      dynamic procedimentos, BuildContext context) async {
    if (selectedDate != null && selectedTime != null) {
      List<dynamic> procedimentosListSessoes = procedimentos['sessoes'];

      List<String> availableProducts = procedimentosListSessoes
          .map((sessao) => sessao['nome'].toString())
          .toList();

      final selectedProduct = await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selecione um pacote'),
            content: SingleChildScrollView(
              child: ListBody(
                children: availableProducts
                    .map(
                      (product) => ListTile(
                        title: Text(product),
                        onTap: () {
                          Navigator.of(context).pop(product);
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          );
        },
      );

      if (selectedProduct != null) {
        setState(() {
          this.selectedProduct = selectedProduct;
        });
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Selecione uma data'),
            content: Text(
                'Por favor, selecione uma data antes de escolher um horário.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final procedimento = args;

    return Scaffold(
        body: Column(
      children: [
        Expanded(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    procedimento['nomeProcedimento'],
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Data',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          controller: TextEditingController(
                            text: selectedDate != null
                                ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                                : '',
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => {
                        if (selectedDate != null)
                          {_selectTime(context)}
                        else
                          {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Data não selecionada'),
                                  content: Text(
                                      'Por favor, selecione uma data antes de escolher um horário.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Fechar'),
                                    ),
                                  ],
                                );
                              },
                            )
                          }
                      },
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Horário',
                            suffixIcon: Icon(Icons.access_time),
                          ),
                          controller: TextEditingController(
                            text: selectedDate != null ? '$selectedTime' : '',
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectProduct(procedimento, context),
                      child: AbsorbPointer(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Pacote',
                            suffixIcon: Icon(Icons.shopping_bag_outlined),
                          ),
                          controller: TextEditingController(
                            text: selectedProduct != null
                                ? '$selectedProduct'
                                : '',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
                style: AppStyles.instance.buttonStyle(),
                onPressed: () {
                  Map<String, dynamic> requestBody = {
                    'date': selectedDate.toString().split(' ')[0],
                    'time': selectedTime,
                    'pack': selectedProduct,
                    'cpf': '123.456.789-12'
                  };

                  http
                      .post(Uri.parse('http://10.0.2.2:8080/schedules'),
                          headers: {'Content-Type': 'application/json'},
                          body: json.encode(requestBody))
                      .then((response) {
                    if (response.statusCode == 200) {
                      // Requisição bem-sucedida
                      print('Requisição enviada com sucesso');
                      print('Resposta do servidor: ${response.body}');
                    } else {
                      // Requisição falhou
                      print(
                          'Erro na requisição. Código de status: ${response.statusCode}');
                    }
                  }).catchError((error) {
                    // Erro na requisição
                    print('Erro na requisição: $error');
                  });
                },
                child: Container(
                    width: 80,
                    height: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Agendar',
                        textAlign: TextAlign.center,
                      ),
                    ))),
          ),
        ),
      ],
    ));
  }
}
