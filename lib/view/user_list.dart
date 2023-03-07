import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/user_tile.dart';
import '../models/user.dart';
import '../provider/users.dart';
import '../routes/app_roues.dart';

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
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.USER_FROM);
              },
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
