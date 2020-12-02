import 'package:easygymclub/Gym/Main/model/gym_model.dart';
import 'package:easygymclub/Gym/Main/model/metas_model.dart';
import 'package:easygymclub/Gym/Main/repository/metas_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class MetasBloc implements Bloc{

  final MetasApi _metasApi = MetasApi();

  Future<List<MetasModel>> getMetas () => _metasApi.getMetas();

  Future<List<GymModel>> getAllGyms() => _metasApi.getAllGyms();

  @override
  void dispose() {
  }

}