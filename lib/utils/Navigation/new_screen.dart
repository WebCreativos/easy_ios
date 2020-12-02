import 'dart:async';

import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/ui/widgets/drawer_user.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_provider.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_screen.dart';
import 'package:easygymclub/utils/Navigation/middleware.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
class NewScreen extends StatefulWidget {
  Widget body;
  String title;

  NewScreen({
      Key key,
      @required this.body,
      @required this.title
    }): assert(body != null, 'Falta body del Scaffold'),
    assert(title != null, 'Falta titulo del Scaffold');

  @override
  _NewScreenState createState() => _NewScreenState();
}

class _NewScreenState extends State < NewScreen > {
  UserBloc userBloc;
  StreamSubscription _subscriptionErrors;
  final LoadingProvider _loadingProvider = LoadingProvider();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  GlobalKey < ScaffoldState > thisScaffold = GlobalKey < ScaffoldState > ();

  @override
  void initState() {
    super.initState();
    var _errorController = ErrorController.instance;
    _subscriptionErrors = _errorController.theresAnyError.listen((errorToShow) {
      _loadingProvider.setLoadingState(StageLoading.Error);
      if (errorToShow == "TokenException") {
        BlocProvider.of < UserBloc > (context).LogOut();
        Navigator.of(context).pushReplacementNamed("/");
        //showError(context, "Tu sesión expiro, vuelve a iniciar sesión");
      } else if (errorToShow == "CloseSession") {
        Navigator.of(context).pushReplacementNamed("/");
      } else {
        showError(context, errorToShow);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    userBloc = BlocProvider.of < UserBloc > (context);

    return Provider(
      create: (_) => _loadingProvider,
      child: Stack(
        children: [
          Scaffold(
            key: thisScaffold,
            //resizeToAvoidBottomInset: true,
            backgroundColor: Color(0xff260d6c),
            appBar: AppBar(
              backgroundColor: Color(0xff3F1D9D),
              title: Text(widget.title),
            ),
            drawer: Drawer(
              child: Container(
                color: Color(0xff260d6c),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: _checkScreens(),
                ),
              )),
            body: SafeArea(
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: WillPopScope(
                    child: widget.body,
                    onWillPop: () { 
                      if(ModalRoute.of(context).settings.name == "/easy_fit"){
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      }else {
                        Navigator.of(context).pushNamed('/easy_fit');
                      }
                    } 
                  )
                )
              )
            )
          ),
          LoadingScreen()
        ],
      ));
  }

