import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/PersonalTrainer/ui/widgets/personal_trainer_perfil.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class RankingPersonalTrainer extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return _RankingPersonalTrainer();
  }

}

class _RankingPersonalTrainer extends State<RankingPersonalTrainer>{

  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _userBloc = BlocProvider.of<UserBloc>(context);

    return FutureBuilder(
      future: _userBloc.getUsuarios("Personal trainer"),
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {

          switch (snap.connectionState) {

            case ConnectionState.none:
            case ConnectionState.waiting:
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case ConnectionState.active:
            case ConnectionState.done:
              return Column(
                children: < Widget > [
                  Container(
                    margin: EdgeInsets.only(bottom:20),
                    child: Row(                     
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _firstThree(snap),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: _body(snap),
                  )
                ]
              );
          }
          return null;
        }

      },
    );
  }

  List<Widget> _firstThree(AsyncSnapshot snap){

    List<UserModel> aux = snap.data;
    List<Widget> response = List<Widget>();

    if(aux.length > 0)
      response.add(
        Container(padding: EdgeInsets.only(top: 40),
          child: Column(
            children: <Widget>[
              Text("${aux[0].nombre} ${aux[0].apellido}",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
              SizedBox(height: 5),
              CircleAvatar(
                  backgroundImage: NetworkImage("${aux[0].imagen_perfil ?? "https://image.shutterstock.com/image-vector/male-avatar-profile-picture-vector-260nw-149083895.jpg"}" ,),
                  maxRadius:40
              ),
              Icon(
                Icons.star,
                color: Colors.grey,
              )
            ],
          ),
        ),
      );
    if(aux.length > 1)
      response.add(
        Container(padding: EdgeInsets.all(20), child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${aux[1].nombre} ${aux[1].apellido}",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            CircleAvatar(
                backgroundImage: NetworkImage("${aux[1].imagen_perfil}"),
                maxRadius:40
            ),
            Icon(
              Icons.star,
              color: Colors.yellowAccent,
            )

          ],
        ), ),
      );
    if(aux.length > 2)
      response.add(Container(padding: EdgeInsets.only(top: 40), child: Column(
        children: <Widget>[
          Text("${aux[2].nombre} ${aux[2].apellido}",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          SizedBox(height: 5),

          CircleAvatar(
              backgroundImage: NetworkImage("${aux[0].imagen_perfil}"),
              maxRadius:40
          ),
          Icon(
            Icons.star,
            color: Colors.orange,
          )
        ],
      ), ),);
    return response;
  }

  Widget _body(AsyncSnapshot snap){
 
    List<UserModel> personalTrainerList = snap.data;
    return ListView.builder(
      itemCount: personalTrainerList.length,
      itemBuilder: (context,index) => PersonalTrainerPerfil(
        personalTrainer: personalTrainerList[index],
        index: index,
      ),
    );

  }

}