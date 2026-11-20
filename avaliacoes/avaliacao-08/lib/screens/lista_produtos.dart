import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/produto.dart';
import '../providers/carrinho_provider.dart';
import 'carrinho_page.dart';

class ListaProdutos extends StatelessWidget {
  const ListaProdutos({super.key});

  static final produtos = [
    Produto(id: 1, nome: 'Camiseta', preco: 49.90, emoji: '👕'),
    Produto(id: 2, nome: 'Tênis', preco: 199.90, emoji: '👟'),
    Produto(id: 3, nome: 'Boné', preco: 29.90, emoji: '🧢'),
    Produto(id: 4, nome: 'Mochila', preco: 129.90, emoji: '🎒'),
  ];

  @override
  Widget build(BuildContext context) {
    final carrinho = context.watch<CarrinhoProvider>();
    final rosa = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛍️ Minha Lojinha'),
        backgroundColor: rosa.primary,
        foregroundColor: Colors.white,
        actions: [
          Badge(
            label: Text('${carrinho.totalItens}'),
            isLabelVisible: carrinho.totalItens > 0,
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CarrinhoPage()),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: produtos.length,
        itemBuilder: (_, i) {
          final p = produtos[i];
          return Card(
            elevation: 3,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: rosa.primary.withOpacity(0.3)),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.pink.shade100,
                child: Text(p.emoji, style: const TextStyle(fontSize: 26)),
              ),
              title: Text(p.nome,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(
                'R\$ ${p.preco.toStringAsFixed(2)}',
                style: TextStyle(
                    color: rosa.primary, fontWeight: FontWeight.w600),
              ),
              trailing: FilledButton.icon(
                icon: const Icon(Icons.add_shopping_cart, size: 18),
                label: const Text('Add'),
                onPressed: () {
                  context.read<CarrinhoProvider>().adicionar(p);
                  ScaffoldMessenger.of(context).clearSnackBars();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${p.emoji} ${p.nome} adicionado ao carrinho!'),
                      duration: const Duration(seconds: 1),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.pink,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}