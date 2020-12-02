import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/User/ui/screens/configuracion/bloc/configuration_bloc.dart';
import 'package:easygymclub/User/ui/screens/configuracion/widgets/configuration_body.dart';
import 'package:easygymclub/User/ui/screens/configuracion/widgets/tipo_de_cuerpo_provider.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class Configuracion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Configuracion();
  }
}

class _Configuracion extends State<Configuracion> {

  UserBloc userBloc;
  UserModel user;
  final controllerNombre = TextEditingController();
  final controllerApellido = TextEditingController();

  ConfigurationBloc _configurationBloc;

  TipoDeCuerpoProvider _tipoDeCuerpoProvider;
  DropdownButton dropdown;

  TextStyle _textStyle(bool isItWhite) {
    return TextStyle(
      color: (isItWhite) ? Colors.white : Color(0xffcbb3f5),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      userBloc = BlocProvider.of<UserBloc>(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: User.getSavedUser(),
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          user = snap.data;
          _configurationBloc = ConfigurationBloc(userModel: snap.data);

          return BlocProvider(
            bloc: _configurationBloc,
            child: ConfigurationBody(),
          );
        }
      },
    );
  }

}




