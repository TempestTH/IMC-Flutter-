import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imc/classes/pessoa.dart';
import 'package:imc/controle/imc.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> registros = [];
  final nomeController = TextEditingController();
  final alturaController = TextEditingController();
  final pesoController = TextEditingController();
  Pessoa pessoa = Pessoa();

  bool camposValidos() {
    return pessoa.getNome().isNotEmpty &&
        pessoa.getAltura() > 0 &&
        pessoa.getPeso() > 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 290,
              child: const Text(
                "Nome",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 1),
                color: Colors.white,
              ),
              child: Center(
                child: TextField(
                  controller: nomeController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Digite o Nome da Pessoa',
                  ),
                  onChanged: (text) {
                    pessoa.setNome(text);
                  },
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            Container(
              width: 290,
              child: const Text(
                "Altura",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 1),
                color: Colors.white,
              ),
              child: Center(
                child: TextField(
                  controller: alturaController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Digite a Altura',
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: (text) {
                    pessoa.setAltura(double.tryParse(text) ?? 0.0);
                  },
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            Container(
              width: 290,
              child: const Text(
                "Peso",
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black, width: 1),
                color: Colors.white,
              ),
              child: Center(
                child: TextField(
                  controller: pesoController,
                  decoration: InputDecoration(
                    border: InputBorder.none, // REMOVE a linha azul
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    hintText: 'Digite o Peso', // Opcional
                  ),
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  onChanged: (text) {
                    pessoa.setPeso(double.tryParse(text) ?? 0.0);
                  },
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              //Cadastro
              width: 150,
              height: 45,
              child: Row(
                children: [
                  Container(
                    width: 150,
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.resolveWith<Color?>((states) {
                              if (states.contains(WidgetState.pressed)) {
                                return const Color.fromARGB(255, 21, 4, 41);
                              }
                              return const Color(0xffb3b3b3);
                            }),
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Color(0xffb3b3b3)),
                          ),
                        ),
                      ),
                      onPressed: () {
                        if (!camposValidos()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Preencha todos os campos corretamente.",
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }
                        double imc = calcular(
                          pessoa.getAltura(),
                          pessoa.getPeso(),
                        );
                        setState(() {
                          registros.add({
                            'nome': pessoa.getNome(),
                            'imc': imc.toStringAsFixed(2),
                          });

                          // Limpar os campos
                          pessoa = Pessoa(); // zera os dados
                          nomeController.clear();
                          alturaController.clear();
                          pesoController.clear();
                        });
                      },
                      //-----------------------------------------------------------------------------------------------------------------------------------------
                      child: const Text(
                        "Calcular",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 300,
              child: Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Nome",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "IMC",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ...registros.map(
                    (registro) => TableRow(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(registro['nome']),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(registro['imc'].toString()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
