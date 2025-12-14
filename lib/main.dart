import 'package:flutter/material.dart';
import 'package:web_admin_tenis/presentation/screens/home_screen.dart';
import 'package:web_admin_tenis/presentation/screens/jugadores_screen.dart';
import 'package:web_admin_tenis/presentation/screens/partidos_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web de Administración del tenis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF6B8E23),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Color(0xFF6B8E23),
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/jugadores': (context) => const JugadoresScreen(),
        '/partidos': (context) => const PartidosScreen(),
      },
    );
  }
}
