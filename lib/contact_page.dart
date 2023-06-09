import 'dart:convert';

import 'package:flutter/material.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String jsonData = '''[
{
"id": "1",
"tipo": "Email",
"valor": "estetica@gmail.com"
},
{
"id": "2",
"tipo": "Telefone",
"valor": "(61) 99999999"
}
]
  ''';

  List<dynamic> contatos = [];
  @override
  void initState() {
    super.initState();
    contatos = jsonDecode(jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        shape: const ContinuousRectangleBorder(
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
                Navigator.pop(context);
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 225),
            child: Text(
              'Contato',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          )
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: FutureBuilder(
          future: Future.delayed(const Duration(seconds: 0), () {
            return contatos;
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Erro ao carregar dados'),
              );
            } else {
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: contatos.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(children: [
                              Row(children: [
                                contatos[index]['tipo'] == 'Email'
                                    ? const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: IconTheme(
                                          data: IconThemeData(
                                            color: Color.fromRGBO(
                                                188, 156, 116, 1.0),
                                          ),
                                          child: Icon(
                                            Icons.email,
                                            size: 20,
                                          ),
                                        ),
                                      )
                                    : const Padding(
                                        padding: EdgeInsets.all(20),
                                        child: IconTheme(
                                          data: IconThemeData(
                                            color: Color.fromRGBO(
                                                188, 156, 116, 1.0),
                                          ),
                                          child: Icon(
                                            Icons.phone,
                                            size: 20,
                                          ),
                                        ),
                                      ),
                                Text(
                                  contatos[index]['valor'],
                                  style: TextStyle(fontSize: 15),
                                ),
                                const Spacer(),
                                const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: IconTheme(
                                    data: IconThemeData(
                                      color: Color.fromRGBO(188, 156, 116, 1.0),
                                    ),
                                    child: Icon(
                                      Icons.copy,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ]),
                              const Divider()
                            ]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}
