import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lock_in_twin/create_routine.dart';

void main() {
  runApp(const MyApp());
}

Widget _emptyRoutinesWidget() {
  return Center(
    child: Text(
      "No Routines",
      style: TextStyle(color: Colors.white, fontSize: 40),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color appBarColor = const Color(0xFF000000);
    Color mainBg = const Color(0xFF302e2e);

    //for testing
    List<String> routines = [
      "Morning Routine",
      "Workout Routine",
      "Evening Routine",
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: mainBg,

            appBar: PreferredSize(
              preferredSize: Size.fromHeight(70),
              child: AppBar(
                backgroundColor: appBarColor,
                title: Center(
                  child: Text(
                    "FME",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),

            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (kDebugMode) {
                  print("Button pressed");
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateRoutine()),
                );
              },
              backgroundColor: Colors.orange,
              child: Icon(Icons.add),
            ),

            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (routines.isEmpty) _emptyRoutinesWidget(),

                SlidableAutoCloseBehavior(
                  child: Center(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: routines.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Align(
                          alignment: Alignment.center,
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 300),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              child: Slidable(
                                groupTag: '0',
                                endActionPane: ActionPane(
                                  extentRatio: 0.25,
                                  motion: const BehindMotion(),
                                  children: [
                                    SlidableAction(
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
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 10);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
