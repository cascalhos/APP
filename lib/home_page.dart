import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedPhotoIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://seu-endpoint-aqui'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // return jsonDecode(jsonData);
    } else {
      throw Exception('Falha ao carregar os dados do backend');
    }
  }

  _carrossel(List<dynamic> procedimentos) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: photos.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectedPhotoIndex = index;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Column(children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(photos[index]),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(description[index]),
                      if (index == selectedPhotoIndex)
                        CircleAvatar(
                            radius: 4,
                            backgroundColor:
                                Color.fromRGBO(188, 156, 116, 1.0)),
                    ]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 5.0, bottom: 8.0, left: 20, right: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    procedimentos[selectedPhotoIndex]['nomeProcedimento'],
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: procedimentos[selectedPhotoIndex]['sessoes'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, bottom: 8.0, left: 20, right: 20),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                            radius: 4,
                            backgroundColor:
                                Color.fromRGBO(188, 156, 116, 1.0)),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                            child: Text(procedimentos[selectedPhotoIndex]
                                ['sessoes'][index]['nome'])),
                        Text(
                          'R\$' +
                              procedimentos[selectedPhotoIndex]['sessoes']
                                      [index]['valor']
                                  .toString() +
                              ' a sessão',
                          textAlign: TextAlign.right,
                        )
                      ]),
                );
              })
        ],
      ),
    );
  }

  List<String> photos = [
    'assets/images/limpezaPele.jpg',
    'assets/images/tratamento.jpg',
    'assets/images/microagulhamento.jpg',
    'assets/images/lipbooster.jpg',
    'assets/images/peeling.jpg',
    'assets/images/dermaplaning.jpg',
  ];

  List<String> description = [
    'Limpeza de Pele',
    'Tratamentos',
    'Microagulhamento',
    'Lip Booster',
    'Peeling Químico',
    'Dermaplaning',
  ];

  String jsonData = '''[
    {
      "id": "1",
      "nomeProcedimento": "Limpeza de Pele",
      "sessoes": [
        {
          "id": "1",
          "nome": "Tradicional",
          "valor": 150.0
        },
        {
          "id": "2",
          "nome": "AntiAcne",
          "valor": 200.0
        }
      ]
    },
        {
      "id": "2",
      "nomeProcedimento": "Tratamento",
      "sessoes": [
        {
          "id": "1",
          "nome": "Tradicional Tratamento",
          "valor": 150.0
        },
        {
          "id": "2",
          "nome": "AntiAcne Tratamento",
          "valor": 200.0
        }
      ]
    }
    ]
  ''';

  // List<dynamic> procedimentos = [];
  // @override
  // void initState() {
  //   super.initState();
  //   procedimentos = jsonDecode(jsonData);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
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
              icon: Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Image.asset('assets/images/larissaLogoBranco.png'),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Image.asset(
              'assets/images/larissa.png',
              color: Color.fromRGBO(188, 156, 116, 0.6),
              colorBlendMode: BlendMode.modulate,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      drawer: Drawer(
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      height: 200,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child:
                            Image.asset('assets/images/larissaLogoDourado.png'),
                      )),
                ],
              ),
              ListTile(
                leading: IconTheme(
                  data: IconThemeData(
                    color: Color.fromRGBO(188, 156, 116, 1.0),
                  ),
                  child: Icon(Icons.list),
                ),
                title: Text('Minhas sessões'),
                trailing: IconTheme(
                  data: IconThemeData(
                    color: Color.fromRGBO(188, 156, 116, 1.0),
                  ),
                  child: Icon(Icons.arrow_forward_ios, size: 15),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/sessions');
                },
              ),
              Divider(),
              ListTile(
                leading: IconTheme(
                  data: IconThemeData(
                    color: Color.fromRGBO(188, 156, 116, 1.0),
                  ),
                  child: Icon(Icons.account_circle),
                ),
                title: Text('Meus Dados'),
                trailing: IconTheme(
                  data: IconThemeData(
                    color: Color.fromRGBO(188, 156, 116, 1.0),
                  ),
                  child: Icon(Icons.arrow_forward_ios, size: 15),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/datas');
                },
              ),
              Divider(),
              ListTile(
                leading: IconTheme(
                  data: IconThemeData(
                    color: Color.fromRGBO(188, 156, 116, 1.0),
                  ),
                  child: Icon(Icons.phone),
                ),
                title: Text('Contato'),
                trailing: IconTheme(
                  data: IconThemeData(
                    color: Color.fromRGBO(
                        188, 156, 116, 1.0), // Altere a cor do ícone aqui
                  ),
                  child: Icon(Icons.arrow_forward_ios, size: 15),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed('/contacts');
                },
              ),
              Spacer(),
              Divider(),
              ListTile(
                leading: IconTheme(
                  data: IconThemeData(
                    color: Color.fromRGBO(
                        188, 156, 116, 1.0), // Altere a cor do ícone aqui
                  ),
                  child: Icon(Icons.logout),
                ),
                title: Text('Sair'),
                trailing: IconTheme(
                  data: IconThemeData(
                    color: Color.fromRGBO(
                        188, 156, 116, 1.0), // Altere a cor do ícone aqui
                  ),
                  child: Icon(Icons.arrow_forward_ios, size: 15),
                ),
                onTap: () {
                  // Lógica da ação da opção 2
                },
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar dados'),
            );
          } else {
            final procedimentos = snapshot.data!;
            return _carrossel(procedimentos);
          }
        },
      ),
    );
  }
}
