import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'add_roupa_screen.dart';

class ListarRoupasScreen extends StatefulWidget {
  const ListarRoupasScreen({super.key});

  @override
  State<ListarRoupasScreen> createState() => _ListarRoupasScreenState();
}

class _ListarRoupasScreenState extends State<ListarRoupasScreen> {

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String userId = _auth.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Minhas Roupas Cadastradas"),
        backgroundColor: Colors.blue,
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddRoupaScreen()),
          );
        },
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('roupas')
            .where('userId', isEqualTo: userId)
            .snapshots(),

        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Nenhuma roupa cadastrada."));
          }

          final roupas = snapshot.data!.docs;

          return ListView.builder(
            itemCount: roupas.length,
            itemBuilder: (context, index) {
              final roupa = roupas[index];

              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text("${roupa['tipo']} - ${roupa['tamanho']}"),
                  subtitle: Text("Condição: ${roupa['condicao']}"),

                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await _firestore
                          .collection('roupas')
                          .doc(roupa.id)
                          .delete();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}