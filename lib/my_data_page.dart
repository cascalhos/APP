import 'package:flutter/material.dart';

class MyDataPage extends StatefulWidget {
  const MyDataPage({super.key});

  @override
  State<MyDataPage> createState() => _MyDataPageState();
}

class _MyDataPageState extends State<MyDataPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 180),
            child: Text(
              'Meus Dados',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          )
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
    );
  }
}
