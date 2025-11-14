        
import 'package:go_router/go_router.dart';
     
import '../../features/auth/splash_gate.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/home/home_screen.dart';


final appRouter = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const SplashGate()),
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    GoRoute(path: '/register', builder: (_, __) => const RegisterScreen()),
    GoRoute(path: '/home', builder: (_, __) => const HomeScreen()), // placeholder
  ],
);
