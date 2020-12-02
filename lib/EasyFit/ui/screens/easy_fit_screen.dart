import 'dart:ui';

import 'package:easygymclub/EasyFit/bloc/actividades_bloc.dart';
import 'package:easygymclub/EasyFit/bloc/cronometros_bloc.dart';
import 'package:easygymclub/EasyFit/ui/screens/detail_cronometro_screen.dart';
import 'package:easygymclub/EasyFit/ui/widgets/bottom_activity.dart';
import 'package:easygymclub/EasyFit/ui/widgets/cronometro.dart';
import 'package:easygymclub/Gym/Main/bloc/metas_bloc.dart';
import 'package:easygymclub/Musica/screen/spotify_login_screen.dart';
import 'package:easygymclub/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class EasyFitScreen extends StatefulWidget {
  @override
  _EasyFitScreenState createState() => _EasyFitScreenState();
}

class _EasyFitScreenState extends State<EasyFitScreen> {
  MetasBloc _metasBloc;
  CronometrosBloc _cronometrosBloc;
  ActividadesBloc _actividadesBloc;
  int index = 0;

  @override
  void initState() {
    _metasBloc = MetasBloc();
    _cronometrosBloc = new CronometrosBloc();
    _actividadesBloc = new ActividadesBloc();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        customScreen(),
        BottomNavigationBar(
          backgroundColor: Color(0xff3F1D9D),
          unselectedItemColor: Colors.white,
          selectedItemColor: Color(0xffFA5C45),
          currentIndex: index,
          onTap: (value) => setState(() => index = value),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Inicio'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run),
              title: Text('Diario'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              title: Text('Actividad'),
            ),
          ],
        ),
        Positioned(right: 20, bottom: 70, child: BottomActivityWidget()),
      ],
    );
  }

  Widget home() {
    return Container(
      height: MediaQuery
      .of(context)
      .size
      .height -
      Scaffold
      .of(context)
      .appBarMaxHeight,
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: ListView(
          children: < Widget > [
            CronometrosProvider(),
            SpotifyLoginScreen(),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }

  datos() {
    return Container(
      height: MediaQuery
      .of(context)
      .size
      .height - Scaffold
      .of(context)
      .appBarMaxHeight,
      padding: EdgeInsets.only(bottom: 60),
      child: FutureBuilder(
        future: _cronometrosBloc.cronometrosList(),
        builder: (context, snap) {
              if (!snap.hasData || snap.hasError) {
                return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: < Widget > [
                    FaIcon(FontAwesomeIcons.sadTear, size: 80, color: Colors.white, ),
                    SizedBox(height: 20),
                    Text("Aun no tienes registros, sal ahora a caminar y empieza a hacer ejercicio!", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ));
          } else {
            List <Map> data = snap.data.reversed.toList();

            if (data.length == 0) return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FaIcon(FontAwesomeIcons.sadTear, size: 80,
                        color: Colors.white,),
                      SizedBox(height: 20),
                      Text(
                        "Aun no tienes registros, sal ahora a caminar y empieza a hacer ejercicio!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ));

            print(data);
            return Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) =>
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              var aux = data[index];
                              return DetailCronometroScreen(cronometro: aux);
                            }));
                      },
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                            Icons.directions_walk,
                                            color: Colors.white),
                                        Text(
                                            data[index]["fechahora"]
                                                .toString()
                                                .split(" ")[1],
                                            style: TextStyle(
                                                color: Colors.white)),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      "Caminata " +
                                          getHoraCaminata(
                                              data[index]["fechahora"]
                                                  .toString()
                                                  .split(" ")[1]),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                          fontSize: 18),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      data[index]["distancia"].toString() +
                                          " km en " +
                                          getTiempo(data[index]["tiempo"]) +
                                          " minutos",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    SizedBox(height: 40),
                                    Row(
                                      children: <Widget>[
                                        Text(getDate(
                                            data[index]["fechahora"]
                                                .toString()),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w300)),
                                        SizedBox(width: 20),
                                        Row(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                FaIcon(
                                                  FontAwesomeIcons.shoePrints,
                                                  color: Colors.greenAccent,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                    data[index]["pasos"]
                                                        .toString() +
                                                        " pasos",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight
                                                          .w300,
                                                      color: Colors.white,
                                                    ))
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(right: 20),
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_forward_ios,
                                    color: Colors.white,))
                            ],

                          ),
                          Divider(
                            height: 1,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
              ),
            );
          }
        })
    );
  }

  Widget registroActividad() {
    return Container(
      height: MediaQuery
      .of(context)
      .size
      .height -Scaffold
      .of(context)
      .appBarMaxHeight, 
      padding: EdgeInsets.only(top:10, bottom: 60),
      child: FutureBuilder(
        future: _actividadesBloc.actividadesList(),
        builder: (context, snap) {
          List < Map > data = snap.data;
          if (!snap.hasData || snap.hasError || data.length == 0) {
            return Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: < Widget > [
                    FaIcon(FontAwesomeIcons.sadTear, size: 80, color: Colors.white, ),
                    SizedBox(height: 20),
                    Text("Aun no tienes registros, sal ahora a caminar y empieza a hacer ejercicio!", style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ));
          } else {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) =>
              Container(
                padding: EdgeInsets.all(10),
                height: 120,
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF282e78),
                      Color(0xFF0298f6)
                    ])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: < Widget > [
                    Row(
                      children: < Widget > [
                        Container(
                          alignment: Alignment.center,
                          width: 80,
                          height: 80,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border:
                            Border.all(width: 2, color: Colors.white),
                            borderRadius:
                            BorderRadius.all(Radius.circular(50)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              // 10% of the width, so there are ten blinds.
                              colors: [
                                const Color(0xFF185cad),
                                  const Color(0xFF02dcba)
                              ], // whitish to gray
                            ),
                          ),
                          child: Text(
                            emojiSelect(
                              data[index]["actividad"].toString()),
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment
                            .start,
                            children: < Widget > [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: < Widget > [
                                  Flexible(
                                    child: Text(
                                      data[index]["actividad"]
                                      .toString(),
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight
                                        .w900,
                                        color: Colors.white))),
                                  FixedStars(
                                    value: data[index]["intensidad"]),
                                ]),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: < Widget > [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: new TextSpan(
                                              // Note: Styles for TextSpans must be explicitly defined.
                                              // Child text spans will inherit styles from parent
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              ),
                                              children: <TextSpan>[
                                                new TextSpan(text: 'Tiempo:'),
                                                new TextSpan(
                                                    text: data[index]["minutos"]
                                                            .toString() +
                                                        " min",
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            textAlign: TextAlign.start,
                                            text: new TextSpan(
                                              // Note: Styles for TextSpans must be explicitly defined.
                                              // Child text spans will inherit styles from parent
                                              style: new TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                              ),
                                              children: <TextSpan>[
                                                new TextSpan(text: 'Cal:'),
                                                new TextSpan(
                                                    text: data[index]
                                                            ["calorias"]
                                                        .toString(),
                                                    style: new TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      /*
                                  Expanded(
                                    child: RichText(
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,
                                        ),
                                        children: < TextSpan > [
                                          new TextSpan(text: 'Tiempo:'),
                                          new TextSpan(
                                            text: data[index]["minutos"]
                                            .toString() +
                                            " min",
                                            style: new TextStyle(
                                              fontWeight:
                                              FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: < Widget > [
                                        Text('Cal: ',
                                          style: new TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                        Text(
                                          data[index]["calorias"]
                                          .toString(),
                                          style: new TextStyle(
                                            fontWeight: FontWeight
                                            .bold,
                                            color: Colors.white, fontSize: 12)),
                                      ],
                                    ),
                                  ),*/
                                  Expanded(
                                    child: new RichText(
                                      textAlign: TextAlign.end,
                                      text: new TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: new TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.white,

                                        ),
                                        children: < TextSpan > [
                                          new TextSpan(text: 'Fecha:'),
                                          new TextSpan(
                                            text: data[index]["fecha"]
                                                .toString(),
                                            style: new TextStyle(
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline, color: Colors.redAccent,),
                          iconSize: 30.0,
                          onPressed: () {
                            print(
                                "### Eliminando actividad nº ${data[index]["id"]}... ###");
                            _actividadesBloc.deleteActividad(data[index]["id"])
                                .then((value) {
                              print("### Actividad eliminada ###");
                              setState(() {

                              });
                            });
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }));
  }

  String getHoraCaminata(String horaMin) {
    int hora = int.parse(horaMin.split(":")[0]);
    if (hora > 6 && hora < 12) {
      return "a la mañana";
    } else if (hora > 12 && hora < 18) {
      return "a la tarde";
    } else if ((hora > 18 && hora < 24) || (hora > 00 && hora < 6)) {
      return "a la noche";
    }
    return "";
  }

  String getTiempo(String tiempo) {
    List splitTiempo = tiempo.split(".");
    return splitTiempo[0];
  }

  getDate(String date) {
    String day = date.split("-")[2].toString().split(" ")[0];
    String formatedDay = DateFormat('EEEE').format(DateTime.parse(date));
    String formatedMonth = DateFormat('MMMM').format(DateTime.parse(date));
    String finalday = "";
    String finalMonth = "";
    print(formatedDay);
    switch (formatedDay.toString()) {
      case "Sunday":
        finalday = "Domingo";
        break;
      case "Monday":
        finalday = "Lunes";
        break;
      case "Tuesday":
        finalday = "Martes";
        break;
      case "Wednesday":
        finalday = "Miercoles";
        break;
      case "Thursday":
        finalday = "Jueves";
        break;
      case "Friday":
        finalday = "Viernes";
        break;
      case "Saturday":
        finalday = "Sabado";
        break;

      default:
    }
    switch (formatedMonth.toString()) {
      case "January":
        finalMonth = "Enero";
        break;
      case "February":
        finalMonth = "Febrero";
        break;
      case "March":
        finalMonth = "Marzo";
        break;
      case "April":
        finalMonth = "Abril";
        break;
      case "May":
        finalMonth = "Mayo";
        break;
      case "June":
        finalMonth = "Junio";
        break;
      case "July":
        finalMonth = "Julio";
        break;
      case "August":
        finalMonth = "Agosto";
        break;
      case "September":
        finalMonth = "Setiembre";
        break;
      case "October":
        finalMonth = "Octubre";
        break;
      case "November":
        finalMonth = "Noviembre";
        break;
      case "December":
        finalMonth = "Diciembre";
        break;

      default:
    }
    return finalday + " " + day + " de " + finalMonth.toLowerCase();
  }

  Widget customScreen() {
    if (index == 0) {
      return home();
    } else if (index == 1) {
      return datos();
    } else {
      return registroActividad();
    }
  }

  String emojiSelect(title) {
    switch (title) {
      case "Correr":
        return "🏃‍♂️";
        break;
      case "Caminar":
        return "🚶‍♂️";
        break;
      case "Ciclismo":
        return "🚴";
        break;
      case "Natacion":
        return "🏊";
        break;
      case "Levantamiento de pesas":
        return "🏋";
        break;
      default:
        return "";
    }
  }

  @override
  void dispose() {
    _metasBloc.dispose();
    super.dispose();
  }
}