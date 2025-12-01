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

        // COLORING: Exercise Title color e.g Squats
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        exercise.subtitle,

        // COLORING: Exercise subtitle color e.g upper body
        style: const TextStyle(color: Colors.white70),
      ),


      // COLORING: Exercise Tile Color (Different when tapped and untapped)
      tileColor: exercise.isSelected ? Colors.orange : null,
      trailing: Icon(
        exercise.isSelected
            ? Icons.backspace_outlined
            : Icons.add_circle_outline,


        // COLORING: Icon Color (Different when tapped and untapped)
        // First color is for backspace icon
        // Second color is for add icon
        color: exercise.isSelected ? Colors.white : Colors.orange,
      ),
      onTap: onTap,
    );
  }
}
