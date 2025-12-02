import 'package:flutter/material.dart';
import 'package:lock_in_twin/items/app_colors.dart';
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
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: exercise.icon,
        title: Text(exercise.title, style: const TextStyle(color: Colors.white)),
        subtitle: Text(exercise.subtitle, style: const TextStyle(color: Colors.white70)),
        tileColor: exercise.isSelected ? AppColors.containerColor : null,
        trailing: Container(
          decoration: BoxDecoration(
            color: AppColors.buttonBlue,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderColor, width: 2),
          ),
          padding: const EdgeInsets.all(6),
          child: Icon(
            exercise.isSelected ? Icons.backspace_outlined : Icons.add,
            color: exercise.isSelected ? Colors.red : AppColors.iconTextWhite,
            size: 24,
          ),
        ),
      ),
    );
  }
}
