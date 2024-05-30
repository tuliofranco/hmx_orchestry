
import 'package:flutter/material.dart';
import 'package:hmx_orchestry/pages/create_account_page.dart';
import 'package:hmx_orchestry/pages/home_page.dart';
import 'package:hmx_orchestry/widgets/components.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(children: [
                  const SizedBox(height: 60.0),
                  ComumTextFormField(
                    controller: _emailController,
                    labelText: "E-mail",
                    hintText: "Digite seu email",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite um email válido';
                      }
                      if (value.length < 5) {
                        return 'O nome precisa ter mais de 5 letras';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  ComumTextFormField(
                    controller: _passwordController,
                    labelText: "Senha",
                    hintText: "Digite sua senha",
                    isObscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, digite uma senha';
                      }
                      return null;
                    },
                  ),
                  Container(height: 50,),
                  Container( height: 50, width: 250,
                  decoration: BoxDecoration(color: const Color.fromRGBO(24, 108, 33, 0.612),borderRadius: BorderRadius.circular(20)),
                  child: TextButton(child: const Text("Entrar",
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 16),),
                  onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> const HomePage()));
                  },),
                  ),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=> const CreateAccountPage()));
                  }, child: const Text("Novo usuário? Criar uma nova conta!"))
                ]
              )
            )
          )
          );
  }
}