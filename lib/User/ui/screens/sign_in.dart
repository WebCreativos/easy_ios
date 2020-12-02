import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/ui/screens/new_password.dart';
import 'package:easygymclub/User/ui/widgets/container_tabs.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_provider.dart';
import 'package:easygymclub/utils/Navigation/navigation_efects/slide_transition_navigation.dart';
import 'package:easygymclub/widgets/avatar_image.dart';
import 'package:easygymclub/widgets/check_box.dart';
import 'package:easygymclub/widgets/custom_button.dart';
import 'package:easygymclub/widgets/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:provider/provider.dart';

const String background = "assets/img/bgr.png";
const String logo = "assets/img/logo1.png";
final Shader textNameApp = LinearGradient(
  colors: <Color>[Color(0xffFA6C42), Color(0xfffbd52b)],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignIn();
  }
}

class _SignIn extends State<SignIn> {
  UserBloc userBloc;

  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final CheckBox checkBox = CheckBox();

  PageController _controller = PageController(
      initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    this.userBloc = BlocProvider.of<UserBloc>(context);
    return SignInUi();
  }

  Widget SignInUi() {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          _signInForm(),
          _signUpForm()
        ],
      ),
    );
  }

  Widget _signInForm() {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(background), fit: BoxFit.cover)),
        child: Stack(
          children: <Widget>[
            Container(
              child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(bottom: 30.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(logo))),
                                height: 80.0,
                                width: 80.0,
                                margin: EdgeInsets.only(bottom: 5.0),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 3.0),
                                child: Text(
                                  "EasyGymClub",
                                  style: TextStyle(
                                    //color: LinearGradient(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                      foreground: Paint()
                                        ..shader = textNameApp),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Your best fitness friend",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              )
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.only(bottom: 15.0),
                        padding: EdgeInsets.only(right: 30.0, left: 30.0),
                        child: TextInput(
                          controller: controllerEmail,
                          hintText: "Email",
                          inputType: null,
                          iconData: Icons.mail,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 30.0, top: 10.0),
                        padding: EdgeInsets.only(right: 30.0, left: 30.0),
                        child: TextInput(
                          controller: controllerPassword,
                          hintText: "Password",
                          inputType: null,
                          iconData: Icons.vpn_key,
                          itIsPassword: true,
                        ),
                      ),
                      Container(
                        child: CustomButton(
                          text: "INGRESAR",
                          colorBg: true,
                          callbackOnPressed: () {
                            //Function to controll data before sign up

                            String userField = controllerEmail.text;
                            String passField = controllerPassword.text;

                            if ((userField != '') && (passField != '')) {
                              Provider.of<LoadingProvider>(
                                  context, listen: false)
                                  .setLoadingState(StageLoading.Loading);
                              controllerEmail.clear();
                              controllerPassword.clear();
                              userBloc.changeAvatarImage(null);

                              userBloc.LogIn(userField, passField).then((data) {
                                Navigator.of(context)
                                .pushReplacementNamed("/easy_fit");

                            Provider.of<LoadingProvider>(
                                    context, listen: false)
                                    .setLoadingState(StageLoading.Error);
                              },
                                  onError: (error) =>
                                      Provider.of<LoadingProvider>(
                                          context,
                                          listen: false)
                                          .setLoadingState(StageLoading.Error)
                              );
                            } else {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text("Ingrese usuario y/o contraseña"),
                                duration: Duration(seconds: 1),
                              ));
                            }
                          },
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                        ),
                      ),
                    ],
                  )),
            ),
            Center(
              child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery
                          .of(context)
                          .size
                          .height * 0.9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          child: InkWell(
                              onTap: () {
                                controllerEmail.clear();
                                controllerPassword.clear();
                                _controller.nextPage(
                                    duration: kTabScrollDuration,
                                    curve: Curves.ease);
                              },
                              splashColor: Colors.white12,
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 2.0,
                                  bottom: 2.0,
                                ),
                                child: Text(
                                  "¿No tienes cuenta? Regístrate",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              )),
                        ),
                      ),
                      Material(
                        type: MaterialType.transparency,
                        child: Ink(
                          child: InkWell(
                              onTap: () {
                                controllerEmail.clear();
                                controllerPassword.clear();
                                Navigator.of(context).push(
                                    SlideTransitionNavigation(
                                        page: NewPassword()
                                    )
                                );
                              },
                              splashColor: Colors.white12,
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 2.0,
                                  bottom: 2.0,
                                ),
                                child: Text(
                                  "Olvide mi contraseña",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300),
                                ),
                              )),
                        ),
                      ),
                    ],
                  )
              ),
            )
          ],
        ));
  }

  Widget _signUpForm() {
    //LayoutBuilder, SignleChildScrollView and ConstrainedBox
    // it's for when the keyboard overlaps a column and make it overflow
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewport) =>
            SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: viewport.maxHeight),
                  child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(background),
                              fit: BoxFit.cover)),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          Positioned(
                            top: MediaQuery
                                .of(context)
                                .size
                                .height * 0.03,
                            left: MediaQuery
                                .of(context)
                                .size
                                .width * 0.01,
                            child: InkWell(
                              child: Icon(
                                Icons.chevron_left,
                                color: Color(0xffFA6C42),
                                size: 50.0,
                              ),
                              onTap: () {
                                controllerEmail.clear();
                                controllerPassword.clear();
                                _controller.previousPage(
                                    duration: kTabScrollDuration,
                                    curve: Curves.ease);
                              },
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AvatarImage(),
                              Container(
                                  child: ContainerTabs(
                                    titles: ["DEPORTISTA"],
                                  )),
                            ],
                          ),
                        ],
                      )),
                )));
  }
}
