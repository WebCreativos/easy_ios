import 'package:easygymclub/PersonalTrainer/ui/screens/perfil_trainer_screen.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:flutter/material.dart';

class PersonalTrainerPerfil extends StatelessWidget {
  int index;
  UserModel personalTrainer;
  PersonalTrainerPerfil({
    Key key,
    this.personalTrainer,
    this.index
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.010,
        left: MediaQuery.of(context).size.height * 0.010,
        right: MediaQuery.of(context).size.height * 0.010,
        ),
      decoration: BoxDecoration(
        color: (this.index % 2 == 0) ? Color(0xFF3f1d9d) : Color(0xFF5937b2),
        borderRadius: BorderRadius.circular(4)
      ),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround ,
          children: < Widget > [
            Expanded(
              flex: 1, // 20%
              child: Text((this.index + 1).toString(), style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
            ),
            Expanded(
              flex: 1, // 20%
              child: Container(
                  child:  CircleAvatar(
                    radius: 20,
                    backgroundImage:(this.personalTrainer.imagen_perfil!=null)? 
                    NetworkImage(this.personalTrainer.imagen_perfil):
                    NetworkImage("https://image.shutterstock.com/image-vector/male-avatar-profile-picture-vector-260nw-149083895.jpg"),
                  ),
              ),
            ),
            SizedBox(width: 15,),
            Expanded(
              flex: 4, // 20%
              child: Text(this.personalTrainer.nombre, style: TextStyle(color: Colors.white),textAlign: TextAlign.left,)
            ),
            Expanded(
              flex: 2, // 20%
              child: Text(this.personalTrainer.data_info_cliente["puntos"].toString(), style: TextStyle(color: Colors.white),textAlign: TextAlign.center,)
            )
          ],
        ),
          onTap:() => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PerfilTrainerScreen(personalTrainer:this.personalTrainer,position: index,)
              )
          ),
      ),
    );
  }
  }
