import 'package:easygymclub/User/ui/screens/configuracion/bloc/configuration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class DropdownTipoDeCuerpos extends StatefulWidget {

  String value;

  DropdownTipoDeCuerpos(this.value);

  @override
  _DropdownTipoDeCuerposState createState() => _DropdownTipoDeCuerposState();
}

class _DropdownTipoDeCuerposState extends State<DropdownTipoDeCuerpos> {

  @override
  Widget build(BuildContext context) {
//Color(0xff5937B2)
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color(0xff5937B2)
      ),
      child: DropdownButton<String>(
        items: [
          DropdownMenuItem<String>(
              value: "Selecciona tu figura",
              child: Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.shapes,
                    color: Colors.white,
                  ),
                  Text(
                    " Selecciona tu figura",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              )),
          DropdownMenuItem<String>(
              value: "Ectomorfo",
              child: Text(
                "Ectomorfo",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          DropdownMenuItem<String>(
              value: "Mesomorfo",
              child: Text(
                "Mesomorfo",
                style: TextStyle(color: Colors.white),
              )),
          DropdownMenuItem<String>(
              value: "Endomorfo",
              child: Text(
                "Endomorfo",
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
        value: widget.value,
        onChanged: (newValue) {
          setState(() {
            widget.value = newValue;
            BlocProvider
                .of<ConfigurationBloc>(context)
                .user
                .data_info_cliente["tipo_de_figura"] = newValue;
            BlocProvider
                .of<ConfigurationBloc>(context)
                .nuevoTipoDeFigura = newValue;
          });
        },
      ),
    );
  }
}
