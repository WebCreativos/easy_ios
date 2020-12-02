import 'dart:async';

import 'package:easygymclub/Clases/ui/screens/clases_screen.dart';
import 'package:easygymclub/Dieta/ui/screens/dieta_screen.dart';
import 'package:easygymclub/EasyFit/bloc/contador_google_maps_bloc.dart';
import 'package:easygymclub/EasyFit/bloc/cronometros_bloc.dart';
import 'package:easygymclub/EasyFit/ui/screens/easy_fit_screen.dart';
import 'package:easygymclub/PersonalTrainer/ui/screens/ranking_personal_trainer.dart';
import 'package:easygymclub/Rutinas/ui/screens/rutinas_screen.dart';
import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/User/ui/screens/agenda/screens/agenda_screen.dart';
import 'package:easygymclub/User/ui/screens/configuracion/screens/configuracion.dart';
import 'package:easygymclub/User/ui/screens/entrada_gym.dart';
import 'package:easygymclub/User/ui/screens/mi_ranking/screens/mi_ranking.dart';
import 'package:easygymclub/User/ui/screens/sign_in.dart';
import 'package:easygymclub/User/ui/screens/sugerencias.dart';
import 'package:easygymclub/User/ui/widgets/premium_pass.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_provider.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_screen.dart';
import 'package:easygymclub/utils/Navigation/navigation_efects/fade_transition_navigation.dart';
import 'package:easygymclub/utils/Navigation/new_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'User/model/user_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  UserBloc _userBloc;
  CronometrosBloc _cronometrosBloc;
  ContadorGoogleMapsBloc _contadorEjercicioBloc;

  @override
  Widget build(BuildContext context) {
    _userBloc = UserBloc();
    _cronometrosBloc = CronometrosBloc();
    _contadorEjercicioBloc = ContadorGoogleMapsBloc();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return BlocProvider(
      child: BlocProvider(
        child: BlocProvider(
          child: MaterialApp(
            initialRoute: "/",
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case "/":
                  return MyCustomRoute(
                      builder: (_) => InitScreen(), settings: settings);
                case "/easy_fit":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                            key: ValueKey("easy_fit"),
                            body: EasyFitScreen(),
                        title: "Easy fit",
                      ),
                      settings: settings);
                case "/configuracion":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("configuracion"),
                        body: Configuracion(),
                        title: "Configuracion",
                      ),
                      settings: settings);
                case "/dietas_easy_gym_club":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("dietas_easy_gym_club"),
                        body: DietaScreen(
                          key: ValueKey("App"),
                          tipo: "App",
                        ),
                        title: "Dietas Easy Gym Club",
                      ),
                      settings: settings);
                case "/rutinas_easy_gym_club":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("rutinas_easy_gym_club"),
                        body: RutinasScreen(
                          key: ValueKey("App"),
                          tipo: "App",
                        ),
                        title: "Rutinas Easy Gym Club",
                      ),
                      settings: settings);
                case "/clases":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("rutinas_easy_gym_club"),
                        body: ClasesScreen(),
                        title: "Clases",
                      ),
                      settings: settings);
                case "/agenda":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("agenda"),
                        body: AgendaScreen(),
                        title: "Agenda",
                      ),
                      settings: settings);
                case "/entrada":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("entrada"),
                        body: EntradaGym(),
                        title: "Entrada al gym",
                      ),
                      settings: settings);
                case "/ranking":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("ranking"),
                        body: MiRanking(),
                        title: "Ranking",
                      ),
                      settings: settings);
                case "/ranking_personal_trainer":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("ranking_personal_trainer"),
                        body: RankingPersonalTrainer(),
                        title: "Ranking Personal Trainer",
                      ),
                      settings: settings);
                case "/dietas_gym":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("dietas_gym"),
                        body: DietaScreen(
                          key: ValueKey("Gimnasio"),
                          tipo: "Gimnasio",
                        ),
                        title: "Dietas Gym",
                      ),
                      settings: settings);
                case "/rutinas_gym":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("rutinas_gym"),
                        body: RutinasScreen(
                          key: ValueKey("Gimnasio"),
                          tipo: "Gimnasio",
                        ),
                        title: "Rutinas Gym",
                      ),
                      settings: settings);
                case "/mis_rutinas":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("mis_rutinas"),
                        body: RutinasScreen(
                          key: ValueKey("Usuario"),
                          tipo: "Usuario",
                        ),
                        title: "Mis Rutinas",
                      ),
                      settings: settings);
                case "/mis_dietas":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("mis_dietas"),
                        body: DietaScreen(
                          key: ValueKey("Usuario"),
                          tipo: "Usuario",
                        ),
                        title: "Mis Dietas",
                      ),
                      settings: settings);
                case "/premium":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                        key: ValueKey("premium"),
                        body: PremiumPass(),
                        title: "Pasarme a Premium",
                      ),
                      settings: settings);
                case "/sugerencias":
                  return MyCustomRoute(
                      builder: (_) => NewScreen(
                            key: ValueKey("sugerencias"),
                            body: Sugerencias(),
                            title: "Sugerencias",
                          ));
                default:
                  return MyCustomRoute(
                      builder: (_) {
                        debugPrint("### RUTA NO ENCONTRADA ${settings.name}");
                        return Scaffold(
                          body: Center(
                            child: Text(
                              "Ruta no encontrada",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      },
                      settings: settings);
              }
            },
            debugShowCheckedModeBanner: false,
            title: "EasyGymClub",
            theme: ThemeData(fontFamily: 'Montserrat'),
          ),
          bloc: _contadorEjercicioBloc,
        ),
        bloc: _cronometrosBloc,
      ),
      bloc: _userBloc,
    );
  }
}

class InitScreen extends StatefulWidget {
  @override
  _InitScreenState createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  final LoadingProvider _loadingProvider = LoadingProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff260d6c),
      body: Provider(create: (_) => _loadingProvider, child: InitScreenChild()),
    );
  }
}

class InitScreenChild extends StatefulWidget {
  @override
  _InitScreenChildState createState() => _InitScreenChildState();
}

class _InitScreenChildState extends State<InitScreenChild> {
  UserBloc _userBloc;
  ErrorController _errorController;
  StreamSubscription _subscriptionError;

  @override
  void initState() {
    super.initState();
    _errorController = ErrorController.instance;
    _subscriptionError = _errorController.theresAnyError.listen((errorToShow) {
      Provider.of<LoadingProvider>(context, listen: false)
          .setLoadingState(StageLoading.Error);
      showError(context, errorToShow);
    });
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    await [
      Permission.location,
      Permission.storage,
    ].request();
  }

  @override
  Widget build(BuildContext context) {
    _userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder<UserModel>(
        stream: _userBloc.userInstance(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.hasError)
            return Container(
              child: Stack(
                children: <Widget>[
                  SignIn(),
                  LoadingScreen(),
                ],
              ),
            );

          Future.delayed(Duration.zero,
                  () =>
                  Navigator.of(context).pushReplacementNamed("/easy_fit"));

          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void showError(BuildContext context, String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      duration: Duration(seconds: 2),
    ));
  }

  @override
  void dispose() {
    _subscriptionError.cancel();
    super.dispose();
  }
}
