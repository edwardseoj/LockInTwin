import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuildRoutineDisplay extends StatelessWidget{
  final index;
  final List<String> routines;

  const BuildRoutineDisplay({
    super.key,
    required this.index,
    required this.routines,
  });

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.center,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 300), // may edit this for max width

        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),

          child: Slidable(
            groupTag: '0', // do not edit this. this is for auto closing other slidables
            endActionPane: ActionPane(
              extentRatio: 0.25,
              motion: const BehindMotion(),
              children: [

                SlidableAction(

                  // edit this function to delete saved routines
                  onPressed: (context) {
                    if (kDebugMode) {
                      print("Delete ${routines[index]}");
                    }
                  },

                  backgroundColor: Colors.red,
                  icon: Icons.delete_outline,
                ),
              ],
            ),


            // design
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              child: Text(
                routines[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}