import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 🔐 CADASTRAR USUÁRIO
  Future<bool> cadastrar(String nome, String email, String senha) async {
    try {
      // 🔥 Criar usuário no Firebase Auth
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      print("✅ Usuário criado no Auth: ${userCredential.user!.uid}");

      // 🔥 Salvar no Firestore
      await _firestore
          .collection('usuarios')
          .doc(userCredential.user!.uid)
          .set({
        'nome': nome,
        'email': email,
      });

      print("🔥 SALVOU NO FIRESTORE");

      return true;

    } on FirebaseAuthException catch (e) {
      print("🔥 ERRO FIREBASE AUTH: ${e.code}");

      if (e.code == 'email-already-in-use') {
        print("📧 Email já está em uso");
      } else if (e.code == 'invalid-email') {
        print("📧 Email inválido");
      } else if (e.code == 'weak-password') {
        print("🔒 Senha fraca (mínimo 6 caracteres)");
      }

      return false;

    } catch (e) {
      print("🔥 ERRO GERAL: $e");
      return false;
    }
  }

  // 🔐 LOGIN
  Future<bool> login(String email, String senha) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );

      print("✅ Login realizado com sucesso");
      return true;

    } catch (e) {
      print("🔥 ERRO NO LOGIN: $e");
      return false;
    }
  }

  // 🚪 LOGOUT
  Future<void> logout() async {
    await _auth.signOut();
    print("🚪 Logout realizado");
  }
}