import 'package:easygymclub/User/model/actividad_agendada_model.dart';
import 'package:easygymclub/User/repository/agenda_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class AgendaBloc implements Bloc{

  final AgendaApi _agendaApi = AgendaApi();
  Future<List<Map<String,dynamic>>>  actividadesDisponibles (String date) => _agendaApi.actividadesDisponibles(date);
  Future<List<ActividadAgendadaModel>> actividadesAgendadas (String date) => _agendaApi.actividadesAgendadas(date);
  Future<void> agendarseActividad (String pkActividad) => _agendaApi.agendarseActividad(pkActividad);

  Stream<bool> isAgendadaCorrectamente () => _agendaApi.isAgendadaCorrectamente();


  @override
  void dispose() {
    _agendaApi.closeAgenda();
  }

}