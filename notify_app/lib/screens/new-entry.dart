import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notify_app/model/notify.dart';
import 'package:notify_app/screens/home.dart';
import 'package:notify_app/screens/new_entry_bloc.dart';
import 'package:notify_app/screens/success_screen.dart';
import 'package:notify_app/utils/global_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NewEntry extends StatefulWidget {
  const NewEntry({Key? key}) : super(key: key);

  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  TextEditingController? nameController;
  TextEditingController? detailsController;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  NewEntryBloc? _newEntryBloc;

  GlobalKey<ScaffoldState>? _scaffoldKey;
  String heading = '';
  String details = '';

  void dispose() {
    super.dispose();
    nameController!.dispose();
    detailsController!.dispose();
    _newEntryBloc!.dispose();
  }

  void initState() {
    super.initState();
    _newEntryBloc = NewEntryBloc();
    nameController = TextEditingController();
    detailsController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeNotifications();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.amber,
        ),
        centerTitle: true,
        title: Text(
          "Add New Note",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        child: Provider<NewEntryBloc?>.value(
          value: _newEntryBloc,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              PanelTitle(
                title: "Note Heading",
                isRequired: true,
              ),
              TextFormField(
                // maxLength: 100,
                style: TextStyle(
                  fontSize: 16,
                ),
                controller: nameController,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              PanelTitle(
                title: "Note Details",
                isRequired: true,
              ),
              TextFormField(
                maxLength: 300,
                controller: detailsController,
                style: TextStyle(
                  fontSize: 16,
                ),
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              PanelTitle(
                title: "Category",
                isRequired: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: StreamBuilder<Categoryn>(
                  stream: _newEntryBloc!.selectedCategoryn,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CategorynColumn(
                            type: Categoryn.Work,
                            name: "Work",
                            iconValue: 0xf553,
                            isSelected:
                                snapshot.data == Categoryn.Work ? true : false),
                        CategorynColumn(
                            type: Categoryn.School,
                            name: "School",
                            iconValue: 0xf115,
                            isSelected: snapshot.data == Categoryn.School
                                ? true
                                : false),
                        CategorynColumn(
                            type: Categoryn.Health,
                            name: "Health",
                            iconValue: 0xe864,
                            isSelected: snapshot.data == Categoryn.Health
                                ? true
                                : false),
                        CategorynColumn(
                            type: Categoryn.Leisure,
                            name: "Leisure",
                            iconValue: 0xf0ac,
                            isSelected: snapshot.data == Categoryn.Leisure
                                ? true
                                : false),
                      ],
                    );
                  },
                ),
              ),
              PanelTitle(
                title: "Starting Time",
                isRequired: true,
              ),
              SelectTime(),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.height * 0.08,
                ),
                child: Container(
                  width: 220,
                  height: 70,
                  child: FlatButton(
                    color: Colors.amber,
                    shape: StadiumBorder(),
                    child: Center(
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    onPressed: () {
                      //--------------------Error Checking------------------------
                      //Had to do error checking in UI
                      //Due to unoptimized BLoC value-grabbing architecture
                      if (nameController!.text == "") {
                        _newEntryBloc!.submitError(EntryError.HeadingNull);
                        return;
                      }
                      if (nameController!.text != "") {
                        heading = nameController!.text;
                      }

                      if (detailsController!.text != "") {
                        details = detailsController!.text;
                      }
                      for (var note in _globalBloc.noteList!.value) {
                        if (heading == note.noteHeading) {
                          _newEntryBloc!
                              .submitError(EntryError.HeadingDuplicate);
                          return;
                        }
                      }
                      // if (_newEntryBloc.selectedInterval$.value == 0) {
                      //   _newEntryBloc.submitError(EntryError.Interval);
                      //   return;
                      // }
                      if (_newEntryBloc!.selectedTimeOfDay!.value == "Others") {
                        _newEntryBloc!.submitError(EntryError.StartTime);
                        return;
                      }
                      //---------------------------------------------------------
                      String category = _newEntryBloc!.selectedCategoryn!.value
                          .toString()
                          .substring(10);
                      String startTime =
                          _newEntryBloc!.selectedTimeOfDay!.value;

                      Note newEntrynote = Note(
                        notificationIDs:
                            DateTime.now().millisecondsSinceEpoch.toString(),
                        noteHeading: heading,
                        noteDetails: details,
                        category: category,
                        startTime: startTime,
                      );

                      _globalBloc.updateNoteList(newEntrynote);
                      scheduleNotification(newEntrynote);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return SuccessScreen();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initializeErrorListen() {
    _newEntryBloc!.errorState!.listen(
      (EntryError error) {
        switch (error) {
          case EntryError.HeadingNull:
            displayError("Please enter the note's heading");
            break;
          case EntryError.HeadingDuplicate:
            displayError("note heading already exists");
            break;
          case EntryError.Details:
            displayError("Please enter the details required");
            break;
          case EntryError.StartTime:
            displayError("Please select the reminder's starting time");
            break;
          default:
        }
      },
    );
  }

  void displayError(String error) {
    _scaffoldKey!.currentState!.showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(error),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }

  initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin!.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  void onSelectNotification(String? payload) {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  Future<void> scheduleNotification(Note note) async {
    var hour = int.parse(note.startTime[0] + note.startTime[1]);
    var ogValue = hour;
    var minute = int.parse(note.startTime[2] + note.startTime[3]);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      channelDescription: 'repeatDailyAtTime description',
      icon: 'ic_launcher',
      largeIcon: DrawableResourceAndroidBitmap('ic_launcher'),
      importance: Importance.max,
      visibility: NotificationVisibility.public,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('sound'),
      showProgress: true,
      ledColor: Colors.amber,
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin!.showDailyAtTime(
        int.parse(note.notificationIDs[0]),
        'Note: ${note.noteHeading}',
        note.category.toString() != Categoryn.Others.toString()
            ? '${note.noteDetails.toLowerCase()}'
            : null,
        Time(hour, minute),
        platformChannelSpecifics);
    hour = ogValue;
  }
  //await flutterLocalNotificationsPlugAppointmentin.cancelAll();
}

class SelectTime extends StatefulWidget {
  const SelectTime({Key? key}) : super(key: key);

  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay?> _selectTime(BuildContext context) async {
    final NewEntryBloc? _newEntryBloc =
        Provider.of<NewEntryBloc?>(context, listen: false);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        _newEntryBloc!.updateTime("${convertTime(_time.hour.toString())}" +
            "${convertTime(_time.minute.toString())}");
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 4),
        child: FlatButton(
          color: Colors.amber,
          shape: StadiumBorder(),
          onPressed: () {
            _selectTime(context);
          },
          child: Center(
            child: Text(
              _clicked == false
                  ? "Pick Time"
                  : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CategorynColumn extends StatelessWidget {
  final Categoryn type;
  final String name;
  final int iconValue;
  final bool isSelected;

  CategorynColumn(
      {Key? key,
      required this.type,
      required this.name,
      required this.iconValue,
      required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc = Provider.of<NewEntryBloc>(context);
    return GestureDetector(
      onTap: () {
        _newEntryBloc.updateSelectedNote(type);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected ? Colors.amber : Colors.white,
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 14.0),
                child: Icon(
                  IconData(iconValue, fontFamily: "MaterialIcons"),
                  size: 30,
                  color: isSelected ? Colors.white : Colors.amber,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: 80,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? Colors.amber : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.white : Colors.amber,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;
  PanelTitle({
    Key? key,
    required this.title,
    required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Colors.amber),
          ),
        ]),
      ),
    );
  }
}
