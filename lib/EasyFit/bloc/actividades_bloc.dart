import 'package:easygymclub/EasyFit/repository/actividades_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ActividadesBloc extends Bloc{
  final ActividadesApi _actividadesApi = ActividadesApi();
  Future<void> saveActividad (actividad) => _actividadesApi.saveActividad(actividad);
  Future < List < Map >> actividadesList() => _actividadesApi.actividadesList();

  Future<void> deleteActividad(int id) => _actividadesApi.deleteActividad(id);

  @override
  void dispose() {
  }

}