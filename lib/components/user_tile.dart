import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';
import '../routes/app_roues.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? const CircleAvatar(
            child: Icon(Icons.person),
          )
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl, scale: 30.5),
          );

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: Container(
        width: 100,
        child: Row(children: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.USER_FROM,
                arguments: user,
              );
            },
            icon: const Icon(Icons.edit),
            color: Colors.blue,
          ),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text('Alerta!!'),
                        content: const Text('Desejar realmente eliminar ?'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                Provider.of<Users>(context, listen: false)
                                    .remover(user);
                                Navigator.of(context).pop();  
                              },
                              child: const Text('Yes')),
                        ],
                      ));
            },
            icon: const Icon(Icons.delete),
            color: Colors.red,
          )
        ]),
      ),
    );
  }
}
