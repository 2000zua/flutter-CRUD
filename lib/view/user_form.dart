import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/users.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});
  @override
  UserFormState createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  //const UserForm({super.key});
  // variavel para pegar os dados do formulario

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User user = ModalRoute.of(context)!.settings.arguments as User;
    _loadFormData(user);
  }

  final Map<String, String> _formData = {};
  final _form = GlobalKey<FormState>();

  void _loadFormData(User user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['nome'] = user.name;
      _formData['email'] = user.email;
      _formData['urlAvatar'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    // pegar os dados passado como argumento na rota
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario de Usuario'),
        actions: [
          IconButton(
              onPressed: () {
                final isValid = _form.currentState!.validate();
                if (isValid) {
                  _form.currentState!.save();
                  // chamar o provider e salvar os dados
                  Provider.of<Users>(context, listen: false).put(User(
                    id: _formData['id'].toString(),
                    name: _formData['nome'].toString(),
                    email: _formData['email'].toString(),
                    avatarUrl: _formData['urlAvatar'].toString(),
                  ));
                  Navigator.of(context).pop();
                }
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                // caso for para editar
                initialValue: _formData['nome'],
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nome Invalido';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome muito curto';
                  }
                },
                onSaved: (value) => _formData['nome'] = value.toString().trim(),
              ),
              TextFormField(
                // caso for para editar
                initialValue: _formData['email'],
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email Invalido';
                  }
                  if (value.trim().length < 3) {
                    return 'Email Invalido';
                  }
                },
                onSaved: (value) {
                  _formData['email'] = value.toString().trim();
                },
              ),
              TextFormField(
                // caso for para editar
                initialValue: _formData['urlAvatar'],
                decoration: const InputDecoration(labelText: 'Url avatar'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Url Invalido';
                  }
                },
                onSaved: (value) {
                  _formData['urlAvatar'] = value.toString().trim();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
