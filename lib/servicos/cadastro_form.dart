import 'package:flutter/material.dart';
import 'package:hmx_orchestry/_comum/snackbar_error.dart';
import 'package:hmx_orchestry/pages/login_page.dart';
import 'package:hmx_orchestry/servicos/autenticacao_servico.dart';
import 'package:hmx_orchestry/widgets/components.dart';
import 'package:logging/logging.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadastroForm extends StatefulWidget {
  const CadastroForm({super.key});

  @override
  State<CadastroForm> createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final Logger _logger = Logger('CadastroForm');
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cnpjController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final AutenticacaoServico _autenticacaoServico = AutenticacaoServico();

  final maskFormatterPhone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final maskFormatterCnpj = MaskTextInputFormatter(
    mask: '##.###.###/####-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 60.0),
              ComumTextFormField(
                controller: _emailController,
                labelText: "E-mail",
                hintText: 'Digite seu email',
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
                controller: _nameController,
                labelText: "Nome",
                hintText: 'Digite o nome da empresa',
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
                controller: _cnpjController,
                labelText: "CNPJ",
                hintText: '00.000.000/0000-00',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite seu CNPJ';
                  }
                  // Adicione aqui a validação de CNPJ se necessário
                  return null;
                },
                inputFormatters: [maskFormatterCnpj],
              ),
              const SizedBox(height: 15.0),
              ComumTextFormField(
                controller: _phoneNumberController,
                labelText: "Telefone",
                hintText: '(99) 99999-9999',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, digite seu telefone';
                  }
                  return null;
                },
                inputFormatters: [maskFormatterPhone],
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
              const SizedBox(height: 15.0),
              ComumTextFormField(
                controller: _confirmPasswordController,
                labelText: "Senha",
                hintText: "Digite sua senha",
                isObscureText: true,
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'As senhas não coincidem.';
                  }
                  return null;
                },),
              const SizedBox(height: 50.0),
              _buildSubmitButton(),
              const SizedBox(height: 130.0),
            ],
            // ignore: avoid_print
          ),
        ),
      ),
    );
  }

  void _logFormValues() {
    _logger.info("Email: ${_emailController.text}");
    _logger.info("CNPJ: ${_cnpjController.text}");
    _logger.info("Telefone: ${_phoneNumberController.text}");
    _logger.info("Senha: ${_passwordController.text}");
    _logger.info("Confirmação de Senha: ${_confirmPasswordController.text}");
  }

  Widget _buildSubmitButton() {
    return Container(
      height: 50,
      width: 250,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(24, 108, 33, 0.612),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextButton(
        onPressed: _submitForm,
        child: const Text(
          'Cadastrar',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    final String email = _emailController.text;
    final String cnpj = _cnpjController.text;
    final String telefone = _phoneNumberController.text;
    final String senha = _passwordController.text;
    final String nome = _nameController.text;

    if (_formKey.currentState!.validate()) {
      _logFormValues();
      _logger.info("Formulário válido!");
      _autenticacaoServico.CadastrarUsuario(
              email: email,
              cnpj: cnpj,
              telefone: telefone,
              senha: senha,
              nome: nome)
          .then((String? error) {
        if (error != null) {
          showSnackBar(context: context, text: error);
        } else {
          showSnackBar(
              context: context,
              text: "Cadastro efetuado com sucesso!!",
              isError: false);
        }
      });
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    } else {
      _logger.info("Formulário inválido!");
    }
  }
}
