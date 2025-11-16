import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:abastecimento/features/veiculos/veiculo_controller.dart';
import 'package:abastecimento/features/veiculos/veiculo_cadastro_dialog.dart';
import 'package:abastecimento/shared/app_drawer.dart';
import 'dart:ui';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(veiculoControllerProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("FuelTrack System", style: TextStyle(color: Colors.white)),
      ),
      drawer: const AppDrawer(),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: _buildGlassCard(context, controller),
          ),
        ),
      ),
    );
  }

  // ------- CARD ESTILO GLASSMORPHISM -------
  Widget _buildGlassCard(BuildContext context, VeiculoController controller) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 600,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.white.withOpacity(0.10),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --------- ÍCONE PRINCIPAL ---------
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.local_gas_station, size: 60, color: Colors.white),
              ),

              const SizedBox(height: 30),

              // --------- TÍTULO ---------
              const Text(
                "Sistema de Controle de Abastecimento",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 16),

              // --------- DESCRIÇÃO ---------
              const Text(
                "Gerencie veículos, registre abastecimentos e acompanhe o consumo com precisão e facilidade.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 32),

              // --------- BOTÃO COM GRADIENTE ---------
              SizedBox(
                width: double.infinity,
                height: 50,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFF5F6D), Color(0xFFFFC371)],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (_) => CadastroVeiculoDialog(controller: controller),
                      );
                    },
                    child: const Text(
                      "Começar agora",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // --------- IMAGEM ---------
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/banner.png",
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
