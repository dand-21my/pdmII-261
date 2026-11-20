import 'package:flutter/material.dart';
import '../models/produto.dart';

class CarrinhoProvider extends ChangeNotifier {
  final Map<Produto, int> _itens = {};

  Map<Produto, int> get itens => _itens;

  int get totalItens => _itens.values.fold(0, (a, b) => a + b);

  double get valorTotal => _itens.entries
      .fold(0, (soma, e) => soma + e.key.preco * e.value);

  void adicionar(Produto p) {
    _itens[p] = (_itens[p] ?? 0) + 1;
    notifyListeners();
  }

  void remover(Produto p) {
    if (!_itens.containsKey(p)) return;
    if (_itens[p]! > 1) {
      _itens[p] = _itens[p]! - 1;
    } else {
      _itens.remove(p);
    }
    notifyListeners();
  }

  void limpar() {
    _itens.clear();
    notifyListeners();
  }
}