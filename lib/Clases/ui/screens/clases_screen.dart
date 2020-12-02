import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easygymclub/Clases/model/clases_model.dart';
import 'package:easygymclub/Clases/bloc/clases_bloc.dart';
import 'package:easygymclub/Clases/ui/widgets/clases.dart';
import 'package:easygymclub/Clases/ui/screens/show_video_screen.dart';
import 'package:easygymclub/widgets/card_widget.dart';

class ClasesScreen extends StatefulWidget {

  String tipo;

  ClasesScreen({Key key,this.tipo});

  @override
  State<StatefulWidget> createState() {
    return _ClasesScreen();
  }
}

class _ClasesScreen extends State<ClasesScreen> {
  Future<List<ClasesModel>> _futureRetos;
  ClasesBloc _clasesBloc;

  @override
  void initState() {
    _clasesBloc = ClasesBloc();
    _futureRetos = _clasesBloc.getClases();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _futureRetos,
      builder: (context, snap) {
        print(snap.data);
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
              return _body(snap,context);
              break;
          }
        }

        return null;
      },
    );
  }

  Widget _body(AsyncSnapshot snap, BuildContext context) {
    List < ClasesModel > listAuxiliar = snap.data;
    return Container(
      height: MediaQuery.of(context).size.height - 80,
      child: ListView.builder(
        itemCount:listAuxiliar.length,
        itemBuilder:(context,index){
          ClasesModel clase = listAuxiliar[index];
          return Container(
            margin: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      var aux = listAuxiliar[index];
                      return ShowVideoScreen(
                        clase: clase);
                    }
                  )
                );

              },
              child: CardWidget(
                data: clase.toMap()
              ),
            ),
          );

        }
      ),
    );
  }

  Widget _loading() {
    return Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      child: Center(
        child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(12, (index) =>
                Container(
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
                    boxShadow: [BoxShadow(
                      color: Colors.black38,
                      blurRadius: 10.0,
                    ),
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: EdgeInsets.all(30.0),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: CircularProgressIndicator(
                    valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.deepOrangeAccent),
                  ),
                ),)
        ),
      ),
    );
  }
}
