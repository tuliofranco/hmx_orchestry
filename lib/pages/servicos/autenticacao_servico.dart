import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

class AutenticacaoServico {
  final Logger _logger = Logger('AutenticacaoServico');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  CadastrarUsuario(
      {required String email,
      required String cnpj,
      required String telefone,
      required String senha,
      required String nome}) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      // Atualiza o nome de exibição do usuário
      await userCredential.user!.updateDisplayName(nome);
      await userCredential.user!.reload();

      // Chama a função fictícia para verificar o número de telefone
      await _verifyPhoneNumber(telefone, userCredential.user!);
    } catch (e) {
      _logger.info('Falha ao cadastrar usuário: $e');
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
}
