import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:easygymclub/EasyFit/bloc/cronometros_bloc.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
class DetailCronometroScreen extends StatefulWidget {

  final Map cronometro;
  DetailCronometroScreen({
    Key key,
    this.cronometro
  });
  @override
  _DetailCronometroScreenState createState() => _DetailCronometroScreenState();
}

class _DetailCronometroScreenState extends State < DetailCronometroScreen > {
  @override
  final GlobalKey < AnimatedCircularChartState > _activePasos = new GlobalKey < AnimatedCircularChartState > ();
  final GlobalKey < AnimatedCircularChartState > _activeCalorias = new GlobalKey < AnimatedCircularChartState > ();
  final GlobalKey < AnimatedCircularChartState > _activeDistancia = new GlobalKey < AnimatedCircularChartState > ();
  Widget build(BuildContext context) {
    final _cronometrosBloc = BlocProvider.of < CronometrosBloc > (context);
    print(widget.cronometro);
    print("aca");
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Color(0xff260d6c),
        appBar: AppBar(
          backgroundColor: Color(0xff3F1D9D),
          title: Text("Caminata " + getHoraCaminata(widget.cronometro["fechahora"].toString().split(" ")[1]).toString()),
          leading: IconButton(
            icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: [
            InkWell(
              child: Padding(
                padding: EdgeInsets.only(right:5),
                child:Icon(Icons.delete),
                ),
                onTap: (){
                  setState(() {
                      _cronometrosBloc.deleteCronometro(widget.cronometro["id"]);
                       Navigator.of(context).pop();
                  });
                },
            )
          ],
        ),

        body: Container(
          child: Container(
            margin: EdgeInsets.only(top: 3.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: < Widget > [
                Stack(
                  alignment: Alignment.center,
                  children: < Widget > [
                    Center(
                      child:
                      AnimatedCircularChart(
                        key: _activeCalorias,
                        size: const Size(200.0, 200.0),
                          initialChartData: < CircularStackEntry > [
                            new CircularStackEntry( <
                              CircularSegmentEntry > [
                                new CircularSegmentEntry(
                                  ((widget.cronometro["calorias"] * 100) / 500),
                                  Colors.red,
                                  rankKey: 'completed',
                                ),
                                new CircularSegmentEntry(
                                  100 - ((widget.cronometro["calorias"] * 100) / 500),
                                  Colors.red[100],
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],

                          chartType: CircularChartType.Radial,
                          edgeStyle: SegmentEdgeStyle.round,
                      ),
                    ),
                    Center(
                      child:
                      AnimatedCircularChart(
                        key: _activePasos,
                        size: const Size(250.0, 250.0),
                          initialChartData: < CircularStackEntry > [
                            new CircularStackEntry( <
                              CircularSegmentEntry > [
                                new CircularSegmentEntry(
                                  ((widget.cronometro["pasos"] * 100) / 6000),
                                  Colors.greenAccent[400],
                                  rankKey: 'completed',
                                ),
                                new CircularSegmentEntry(
                                  100 - ((widget.cronometro["pasos"] * 100) / 6000),
                                  Colors.green[100],
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],

                          chartType: CircularChartType.Radial,
                          edgeStyle: SegmentEdgeStyle.round,
                      ),
                    ),
                    Center(
                      child:
                      AnimatedCircularChart(
                        key: _activeDistancia,
                        size: const Size(300.0, 300.0),
                          initialChartData: < CircularStackEntry > [
                            new CircularStackEntry( <
                              CircularSegmentEntry > [
                                new CircularSegmentEntry(
                                  ((widget.cronometro["distancia"] * 100) / 5),
                                  Colors.blue[400],
                                  rankKey: 'completed',
                                ),
                                new CircularSegmentEntry(
                                  100 - ((widget.cronometro["distancia"] * 100) / 5),
                                  Colors.blueAccent[100],
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],

                          chartType: CircularChartType.Radial,
                          edgeStyle: SegmentEdgeStyle.round,
                      ),
                    ),
                    Center(child: Column(
                      children: < Widget > [
                        Text(
                          widget.cronometro["pasos"].toString(),
                          style: TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.w300),
                        ),
                        Text(widget.cronometro["calorias"].toString() + " Kcal", style: TextStyle(color: Colors.red[400], fontSize: 22, fontWeight: FontWeight.w300), ),
                        Text(widget.cronometro["distancia"].toString() + " Km",
                          style: TextStyle(color: Colors.blue[400], fontSize: 20, fontWeight: FontWeight.w300),
                        ),
                      ]
                    )),
                  ],
                ),
                Center(child: Text(widget.cronometro["tiempo"].toString(),
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontWeight: FontWeight.w300
                  ), )),
                SizedBox(height: 20, ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: < Widget > [
                    Column(
                      children: < Widget > [

                        Row(
                          children: < Widget > [
                            FaIcon(
                              FontAwesomeIcons.shoePrints,
                              color: Colors.greenAccent,
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text("Pasos", style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, ))
                          ],
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: < Widget > [
                        FaIcon(
                          FontAwesomeIcons.fire,
                          color: Colors.red[400],
                        ),
                        SizedBox(width: 5),
                        Text("Calorias", style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, ))
                      ],
                    ),
                    SizedBox(width: 10),
                    Row(
                      children: < Widget > [
                        FaIcon(
                          FontAwesomeIcons.road,
                          color: Colors.blue[400],
                        ),
                        SizedBox(width: 5),
                        Text("Distancia (KM)", style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, ))
                      ],
                    ),

                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: < Widget > [
                      Text("Informacion", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 20), textAlign: TextAlign.left, ),
                      item("Distancia", widget.cronometro["distancia"].toString()+" Km"),
                      item("Calorias", widget.cronometro["calorias"].toString()+" Kcal"),
                      item("Tiempo", widget.cronometro["tiempo"].toString()+ " Min"),
                      item("Pasos", widget.cronometro["pasos"].toString()),
                    ],
                  )
                ),
              ]
            ),
          )
        )
      ),
    );
  }
  String getHoraCaminata(String horaMin) {
    int hora = int.parse(horaMin.split(":")[0]);
    print(hora);
    if (hora >= 6 && hora < 12) {
      return "a la mañana";
    } else if (hora >= 12 && hora < 18) {
      return "a la tarde";
    } else if ((hora >= 18 && hora < 24) || (hora >= 00 && hora < 6)) {
      return "a la noche";
    }
  }
  String getTiempo(String tiempo) {
    print(tiempo);
    List splitTiempo = tiempo.split(":");
    if (splitTiempo[0] == "00") {
      return splitTiempo[1];
    } else {
      return splitTiempo[1] + ":" + splitTiempo[2];
    }
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
  Widget item(String titulo, String elemento) {
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Column(
        children: < Widget > [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: < Widget > [
              Text(titulo, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14)),
              Text(elemento, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 14), )
            ],
          ),
          SizedBox(height: 5),
          Divider(color: Colors.white, height: 1, ),
        ],
      ),
    );
  }
}