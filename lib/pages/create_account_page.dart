import 'package:flutter/material.dart';
import 'package:hmx_orchestry/widgets/cadastro_form.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          
        child: CadastroForm())));
  }
}