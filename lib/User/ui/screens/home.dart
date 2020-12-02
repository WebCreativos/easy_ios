//rutinas
import 'package:easygymclub/Dieta/ui/screens/dieta_screen.dart';
import 'package:easygymclub/EasyFit/ui/screens/easy_fit_screen.dart';
import 'package:easygymclub/PersonalTrainer/ui/screens/ranking_personal_trainer.dart';
import 'package:easygymclub/Rutinas/ui/screens/rutinas_screen.dart';
import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/ui/screens/agenda/screens/agenda_screen.dart';
import 'package:easygymclub/User/ui/screens/configuracion/screens/configuracion.dart';
import 'package:easygymclub/User/ui/screens/entrada_gym.dart';
import 'package:easygymclub/User/ui/screens/mi_ranking/screens/mi_ranking.dart';
import 'package:easygymclub/User/ui/widgets/drawer_user.dart';
import 'package:easygymclub/User/ui/widgets/premium_pass.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:location/location.dart'
as gps;
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    return _Home();
  }
}

class _Home extends State < Home > {
  UserBloc userBloc;
  gps.Location location = gps.Location();
  Map < String,
  Widget > screens = {};
  String keyMenu = 'Easy fit';

  @override
  void initState() {
    _checkGps();
    _checkPermissions();
    super.initState();
  }

  Future < void > _checkPermissions() async {
    await [
      Permission.location,
      Permission.storage,
    ].request();
  }

  Future < void > _checkGps() async {

    if (!await location.serviceEnabled()) {
      location.requestService();
    }
  }

