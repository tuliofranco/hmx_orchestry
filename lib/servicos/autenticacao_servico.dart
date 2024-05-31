import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';
import 'package:dartz/dartz.dart';

class AutenticacaoServico {
  final Logger _logger = Logger('AutenticacaoServico');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  get instance => null;
  // ignore: non_constant_identifier_names
  Future<String?> CadastrarUsuario(
      {required String email,
      required String cnpj,
      required String telefone,
      required String senha,
      required String nome}) async {
    try  {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Atualiza o nome de exibição do usuário
      await userCredential.user!.updateDisplayName(nome);
      await userCredential.user!.reload();

      // Chama a função fictícia para verificar o número de telefone
      await _verifyPhoneNumber(telefone, userCredential.user!);

      return null;
    } on FirebaseAuthException catch(e) {
      if(e.code == 'email-already-in-use'){
        return 'Email já está sendo usado.';
        //showSnackBar(context: context, text: text);

      } else {
        return 'Erro desconhecido! Falha ao cadastrar usuário: $e';
      }
    }
  }
  Future<void> _verifyPhoneNumber(String phoneNumber, User user) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Atualiza o número de telefone do usuário automaticamente
        await user.updatePhoneNumber(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        _logger.severe('Falha na verificação do telefone: $e');
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Aqui você deve implementar a lógica para solicitar ao usuário o código de verificação
        // e então usar `PhoneAuthProvider.credential` para obter as credenciais de autenticação
        // a partir do código e do `verificationId`
        _logger.info('Código de verificação enviado para o número de telefone');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Lógica para timeout do código de verificação
        print('Tempo limite para recuperação automática do código atingido');
      },
    );
  }

  // ignore: non_constant_identifier_names
  Future<Either<String, void>> logarUsuario({required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: senha);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(e.message ?? 'Erro desconhecido');
    }
  }



  // ignore: non_constant_identifier_names
  Future<void> Deslogar() async {
    return _firebaseAuth.signOut();
  }
}
