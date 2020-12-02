import 'package:easygymclub/Rutinas/repository/rutinas_repository.dart';
import 'package:easygymclub/Rutinas/ui/widgets/rutinas.dart';
import 'package:soundpool/soundpool.dart';
import 'package:easygymclub/Rutinas/model/rutinas_model.dart';

class RutinasApi{

  final RutinasRepository _RutinasRepository = RutinasRepository();
  Future<List<RutinasModel>> getRutinas (String tipo) => _RutinasRepository.getRutinas(tipo);

  Stream<int> get realizandoEjercicio => _RutinasRepository.realizandoEjercicio;
  void setEjercicioListo(int siguienteEjercicio) => _RutinasRepository.setEjercicioListo(siguienteEjercicio);

  Future<Soundpool> makeSound() => _RutinasRepository.makeSound();

  void dispose() => _RutinasRepository.dispose();

}