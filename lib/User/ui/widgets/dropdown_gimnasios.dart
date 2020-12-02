import 'package:easygymclub/Gym/Main/bloc/metas_bloc.dart';
import 'package:easygymclub/Gym/Main/model/gym_model.dart';
import 'package:flutter/material.dart';

class DropdownGimnasios extends StatefulWidget {
  GymModel _gym;

  int get gym => _gym?.pk;

  @override
  _DropdownGimnasiosState createState() => _DropdownGimnasiosState();
}

class _DropdownGimnasiosState extends State<DropdownGimnasios> {
  List<DropdownMenuItem<GymModel>> listaDeGimnasios = [];

  @override
  void initState() {
    MetasBloc().getAllGyms().then((gimnasios) {
      listaDeGimnasios.add(
        DropdownMenuItem<GymModel>(
            value: null,
            child: Text(
              "Seleccione su gimnasio (Opcional)", 
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      );
      gimnasios.forEach((gimnasio) {
        listaDeGimnasios.add(DropdownMenuItem<GymModel>(
          value: gimnasio,
          child: Text(
            gimnasio.nombre,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ));
      });
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (listaDeGimnasios.isEmpty) {
      return LinearProgressIndicator();
    }
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Color(0xff5937B2)),
      child: DropdownButton<GymModel>(
        isExpanded: true,
        items: listaDeGimnasios,
        value: widget._gym,
        onChanged: (newValue) {
          setState(() {
            widget._gym = newValue;
          });
        },
      ),
    );
  }
}
