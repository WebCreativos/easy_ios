import 'dart:async';

import 'package:easygymclub/EasyFit/bloc/contador_google_maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

const api_key = 'AIzaSyB8t9tonYG4Q-tSQG0dMLX4M0Cdl3h7Fys';
const double CAMERA_ZOOM = 16;
const double CAMERA_TILT = 80;
const double CAMERA_BEARING = 30;

class GoogleMaps extends StatefulWidget {

  @override
  GoogleMaps();
  State<StatefulWidget> createState() {
    return _GoogleMaps();
  }
}

class _GoogleMaps extends State<GoogleMaps>{

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();

// for my drawn routes on the map
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints;
  String googleAPIKey = api_key;
  StreamSubscription _locationListen;

  bool datosViejosObtenidos = false;

// for my custom marker pins
  BitmapDescriptor sourceIcon;

  ContadorGoogleMapsBloc _contadorGoogleMapsBloc;

  // the user's initial location and current location
  // as it moves
  LocationData currentLocation;

  // The user's position before move
  LocationData beforeLocation;

  // a reference to the destination location
  LocationData destinationLocation;

  // wrapper around the location API
  Location location;
  double pinPillPosition = -100;

  //Listen onLocationChanged
  Stream<LocationData> _onLocationChanged;

  @override
  void initState() {
    super.initState();
    location = new Location();
    polylinePoints = PolylinePoints();

    _onLocationChanged = location.onLocationChanged();
    _locationListen = _onLocationChanged.listen((LocationData cLoc) {
      beforeLocation = currentLocation;
      currentLocation = cLoc;

      if (currentLocation != null && beforeLocation != null)
        setNewPolylines(
            LatLng(beforeLocation.latitude, beforeLocation.longitude),
            LatLng(currentLocation.latitude, currentLocation.longitude));

      updatePinOnMap();
    });

    setSourceAndDestinationIcons();

    setInitialLocation();

  }

  void setSourceAndDestinationIcons() async {
    sourceIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'assets/img/runner.png');
  }

  void setInitialLocation() async {
    currentLocation = await location.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    if (!datosViejosObtenidos) chequearSiHuboRecorridoAntes();

    CameraPosition initialCameraPosition = CameraPosition(
        zoom: CAMERA_ZOOM,
        tilt: CAMERA_TILT,
        bearing: CAMERA_BEARING,
        target: LatLng(0.0,0.0));

    if (currentLocation != null) {
      initialCameraPosition = CameraPosition(
          target: LatLng(currentLocation.latitude, currentLocation.longitude),
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: CAMERA_BEARING);
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: GoogleMap(
          myLocationEnabled: true,
          compassEnabled: true,
          tiltGesturesEnabled: false,
          markers: _markers,
          polylines: _polylines,
          mapType: MapType.normal,
          initialCameraPosition: initialCameraPosition,
          onMapCreated: this.onMapCreated),
    );
  }

  void chequearSiHuboRecorridoAntes() {
    datosViejosObtenidos = true;
    _contadorGoogleMapsBloc = BlocProvider.of<ContadorGoogleMapsBloc>(context);
    Map<String, dynamic> data = _contadorGoogleMapsBloc.getDataLocation();
    _polylines = data["polylines"];
    polylineCoordinates = data["polylineCoordinates"];
  }

  void onMapCreated(GoogleMapController controller) {
    _controller.complete(controller); // my map has completed being created;
    // i'm ready to show the pins on the map
    if (currentLocation != null) showPinsOnMap();
  }

  void showPinsOnMap() {
    // get a LatLng for the source location
    // from the LocationData currentLocation object
    var pinPosition = LatLng(
        currentLocation.latitude,
        currentLocation
            .longitude); // get a LatLng out of the LocationData object

    _markers.add(Marker(
      markerId: MarkerId('sourcePin'),
      position: pinPosition,
      icon: sourceIcon,
    )); // destination pin
  }

  void setNewPolylines(LatLng anterior, LatLng ahora) async{

    polylineCoordinates.add(anterior);
    polylineCoordinates.add(ahora);
    //_cronometrosBloc.setPocisiones(jsonEncode(polylineCoordinates));
    _polylines.add(Polyline(
        width: 4, // set the width of the polylines
        polylineId: PolylineId("poly"),
        color: Colors.deepPurpleAccent,
        points: polylineCoordinates)); 
  }

  void updatePinOnMap() async {
    // create a new CameraPosition instance
    // every time the location changes, so the camera
    // follows the pin as it moves with an animation
    CameraPosition cPosition = CameraPosition(
      zoom: CAMERA_ZOOM,
      tilt: CAMERA_TILT,
      bearing: CAMERA_BEARING,
      target: LatLng(currentLocation.latitude, currentLocation.longitude),
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cPosition));

    if (mounted) {
      setState(() {
        // the trick is to remove the marker (by id)
        // and add it again at the updated location
        _markers.removeWhere((m) => m.markerId.value == 'sourcePin');
        _markers.add(Marker(
          markerId: MarkerId('sourcePin'),
          position: LatLng(currentLocation.latitude, currentLocation.longitude),
          // updated position
          icon: sourceIcon,
          alpha: 0.5,
        ));
      });
    }
  }

  @override
  void dispose() {
    _contadorGoogleMapsBloc.saveDataLocation(_polylines, polylineCoordinates);
    _locationListen.cancel();
    super.dispose();
  }


}

