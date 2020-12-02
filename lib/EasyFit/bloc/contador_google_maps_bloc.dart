import 'package:easygymclub/EasyFit/repository/contador_google_maps_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContadorGoogleMapsBloc extends Bloc {
  final ContadorGoogleMapsRepository _contadorGoogleMapsRepository =
      ContadorGoogleMapsRepository();

  Stream<int> get tiempo => _contadorGoogleMapsRepository.getTime;

  Stream<ButtonState> get buttonState =>
      _contadorGoogleMapsRepository.buttonState;

  Stream<bool> get startMap => _contadorGoogleMapsRepository.startMap;

  void startTimer() => _contadorGoogleMapsRepository.startTimer();

  Future<void> pauseTimer() => _contadorGoogleMapsRepository.pausaTimer();

  Future<void> stopTimer() => _contadorGoogleMapsRepository.stopTimer();

  bool isRunning() => _contadorGoogleMapsRepository.isRunning();

  void saveDataLocation(
          Set<Polyline> savePolylines, List<LatLng> savePolylineCoordinates) =>
      _contadorGoogleMapsRepository.saveDataLocation(
          savePolylines, savePolylineCoordinates);

  Map<String, dynamic> getDataLocation() =>
      _contadorGoogleMapsRepository.getDataLocation();

  @override
  void dispose() {
    _contadorGoogleMapsRepository.dispose();
  }

}