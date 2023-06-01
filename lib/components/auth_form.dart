import 'dart:io';

import 'package:chat/components/user_Image_picker.dart';
import 'package:chat/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;
  const AuthForm({
    required this.onSubmit,
    super.key,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();
  bool isPasswordHide = true;

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;

    if (_formData.image == null && _formData.isSignup) {
      return _showError("Imagem não selecionada!");
    }

      widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_formData.isSignup)
                UserImagePicker(
                  onImagePick: _handleImagePick,
                ),
              if (_formData.isSignup)
                TextFormField(
                  key: const ValueKey("name"),
                  initialValue: _formData.name,
                  onChanged: (name) => _formData.name = name,
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    final name = value ?? "";
                    if (name.trim().length < 3) {
                      return "Nome deve ter no mínimo 3 caracteres.";
                    }

                    return null;
                  },
                ),
              TextFormField(
                key: const ValueKey("email"),
                onChanged: (email) => _formData.email = email,
                decoration: const InputDecoration(labelText: "E-mail"),
                validator: (value) {
                  final email = value ?? "";
                  if (!email.contains("@")) {
                    return "Email informado não é válido.";
                  }

                  return null;
                },
              ),
              Row(
                children: [
                  SizedBox(
                    width: 335,
                    child: TextFormField(
                      key: const ValueKey("password"),
                      initialValue: _formData.password,
                      onChanged: (password) => _formData.password = password,
                      obscureText: isPasswordHide ? true : false,
                      decoration: const InputDecoration(labelText: "Senha"),
                      validator: (value) {
                        final password = value ?? "";
                        if (password.trim().length < 6) {
                          return "Senha deve ter no mínimo 6 caracteres.";
                        }

                        return null;
                      },
                    ),
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     setState(() {
                  //       isPasswordHide = !isPasswordHide;
                  //     });
                  //   },
                  //   icon: Icon(isPasswordHide
                  //       ? Icons.visibility
                  //       : Icons.visibility_off),
                  // ),
                ],
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _submit,
                child: Text(
                  _formData.isLogin ? "Entrar" : "Cadastrar",
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _formData.toggleAuthMode();
                  });
                },
                child: Text(
                  _formData.isLogin
                      ? "Criar uma nova conta?"
                      : "Já possui conta?",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
