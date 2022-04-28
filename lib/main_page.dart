import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _formKey = GlobalKey<FormState>();
  final Data data = Data();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Formulário de Contato"),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 200,
                    child: Center(
                        child: CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/profile.png'),
                    )),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Nome"), hintText: "Nome"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor coloque um nome';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        data.name = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Email"), hintText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor coloque um email';
                      }
                      if (!RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Por favor insira um email válido';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        data.email = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        label: Text("Mensagem"), hintText: "Mensagem"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor coloque uma mensagem';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        data.message = value;
                      });
                    },
                  ),
                  Row(
                    children: [
                      Switch(
                          value: data.allowAnswer,
                          onChanged: (value) => setState(() {
                                data.allowAnswer = value;
                              })),
                      const Text("Permite resposta"),
                    ],
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Enviado"),
                                  content: Text("""
Uma mensagem será enviada com os dados:
Nome: ${data.name}
Email: ${data.email}
Mensagem: ${data.message}
Permite resposta: ${data.allowAnswer ? 'Sim' : 'Não'}
                              """),
                                );
                              });
                        }
                      },
                      child: const Text("Enviar"))
                ],
              ),
            )),
      ),
    );
  }
}

class Data {
  String? name;
  String? email;
  String? message;
  bool allowAnswer = false;
}
