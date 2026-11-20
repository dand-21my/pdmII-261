import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/carrinho_provider.dart';
import 'screens/lista_produtos.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CarrinhoProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho de Compras',
      theme: ThemeData(
        colorSchemeSeed: Colors.pink,
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFFF0F5),
      ),
      home: const ListaProdutos(),
    );
  }
}