import 'package:flutter/material.dart';

void main() {
  runApp(const AnimatedAlignExample());
}

class AnimatedAlignExample extends StatelessWidget {
  const AnimatedAlignExample({super.key});

  static const Duration duration = Duration(seconds: 5);
  //tempo padrão da animação de entrada de tela
  static const Curve curve = Curves.fastOutSlowIn;
  //tipo de animação

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color(0xFF2C3E50),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.calculate, color: Colors.white),

              SizedBox(width: 30),

              Text("Calculadora IMC", style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
        body: const MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  double altura = 0;
  double peso = 0;
  double imc = 0;
  bool selected = false;
  bool mostraResultado = false;
  bool voltarInicio = false;

  void calcularImc() {
    imc = (peso / (altura * altura));
  }

  String classificarImc(double imc) {
    calcularImc();

    if (imc < 16.0) {
      return "Magreza grave";
    } else if (imc >= 16 && imc <= 16.9) {
      return "Magreza moderada";
    } else if (imc >= 17 && imc <= 18.4) {
      return "Magreza leve";
    } else if (imc >= 18.5 && imc <= 24.9) {
      return "Peso normal";
    } else if (imc >= 25 && imc <= 29.9) {
      return "Sobrepeso";
    } else if (imc >= 30 && imc <= 34.9) {
      return "Obesidade grau I";
    } else if (imc >= 35 && imc <= 39.9) {
      return "Obesidade grau II";
    } else {
      return "Obesidade garu III";
    }
  }

  Color mudarCor() {
    if (imc >= 0 && imc <= 18.4) {
      return Colors.red;
    } else if (imc >= 18.5 && imc <= 24.9) {
      return Colors.green;
    } else if (imc >= 25 && imc <= 29.9) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _pesoController.dispose();
    _alturaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() {
          selected = !selected;
        });
      },
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 80),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 150),

                      TextFormField(
                        controller: _nomeController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 16,
                          ),
                          icon: Icon(Icons.people),
                          labelText: 'Nome',
                          hintText: 'Digite seu nome',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        validator: (nome) {
                          if (nome == null || nome.isEmpty) {
                            return 'Digite um nome';
                          }
                          if (nome.length < 3) {
                            return 'O nome deve conter mais de 3 letras';
                          }
                        },
                      ),

                      SizedBox(height: 30),

                      TextFormField(
                        controller: _pesoController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 16,
                          ),
                          icon: Icon(Icons.scale),
                          labelText: 'Peso',
                          hintText: 'Digite seu peso',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite um peso válido';
                          }

                          if (!RegExp(r'^\d+([.,]\d+)?$').hasMatch(value)) {
                            return 'Digite um peso válido';
                          }

                          double peso = double.parse(
                            value.replaceAll(',', '.'),
                          );

                          if (peso <= 0) {
                            return 'Peso inválido';
                          }

                          if (peso < 20 || peso > 300) {
                            return 'Peso fora do limite';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 30),

                      TextFormField(
                        controller: _alturaController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 30,
                            horizontal: 16,
                          ),
                          icon: Icon(Icons.accessibility),
                          labelText: 'Altura',
                          hintText: 'Digite sua altura',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite uma altura válida';
                          }

                          if (!RegExp(r'^\d+([.,]\d+)?$').hasMatch(value)) {
                            return 'Digite uma altura válida';
                          }

                          double altura = double.parse(
                            value.replaceAll(',', '.'),
                          );

                          if (altura <= 0) {
                            return 'Altura inválida';
                          }

                          if (altura > 3.00) {
                            return 'Altura fora dos limites';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 50),

                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              peso = double.parse(
                                _pesoController.text.replaceAll(',', '.'),
                              );
                              altura = double.parse(
                                _alturaController.text.replaceAll(',', '.'),
                              );

                              setState(() {
                                mostraResultado = true;
                              });

                              calcularImc();
                              // print('IMC: ${imc.toString()}');

                              // print('Nome: ${_nomeController.text}');
                              // print('Peso: ${_pesoController.text} Kg');
                              // print('Altura: ${_alturaController.text} m');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF2C3E50),
                          ),
                          child: Text(
                            "Calcular IMC",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          AnimatedSlide(
            duration: Duration(milliseconds: 500),
            offset: mostraResultado ? Offset(0, 0) : Offset(0, 1),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: mudarCor(),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  Text(
                    "Seu IMC: ${imc.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),

                  Text(
                    "Sua classificação: ${classificarImc(imc)}",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),

                  SizedBox(height: 50),

                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        mostraResultado = false;
                      });
                    },
                    child: Text("Fazer novo cálculo"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
