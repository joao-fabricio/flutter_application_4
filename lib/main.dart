import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _validarCpf = TextEditingController();
  
  bool _obscure = true;

  @override
  void dispose() {
    _nomeController.dispose();
    _validarCpf.dispose();
    super.dispose();
  } 

  bool validarCpf(String cpf) {

    cpf = cpf.replaceAll(RegExp(r'[^0-9]',), '');

    if (cpf.length != 11) {
     return false;
    }

    if (RegExp(r'(\d)\1{10}').hasMatch(cpf)) {
     return false;
   }

   try {
     int soma = 0;
     int peso = 10;

     //verificar primeiro digito
     for (int i = 0; i < 9; i++) {
       soma += int.parse(cpf[i]) * peso--;
     }

     int resto = soma % 11;
     int digito1 = (resto < 2) ? 0 : 11 - resto;
   } catch (e) {
     
   }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 500,
              
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Colors.white),
              
              child: Padding(
                padding: EdgeInsetsGeometry.only(left: 50, right: 50),
                child: Form(
                  key: _formKey,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      
                      children: [
                        SizedBox(height: 10,),
                        
                        TextFormField(
                          controller: _nomeController,
                          decoration: InputDecoration(
                            labelText: 'Nome',
                            hintText: 'Digite seu nome',
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                            prefixIcon: Icon(Icons.people)
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite um nome';
                            }
                            if (value.length < 3) {
                              return 'Digite ao menos 3 letras';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 10,),
                    
                        TextFormField(
                          controller: _validarCpf,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                            labelText: 'CPF',
                            hintText: 'Digite seu CPF',
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                            prefixIcon: Icon(Icons.numbers)
                          ),
                          
                          validator: (cpf) {
                            
                            if (cpf == null || cpf.isEmpty) {
                              return 'Digite o CPF';
                            }

                            if (validarCpf(cpf) == false) {
                              return 'CPF incorreto';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 10,),
            
                        TextFormField(
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Senha',
                            hintText: 'Digite sua senha',
                            suffixIcon: IconButton( icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off), onPressed: () {
                              setState(() {
                                _obscure = !_obscure;
                              });
                            }),
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                            prefixIcon: Icon(Icons.lock)
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Digite uma senha válida';
                            }

                            final regex = RegExp(r'^(?=.*[0-9])(?=.*[A-Z])(?=.*[a-z])(?=.*[^a-zA-Z0-9]).+$');

                            if (!regex.hasMatch(value)) {
                              return 'Senha deve ter:\n- 1 número\n- 1 maiúscula\n- 1 minúscula\n- 1 caractere especial\n- mínimo 8 caracteres';
                            }

                            return null;
                          },
                        ),

                        SizedBox(height: 10,),
                    
                        ElevatedButton(onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            print('Nome: ${_nomeController}');
                          }
                        }, child: Text('Cadastrar')),

                        SizedBox(height: 30,)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
