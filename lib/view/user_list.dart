import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/user_tile.dart';
import '../provider/users.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    // PEGAR OS DADOS com provider
    final Users users = Provider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Usuarios'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
              color: const Color.fromARGB(255, 255, 255, 255),
            )
          ],
        ),
        body: ListView.builder(
          itemCount: users.count,
          itemBuilder: (ctx, i) => UserTile(user: users.byIndex(i)),
        ));
  }
}
