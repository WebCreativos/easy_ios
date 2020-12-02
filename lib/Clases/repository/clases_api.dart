import 'package:easygymclub/Clases/repository/clases_repository.dart';
import 'package:easygymclub/Rutinas/ui/widgets/rutinas.dart';
import 'package:soundpool/soundpool.dart';
import 'package:easygymclub/Clases/model/clases_model.dart';

class ClasesApi{

  final ClasesRepository _clasesRepository = ClasesRepository();
  Future<List<ClasesModel>> getClases () => _clasesRepository.getClases();

}