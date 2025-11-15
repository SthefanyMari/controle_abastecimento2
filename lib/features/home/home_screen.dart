import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:abastecimento/features/veiculos/veiculo_controller.dart';
import 'package:abastecimento/features/veiculos/veiculo_cadastro_dialog.dart';
import 'package:abastecimento/shared/app_drawer.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(veiculoControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('FuelTrack System')),
      drawer: const AppDrawer(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            // 📱 Layout vertical para telas pequenas
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/banner.png',
                    fit: BoxFit.cover,
                    height: 200, // limita altura da imagem
                  ),
                  const SizedBox(height: 24),
                  _buildTextSection(context, controller),
                ],
              ),
            );
          } else {
            // 💻 Layout horizontal para telas grandes
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Expanded(flex: 2, child: _buildTextSection(context, controller)),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      'assets/banner.png',
                      fit: BoxFit.cover,
                      height: 300, // altura controlada
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTextSection(BuildContext context, VeiculoController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sistema de Controle de Abastecimento',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D1B2A),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Gerencie seus veículos, registre abastecimentos e acompanhe o consumo de forma prática e organizada. Tenha total controle da sua frota em um único lugar.',
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0D1B2A),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => CadastroVeiculoDialog(controller: controller),
            );
          },
          child: const Text('Começar agora'),
        ),
      ],
    );
  }
}