  @override
  Widget build(BuildContext context) {
    this.userBloc = BlocProvider.of < UserBloc > (context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xff260d6c),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(keyMenu),
      ),
      drawer: Drawer(
        child: Container(
          color: Color(0xff260d6c),
          child: ListView(
            padding: EdgeInsets.zero,
            children: _checkScreens(context),
          ),
        )),
      body: SafeArea(
        child: Container(
          key: UniqueKey(),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(child: screens[keyMenu])
        )
      )
    );
  }

  List < Widget > _miCuentaOpciones() {
    List < Widget > aux = [
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          color: (keyMenu == "Configuracion") ? Color(0xff3f1d9d) : null,
          child: ListTile(
            leading: Icon(
              Icons.settings,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Configuracion',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              navigationTap("Configuracion");
            },
          ),
        ),
      ),
    ];

    if (!userBloc.isUserFree) {
      aux.addAll([
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            color: (keyMenu == "Mis dietas") ? Color(0xff3f1d9d) : null,
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.appleAlt,
                color: Color(0xffFA5C45),
              ),
              title: Text(
                'Mis dietas',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                navigationTap("Mis dietas");
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            color: (keyMenu == "Mis rutinas") ? Color(0xff3f1d9d) : null,
            child: ListTile(
              leading: Icon(
                Icons.directions_run,
                color: Color(0xffFA5C45),
              ),
              title: Text(
                'Mis rutinas',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                navigationTap("Mis rutinas");
              },
            ),
          ),
        ),
      ]);
    }

    return aux;
  }

  List < Widget > _checkScreens(context) {
    // Check if the user is Free or Premium
    screens = {
      'Easy fit': EasyFitScreen(),
      'Configuracion': Configuracion(),
      'Dietas Easy Gym Club': DietaScreen(
        key: ValueKey("App"),
        tipo: "App",
      ),
      'Rutinas Easy Gym Club': RutinasScreen(
        key: ValueKey("App"),
        tipo: "App",
      ),
    };

    List < Widget > _response = [
      DrawerUser(),
      Container(
        color: (keyMenu == "Easy fit") ? Color(0xff3f1d9d) : null,
        child: ListTile(
          leading: FaIcon(
            FontAwesomeIcons.bolt,
            color: Color(0xffFA5C45),
          ),
          title: Text(
            'Easy fit',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            navigationTap("Easy fit");
          },
        ),
      ),
      Container(
        child: ExpansionTile(
          children: _miCuentaOpciones(),
          leading: FaIcon(
            FontAwesomeIcons.userCircle,
            color: Color(0xffFA5C45),
          ),
          title: Text(
            'Mi cuenta',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      Container(
        color: (keyMenu == "Dietas Easy Gym Club") ? Color(0xff3f1d9d) : null,
        child: ListTile(
          leading: FaIcon(
            FontAwesomeIcons.appleAlt,
            color: Color(0xffFA5C45),
          ),
          title: Text(
            'Dietas Easy Gym Club',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            navigationTap("Dietas Easy Gym Club");
          },
        ),
      ),
      Container(
        color: (keyMenu == "Rutinas Easy Gym Club") ? Color(0xff3f1d9d) : null,
        child: ListTile(
          leading: Icon(
            Icons.directions_run,
            color: Color(0xffFA5C45),
          ),
          title: Text(
            'Rutinas Easy Gym Club',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            navigationTap("Rutinas Easy Gym Club");
          },
        ),
      ),
    ];

    if (!userBloc.isUserFree) {
      screens.addAll({
        'Agenda': AgendaScreen(),
        'Entrada al gym': EntradaGym(),
        'Ranking': MiRanking(),
        'Ranking Personal Trainer': RankingPersonalTrainer(),
        //'Tu Gym': MyGym(),
        'Dietas Gym': DietaScreen(
          key: ValueKey("Gimnasio"),
          tipo: "Gimnasio",
        ),
        'Rutinas Gym': RutinasScreen(
          key: ValueKey("Gimnasio"),
          tipo: "Gimnasio",
        ),
        'Mis rutinas': RutinasScreen(
          key: ValueKey("Usuario"),
          tipo: "Usuario",
        ),
        'Mis dietas': DietaScreen(
          key: ValueKey("Usuario"),
          tipo: "Usuario",
        )
      });

      _response.addAll([
        Container(
          color: (keyMenu == "Agenda") ? Color(0xff3f1d9d) : null,
          child: ListTile(
            leading: Icon(
              Icons.date_range,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Agenda',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              navigationTap("Agenda");
            }),
        ),
        Container(
          color: (keyMenu == "Ranking") ? Color(0xff3f1d9d) : null,
          child: ListTile(
            leading: Icon(
              Icons.contacts,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Ranking',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              setState(() {
                navigationTap("Ranking");
              });
            },
          ),
        ),
        Container(
          color: (keyMenu == "Ranking Personal Trainer") ?
          Color(0xff3f1d9d) :
          null,
          child: ListTile(
            leading: Icon(
              Icons.add_call,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Ranking Personal Trainer',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              setState(() {
                navigationTap("Ranking Personal Trainer");
              });
            },
          ),
        ),
        Container(
          child: ExpansionTile(
            children: < Widget > [
              Padding(
                padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: (keyMenu == "Entrada al gym") ? Color(0xff3f1d9d) : null,
                    child: ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Color(0xffFA5C45),
                      ),
                      title: Text(
                        'Entrada al gym',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        setState(() {
                          navigationTap("Entrada al gym");
                        });
                      },
                    ),
                  ),
              ),
              /*Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  color: (keyMenu == "Tu Gym") ? Color(0xff3f1d9d) : null,
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.dumbbell,
                      color: Color(0xffFA5C45),
                    ),
                    title: Text(
                      'Mi gimnasio',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                      if (keyMenu != "Tu Gym") {
                        setState(() {
                          keyMenu = "Tu Gym";
                        });
                      }
                    },
                  ),
                ),
              ),*/
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  color: (keyMenu == "Dietas Gym") ? Color(0xff3f1d9d) : null,
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.appleAlt,
                      color: Color(0xffFA5C45),
                    ),
                    title: Text(
                      'Dietas Gym',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      navigationTap("Dietas Gym");
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  color: (keyMenu == "Rutinas Gym") ? Color(0xff3f1d9d) : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.directions_run,
                      color: Color(0xffFA5C45),
                    ),
                    title: Text(
                      'Rutinas Gym',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      navigationTap("Rutinas Gym");
                    },
                  ),
                ),
              ),
            ],
            leading: FaIcon(
              FontAwesomeIcons.dumbbell,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Tu Gym',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ]);
    } else {
      screens.addAll({
        'Pasarme a Premium!': PremiumPass()
      });

      _response.add(
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color:
            (keyMenu == "Pasarme a Premium!") ? Color(0xff3f1d9d) : null,
            border: Border.all(
              color: Color(0xffffd100),
            ),
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: ListTile(
            leading: Icon(
              Icons.favorite,
              color: Color(0xfffff9d4),
            ),
            title: Text(
              'Pasarme a Premium!',
              style: TextStyle(
                fontSize: 16.4,
                foreground: Paint()..shader = LinearGradient(
                  colors: < Color > [
                    Color(0xffffd100),
                    Color(0xfffff9d4),
                    Color(0xffd4af37)
                  ],
                ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0))),
            ),
            onTap: () {
              navigationTap("Pasarme a Premium!");
            },
          ),
        ),
      );
    }

    _response.add(
      Container(
        child: ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.redAccent,
          ),
          title: Text(
            'Cerrar sesión',
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            Navigator.pop(context);
            userBloc.LogOut();
          }),
      ),
    );

    return _response;
  }

  void navigationTap(String screen) {
    Navigator.of(context).pop();
    if (keyMenu != screen) {
      setState(() {
        keyMenu = screen;
      });
    }
  }
}