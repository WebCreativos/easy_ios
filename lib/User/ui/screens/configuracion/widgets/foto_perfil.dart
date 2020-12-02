import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';

class FotoPerfil extends StatefulWidget {
  String url;

  FotoPerfil({this.url});

  @override
  _FotoPerfilState createState() => _FotoPerfilState();
}

class _FotoPerfilState extends State<FotoPerfil> {
  UserBloc _userBloc;

  @override
  Widget build(BuildContext context) {
    _userBloc = BlocProvider.of<UserBloc>(context);

    return Container(
      width: 100.0,
      height: 100.0,
      child: InkWell(
        onTap: () {
          AwesomeDialog(
              context: context,
              animType: AnimType.SCALE,
              dialogType: DialogType.INFO,
              customHeader: Icon(
                Icons.add_a_photo,
                size: 50,
                color: Colors.black54,
              ),
              body: Container(
                child: Center(
                  child: _DialogPhoto(),
                ),
              ),
              btnOk: FlatButton(
                color: Colors.deepPurpleAccent,
                child: Text(
                  "Cambiar foto de perfil",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: _onPressed,
              )).show();
        },
        child: _WhichPhoto(),
      ),
    );
  }

  void _onPressed() {
    try {
      ImagePicker.pickImage(source: ImageSource.gallery).then((File image) {
        print("aca");
        _userBloc.setFileImageProfile(image);
        _userBloc.changeAvatarImage(File(image.path));
      });
    } catch (e) {
      ErrorController.instance
          .setErrorToShow("Error con la imagen, vuelva a elejir o elija otra");
    }
  }

  Widget _DialogPhoto() {
    return StreamBuilder(
      stream: _userBloc.avatarImage(),
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return SizedBox(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              child: Image.network(widget.url)
          );
        }
        return SizedBox(
          child: Image.file(snap.data),
          height: MediaQuery.of(context).size.height / 2,
        );
      },
    );
  }
}

class _WhichPhoto extends StatelessWidget {
  UserBloc _userBloc;

  @override
  Widget build(BuildContext context) {
    _userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: _userBloc.avatarImage(),
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return _getImageUser();
        }

        File image = snap.data;

        return Container(
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: FileImage(image),
              radius: 0.16),
        );
      },
    );
  }

  Widget _getImageUser() {
    return FutureBuilder(
      future: _userBloc.userInstance().first,
      builder: (context, snap) {
        if (!snap.hasData) {
          return CircularProgressIndicator();
        }

        UserModel user = snap.data;

        return Container(
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(user.imagen_perfil),
              radius: 0.16),
        );
      },
    );
  }
}
