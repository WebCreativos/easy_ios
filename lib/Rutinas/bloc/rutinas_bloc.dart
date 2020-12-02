import 'package:easygymclub/Rutinas/repository/rutinas_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:easygymclub/Rutinas/ui/widgets/rutinas.dart';
import 'package:soundpool/soundpool.dart';
import 'package:easygymclub/Rutinas/model/rutinas_model.dart';

class RutinasBloc implements Bloc{

  final RutinasApi _rankingApi = RutinasApi();

  Future<List<RutinasModel>> getRutinas (String tipo) => _rankingApi.getRutinas(tipo);
  Stream<int> get realizandoEjercicio => _rankingApi.realizandoEjercicio;
  void setEjercicioListo(int siguienteEjercicio) => _rankingApi.setEjercicioListo(siguienteEjercicio);

  Future<Soundpool> makeSound() => _rankingApi.makeSound();


  @override
  void dispose() {
    _rankingApi.dispose();
  }

}