import 'package:flutter/material.dart';

class AppStyles {
  static AppStyles instance = AppStyles();

  buttonStyleLogin() {
    return ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 188, 156, 116), // Cor de fundo do botão
      onPrimary: Colors.white, // Cor do texto do botão
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(5), // Formato do botão (bordas arredondadas)
      ),
    );
  }

  buttonStyle() {
    return ElevatedButton.styleFrom(
      primary: Color.fromARGB(255, 188, 156, 116), // Cor de fundo do botão
      onPrimary: Colors.white, // Cor do texto do botão
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(10), // Formato do botão (bordas arredondadas)
      ),
    );
  }
}
