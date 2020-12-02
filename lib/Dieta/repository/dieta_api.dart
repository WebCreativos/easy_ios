import 'package:easygymclub/Dieta/model/dieta_model.dart';
import 'package:easygymclub/Dieta/repository/dieta_repository.dart';

class DietaApi{
  final DietaRepository _dietaRepository = DietaRepository();
  Future<List<DietaModel>> getDieta (String tipo) => _dietaRepository.getDieta(tipo);

}