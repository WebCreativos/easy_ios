import 'package:easygymclub/EasyFit/bloc/actividades_bloc.dart';
import 'package:easygymclub/EasyFit/models/actividades.dart';
import 'package:easygymclub/widgets/custom_button.dart';
import 'package:easygymclub/widgets/stars.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numberpicker/numberpicker.dart';
class BottomActivityWidget extends StatefulWidget {
  @override
  _BottomActivityWidgetState createState() => _BottomActivityWidgetState();
}

class _BottomActivityWidgetState extends State < BottomActivityWidget > {
  int valueMinutes = 1;
  int valueDays = 1;
  int valueMonths = 1;
  int valueYears = 2020;
  int intensidad = 2;
  bool selectMinutesValues = false; 
  bool selectDateValues = false;
  bool updateActivity = false;
  String titleActivity;
  ActividadesBloc _actividadesBloc;

  @override
  void initState() {
    DateTime now = new DateTime.now();
    print(now); 
    this.valueMonths = now.month;
    this.valueYears = now.year;
    this.valueDays = now.day;
    _actividadesBloc = new ActividadesBloc();
    super.initState();
  }

  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: "btn",
      onPressed: () {
        this._settingModalBottomSheet(context);
      },
      child: Icon(Icons.add),
      backgroundColor: Color(0xFF038dd6),

    );
  }

  Widget screenSelectActivity(StateSetter setState) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(15.0),
                topRight: const Radius.circular(15.0))),
        child: Column(
          children: < Widget > [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text("Registrar actividad", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
            ),
            Divider(height: 2, color: Colors.black54, ),
            Expanded(
              child: ListView(
                children: < Widget > [
                  ListTile(
                    leading: Text("🏃‍♂️", style: TextStyle(fontSize: 20, )),
                    title: Text('Correr'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        this.updateActivity = true;
                        this.titleActivity = "Correr";
                      });
                    },
                  ),
                  ListTile(
                    leading: Text("🚶‍♂️", style: TextStyle(fontSize: 20, )),
                    title: Text('Caminar'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        this.updateActivity = true;
                        this.titleActivity = "Caminar";
                      });
                    },
                  ),
                  ListTile(
                    leading: Text("🚴", style: TextStyle(fontSize: 20, )),
                    title: Text('Ciclismo'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        this.updateActivity = true;
                        this.titleActivity = "Ciclismo";
                      });
                    },
                  ),
                  ListTile(
                    leading: Text("🏊", style: TextStyle(fontSize: 20, )),
                    title: Text('Natacion'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        this.updateActivity = true;
                        this.titleActivity = "Natacion";
                      });
                    },
                  ),
                  ListTile(
                    leading: Text("🏋", style: TextStyle(fontSize: 20, )),
                    title: Text('Levantamiento de pesas‍'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      setState(() {
                        this.updateActivity = true;
                        this.titleActivity = "Levantamiento de pesas";
                      });
                    },
                  )

                ],
              ),
            )


          ],
        ));
  }

  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return new Container(
                    height: 400.0,
                    color: Colors.transparent,
                    child: (this.updateActivity) ? screenAddActivity(setState) : screenSelectActivity(setState)
                );
              }
          );
        }
    );
  }

  Widget screenAddActivity(StateSetter setState) {
    String emojiSelect() {
      switch (this.titleActivity) {
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
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),

      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(15.0),
              topRight: const Radius.circular(15.0)
          )
      ),
      child: Container(
        child: Column(
          children: < Widget > [
            Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: < Widget > [

                    Expanded(
                      flex: 1,
                      child: InkWell(
                        child: Icon(Icons.arrow_back),
                        onTap: () {
                          setState(() {
                            this.updateActivity = false;
                          });
                        },
                      ),
                    ),
                    Expanded(flex: 10, child: Text(this.titleActivity, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
                    Expanded(flex: 1, child: SizedBox())
                  ],
                )
            ),
            Divider(color: Colors.black26, height: 3),
            Expanded(
              child: ListView(
                  children: < Widget > [
                    Container(
                        color: Colors.black12,
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 10),
                        child: Column(
                            children: < Widget > [
                              Text(emojiSelect(), style: TextStyle(fontSize: 80), textAlign: TextAlign.center),
                              Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text("Como te ha ido?", textAlign: TextAlign.left, )
                              ),
                            ]
                        )
                    ),
                    Form(
                      child: Column(
                        children: < Widget > [
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: < Widget > [
                                  Text("Minutos de actividad"),
                                  Container(
                                    child: InkWell(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text("$valueMinutes minutos",
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .bold),),
                                            Icon(Icons.keyboard_arrow_right)
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            this.selectDateValues = false;
                                            this.selectMinutesValues = true;
                                          });
                                        }
                                    ),
                                  )
                                ],
                              )
                          ),
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: < Widget > [
                                  Text("Intensidad del ejercicio"),

                                  Container(
                                    child: InkWell(
                                        child: Stars(
                                            initValue: this.intensidad,
                                            onCountChange: (int val) {
                                              print(val);
                                              setState(() {
                                                this.intensidad = val;
                                              });
                                            }),
                                        onTap: () {
                                          setState(() {
                                            this.selectDateValues = false;
                                            this.selectMinutesValues = true;
                                          });
                                        }
                                    ),
                                  )
                                ],
                              )
                          ),
                          Divider(height: 2, color: Colors.black38),
                          Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: < Widget > [
                                  Text("Fecha"),
                                  Container(
                                    child: InkWell(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Text(
                                              "$valueDays/$valueMonths/$valueYears",
                                              style: TextStyle(
                                                  fontWeight: FontWeight
                                                      .bold),),
                                            Icon(Icons.keyboard_arrow_right)
                                          ],
                                        ),
                                        onTap: () {
                                          setState(() {
                                            this.selectMinutesValues = false;
                                            this.selectDateValues = true;
                                          });
                                        }
                                    ),
                                  )
                                ],
                              )
                          ),
                          (this.selectMinutesValues) ?
                          Column(
                            children: < Widget > [
                              Text("Ingrese cuantos minutos de actividad tuvo", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              NumberPicker.integer(
                                  initialValue: this.valueMinutes,
                                  minValue: 1,
                                  maxValue: 180,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      this.valueMinutes = value;
                                    });
                                  })
                            ],
                          ) :
                          (this.selectDateValues) ?
                          Column(
                            children: < Widget > [
                              Text("Ingrese en que fecha fue la misma", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: < Widget > [
                                  NumberPicker.integer(
                                      initialValue: this.valueDays,
                                      minValue: 1,
                                      maxValue: 31,
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          this.valueDays = value;
                                        });
                                      }),
                                  NumberPicker.integer(
                                      initialValue: this.valueMonths,
                                      minValue: 1,
                                      maxValue: 12,
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          this.valueMonths = value;
                                        });
                                      }),
                                  NumberPicker.integer(
                                      initialValue: this.valueYears,
                                      minValue: 2019,
                                      maxValue: 2030,
                                      onChanged: (value) {
                                        print(value);
                                        setState(() {
                                          this.valueYears = value;
                                        });
                                      })
                                ], )
                            ],
                          ) :
                          Container(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15),
                      child: CustomButton(text: "Guardar actividad", width: 100.0, colorBg: true, callbackOnPressed: () {
                        Actividades actividad = new Actividades(actividad: this.titleActivity, intensidad: intensidad, fecha: "$valueDays/$valueMonths/$valueYears", minutos: valueMinutes);
                        _actividadesBloc.saveActividad(actividad);
                        Fluttertoast.showToast(
                            msg: "Actividad guardada",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0
                        );
                        Navigator.pop(context);
                      }, ),
                    )
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setIntenseValue(int intensidad) {
    setState(() {
      this.intensidad = intensidad;
    });
  }
}