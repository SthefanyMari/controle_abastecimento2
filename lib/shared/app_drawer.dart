import 'package:flutter/material.dart';
import 'package:abastecimento/features/home/home_screen.dart';
import 'package:abastecimento/features/veiculos/veiculo_screen.dart';
import 'package:abastecimento/features/abastecimentos/abastecimento_screen.dart';
import 'package:abastecimento/features/abastecimentos/historico_abastecimentos_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.indigo),
            child: Column(
              children: [
                const Text(
                  'FuelTrack System',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: const Text('Meus Veículos'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const VeiculoScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_gas_station),
            title: const Text('Registrar Abastecimento'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const AbastecimentoScreen(veiculoId: ''), 
                ),
              );
            },
          ),
          ListTile(
  leading: const Icon(Icons.history),
  title: const Text('Histórico de Abastecimentos'),
  onTap: () {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HistoricoAbastecimentosScreen()),
    );
  },
),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
