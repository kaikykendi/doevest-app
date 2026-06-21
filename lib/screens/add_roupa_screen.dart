import 'package:flutter/material.dart';
import 'roupa_service.dart';

class AddRoupaScreen extends StatefulWidget {
  const AddRoupaScreen({super.key});

  @override
  State<AddRoupaScreen> createState() => _AddRoupaScreenState();
}

class _AddRoupaScreenState extends State<AddRoupaScreen> {
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();
  final TextEditingController tamanhoController = TextEditingController();
  final TextEditingController condicaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar Roupa"),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            ElevatedButton(
              onPressed: () {
                // implementar depois
              },
              child: const Text("Adicionar Fotos da Doação"),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: tipoController,
              decoration: const InputDecoration(
                labelText: "Tipo da Roupa",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: descricaoController,
              decoration: const InputDecoration(
                labelText: "Descrição",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: tamanhoController,
              decoration: const InputDecoration(
                labelText: "Tamanho",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: condicaoController,
              decoration: const InputDecoration(
                labelText: "Condição",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                ),
                onPressed: () async {
                  // validação simples
                  if (tipoController.text.isEmpty ||
                      descricaoController.text.isEmpty ||
                      tamanhoController.text.isEmpty ||
                      condicaoController.text.isEmpty) {

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Preencha todos os campos"),
                      ),
                    );
                    return;
                  }

                  try {
                    await RoupaService().salvarRoupa(
                      tipoController.text,
                      descricaoController.text,
                      tamanhoController.text,
                      condicaoController.text,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Roupa cadastrada com sucesso!"),
                      ),
                    );

                    tipoController.clear();
                    descricaoController.clear();
                    tamanhoController.clear();
                    condicaoController.clear();

                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Erro ao cadastrar roupa: $e"),
                      ),
                    );
                  }
                },
                child: const Text(
                  "Cadastrar Roupa",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}