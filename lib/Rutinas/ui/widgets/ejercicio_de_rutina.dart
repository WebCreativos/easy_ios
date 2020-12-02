import 'package:easygymclub/Rutinas/bloc/rutinas_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class EjercicioDeRutina extends StatefulWidget {

  Map<String, dynamic> rutina;
  int ejercicioIndex;

  EjercicioDeRutina({Key key, this.rutina, this.ejercicioIndex});

  @override
  State<StatefulWidget> createState() {
    return _EjercicioDeRutina();
  }

}

class _EjercicioDeRutina extends State<EjercicioDeRutina> {

  RutinasBloc _rutinasBloc;
  @override
  Widget build(BuildContext context) {
    _rutinasBloc = BlocProvider.of<RutinasBloc>(context);

    return StreamBuilder(
      stream: _rutinasBloc.realizandoEjercicio,
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return _ejercicio(snap, context);
        }

      },
    );
  }


  Widget _ejercicio(AsyncSnapshot snap, BuildContext context) {

    // Chequear si el indice de este ejercicio es menor al que se esta haciendo,
    // de serlo, aplicar cambios correspondientes

      return Column(
        children: <Widget>[
          InkWell(
            onTap: (){
            },
            child:Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF3f1d9d),
                    Color(0xFF5937b2)
                  ], // whitish to gray
                  tileMode:
                  TileMode.mirror, // repeats the gradient over the canvas
                ),
                borderRadius: BorderRadius.circular(5),
                color: (snap.data <= widget.ejercicioIndex) ? Color(
                    0xff260d6c) : Colors.white54,
                boxShadow: [BoxShadow(
                  color: Colors.black54,
                  blurRadius: 20.0,
                )
                ]
            ),
            child: ListTile(
              trailing: InkWell(
                  onTap: () {
                    print("A hacer excercise baby... vamo' ");
                  },
                  child: (snap.data <= widget.ejercicioIndex)
                      ?Icon(Icons.access_time, color: Colors.white)
                      : Icon(Icons.check, color: Colors.green,)),
              title: Text(widget.rutina["nombre"].toString(),
                style: TextStyle(color: Colors.white),),
            ),
          )
          ),
        ],
      );
  }
}