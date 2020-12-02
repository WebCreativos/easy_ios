import 'package:age/age.dart';
import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/ui/screens/agenda/widgets/dropdown_actividades.dart';
import 'package:easygymclub/User/ui/widgets/dropdown_gimnasios.dart';
import 'package:easygymclub/User/ui/widgets/fecha_de_nacimiento.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_provider.dart';
import 'package:easygymclub/utils/user_type.dart';
import 'package:easygymclub/widgets/check_box.dart';
import 'package:easygymclub/widgets/custom_button.dart';
import 'package:easygymclub/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonForm extends StatefulWidget {
  @override
  _CommonFormState createState() => _CommonFormState();
}

class _CommonFormState extends State<CommonForm> with UserType {
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerNombre = TextEditingController();
  final TextEditingController controllerApellido = TextEditingController();
  final TextEditingController controllerCelular = TextEditingController();
  final CheckBox checkBox = CheckBox();
  DropdownActividades dropdown;
  UserBloc _userBloc;
  final FechaDeNacimiento _fechaDeNacimiento = FechaDeNacimiento();
  final DropdownGimnasios _dropdownGimnasios = DropdownGimnasios();

  @override
  Widget build(BuildContext context) {
    _userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: TextInput(
              controller: controllerEmail,
              hintText: "Email",
              inputType: null,
              iconData: Icons.mail,
            ),
          ),
          Container(
            child: TextInput(
              controller: controllerPassword,
              hintText: "Password",
              inputType: null,
              iconData: Icons.vpn_key,
              itIsPassword: true,
            ),
          ),
          Container(
            child: TextInput(
              controller: controllerNombre,
              hintText: "Nombre",
              inputType: null,
              iconData: Icons.account_circle,
            ),
          ),
          Container(
            child: TextInput(
              controller: controllerApellido,
              hintText: "Apellido",
              inputType: null,
              iconData: Icons.account_circle,
            ),
          ),
          _fechaDeNacimiento,
          Container(
            child: TextInput(
              controller: controllerCelular,
              hintText: "Celular",
              inputType: TextInputType.numberWithOptions(decimal: false),
              iconData: Icons.phone_android,
            ),
          ),
          Container(child: _sexos()),
          Container(
            child: _dropdownGimnasios,
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery
                      .of(context)
                      .size
                      .height * 0.05),
              child: Row(
                children: <Widget>[
                  checkBox,
                  Expanded(
                    child: InkWell(
                      onTap: () async {
                        if (await canLaunch(
                            "https://easygymclub.com/terminos-y-condiciones/")) {
                          await launch(
                              "https://easygymclub.com/terminos-y-condiciones/");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                          right: MediaQuery
                              .of(context)
                              .size
                              .width * 0.03,
                        ),
                        child: Text(
                          "He leido este Acuerdo y acepto los terminos y condiciones",
                          style: TextStyle(
                              color: Colors.white,
                              decoration: TextDecoration.underline),
                          textAlign: TextAlign.left,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
          Container(
            margin:
            EdgeInsets.only(top: MediaQuery
                .of(context)
                .size
                .height * 0.05),
            child: CustomButton(
              text: "Registro",
              colorBg: true,
              callbackOnPressed: () {
                if (checkBox.isChecked() && this.validate()) {
                  var dataForm = this.getData();
                  Provider.of<LoadingProvider>(context, listen: false)
                      .setLoadingState(StageLoading.Loading);

                  var aux_fecha =
                      _fechaDeNacimiento.fecha.split('/'); //dd/MM/YYYY

                  var birth = DateTime(int.parse(aux_fecha[2]),
                      int.parse(aux_fecha[1]), int.parse(aux_fecha[0]));

                  var now = DateTime.now();

                  AgeDuration edad =
                      Age.dateDifference(fromDate: birth, toDate: now);

                  var gymPk = _dropdownGimnasios.gym;

                  _userBloc
                      .signUp(
                      dataForm['password'],
                      dataForm['sexo'],
                      dataForm['email'],
                      userTypeString(user_types.Cliente_normal),
                      dataForm['nombre'],
                      dataForm['apellido'],
                      dataForm['celular'],
                      edad.years,
                      gymPk: gymPk

                  )
                      .then((data) {
                    Navigator.of(context).pushReplacementNamed("/easy_fit");
                    Provider.of<LoadingProvider>(context, listen: false)
                        .setLoadingState(StageLoading.Loaded);
                  },
                      onError: (onError) =>
                          Provider.of<LoadingProvider>(
                              context,
                              listen: false)
                              .setLoadingState(StageLoading.Error));

                  controllerPassword.clear();
                  controllerEmail.clear();
                  controllerNombre.clear();
                  controllerApellido.clear();
                  controllerCelular.clear();

                  checkBox.createState();
                } else {
                  var textSnack;

                  (!this.validate())
                      ? textSnack = Text("Rellene todos los campos para continuar")
                      : textSnack = Text("Acuerdo y condiciones no aceptado");

                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: textSnack,
                    duration: Duration(seconds: 1),
                  ));
                }
              },
              width: MediaQuery.of(context).size.width * 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sexos() {
    dropdown = DropdownActividades(
      actividades: List<String>.from(
          ["Seleccionar sexo", "Femenino", "Masculino", "Otro"]),
      color: Color(0xff5937B2),
      textStyle: TextStyle(color: Colors.white),
      value: "Seleccionar sexo",
    );

    return dropdown;
  }

  bool validate() {
    String pass = controllerPassword.text;
    String email = controllerEmail.text;
    String nombre = controllerNombre.text;
    String apellido = controllerApellido.text;
    String celular = controllerCelular.text;
    String fecha = _fechaDeNacimiento.fecha;

    return (pass.isNotEmpty &&
        email.isNotEmpty &&
        nombre.isNotEmpty &&
        apellido.isNotEmpty &&
        celular.isNotEmpty &&
        fecha.isNotEmpty &&
        dropdown.isSelected());
  }

  Map<String, dynamic> getData() {
    String pass = controllerPassword.text;
    String email = controllerEmail.text;
    String nombre = controllerNombre.text;
    String apellido = controllerApellido.text;
    String celular = controllerCelular.text;

    return {
      'password': pass,
      'email': email,
      'nombre': nombre,
      'apellido': apellido,
      'celular': celular,
      'sexo': dropdown.getValue()
    };
  }
}
