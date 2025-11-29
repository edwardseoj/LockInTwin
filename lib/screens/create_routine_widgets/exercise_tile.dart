import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/exercises.dart';

class ExerciseTile extends StatelessWidget {
  final Exercises exercise;
  final VoidCallback onTap;

  const ExerciseTile({
    super.key,
    required this.exercise,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: exercise.icon,
      title: Text(
        exercise.title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        exercise.subtitle,
        style: const TextStyle(color: Colors.white70),
      ),
      tileColor: exercise.isSelected ? Colors.orange : null,
      trailing: Icon(
        exercise.isSelected
            ? Icons.backspace_outlined
            : Icons.add_circle_outline,
        color: exercise.isSelected ? Colors.white : Colors.orange,
      ),
      onTap: onTap,
    );
  }
}
