import 'package:flutter/material.dart';
import 'package:lock_in_twin/main.dart';

class CreateRoutine extends StatefulWidget{
  const CreateRoutine({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CreateRoutineState();
  }
}

class _CreateRoutineState extends State<CreateRoutine>{
  Color mainBg = const Color(0xFF302e2e);
  Map<String, List<dynamic>> exercises = {
    "Push Ups": ["Push Ups", "Upper Body", Icon(Icons.fitness_center), false],
    "Squats": ["Squats", "Lower Body", Icon(Icons.airline_seat_legroom_extra_sharp), false],
    "Glute Bridges": ["Glute Bridges", "Lower Body", Icon(Icons.airline_seat_legroom_extra_sharp), false],
    "Pull Ups": ["Pull Ups", "Upper Body", Icon(Icons.fitness_center), false],
    "Plank": ["Plank", "Core", Icon(Icons.fitness_center), false],
    "Plank1": ["Plank1", "Core", Icon(Icons.fitness_center), false],
    "Plank2": ["Plank2", "Core", Icon(Icons.fitness_center), false],
    "Plank3": ["Plank3", "Core", Icon(Icons.fitness_center), false],
    "Plank4": ["Plank4", "Core", Icon(Icons.fitness_center), false],
    "Plank5": ["Plank5", "Core", Icon(Icons.fitness_center), false],
  };



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
          return Scaffold(

            backgroundColor: mainBg,


            appBar: PreferredSize(preferredSize: Size.fromHeight(70), child:
            AppBar(
              backgroundColor: Colors.black,

              leading: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Builder(
                      builder: (BuildContext context){
                        return IconButton(
                            onPressed: (){
                              print("Went to Home Page");
                              Navigator.pushAndRemoveUntil(
                                  context, 
                                  MaterialPageRoute(builder: (context) => MyApp()),
                                  (Route<dynamic> route) => false,
                              );
                            },
                            icon: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.orange,
                                size: 30
                            ),
                        );
                      }
                  ),
                ],
              ),

              title: Text(
                "CREATE ROUTINE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              centerTitle: true,
            ),
            ),

            body:
                SafeArea(child:
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Routine Name',
                          labelStyle: TextStyle(color: Colors.white70),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white54),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          String key = exercises.keys.elementAt(index);
                          return ListTile(
                            leading: exercises[key]![2],
                            onTap: () {
                              setState(() {
                                exercises[key]![3] = !exercises[key]![3];
                                print(exercises[key]![0] + " selected" );
                              });
                            },
                            tileColor: exercises[key]![3] ? Colors.orange : null,

                            title: Text(
                              exercises[key]![0],
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              exercises[key]![1],
                              style: TextStyle(color: Colors.white70),
                            ),
                            trailing: Icon(
                              exercises[key]![3] ? Icons.backspace_outlined:  Icons.add_circle_outline,
                              color: exercises[key]![3] ? Colors.white: Colors.orange,
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(color: Colors.white24);
                        },
                        itemCount: exercises.length,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Logic to save the routine
                          print("Routine Saved");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => MyApp()),
                                (Route<dynamic> route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ),
          );
        }
      ),
    );
  }
}