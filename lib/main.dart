import 'package:flutter/material.dart';
import 'package:lock_in_twin/create_routine.dart';

void main() {
  runApp(const MyApp());
}

Widget _emptyRoutinesWidget() {
  return Center(
    child: Text(
      "No Routines",
      style: TextStyle(
        color: Colors.white,
        fontSize: 40,
      ),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color appBarColor = const Color(0xFF000000);
    Color mainBg = const Color(0xFF302e2e);

    //for testing
    List<String> routines = ["Morning Routine", "Workout Routine", "Evening Routine"];


    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: mainBg,


            appBar: PreferredSize(preferredSize: Size.fromHeight(70), child:
              AppBar(
                backgroundColor: appBarColor,
                title: Center(
                    child: Text(
                      "Lock in Twin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    )
                ),
              ),
            ),



            floatingActionButton: FloatingActionButton(onPressed: () {
                print("Button pressed");
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

                //put a list view here if routines is not empty
                ListView.separated(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: routines.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: Container(
                        padding: Padding(padding: EdgeInsets.all(10)).padding,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          routines[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(height: 10);
                  },
                      // ListTile(
                      //
                      //   title: Text(
                      //     routines[i],
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 20,
                      //     ),
                      //   ),
                      // )

                )
              ],
            ),


          );
        }
      ),
    );
  }
}