import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import '../models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  // pegar todos os elementos
  List<User> get all {
    return [..._items.values];
  }

  // pegar o tamanho de todos os dados
  int get count {
    return _items.length;
  }

  // pegar os elemento pelo id
  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  // Inserir um  novouser
  void put(User user) {
    if (user == null) {
      return;
    }

    if (_items.containsKey(user.id) &&
        user.id != null &&
        user.id.trim().isNotEmpty) {
        // editar
      _items.update(user.id, (_) => user);
    
    } else {
      // adicionar
      final id = Random().nextDouble().toString();
      _items.putIfAbsent(
          id,
          () => User(
              id: id,
              name: user.name,
              email: user.email,
              avatarUrl: user.avatarUrl));
    }
    // notificar todos os filhos sobre as alteracaoes
    notifyListeners();
  }

  void remover(User user) {
    if (user != null && user.id != null) {
      _items.remove(user.id);
      notifyListeners();
    }
    return;
  }
}


/**
 * ... PARA FAZER UM CLONE, ++
 */