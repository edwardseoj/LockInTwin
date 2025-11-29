import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/routines.dart';

class RoutineTitleForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Routine routine;

  const RoutineTitleForm({
    super.key,
    required this.formKey,
    required this.routine,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'Routine Name',
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white54),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
        onSaved: (value) {
          routine.routineName = value ?? '';
        },
      ),
    );
  }
}
