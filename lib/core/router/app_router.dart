import 'package:abastecimento/features/abastecimentos/abastecimento_screen.dart';
import 'package:abastecimento/features/abastecimentos/historico_abastecimentos_screen.dart';
import 'package:abastecimento/features/veiculos/veiculo_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/splash_gate.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/home/home_screen.dart';


import '../navigation/global_transition.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (_, __) => globalTransition(
        child: const SplashGate(),
      ),
    ),

    GoRoute(
      path: '/login',
      pageBuilder: (_, __) => globalTransition(
        child: const LoginScreen(),
      ),
    ),

    GoRoute(
      path: '/register',
      pageBuilder: (_, __) => globalTransition(
        child: const RegisterScreen(),
      ),
    ),

    GoRoute(
      path: '/home',
      pageBuilder: (_, __) => globalTransition(
        child: const HomeScreen(),
      ),
    ),

    GoRoute(
      path: '/listaVeiculo',
      pageBuilder: (_, __) => globalTransition(
        child: const VeiculoScreen(),
      ),
    ),

    GoRoute(
      path: '/listaAbastecimento',
      pageBuilder: (_, __) => globalTransition(
        child: const HistoricoAbastecimentosScreen(),
      ),
    ),

    GoRoute(
      path: '/abastecimentos/:veiculoId',
      pageBuilder: (context, state) {
        final veiculoId = state.pathParameters['veiculoId']!;
        return globalTransition(
          child: AbastecimentoScreen(veiculoId: veiculoId),
        );
      },
    ),
  ],
);
