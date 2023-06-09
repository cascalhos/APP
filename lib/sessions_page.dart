import 'package:flutter/material.dart';

class SessionsPage extends StatefulWidget {
  const SessionsPage({super.key});

  @override
  State<SessionsPage> createState() => _SessionsPageState();
}

class _SessionsPageState extends State<SessionsPage> {
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
            padding: const EdgeInsets.only(right: 140),
            child: Text(
              'Minhas Sessões',
              style: TextStyle(color: Colors.white, fontSize: 23),
            ),
          )
        ],
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
    );
  }
}
