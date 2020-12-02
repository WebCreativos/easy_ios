import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

enum ButtonState { stop, start, pausa }

class ContadorGoogleMapsRepository {
  // Boton play, pausa y stop
  final StopWatchTimer _tiempo = StopWatchTimer();
  final BehaviorSubject<bool> _startMap = BehaviorSubject<bool>.seeded(false);
  final BehaviorSubject<ButtonState> _buttonState =
      BehaviorSubject<ButtonState>.seeded(ButtonState.stop);

  Stream<int> get getTime => _tiempo.rawTime;

  Stream<bool> get startMap => _startMap.stream;

  Stream<ButtonState> get buttonState => _buttonState.stream;

  //Para GoogleMaps
  Set<Polyline> polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  Location location;
  StreamSubscription listenLocationChange;
  LocationData currentLocation;
  LocationData beforeLocation;

  void saveDataLocation(
      Set<Polyline> savePolylines, List<LatLng> savePolylineCoordinates) {
    location = Location();

    polylines = savePolylines;
    polylineCoordinates = savePolylineCoordinates;

    listenLocationChange =
        location.onLocationChanged().listen((LocationData dataLocation) {
      beforeLocation = currentLocation;
      currentLocation = dataLocation;

      print("### Fuera de la pantalla ### Guardando la data");

      if (currentLocation != null && beforeLocation != null) {
        polylineCoordinates
            .add(LatLng(beforeLocation.latitude, beforeLocation.longitude));
        polylineCoordinates
            .add(LatLng(currentLocation.latitude, currentLocation.longitude));

        polylines.add(Polyline(
            width: 4, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Colors.deepPurpleAccent,
            points: polylineCoordinates));
      }
    });
  }

  Function testFunction() {
    debugPrint("#### The current time is: ${DateTime.now()}");
  }

  Map<String, dynamic> getDataLocation() {
    print("### Devolviendo la data ");

    try {
      listenLocationChange.cancel();
    } catch (e) {
      print(" ### Exception cancel streamSubscriber ###");
    }

    return {"polylines": polylines, "polylineCoordinates": polylineCoordinates};
  }

  void startTimer() {
    _tiempo.onExecute.add(StopWatchExecute.start);
    _buttonState.add(ButtonState.start);

    if (!_startMap.value) {
      _startMap.sink.add(true);
      //setForegroundService();
    }
  }

  Future<void> stopTimer() async {
    _tiempo.onExecute.add(StopWatchExecute.reset);
    _buttonState.add(ButtonState.pausa);

    _startMap.sink.add(false);
    //closeForegroundService();
  }

  Future<void> pausaTimer() async {
    _tiempo.onExecute.add(StopWatchExecute.stop);
    _buttonState.add(ButtonState.stop);
  }

  bool isRunning() {
    return _tiempo.isRunning();
  }

  void dispose() {
    listenLocationChange.cancel();
    _tiempo.dispose();
    _startMap.close();
  }
}
