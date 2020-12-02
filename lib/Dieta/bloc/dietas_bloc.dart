import 'package:easygymclub/Dieta/model/dieta_model.dart';
import 'package:easygymclub/Dieta/repository/dieta_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class DietaBloc implements Bloc{

  final DietaApi _rankingApi = DietaApi();

  Future<List<DietaModel>> getDieta (String tipo) => _rankingApi.getDieta(tipo);

  @override
  void dispose() {
  }

}