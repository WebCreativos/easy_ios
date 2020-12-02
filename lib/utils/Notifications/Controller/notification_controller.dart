import 'package:background_fetch/background_fetch.dart';
import 'package:easygymclub/utils/Notifications/Repository/notification_repository.dart';
import 'package:get/get.dart';
import 'package:locally/locally.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

class NotificationController extends GetxController {

  List hoursEat = [{
      'hour': '08:30',
      'content': 'del desayuno'
    },
    {
      'hour': '12:30',
      'content': 'del almuerzo'
    },
    {
      'hour': '18:30',
      'content': 'de la merienda'
    },
    {
      'hour': '21:30',
      'content': 'de la cena'
    },
  ];
  Locally locally;

  NotificationRepository repository = NotificationRepository();


  Future < void > startBackground() async {
    // Configure BackgroundFetch.
    locally = Locally(
      payload: 'test',
      appIcon: 'mipmap/ic_launcher', );
    BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 15,
      forceAlarmManager: true,
      stopOnTerminate: false,
      startOnBoot: true,
      enableHeadless: true,
      requiresBatteryNotLow: false,
      requiresCharging: false,
      requiresStorageNotLow: false,
      requiresDeviceIdle: false,
      requiredNetworkType: NetworkType.NONE,

    ), (String taskId) async {  
      // This is the fetch-event callback.
      locally.show(title: 'Es hora de comer!', message: "Es hora del almuerzo");
 
      BackgroundFetch.finish(taskId);
    }).then((int status) {
      print('[BackgroundFetch] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch] configure ERROR: $e');
    });
    BackgroundFetch.start().then((int status) {
      print('[BackgroundFetch] start success: $status');
    });
  }

  Future<void> guardarRecordatorios() async {
    final CalendarPlugin _myPlugin = CalendarPlugin();
    var hasPermission = await _myPlugin.hasPermissions();
    if (!hasPermission) {
      print("No tenemos permisos po!");
      await _myPlugin.requestPermissions();
    }

    hasPermission = await _myPlugin.hasPermissions();
    if (!hasPermission)
      return Future.error(
          "Necesitamos tus permisos para guardar recordatorios");

    List<Calendar> calendars = await _myPlugin.getCalendars();

    Calendar calendar = calendars[0];

    var year = DateTime.now().year;
    var day = DateTime.now().day;
    var month = DateTime.now().month;
    var fromDate = DateTime(year, month, day);

    for (var i = 1; i <= 30; i++) {
      var startDateDesayunar =
          DateTime(fromDate.year, fromDate.month, fromDate.day, 9);
      var endDateDesayunar = startDateDesayunar.add(Duration(hours: 1));
      CalendarEvent eventDesayunar = await CalendarEvent(
        title: "Hora de desayunar",
        description: "Easy gym club te recuerda que es tu hora de desayunar",
        startDate: startDateDesayunar,
        endDate: endDateDesayunar,
      );

      var startDateAlmorzar =
          DateTime(fromDate.year, fromDate.month, fromDate.day, 12);
      var endDateAlmorzar = startDateAlmorzar.add(Duration(hours: 1));
      CalendarEvent eventAlmorzar = await CalendarEvent(
        title: "Hora de almorzar",
        description: "Easy gym club te recuerda que es tu hora de almorzar",
        startDate: startDateAlmorzar,
        endDate: endDateAlmorzar,
      );

      var startDateMerendar =
          DateTime(fromDate.year, fromDate.month, fromDate.day, 18);
      var endDateMerendar = startDateMerendar.add(Duration(hours: 1));
      CalendarEvent eventMerendar = await CalendarEvent(
        title: "Hora de merendar",
        description: "Easy gym club te recuerda que es tu hora de merendar",
        startDate: startDateMerendar,
        endDate: endDateMerendar,
      );

      var startDateCenar =
          DateTime(fromDate.year, fromDate.month, fromDate.day, 22);
      var endDateCenar = startDateCenar.add(Duration(hours: 1));
      CalendarEvent eventCenar = await CalendarEvent(
        title: "Hora de cenar",
        description: "Easy gym club te recuerda que es tu hora de cenar",
        startDate: startDateCenar,
        endDate: endDateCenar,
      );

      //Creo que se puede evitar el await
      await _myPlugin.createEvent(
          calendarId: calendar.id, event: eventDesayunar);
      await _myPlugin.createEvent(
          calendarId: calendar.id, event: eventAlmorzar);
      await _myPlugin.createEvent(
          calendarId: calendar.id, event: eventMerendar);
      await _myPlugin.createEvent(calendarId: calendar.id, event: eventCenar);

      fromDate = fromDate.add(Duration(days: 1));
    }
  }
  }
