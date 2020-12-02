import 'package:easygymclub/Dieta/model/dieta_model.dart';
import 'package:easygymclub/Dieta/ui/widgets/button_day_widget.dart';
import 'package:easygymclub/utils/Notifications/Controller/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DietaIndividualScreen extends StatefulWidget {
  final DietaModel dietas;

  DietaIndividualScreen({Key key, @required this.dietas});

  @override
  _DietaIndividualScreen createState() => _DietaIndividualScreen();
}

class _DietaIndividualScreen extends State<DietaIndividualScreen> {
  String diaSeleccionado = "lunes";
  bool empezarRutina = false;
  var dias = [
    "lunes",
    "martes",
    "miercoles",
    "jueves",
    "viernes",
    "sabado",
    "domingo"
  ];
  var terminado = [];

  @override
  void initState() {
    super.initState();
  }

  NotificationController notification = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xff260d6c),
        appBar: AppBar(
          backgroundColor: Color(0xff3F1D9D),
          title: Text(widget.dietas.nombre),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            Builder(
              builder: (cntx) => IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  notification
                      .guardarRecordatorios()
                      .then((value) =>
                          Scaffold.of(context).showSnackBar(SnackBar(
                            content:
                                Text("Easy gym club te recordara tus comidas"),
                            duration: Duration(seconds: 1),
                          )))
                      .catchError(
                          (error) => Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Error guardando recordatorios"),
                                duration: Duration(seconds: 1),
                              )));
                },
              ),
            )
          ],
        ),
        body: SafeArea(
            child: Container(
          height: double.infinity,
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () {
                      notification.startBackground();
                    },
                    child: Text(
                      "Elige un dia",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  )),
              listaDias(),
              if (filtroAlimentosPorDia("Desayuno").length > 1)
                tablaDieta("Desayuno"),
              if (filtroAlimentosPorDia("Almuerzo").length > 1)
                tablaDieta("Almuerzo"),
              if (filtroAlimentosPorDia("Merienda").length > 1)
                tablaDieta("Merienda"),
              if (filtroAlimentosPorDia("Cena").length > 1) tablaDieta("Cena")
            ],
          ),
            )));
  }

  Widget listaDias() {
    List<Widget> list = new List<Widget>();
    for (var dia in dias) {
      list.add(ButtonDayWidget(
        text: dia,
        callbackOnPressed: () {
          setState(() {
            this.diaSeleccionado = dia;
          });
        },
        active: dia == this.diaSeleccionado,
      ));
    }
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: 60,
      child: ListView(
        padding: EdgeInsets.only(top: 20.0),
        children: list,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget tablaDieta(String horarioDieta) {
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3f1d9d), Color(0xFF5937b2)], // whitish to gray
            tileMode: TileMode.mirror, // repeats the gradient over the canvas
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 20.0,
            ),
          ],
          borderRadius: BorderRadius.circular(15.0),
        ),
        alignment: Alignment.topCenter,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: filtroAlimentosPorDia(horarioDieta)));
  }

  List<Widget> filtroAlimentosPorDia(String horarioDieta) {
    List<Widget> aux = List<Widget>();

    aux.add(Row(
      children: <Widget>[
        Text(
          horarioDieta,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          textAlign: TextAlign.left,
        ),
        Spacer(),
      ],
    ));
    List<dynamic> platos =
        widget.dietas.dietas[this.diaSeleccionado] ?? List<dynamic>();

    for (var plato in platos) {
      if (plato['horario'] == horarioDieta)
        aux.add(Card(
          color: Color(0xff260d6c),
          margin: EdgeInsets.only(top: 15),
          child: ListTile(
            leading: (plato["imagen"] != null)
                ? Container(
              padding: EdgeInsets.all(0),
              child: Container(
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://app.easygymclub.com/uploads/' +
                              plato["imagen"].toString()),
                      fit: BoxFit.cover,
                    )),
                alignment: Alignment.centerLeft,
                height: 40,
              ),
            )
                : SizedBox(
              width: 10,
            ),
            title: Text(
              plato['nombre'],
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 15),
            ),
          ),
        ));
    }

    return aux;
  }
}
