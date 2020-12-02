import 'dart:async';

import 'package:easygymclub/User/ui/screens/configuracion/bloc/configuration_bloc.dart';
import 'package:easygymclub/User/ui/screens/configuracion/widgets/rainbow_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class IMC extends StatefulWidget {
  String imc = "";

  IMC(this.imc);

  @override
  _IMCState createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  String valueIMC = "0.0";
  StreamSubscription _controllerPeso;
  StreamSubscription _controllerAltura;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      ConfigurationBloc bloc = BlocProvider.of<ConfigurationBloc>(context);
      _controllerPeso = bloc.peso.listen((peso) {
        var newPeso = double.parse(peso);
        var altura =
            double.parse(bloc.user.data_info_cliente["altura"].toString());
        setState(() {
          valueIMC = formulaImc(newPeso, altura);
        });
      });
      _controllerAltura = bloc.altura.listen((altura) {
        var newAltura = double.parse(altura);
        var peso = double.parse(bloc.user.data_info_cliente["peso"].toString());
        setState(() {
          valueIMC = formulaImc(peso, newAltura);
        });
      });
      valueIMC = widget.imc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "IMC: $valueIMC",
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          ScoreMeter(score: double.parse(valueIMC),)
        ],
      ),
    );
  }

  String formulaImc(double peso, double altura) {
    if (peso == 0 || altura == 0) return "0.0";
    if (peso == null || altura == null) return "0.0";
    return (peso / (altura * altura)).toStringAsFixed(2);
  }

  @override
  void dispose() {
    _controllerAltura.cancel();
    _controllerPeso.cancel();
    super.dispose();
  }
}
