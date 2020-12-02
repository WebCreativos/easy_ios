
import 'package:easygymclub/User/model/actividad_agendada_model.dart';
import 'package:easygymclub/User/repository/user_agenda_repository.dart';

class AgendaApi {

  final UserAgendaRepository _agendaRepository = UserAgendaRepository();
  Future<List<Map<String,dynamic>>> actividadesDisponibles (date) => _agendaRepository.getActividadesDisponibles(date);
  Future<List<ActividadAgendadaModel>> actividadesAgendadas (date) => _agendaRepository.getActividadesAgendadas(date);
  Future<void> agendarseActividad (String pkActividad) => _agendaRepository.setActividad(pkActividad);

  Stream<bool> isAgendadaCorrectamente () => _agendaRepository.isAgendadaCorrectamente;

  Future<void> closeAgenda () {
    _agendaRepository.closeStreams();
  }
  
}