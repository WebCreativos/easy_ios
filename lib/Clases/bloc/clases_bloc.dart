import 'package:easygymclub/Clases/repository/clases_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:easygymclub/Rutinas/ui/widgets/rutinas.dart';
import 'package:soundpool/soundpool.dart';
import 'package:easygymclub/Clases/model/clases_model.dart';

class ClasesBloc implements Bloc{

  final ClasesApi _clasesApi = ClasesApi();

  Future<List<ClasesModel>> getClases () => _clasesApi.getClases();


  @override
  void dispose() {
  }

}