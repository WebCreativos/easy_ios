import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class Sugerencias extends StatefulWidget {
  @override
  _SugerenciasState createState() => _SugerenciasState();
}

class _SugerenciasState extends State<Sugerencias> {
  TextEditingController controller = TextEditingController();
  RoundedLoadingButtonController btnController =
      RoundedLoadingButtonController();
  bool _validation = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/bgr.png"), fit: BoxFit.cover)),
      child: Container(
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 8,
            right: MediaQuery.of(context).size.width / 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                "ENVIANOS TUS SUGERENCIAS!",
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
                  "Tu ayuda nos importa!",
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
              keyboardType: TextInputType.text,
              maxLines: 2,
              style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w300),
              decoration: InputDecoration(
                  hintText: "Sugerencia",
                  errorText: _validation ? "Campo vacio" : null,
                  filled: false,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w400),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF5937b2),
                          width: 1.0,
                          style: BorderStyle.solid)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white70,
                          width: 1.3,
                          style: BorderStyle.solid))),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
              child: RoundedLoadingButton(
                controller: btnController,
                color: Color(0xff3F1D9D),
                child: Text(
                  "Enviar",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (controller.text.isEmpty) {
                    btnController.stop();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text("Campo vacio"),
                      duration: Duration(seconds: 2),
                    ));
                    return;
                  }

                  BlocProvider.of<UserBloc>(context)
                      .enviarSugerencia(controller.text)
                      .then((value) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              title: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.lightbulb_outline,
                                      size: 30,
                                    ),
                                    Text(
                                      "Gracias por enviar su sugerencia!",
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ));
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.pop(context);
                      Future.delayed(
                          Duration(seconds: 1), () => Navigator.pop(context));
                    });
                  }, onError: (error) {
                    btnController.stop();
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(error),
                      duration: Duration(seconds: 1),
                    ));
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
