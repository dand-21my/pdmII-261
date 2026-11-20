import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/carrinho_provider.dart';

class CarrinhoPage extends StatelessWidget {
  const CarrinhoPage({super.key});

  void _finalizar(BuildContext context, CarrinhoProvider carrinho) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('💳 Finalizar compra'),
        content: Text(
            'Total a pagar: R\$ ${carrinho.valorTotal.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(ctx); // fecha o dialog
              carrinho.limpar();
              Navigator.pop(context); // volta pra lista
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🎉 Compra realizada com sucesso!'),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.pink,
                ),
              );
            },
            child: const Text('Pagar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final carrinho = context.watch<CarrinhoProvider>();
    final entradas = carrinho.itens.entries.toList();
    final rosa = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('🛒 Meu Carrinho'),
        backgroundColor: rosa.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: carrinho.limpar,
          ),
        ],
      ),
      body: entradas.isEmpty
          ? const Center(
              child: Text('Carrinho vazio 🥺', style: TextStyle(fontSize: 18)),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: entradas.length,
                    itemBuilder: (_, i) {
                      final produto = entradas[i].key;
                      final qtd = entradas[i].value;
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.pink.shade100,
                            child: Text(produto.emoji,
                                style: const TextStyle(fontSize: 22)),
                          ),
                          title: Text(produto.nome),
                          subtitle: Text(
                            'R\$ ${(produto.preco * qtd).toStringAsFixed(2)}',
                            style: TextStyle(color: rosa.primary),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => carrinho.remover(produto),
                              ),
                              Text('$qtd',
                                  style: const TextStyle(fontSize: 16)),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => carrinho.adicionar(produto),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.pink.withOpacity(0.2), blurRadius: 10),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Total: R\$ ${carrinho.valorTotal.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            icon: const Icon(Icons.payment),
                            label: const Text('Finalizar compra'),
                            onPressed: () => _finalizar(context, carrinho),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}