  List < Widget > _checkScreens() {
    List < Widget > _response = [
      DrawerUser(),
      Container(
        color: (ModalRoute.of(context).settings.name == "/easy_fit") ?
        Color(0xff3f1d9d) :
        null,
        child: ListTile(
          leading: FaIcon(
            FontAwesomeIcons.bolt,
            color: Color(0xffFA5C45),
          ),
          title: Text(
            'Easy fit',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          onTap: () {
            if (ModalRoute
              .of(context)
              .settings
              .name != "/easy_fit")
              Middleware().goTo(
                callbackGoTo: () =>
                Navigator.of(context).pushReplacementNamed("/easy_fit"),
                callbackExcept: (mensaje) => showModal(mensaje)
              );
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
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ),
      Container(
        color: (ModalRoute.of(context).settings.name == "/dietas_easy_gym_club") ?
        Color(0xff3f1d9d) :
        null,
        child: ListTile(
          leading: FaIcon(
            FontAwesomeIcons.appleAlt,
            color: Color(0xffFA5C45),
          ),
          title: Text(
            'Dietas Easy Gym Club',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          onTap: () {
            if (ModalRoute.of(context).settings.name != "/dietas_easy_gym_club")
              Middleware().goTo(
                callbackGoTo: () =>
                Navigator.of(context)
                .pushReplacementNamed("/dietas_easy_gym_club"),
                callbackExcept: (mensaje) => showModal(mensaje)
              );
          },
        ),
      ),
      Container(
        color:
        (ModalRoute.of(context).settings.name == "/rutinas_easy_gym_club") ?
        Color(0xff3f1d9d) :
        null,
        child: ListTile(
          leading: Icon(
            Icons.directions_run,
            color: Color(0xffFA5C45),
          ),
          title: Text(
            'Rutinas Easy Gym Club',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          onTap: () {
            if (ModalRoute.of(context).settings.name !=
              "/rutinas_easy_gym_club")
              Middleware().goTo(
                callbackGoTo: () =>
                Navigator.of(context)
                .pushReplacementNamed("/rutinas_easy_gym_club"),
                callbackExcept: (mensaje) => showModal(mensaje)
              );
          },
        ),
      ),
    ];

    if (!userBloc.isUserFree) {
      _response.addAll([
        Container(
          color: (ModalRoute.of(context).settings.name == "/clases") ?
          Color(0xff3f1d9d) :
          null,
          child: ListTile(
            leading: Icon(
              Icons.live_tv,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Clases',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              if (ModalRoute.of(context).settings.name != "/clases")
                Middleware().goTo(
                  callbackGoTo: () =>
                  Navigator.of(context).pushReplacementNamed("/clases"),
                  callbackExcept: (mensaje) => showModal(mensaje)
                );
            }),
        ),
        Container(
          color: (ModalRoute.of(context).settings.name == "/agenda") ?
          Color(0xff3f1d9d) :
          null,
          child: ListTile(
            leading: Icon(
              Icons.date_range,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Agenda',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              if (ModalRoute.of(context).settings.name != "/agenda")
                Middleware().goTo(
                  callbackGoTo: () =>
                  Navigator.of(context).pushReplacementNamed("/agenda"),
                  callbackExcept: (mensaje) => showModal(mensaje)
                );
            }),
        ),
        Container(
          color: (ModalRoute.of(context).settings.name == "/ranking") ?
          Color(0xff3f1d9d) :
          null,
          child: ListTile(
            leading: Icon(
              Icons.contacts,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Ranking',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              if (ModalRoute.of(context).settings.name != "/ranking")
                Middleware().goTo(
                  callbackGoTo: () =>
                  Navigator.of(context).pushReplacementNamed("/ranking"),
                  callbackExcept: (mensaje) => showModal(mensaje)
                );
            },
          ),
        ),
        Container(
          color: (ModalRoute.of(context).settings.name ==
            "/ranking_personal_trainer") ?
          Color(0xff3f1d9d) :
          null,
          child: ListTile(
            leading: Icon(
              Icons.add_call,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Ranking Personal Trainer',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              if (ModalRoute.of(context).settings.name !=
                "/ranking_personal_trainer")
                Middleware().goTo(
                  callbackGoTo: () =>
                  Navigator.of(context)
                  .pushReplacementNamed("/ranking_personal_trainer"),
                  callbackExcept: (mensaje) => showModal(mensaje)
                );
            },
          ),
        ),
        Container(
          child: ExpansionTile(
            children: < Widget > [
              Padding(
                padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: (ModalRoute.of(context).settings.name == "/entrada") ?
                    Color(0xff3f1d9d) :
                    null,
                    child: ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Color(0xffFA5C45),
                      ),
                      title: Text(
                        'Entrada al gym',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                      ),
                      onTap: () {
                        if (ModalRoute.of(context).settings.name != "/entrada")
                          Middleware().goTo(
                            callbackGoTo: () =>
                            Navigator.of(context)
                            .pushReplacementNamed("/entrada"),
                            callbackExcept: (mensaje) => showModal(mensaje)
                          );
                      },
                    ),
                  ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  color: (ModalRoute.of(context).settings.name == "/dietas_gym") ?
                  Color(0xff3f1d9d) :
                  null,
                  child: ListTile(
                    leading: FaIcon(
                      FontAwesomeIcons.appleAlt,
                      color: Color(0xffFA5C45),
                    ),
                    title: Text(
                      'Dietas Gym',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                    onTap: () {
                      if (ModalRoute.of(context).settings.name != "/dietas_gym")
                        Middleware().goTo(
                          callbackGoTo: () =>
                          Navigator.of(context)
                          .pushReplacementNamed("/dietas_gym"),
                          callbackExcept: (mensaje) => showModal(mensaje)
                        );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Container(
                  color:
                  (ModalRoute.of(context).settings.name == "/rutinas_gym") ?
                  Color(0xff3f1d9d) :
                  null,
                  child: ListTile(
                    leading: Icon(
                      Icons.directions_run,
                      color: Color(0xffFA5C45),
                    ),
                    title: Text(
                      'Rutinas Gym',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                    onTap: () {
                      if (ModalRoute.of(context).settings.name !=
                        "/rutinas_gym")
                        Middleware().goTo(
                          callbackGoTo: () =>
                          Navigator.of(context)
                          .pushReplacementNamed("/rutinas_gym"),
                          callbackExcept: (mensaje) => showModal(mensaje)
                        );
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
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
          ),
        ),
      ]);
    } else {
      _response.add(
        Container(
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            color: (ModalRoute.of(context).settings.name == "/premium") ?
            Color(0xff3f1d9d) :
            null,
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
              if (ModalRoute.of(context).settings.name != "/premium")
                Middleware().goTo(
                  callbackGoTo: () =>
                  Navigator.of(context).pushReplacementNamed(
                    "/premium"),
                  callbackExcept: (mensaje) => showModal(mensaje)
                );
            },
          ),
        ),
      );
    }

    _response.addAll([
      Container(
        color: (ModalRoute.of(context).settings.name == "/sugerencias") ?
        Color(0xff3f1d9d) :
        null,
        child: ListTile(
          leading: Icon(
            Icons.lightbulb_outline,
            color: Color(0xffFA5C45),
          ),
          title: Text(
            'Sugerencias',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          onTap: () {
            if (ModalRoute.of(context).settings.name != "/sugerencias")
              Middleware().goTo(
                callbackGoTo: () => Navigator.of(context)
                .pushReplacementNamed("/sugerencias"),
                callbackExcept: (mensaje) => showModal(mensaje));
          },
        ),
      ),
      Container(
        child: ListTile(
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.redAccent,
          ),
          title: Text(
            'Cerrar sesión',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          onTap: () {
            Middleware().goTo(
              callbackGoTo: () {
                userBloc.LogOut();
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed("/");
              },
              callbackExcept: (mensaje) => showModal(mensaje)
            );
          }),
      ),
    ]);

    return _response;
  }

  List < Widget > _miCuentaOpciones() {
    List < Widget > aux = [
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Container(
          color: (ModalRoute.of(context).settings.name == "/configuracion") ?
          Color(0xff3f1d9d) :
          null,
          child: ListTile(
            leading: Icon(
              Icons.settings,
              color: Color(0xffFA5C45),
            ),
            title: Text(
              'Configuracion',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            onTap: () {
              if (ModalRoute.of(context).settings.name != "/configuracion")
                Middleware().goTo(
                  callbackGoTo: () =>
                  Navigator.of(context).pushReplacementNamed(
                    "/configuracion"),
                  callbackExcept: (mensaje) => showModal(mensaje)
                );
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
            color: (ModalRoute.of(context).settings.name == "/mis_dietas") ?
            Color(0xff3f1d9d) :
            null,
            child: ListTile(
              leading: FaIcon(
                FontAwesomeIcons.appleAlt,
                color: Color(0xffFA5C45),
              ),
              title: Text(
                'Mis dietas',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                if (ModalRoute.of(context).settings.name != "/mis_dietas")
                  Middleware().goTo(
                    callbackGoTo: () =>
                    Navigator.of(context).pushReplacementNamed(
                      "/mis_dietas"),
                    callbackExcept: (mensaje) => showModal(mensaje)
                  );
              },
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Container(
            color: (ModalRoute.of(context).settings.name == "/mis_rutinas") ?
            Color(0xff3f1d9d) :
            null,
            child: ListTile(
              leading: Icon(
                Icons.directions_run,
                color: Color(0xffFA5C45),
              ),
              title: Text(
                'Mis rutinas',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                if (ModalRoute.of(context).settings.name != "/mis_rutinas")
                  Middleware().goTo(
                    callbackGoTo: () =>
                    Navigator.of(context).pushReplacementNamed(
                      "/mis_rutinas"),
                    callbackExcept: (mensaje) => showModal(mensaje)
                  );
              },
            ),
          ),
        ),
      ]);
    }

    return aux;
  }

  void showError(BuildContext context, String error) {
    thisScaffold.currentState.showSnackBar(SnackBar(
      content: Text(error),
      duration: Duration(seconds: 2),
    ));
  }

  void showModal(String mensaje) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (_) =>
      AlertDialog(
        title: Text(
          mensaje,
          textAlign: TextAlign.center,
        ),
        actions: [
          FlatButton(
            child: Text("Ok"),
            onPressed: () =>
            Navigator.of(context).pop(
              true),
          ),
          FlatButton(
            child: Text("Cancelar"),
            onPressed: () => Navigator.of(context).pop(false),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _subscriptionErrors.cancel();
    super.dispose();
  }
}