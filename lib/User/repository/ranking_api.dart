import 'package:easygymclub/User/repository/ranking_repository.dart';

class RankingApi{
  final RankingRepository _rankingRepository = RankingRepository();

  Future<Map<String,dynamic>> getMiPuesto () => _rankingRepository.getMiRanking();
  Future<List<Map>> getMiHistorial () => _rankingRepository.getMiHistorial();
}