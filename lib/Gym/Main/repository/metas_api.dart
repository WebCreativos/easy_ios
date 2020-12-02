import 'package:easygymclub/Gym/Main/model/metas_model.dart';
import 'package:easygymclub/Gym/Main/repository/metas_repository.dart';

class MetasApi{

  final MetasRepository _MetasRepository = MetasRepository();
  Future<List<MetasModel>> getMetas () => _MetasRepository.getMetas();

  Future<List<dynamic>> getAllGyms() => _MetasRepository.getAllGyms();
}