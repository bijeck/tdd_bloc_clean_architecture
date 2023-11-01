import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_bloc_clean_architecture/src/authentication/presentation/bloc/authentication_bloc.dart';

class CreateUserDialog extends StatelessWidget {
  const CreateUserDialog({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'User name',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  const avatar = 'https://cloudflare-ipfs.com/ipfs/Qmd3W5Duh'
                      'gHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1203.jpg';
                  final name = controller.text.trim();
                  context.read<AuthenticationBloc>().add(
                        CreateUserEvent(
                          createdAt: DateTime.now().toString(),
                          name: name,
                          avatar: avatar,
                        ),
                      );
                  controller.clear();
                  Navigator.of(context).pop();
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
