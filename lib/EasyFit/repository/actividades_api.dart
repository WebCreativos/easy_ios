import 'package:easygymclub/EasyFit/repository/actividades_repository.dart';

class ActividadesApi {

  final ActividadesRepository _actividadRepo = ActividadesRepository();
  Future<void> saveActividad (actividad) => _actividadRepo.saveActividad(actividad);

  Future<List<Map>> actividadesList() => _actividadRepo.actividadesList();

  Future<void> deleteActividad(int id) => _actividadRepo.deleteActividad(id);
}