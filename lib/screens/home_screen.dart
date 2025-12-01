import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lock_in_twin/screens/home_widgets/appbar.dart';

import 'create_routine.dart';
import '../items/routines.dart';
import 'package:lock_in_twin/screens/home_widgets/build_routine_display.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color appBarColor = const Color(0xFF000000);
  Color mainBg = const Color(0xFF302e2e);
  final routineObj = Routine();

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Saved routines: ${routineObj.savedRoutines.length}");
    }

    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: mainBg,

          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: CustomAppBar(),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (kDebugMode) {
                print("Button pressed");
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateRoutine(routineObj: routineObj),
                  settings: const RouteSettings(name: "/CreateRoutine1"),
                ),
              ).then((_) {
                setState(() {});
              });
            },
            backgroundColor: Colors.orange,
            child: Icon(Icons.add),
          ),

          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (routineObj.savedRoutines.isEmpty) _emptyRoutinesWidget(),
              Expanded(
                child: SlidableAutoCloseBehavior(
                  child: Center(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: routineObj.savedRoutines.length,
                      itemBuilder: (BuildContext context, int index) {
                        return BuildRoutineDisplay(
                          index: index,
                          routineObj: routineObj,
                          onDelete: () {
                            setState(() {});
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 20);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // helper widget
  Widget _emptyRoutinesWidget() {
    return Center(
      child: Text(
        "No Routines",
        style: TextStyle(color: Colors.white, fontSize: 40),
      ),
    );
  }
}
