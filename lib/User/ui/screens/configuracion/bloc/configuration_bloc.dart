import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/User/ui/screens/configuracion/repository/configuration_repository.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ConfigurationBloc extends Bloc {
  ConfigurationRepository _repository;

  ConfigurationBloc({UserModel userModel}) {
    _repository = ConfigurationRepository(userModel: userModel);
  }

  UserModel get user => _repository.userModel;

  Stream<String> get altura => _repository.altura;

  Stream<String> get peso => _repository.peso;

  Stream<String> get tipoDeFigura => _repository.tipoDeFigura;

  void set nuevaAltura(String altura) {
    _repository.changeAltura(altura);
  }

  void set nuevoPeso(String peso) {
    _repository.changePeso(peso);
  }

  void set nuevoTipoDeFigura(String nuevoTipoDeFigura) {
    _repository.changeTipoDeFigura(nuevoTipoDeFigura);
  }

  @override
  void dispose() {
    _repository.dispose();
  }
}
