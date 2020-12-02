import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class NewPassword extends StatefulWidget {
  @override
  _NewPasswordState createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController controller = TextEditingController();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  bool _validation = false;

  GlobalKey<ScaffoldState> thisScaffold = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: thisScaffold,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/bgr.png"), fit: BoxFit.cover)),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: MediaQuery
                        .of(context)
                        .size
                        .width / 8,
                    right: MediaQuery
                        .of(context)
                        .size
                        .width / 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "OLVIDE MI CONTRASEÑA",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(top: 70, bottom: 40),
                        child: Text(
                          "Ingrese su email y le enviaremos una nueva contraseña",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    TextField(
                      controller: controller,
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                      decoration: InputDecoration(
                          hintText: "Email",
                          errorText: _validation
                              ? "Ingrese un email valido"
                              : null,
                          icon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          filled: false,
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w400),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFF5937b2),
                                  width: 1.0,
                                  style: BorderStyle.solid)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white70,
                                  width: 2.0,
                                  style: BorderStyle.solid))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery
                              .of(context)
                              .size
                              .height / 6),
                      child: RoundedLoadingButton(
                        controller: btnController,
                        color: Color(0xff3F1D9D),
                        child: Text(
                          "Enviar",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (controller.text.isEmpty && !controller.text
                              .contains(RegExp(r'[@]'))) {
                            btnController.stop();
                            thisScaffold.currentState.showSnackBar(SnackBar(
                              content: Text("Ingrese un email valido"),
                              duration: Duration(seconds: 2),
                            ));
                            return;
                          }

                          BlocProvider.of<UserBloc>(context)
                              .newPassword(controller.text)
                              .then((value) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(15))),
                                      title: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment
                                              .center,
                                          children: [
                                            Icon(Icons.email, size: 30,),
                                            Text(
                                              "Su contraseña a hizo reestablecida, por favor revise su correo",
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      ),
                                    ));
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.pop(context);
                              Future.delayed(Duration(seconds: 1), () =>
                                  Navigator.pop(context));
                            });
                          }, onError: (error) {
                            btnController.stop();
                            Scaffold.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                  duration: Duration(seconds: 1),
                                )
                            );
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
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
                    controller.clear();
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
