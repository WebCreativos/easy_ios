import 'package:easygymclub/User/model/user_model.dart';
import 'package:rxdart/rxdart.dart';

class ConfigurationRepository {
  UserModel userModel;

  BehaviorSubject<String> _controllerAltura = BehaviorSubject<String>();
  BehaviorSubject<String> _controllerPeso = BehaviorSubject<String>();
  BehaviorSubject<String> _controllerTipoDefigura = BehaviorSubject<String>();

  Stream<String> get altura => _controllerAltura.stream;

  Stream<String> get peso => _controllerPeso.stream;

  Stream<String> get tipoDeFigura => _controllerTipoDefigura.stream;

  ConfigurationRepository({this.userModel}) {
    _controllerTipoDefigura.sink
        .add(userModel.data_info_cliente["tipo_de_figura"]);
    _controllerAltura.sink
        .add(userModel.data_info_cliente["altura"].toString());
    _controllerPeso.sink.add(userModel.data_info_cliente["peso"].toString());
  }

  void changeAltura(String newAltura) => _controllerAltura.sink.add(newAltura);

  void changePeso(String newPeso) => _controllerPeso.sink.add(newPeso);

  void changeTipoDeFigura(String nuevoTipoDefigura) =>
      _controllerTipoDefigura.sink.add(nuevoTipoDefigura);

  void dispose() {
    _controllerPeso.close();
    _controllerAltura.close();
    _controllerTipoDefigura.close();
  }
}
