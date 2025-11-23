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
            ListView(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.safety_divider_outlined),
                        Text(
                          "Something 1",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.ac_unit_rounded),
                        Text(
                          "Something 2",
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),

          );
        }
      ),
    );
  }
}