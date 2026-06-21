import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoupaService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> salvarRoupa(String tipo, String descricao, String tamanho, String condicao) async {
    try {
      String userId = _auth.currentUser!.uid;

      await _firestore.collection('roupas').add({
        'userId': userId,
        'tipo': tipo,
        'descricao': descricao,
        'tamanho': tamanho,
        'condicao': condicao,
        'dataCadastro': FieldValue.serverTimestamp(),
      });

      print("Roupa salva com sucesso no Firestore!");
    } catch (e) {
      print("Erro ao salvar roupa: $e");
      throw e;
    }
  }
}