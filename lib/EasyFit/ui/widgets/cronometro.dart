import 'package:easygymclub/EasyFit/bloc/cronometros_bloc.dart';
import 'package:easygymclub/EasyFit/ui/widgets/before_map.dart';
import 'package:easygymclub/EasyFit/ui/widgets/chronometer_map.dart';
import 'package:easygymclub/EasyFit/ui/widgets/pasos_map.dart';
import 'package:easygymclub/EasyFit/ui/widgets/play_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class CronometrosProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _Cronometro();
  }
}


class _Cronometro extends StatefulWidget {
  @override
  __CronometroState createState() => __CronometroState();
}

class __CronometroState extends State < _Cronometro > {
  @override
  void initState() {
    super.initState();
  }
  final GlobalKey < AnimatedCircularChartState > _activePasos = new GlobalKey < AnimatedCircularChartState > ();
  final GlobalKey < AnimatedCircularChartState > _activeCalorias = new GlobalKey < AnimatedCircularChartState > ();
  final GlobalKey < AnimatedCircularChartState > _activeDistancia = new GlobalKey < AnimatedCircularChartState > ();
  int pasos;
  Widget build(BuildContext context) {
    final _cronometrosBloc = BlocProvider.of < CronometrosBloc > (context);
    return Container(
      margin: EdgeInsets.only(top: 3.0),
      child: Column(
        children: < Widget > [
          Stack(
            alignment: Alignment.center,
            children: < Widget > [
              StreamBuilder < Object > (
                stream: _cronometrosBloc.getPasos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    this._updatePasos(snapshot.data);
                    this._updateDistancia(_cronometrosBloc.getDistancia());
                    this._updateCalorias(_cronometrosBloc.getCalorias());
                  }
                  return
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
                                    0,
                                    Colors.red,
                                    rankKey: 'completed',
                                  ),
                                  new CircularSegmentEntry(
                                    66.67,
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
                                    0,
                                    Colors.greenAccent[400],
                                    rankKey: 'completed',
                                  ),
                                  new CircularSegmentEntry(
                                    100,
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
                                    33.33,
                                    Colors.blue[400],
                                    rankKey: 'completed',
                                  ),
                                  new CircularSegmentEntry(
                                    66.67,
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
                      )
                    ],
                  );
                }
              ),
              Center(child: Column(
                children: < Widget > [
                  PasosMap(),
                ]
              )),
            ],
          ),
          Center(child: ChronometerMap(), ),
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
                      SizedBox(width:5),
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
                  SizedBox(width:5),
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
                  SizedBox(width:5),
                  Text("Distancia (KM)", style: TextStyle(fontWeight: FontWeight.w300, color: Colors.white, ))
                ],
              ),

            ],
          ),
          Container(
            margin: EdgeInsets.only(
              left: 15.0, right: 15.0, top: 10.0, bottom: 10.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF3f1d9d),
                  Color(0xFF5937b2)
                ], // whitish to gray
                tileMode: TileMode
                .mirror, // repeats the gradient over the canvas
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x0000004a),
                  spreadRadius: 1.0,
                  blurRadius: 5.0,
                  offset: Offset(5.0, 10.0))
              ]),
            child: Column(
              children: < Widget > [
                Container(
                  height: (MediaQuery.of(context).size.height -
                    (Scaffold.of(context).appBarMaxHeight)) /
                  2,
                  child: Stack(
                    children: < Widget > [
                      Container(
                        child: BeforeMap(),
                        height: (MediaQuery.of(context).size.height -
                          (Scaffold.of(context).appBarMaxHeight)) /
                        2,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: PlayMap(),
                      )
                    ],
                    overflow: Overflow.visible,
                  ),
                )
              ],
            ),
          ),
        ]
      ),
    );

  }
  void _updatePasos(int pasos) async {
    double porcentPasos = ((pasos * 100) / 6000);
    List < CircularStackEntry > nextData = < CircularStackEntry > [
      new CircularStackEntry( <
        CircularSegmentEntry > [
          new CircularSegmentEntry(
            porcentPasos,
            Colors.greenAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            100 - porcentPasos,
            Colors.green[100],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
    ];
    this._activePasos.currentState.updateData(nextData);
  }
  void _updateDistancia(double distancia) async {
    double porcentDistancia = ((distancia * 100) / 5);
    List < CircularStackEntry > nextData = < CircularStackEntry > [
      new CircularStackEntry( <
        CircularSegmentEntry > [
          new CircularSegmentEntry(
            porcentDistancia,
            Colors.blueAccent[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            100 - porcentDistancia,
            Colors.blue[100],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
    ];
    this._activeDistancia.currentState.updateData(nextData);
  }
  void _updateCalorias(double calorias) async {
    double porcentCalorias = ((calorias * 100) / 500);
    List < CircularStackEntry > nextData = < CircularStackEntry > [
      new CircularStackEntry( <
        CircularSegmentEntry > [
          new CircularSegmentEntry(
            porcentCalorias,
            Colors.red[400],
            rankKey: 'completed',
          ),
          new CircularSegmentEntry(
            100 - porcentCalorias,
            Colors.redAccent[100],
            rankKey: 'remaining',
          ),
        ],
        rankKey: 'progress',
      ),
    ];
    this._activeCalorias.currentState.updateData(nextData);
  }


}