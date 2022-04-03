import 'package:flutter/material.dart';
import 'package:my_eagles/models/schedule_object.dart';
import 'package:my_eagles/models/app_user.dart';
import 'package:my_eagles/pages/home/scheduleChange.dart';
import 'package:my_eagles/shared/loading.dart';
import 'package:provider/provider.dart';
import 'package:my_eagles/services/database.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamBuilder<List<ScheduleObject>>(
        stream: DatabaseService(uid: user.uid).userSchedule,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ScheduleObject>? scheduleItems = snapshot.data;
            return Scaffold(
              body: ListView.builder(
                itemCount: scheduleItems!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 1.0, horizontal: 4.0),
                    child: Card(
                      color: Colors.grey[700],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 2.0),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              scheduleItems[index].className,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20.0),
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              "Period: " +
                                  scheduleItems[index].classPeriod.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 17.0),
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              "Teacher: " + scheduleItems[index].classTeacher,
                              style: const TextStyle(fontSize: 15.0),
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(4.0, 0.0, 0.0, 0.0),
                            child: Text(
                              "Room: " +
                                  scheduleItems[index].classRoom.toString(),
                              style: const TextStyle(fontSize: 17.0),
                            ),
                          ),
                          const SizedBox(height: 2.0),
                        ],
                      ),
                    ),
                  );
                },
              ),
              backgroundColor: Colors.grey[900],
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleChange()));
                },
                icon: const Icon(Icons.settings_outlined),
                label: const Text('Change'),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}