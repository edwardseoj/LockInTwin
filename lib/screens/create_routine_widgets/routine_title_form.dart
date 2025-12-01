import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/routines.dart';

class RoutineTitleForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final Routine routineObj;

  const RoutineTitleForm({
    super.key,
    required this.formKey,
    required this.routineObj,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(

        // COLORING: Text Color after typing
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          labelText: 'Routine Name',


          // COLORING: Text Color - Placeholder Text
          labelStyle: TextStyle(color: Colors.white70),
          enabledBorder: OutlineInputBorder(


            // COLORING: Border Color when not typing
            borderSide: BorderSide(color: Colors.white54),
          ),
          focusedBorder: OutlineInputBorder(


            // COLORING: Border Color when typing
            borderSide: BorderSide(color: Colors.orange),
          ),
        ),
        onSaved: (value) {
          routineObj.routineName = value ?? '';
        },
      ),
    );
  }
}
