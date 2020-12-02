import 'dart:async';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

/*
class EmpezarRutina extends StatefulWidget{

String diaSeleccionado;

List ejercicios;

EmpezarRutina({Key key,this.diaSeleccionado,this.ejercicios});

@override
State<StatefulWidget> createState() {

  return _EmpezarRutina();
  }

  }

  class _EmpezarRutina extends State<EmpezarRutina>{

    RutinasBloc _rutinasBloc;
    int ejerciciosListos = 0;
    int tiempoDeEspera = 5;

    @override
    void initState() {
    _rutinasBloc = RutinasBloc();
    super.initState();
    }


    @override
    Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
    backgroundColor: Color(0xff3F1D9D),
    title: Text("Empezar rutina"),
    leading: IconButton(
    icon: Icon(Icons.keyboard_arrow_left, color: Colors.white),
    onPressed: () => showDialog(
    context: context,
    builder: (_) => AlertDialog(
    title: Text("¿Seguro quieres cortar con la rutina?"),
    actions: <Widget>[
      FlatButton(
      child: Text("Ok"),
      onPressed: () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      },
      ),
      FlatButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.of(context).pop(),
      ),
      ],
      )),
      ),
      ),
      body: WillPopScope(
      child: _body(),
      onWillPop: () =>
      showDialog(
      context: context,
      builder: (_) =>
      AlertDialog(
      title: Text("¿Seguro quieres cortar con la rutina?"),
      actions: <Widget>[
        FlatButton(
        child: Text("Ok"),
        onPressed: () {
        Navigator.of(context).pop(true);
        },
        ),
        FlatButton(
        child: Text("Cancel"),
        onPressed: () => Navigator.of(context).pop(false),
        ),
        ],
        )
        ),
        )
        );
        }


        // El tiempo de espera del Future a la hora de cambiar de pantalla
        // es el mismo tiempo que meustra el contador en la pantalla.
        // La unica relacion es la variable tiempoDeEspera

        Widget _body(){
        return FutureBuilder(
        future: Future.delayed(Duration(seconds: this.tiempoDeEspera),() => Future.value(this.ejercicios)),
        builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.hasError) {
        return Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/img/bgr.png"),
        fit: BoxFit.cover)),
        child: Center(
        child: Countdown(
        duration: Duration(seconds: this.tiempoDeEspera),
        builder: (BuildContext ctx, Duration remaining) {
        _rutinasBloc.makeSound();
        return Text(
        '${remaining.inSeconds}',
        style: TextStyle(
        color: Colors.white,
        fontSize: 50.0
        ),
        );
        },
        ),
        ),
        );
        } else {

        return BlocProvider(
        child: ListView(
        children: <Widget>[ Container(
          decoration: BoxDecoration(
          image: DecorationImage(
          image: AssetImage("assets/img/bgr.png"),
          fit: BoxFit.cover)),
          child: Column(
          children: _listEjercicios(snapshot),
          )
          ),
          ]
          ),
          bloc: _rutinasBloc,
          );
          }
          }
          );
          }

          List<Widget> _listEjercicios(AsyncSnapshot snapshot){


            List<Widget> listaARetornar = List<Widget>();

                List auxlist = snapshot.data;
                List<Widget> ejercicios = List();
                  var index = 0;
                  print(ejercicios);
                  for(var rutina in auxlist){
                  for (var i=0;i<rutina["series"];i++){ var widget=Container( child: EjercicioDeRutina( rutina: rutina,
                    ejercicioIndex: index ) ); ejercicios.add( widget ); index++; } } //Cantidad de ejercicios antes de
                    agregar a la ListView los demas mensajes int cantidadRutinas=ejercicios.length;
                    listaARetornar.add(Container( padding: EdgeInsets.only(bottom: 15.0,top:15.0), child:
                    Text( "Empezar rutina del " + widget.diaSeleccionado, textAlign: TextAlign.center, style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25, ), ), ));
                    listaARetornar.addAll(ejercicios); // Agregar al final de la lista la cantidad de ejercicios
                    terminados listaARetornar.add( RutinasTerminadas(cantidadRutinas: cantidadRutinas,) );
                    listaARetornar.add( Contador( tiempoDeDescanzo: 20, tiempoDeEjercicio: 60, cantidadDeEjercicios:
                    cantidadRutinas, ) ); return listaARetornar; } @override void dispose() { super.dispose(); } } */
