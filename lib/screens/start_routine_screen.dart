
import 'package:flutter/material.dart';

import '../items/routines.dart';
import 'home_widgets/appbar.dart';

class StartRoutine extends StatefulWidget {
  final Routine routineObj;

  const StartRoutine({super.key, required this.routineObj});

  @override
  State<StatefulWidget> createState() => _StartRoutineState();
}


class _StartRoutineState extends State<StartRoutine> {
  Color mainBg = const Color(0xFF302e2e);

  Routine get routineObj => widget.routineObj;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBg,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: CustomAppBar(),
      ),

      body: Center(
        child: Column(
          children: [
            Expanded(

              // main list view
              // issue: shows ALL of the routines
              // should only show the selected routine
              child: ListView.separated(
                //place this in a separate class for easier reading
                itemBuilder: (BuildContext context, int index) {
                  final routineName = routineObj.savedRoutines.keys.elementAt(
                    index,
                  );
                  final routineExercises = routineObj.savedRoutines.values
                      .elementAt(index);
                  final exerciseTitles = routineExercises.values
                      .map((e) => e.title)
                      .toList();

                  // main list view contents
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),

                    // routine name
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10.0,
                        children: [
                          Container(
                            decoration: BoxDecoration(color: Colors.black12),
                            child: Text(
                              routineName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),

                          // rows for each exercise
                          ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 350),
                            child:Column(
                              children: [
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context, int index) {
                                    final isRowEven = index % 2;
                                    final specificExercise =
                                    exerciseTitles[index];

                                    //edit this later after second part of create routine is finished
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: isRowEven == 0 ? mainBg : Colors.orange,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 10),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  specificExercise,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // add one for set after rep
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Rep",
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
                                                child: Icon(
                                                  Icons.check_box_outline_blank,
                                                  color: Colors.black26,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 0);
                                  },
                                  itemCount: exerciseTitles.length,
                                ),
                              ],
                            ),
                          ),

                          ElevatedButton(
                              onPressed: (){},
                              child: Text(
                                "Finish routine",
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                ),
                              )
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 20);
                },
                itemCount: routineObj.savedRoutines.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
