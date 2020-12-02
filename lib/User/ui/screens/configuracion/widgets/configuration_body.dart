import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/User/ui/screens/configuracion/bloc/configuration_bloc.dart';
import 'package:easygymclub/User/ui/screens/configuracion/widgets/dropdown_tipo_de_cuerpos.dart';
import 'package:easygymclub/User/ui/screens/configuracion/widgets/foto_perfil.dart';
import 'package:easygymclub/User/ui/screens/configuracion/widgets/imagen_tipo_de_cuerpo.dart';
import 'package:easygymclub/User/ui/screens/configuracion/widgets/imc.dart';
import 'package:easygymclub/User/ui/widgets/minus_number_plus.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_provider.dart';
import 'package:easygymclub/widgets/custom_button.dart';
import 'package:easygymclub/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';

class ConfigurationBody extends StatefulWidget {
  @override
  _ConfigurationBodyState createState() => _ConfigurationBodyState();
}

class _ConfigurationBodyState extends State<ConfigurationBody> {
  final TextEditingController controllerNombre = TextEditingController();

  final TextEditingController controllerApellido = TextEditingController();

  ConfigurationBloc _configurationBloc;

  @override
  Widget build(BuildContext context) {
    _configurationBloc = BlocProvider.of<ConfigurationBloc>(context);

    return Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
        color: Color(0xff260d6c),
        child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08,
                ),
                child: Row(
                    // 1 - Imagen nombre y apellido
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FotoPerfil(
                        url: _configurationBloc.user.imagen_perfil,
                      ),
                      Column(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextInput(
                              controller: controllerNombre,
                              hintText: _configurationBloc.user.nombre,
                              inputType: null,
                              iconData:
                                  null // Be carefoul with this - check if it works
                              ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextInput(
                              controller: controllerApellido,
                              hintText: _configurationBloc.user.apellido,
                              inputType: null,
                              iconData:
                                  null //Be carefoul with this - check if it works
                              ),
                        )
                      ])
                    ]), // END imagen nombre y apellido
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08,
                ),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xff5937B2)))),
                child: Row(
                    // 2 - Sexo y edad
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(children: <Widget>[
                        Text(
                            "Sexo: ${_configurationBloc.user.data_info_cliente["sexo"]}",
                            style: _textStyle(false)),
                        //CHOICES
                      ]),
                      Row(
                        children: <Widget>[
                          Text("Edad ", style: _textStyle(false)),
                          MinusNumberPlus(
                            initValue: int.parse(_configurationBloc
                                    .user.data_info_cliente["edad"]
                                    .toString() ??
                                '0'),
                            newValue: (newValue) {
                              _configurationBloc
                                  .user.data_info_cliente["edad"] = newValue;
                            },
                            tipoMedida: "AÑOS",
                          )
                        ],
                      )
                    ]),
              ), // END sexo y edad
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08,
                ),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xff5937B2)))),
                child: Row(
                    // 3 - Tipo cuerpo mas info
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Tipo de figura:", style: _textStyle(false)),
                      Container(
                        child: DropdownTipoDeCuerpos(_configurationBloc
                            .user.data_info_cliente["tipo_de_figura"]),
                        //width: 300.0,
                      ),
                    ]),
              ), // END tipo cuerpo mas inf
              ImagenTipoDeCuerpo(),
              Divider(
                color: Color(0xff5937B2),
                height: 1,
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08,
                ),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xff5937B2)))),
                child: Row(
                    // 4 - Altura y peso
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.4,
                        child: Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text("Altura: ", style: _textStyle(false)),
                              MinusNumberPlus(
                                initValue: double.parse(_configurationBloc
                                        .user.data_info_cliente["altura"]
                                        .toString() ??
                                    '0.0'),
                                newValue: (newValue) {
                                  _configurationBloc.user
                                      .data_info_cliente["altura"] = newValue;
                                  _configurationBloc.nuevaAltura = newValue;
                                },
                                tipoMedida: "M",
                              ),
                            ],
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(
                              children: <Widget>[
                                Text("Peso: ", style: _textStyle(false)),
                                MinusNumberPlus(
                                  initValue: double.parse(_configurationBloc
                                          .user.data_info_cliente["peso"]
                                          .toString() ??
                                      '0.0'),
                                  newValue: (newValue) {
                                    _configurationBloc.user
                                        .data_info_cliente["peso"] = newValue;
                                    _configurationBloc.nuevoPeso = newValue;
                                  },
                                  tipoMedida: "KG",
                                ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      IMC(
                        formulaImc(
                            double.parse(_configurationBloc
                                .user.data_info_cliente["peso"]
                                .toString()),
                            double.parse(_configurationBloc
                                .user.data_info_cliente["altura"]
                                .toString())),
                      ),
                    ]),
              ), // END Altura y peso
              Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.01),
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.03,
                  left: MediaQuery.of(context).size.width * 0.08,
                  right: MediaQuery.of(context).size.width * 0.08,
                ),
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xff5937B2)))),
                child: Row(
                    // 5 - Pecho cintura y piernas
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(children: <Widget>[
                            Text("Pecho: ", style: _textStyle(false)),
                            MinusNumberPlus(
                              initValue: int.parse(_configurationBloc
                                      .user.data_info_cliente["pecho"]
                                      .toString() ??
                                  '0'),
                              newValue: (newValue) {
                                _configurationBloc
                                    .user.data_info_cliente["pecho"] = newValue;
                              },
                              tipoMedida: "CM",
                            ),
                          ]),
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Row(children: <Widget>[
                              Text("Cintura: ", style: _textStyle(false)),
                              MinusNumberPlus(
                                initValue: int.parse(_configurationBloc
                                        .user.data_info_cliente["cintura"]
                                        .toString() ??
                                    '0'),
                                newValue: (newValue) {
                                  _configurationBloc.user
                                      .data_info_cliente["cintura"] = newValue;
                                },
                                tipoMedida: "CM",
                              ),
                            ])),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Row(children: <Widget>[
                            Text("Piernas: ", style: _textStyle(false)),
                            MinusNumberPlus(
                              initValue: int.parse(_configurationBloc
                                      .user.data_info_cliente["piernas"]
                                      .toString() ??
                                  '0'),
                              newValue: (newValue) {
                                _configurationBloc.user
                                    .data_info_cliente["piernas"] = newValue;
                              },
                              tipoMedida: "CM",
                            ),
                          ]),
                        ),
                      ]),
                    ]),
              ), // END pe
              CustomButton(
                  text: "Guardar",
                  colorBg: true,
                  callbackOnPressed: () {
                    UserModel newUserData = _configurationBloc.user;
                    Provider.of<LoadingProvider>(context, listen: false)
                        .setLoadingState(StageLoading.Loading);

                    BlocProvider.of<UserBloc>(context)
                        .updateInfoUser(newUserData).then((onSuccessData) {
                      Provider.of<LoadingProvider>(
                          context, listen: false)
                          .setLoadingState(StageLoading.Loaded);
                    }, onError: (onErrorData) {
                      Provider.of<LoadingProvider>(
                          context, listen: false)
                          .setLoadingState(StageLoading.Error);
                    }
                    );
                  }),

                ])));
  }

  String formulaImc(double peso, double altura) {
    if (peso == 0 || altura == 0) {
      return "0.0";
    }
    return (peso / (altura * altura)).toStringAsFixed(2);
  }

  TextStyle _textStyle(bool isItWhite) {
    return TextStyle(
      color: (isItWhite) ? Colors.white : Color(0xffcbb3f5),
    );
  }
}
