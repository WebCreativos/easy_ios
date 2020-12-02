import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easygymclub/Rutinas/model/rutinas_model.dart';
import 'package:easygymclub/Rutinas/bloc/rutinas_bloc.dart';
import 'package:easygymclub/Rutinas/ui/screens/rutina_individual_screen.dart';
import 'package:easygymclub/widgets/card_widget.dart';
import 'package:easygymclub/widgets/loadingCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class RutinasScreen extends StatefulWidget {

  String tipo;

  RutinasScreen({
    Key key,
    this.tipo
  });

  @override
  State < StatefulWidget > createState() {
    return _RutinasScreen();
  }
}

class _RutinasScreen extends State < RutinasScreen > {
  Future < List < RutinasModel >> _futureRetos;
  RutinasBloc _rutinasBloc;

  @override
  void initState() {
    _rutinasBloc = RutinasBloc();

    _futureRetos = _rutinasBloc.getRutinas(widget.tipo);
    super.initState();
    _showDialog();
  }
  _showDialog() async {
    await Future.delayed(Duration(milliseconds: 50));
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[900],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: < Widget > [
                    SizedBox(height: 10, ),
                    SizedBox(height: 10, ),
                  ],
                ),
            ),
          )
        );
      });
  }

  @override
  void dispose() {
    _rutinasBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureRetos,
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return _loading();
        } else {
          switch (snap.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return _loading();
              break;
            case ConnectionState.active:
            case ConnectionState.done:
              return _body(snap, context);
              break;
          }
        }

        return null;
      },
    );
  }

  Widget _body(AsyncSnapshot snap, BuildContext context) {
    List < RutinasModel > listAuxiliar = snap.data;
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        return Container(
          height: MediaQuery.of(context).size.height - 80,
          child: ListView.builder(
            itemCount: listAuxiliar.length,
            itemBuilder: (context, index) {
              RutinasModel rutina = listAuxiliar[index];
              return Container(
                margin: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return RutinasIndividualScreen(
                            rutina: rutina
                          );
                        }
                      )
                    );

                  },
                  child: CardWidget(
                    data: rutina.toMap()
                  ),
                ),
              );

            }
          ),
        );
      }
    );
  }

  Widget _loading() {

    return Container(
      height: MediaQuery
      .of(context)
      .size
      .height,
      child: Center(
        child: ListView.builder(
          itemCount: 12,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.all(10),
              child: LoadingCard()
            );
          }
        ),
      ),
    );
  }
}