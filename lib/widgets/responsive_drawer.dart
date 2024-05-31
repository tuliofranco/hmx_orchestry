import 'package:flutter/material.dart';
import 'package:hmx_orchestry/servicos/autenticacao_servico.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Drawer(
          child: Container(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Center(
                  // ignore: sort_child_properties_last
                  child: Image.asset('asset/images/logo_hemox.png',
                  fit: BoxFit.contain,
                  height: 1000,),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.logout), title: const Text('Sair'), 
                  onTap: () {
                    // Atualize o estado da aplicação
                    AutenticacaoServico().Deslogar();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}