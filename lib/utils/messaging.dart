import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State < MessagingWidget > {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  BuildContext _context;
  BuildContext get context => _context;

  void initState() {
    this.alertNotification({
      "title": "Titulo", 
      "body": "Cuerpo"
    }); 
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map < String, dynamic > message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map < String, dynamic > message) async {
        print("onLaunch: $message");
      },
      onResume: (Map < String, dynamic > message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
        print("Settings registered: $settings");
      });
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true, badge: true, alert: true)
    );

  }

  @override
  Widget build(BuildContext context) {
    this.alertNotification({
      "title": "Titulo",
      "body": "Cuerpo"
    });
    return Container();
  }
  void alertNotification(Map notification) {
    showDialog(
      context: _context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Colors.grey[900],
              title: Container(
                padding: EdgeInsets.all(10),
                color: Color(0xFF33b44d),
                child: Text(
                  "Nueva notificacion",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              titlePadding: EdgeInsets.all(0),
              actions: < Widget > [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cerrar")
                )
              ],
              content: new Container(
                padding: EdgeInsets.all(0),
                width: 260.0,
                height: 230.0,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: < Widget > [
                    new Expanded(
                      child: new Container(
                        height: 20,
                        child: ListView(
                          children: < Widget > [
                            Text("$notification['title']"),
                            Text("$notification['body']"),
                          ],
                        )),
                      flex: 2,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      });

    ;
  }

}