import 'package:flutter/material.dart';
import 'package:flutter/material.dart'
as prefix0;
import 'dart:async';
class EmpezarRutina extends StatefulWidget {
  List ejercicios;
  final String
  tag = 'imageHeader';
  EmpezarRutina({
    Key key,
    this.ejercicios
  });
  @override _EmpezarRutinaState
  createState() => _EmpezarRutinaState();
}

class _EmpezarRutinaState extends State < EmpezarRutina > {
    final GlobalKey < AnimatedCircularChartState > _timeRoutine = new GlobalKey <AnimatedCircularChartState > ();
    Timer _timer;
    int _start = 60;
    int ejercicio = 0;
    List ejercicios;
    bool stopWatch = false;
    bool finalized = false;
    BetterPlayerController _betterPlayerController;
    BetterPlayerDataSource _betterPlayerDataSource;
    void startTimer() {
      const oneSec =
        const Duration(milliseconds: 1000);
      _timer = Timer.periodic(oneSec, (timer) {
        if (_start < 1) {
          timer.cancel();
        } else {
          setState(() {
            _start = _start - 1;
          });
          this._updateTime(_start);
          if (ejercicio == (this.ejercicios.length - 1) && _start == 0) {
            setState(() {
              this.rutinaFinalizada();
            });
          } else if (_start == 0) {
            setState(() {
              this.changeVideo(ejercicio);
              _start = 60;
              ejercicio = ejercicio + 1;
            });
          }
        }
      });
    }
    @override 
    void initState(){
      this.ejercicios = [];
      for(var ejercicio in widget.ejercicios){
        for(int i=0;i<ejercicio["series"];i++){
          this.ejercicios.add(ejercicio);
        }
      }
      if (mounted) {
        this.changeVideo(ejercicio);
        startTimer();
      }
      super.initState();
    }
    @override void dispose() {
      _timer.cancel();
      super.dispose();
    }
    @override Widget
    build(BuildContext context) {
      return Scaffold(backgroundColor: Colors.grey[900], body:
        SingleChildScrollView(child: Ejercicio(context)));
    }
    Widget Ejercicio(BuildContext context) {
      var size = MediaQuery.of(context).size;
      return Stack(children: < Widget > [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/bgr.png"),
              fit: BoxFit.cover)),

          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: < Widget > [
              ListView(
                children: < Widget > [
                  Stack(
                    children: < Widget > [
                      Hero(
                        tag: widget.tag,
                        child: (this.ejercicios[ejercicio]['video'] != null) ?
                        AspectRatio(
                          aspectRatio: 16 / 10,
                          child: Card(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                                child: BetterPlayer(

                                  controller: _betterPlayerController,
                                ),
                            ),
                          ),
                        ) : Container(),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
                    height: size.height - 100,
                    width: size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: < Widget > [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: < Widget > [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                                child: Text(
                                  '${this.ejercicios[ejercicio]['nombre']}',
                                  style: TextStyle(
                                    fontSize: 28.0,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.white,
                                  ),
                                ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                                child: Center(
                                  child:
                                  Stack(
                                    alignment: Alignment.center,
                                    children: < Widget > [
                                      Text("$_start", style: TextStyle(color: Colors.white, fontSize: 60, fontWeight:
                                        FontWeight.bold), ),
                                      AnimatedCircularChart(
                                        key: _timeRoutine,
                                        size: const Size(200.0, 200.0),
                                          initialChartData: < CircularStackEntry > [
                                            new CircularStackEntry( < CircularSegmentEntry > [
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
                                    ],
                                  ),
                                ),
                            ),
                            Text("Descripcion".toString(),
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight:
                                FontWeight.w300),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(height: 10),
                            Divider(height: 1, color: Colors.white),
                            SizedBox(height: 20),
                            (this.ejercicios[ejercicio]['descripcion'] != null) ?
                            Text("${this.ejercicios[ejercicio]['descripcion']}".toString(),
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight:
                                FontWeight.w300),
                              textAlign: TextAlign.left,
                            ) : Text("Ejercicio sin descripcion",
                              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight:
                                FontWeight.w300),
                              textAlign: TextAlign.left,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 40,
                right: 20,
                child: GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(0, 0, 0, 0.7),
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 30.0,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ]
          )
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
              color: Color(0xFF5937b2),
              boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius:
                2), ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: < Widget > [
                InkWell(
                  onTap: () {
                    setState(() {
                      if (stopWatch == true) {
                        this.startTimer();
                      } else {
                        _timer.cancel();
                      }
                      stopWatch = !stopWatch;
                    });
                  },
                  child: Container(
                    width: 80.0,
                    height: 55.0,
                    margin: EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF3f1d9d),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius:
                        2), ]
                    ),
                    child: Icon(
                      (!stopWatch) ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      if ((this.ejercicios.length > (ejercicio + 1) &&
                          this.ejercicios[ejercicio + 1] != null)) {
                        this.ejercicio = this.ejercicio + 1;
                        this._start = 60;
                        this.changeVideo(ejercicio);        
                      } else {
                        _timer.cancel();
                        this.rutinaFinalizada();
                      }
                    });
                  },
                  child: Container(
                    width: size.width - 130.0,
                    height: 55.0,
                    decoration: BoxDecoration(
                      color: Color(0xFF3f1d9d),
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [BoxShadow(color: Colors.black45, blurRadius: 3, spreadRadius:
                        2), ]
                    ),
                    padding: EdgeInsets.all(10),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: < Widget > [
                          Text(
                            (this.ejercicios.length > (ejercicio + 1) &&
                              this.ejercicios[ejercicio + 1] != null) ?
                            "Siguiente" : "Finalizar",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 20),
                          ),
                          Icon(Icons.play_arrow, color: Colors.white)
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ),
        )
      ], );
    }
    void _updateTime(int time) async {
      time = 60 - time;
      double porcentTime = ((time * 100) / 60);
      List < CircularStackEntry > nextData = < CircularStackEntry > [
        new CircularStackEntry( < CircularSegmentEntry > [
            new CircularSegmentEntry(
              porcentTime,
              Colors.blueAccent[400],
              rankKey: 'completed',
            ),
            new CircularSegmentEntry(
              100 - porcentTime,
              Colors.blue[100],
              rankKey: 'remaining',
            ),
          ],
          rankKey: 'progress',
        ),
      ];
      this._timeRoutine.currentState.updateData(nextData);
    }
    void rutinaFinalizada() {
      this._start = 60;
      this.stopWatch = true;
      this.ejercicio = 0;
      _timer.cancel();
        setState(() {
          this.changeVideo(ejercicio);        
        });
        this._updateTime(this._start);
        showDialog(
          context: context,
          builder: (_) =>
          AlertDialog(
            contentPadding: EdgeInsets.all(5),
            titlePadding: EdgeInsets.all(20),
            backgroundColor: Colors.grey[900],

            title: Text(
              "Rutina finalizada con exito!", style: TextStyle(color:
                Colors.white), ),
            actions: [
              FlatButton(
                child: Text("ACEPTAR", style: TextStyle(color: Colors.green),
                  textAlign: TextAlign.center, ),
                onPressed: () =>
                Navigator.of(context).pop(true),
              )
            ],
          ),
          barrierDismissible: false
        );

      }
      void changeVideo(int ejercicio) {
        if(this.ejercicios.length>0){
          if (this.ejercicios[ejercicio]['video'] != null) {
            _betterPlayerDataSource = BetterPlayerDataSource(BetterPlayerDataSourceType.NETWORK,
                this.ejercicios[ejercicio]["video"]);
            _betterPlayerController = BetterPlayerController(BetterPlayerConfiguration(),
              betterPlayerDataSource: _betterPlayerDataSource);
          }
        }
      }
    }
