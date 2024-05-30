import 'package:flutter/material.dart';
import 'package:hmx_orchestry/servicos/login_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
            child : Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                children: [Center(
                  child: SizedBox(
                    width: 300,
                    height: 225,
                    child:  Image.asset('asset/images/logo_hemox.png'),
              ),
            ),
          const Padding(
          padding:  EdgeInsets.all(8),
              child:  LoginForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
