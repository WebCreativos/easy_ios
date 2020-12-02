import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/user.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:transparent_image/transparent_image.dart';
class DrawerUser extends StatefulWidget{


  String username;

  UserModel user;

  DrawerUser({
    Key key,
    this.username
  });

  @override
  _DrawerUserState createState() => _DrawerUserState();
}

class _DrawerUserState extends State<DrawerUser> {
  UserBloc userBloc;


  TextStyle _textStyle() => TextStyle(
      color: Colors.orangeAccent,
      fontWeight: FontWeight.w300,
      fontSize: MediaQuery.of(context).size.width * 0.029
  );
  @override
  Widget build(BuildContext context)   {
    this.userBloc = BlocProvider.of<UserBloc>(context);
    return FutureBuilder(
      future: User.getSavedUser(),
      builder: (BuildContext context, AsyncSnapshot snap) {

        if( !snap.hasData || snap.hasError ){

          return Container(
            height: 150.0,
            child: LinearProgressIndicator(),
          );
        } else {
            UserModel user = snap.data;
            return Container(
              margin: EdgeInsets.only(top: 20.0),
              color: Color(0xff260d6c),
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 50,
                    backgroundImage: (user.imagen_perfil != null)
                        ? NetworkImage(user.imagen_perfil)
                        : MemoryImage(kTransparentImage),
                    backgroundColor: Colors.transparent,
                  ),
                  Text(
                    user.username ?? "",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "edad",
                              style: _textStyle()
                            ),
                            Text(
                              (user.data_info_cliente["edad"]!=null)?user.data_info_cliente["edad"].toString():"",
                              style: TextStyle( 
                                  color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                  fontSize: 30.0
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.center,
                        )
                      ),
                      Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "peso",
                                style: _textStyle()
                              ),
                              Text(
                                (user.data_info_cliente["peso"]!=null)?user.data_info_cliente["peso"].toString():"",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30.0
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )
                      ),
                      Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "altura",
                                style: _textStyle()
                              ),
                              Text(
                                (user.data_info_cliente["altura"]!=null)?user.data_info_cliente["altura"].toString():"",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w300
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )
                      ),
                      Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                "IMC",
                                style: _textStyle()
                              ),
                              Text(
                                formulaImc(user.data_info_cliente["peso"],user.data_info_cliente["altura"]),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 30.0 
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        }
      );
  }
  String formulaImc(double peso, double altura){
    if ((peso == null) || (altura == null)) return "";
    if (peso == 0 || altura == 0) return "0.0";
    return (peso/(altura*altura)).toStringAsFixed(2);
  }
}
