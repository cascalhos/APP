import 'package:agendamento/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController cpfController = TextEditingController();
  final MaskTextInputFormatter cpfMaskFormatter = MaskTextInputFormatter(
      mask: '000.000.000-00', filter: {"0": RegExp(r'[0-9]')});

  String cpf = '';
  String senha = '';
  bool obscureText = true;

  Widget _body() {
    return SingleChildScrollView(
        child: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Image.asset('assets/images/larissaLogoDourado.png'),
          )),
          Card(
            elevation: 0,
            child: Column(children: [
              TextField(
                onChanged: (text) {
                  cpf = text;
                },
                controller: cpfController,
                keyboardType: TextInputType.number,
                inputFormatters: [cpfMaskFormatter],
                decoration: InputDecoration(
                    labelText: 'CPF', border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                  onChanged: (text) {
                    senha = text;
                  },
                  obscureText: obscureText,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            obscureText = !obscureText;
                          },
                        );
                      },
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: AppStyles.instance.buttonStyleLogin(),
                  onPressed: () {
                    if (cpf == '123.456.789-12' && senha == '123') {
                      Navigator.of(context).pushReplacementNamed('/home');
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      child: Text(
                        'Entrar',
                        textAlign: TextAlign.center,
                      ))),
            ]),
          ),
        ]),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [_body()],
    ));
  }
}
