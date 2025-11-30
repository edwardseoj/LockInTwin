import 'package:flutter/material.dart';

class BuildExerciseRow extends StatelessWidget {
  final String title;
  final int index;

  const BuildExerciseRow({
    super.key,
    required this.title,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final isRowEven = index % 2;

    return Container(
      decoration: BoxDecoration(
        color: isRowEven == 0 ? Colors.white12 : Colors.orange,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
          top: 10,
        ),
        child: Column(
          children: [

            // exercise title
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
            ),

            // set and reps row
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      index == 0 ? "Set" : "x",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      index == 0 ? "Rep" : "x",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: index > 0
                        ? Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.black26,
                    )
                        : null,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
