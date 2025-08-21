import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tarjet_list/presentation/providers/card_provider.dart';
import 'package:tarjet_list/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CardProvider()), //Gestor de estado
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Listado de Tarjetas',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
