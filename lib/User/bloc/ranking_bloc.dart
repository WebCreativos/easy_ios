import 'package:easygymclub/User/repository/ranking_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class RankingBloc implements Bloc{

  final RankingApi _rankingApi = RankingApi();

  Future<Map<String,dynamic>> getMiPuesto () => _rankingApi.getMiPuesto();
  Future<List<Map>> getMiHistorial () => _rankingApi.getMiHistorial();

  @override
  void dispose() {
  }

}