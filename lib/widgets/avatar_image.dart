import 'dart:io';

import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/model/user_model.dart';
import 'package:easygymclub/utils/ErrorController/error_controller.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:image_picker/image_picker.dart';

const String logo = "assets/img/logo1.png";

class AvatarImage extends StatefulWidget {
  double width, height;
  String path;
  State<AvatarImage> _state = _AvatarImage();

  AvatarImage({Key key, this.width = 0.33, this.height = 0.3, this.path});

  // Call this constructor if the user is already sign up
  AvatarImage.imgPath({
    Key key,
    this.width = 0.33,
    this.height = 0.3,
  }) {
    _state = _AvatarImagePath();
  }

  @override
  State<StatefulWidget> createState() {
    return _state;
  }
}

class _AvatarImage extends State<AvatarImage> {
  UserBloc userBloc;
  var _mediaQuery;

  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context).size;
    userBloc = BlocProvider.of<UserBloc>(context);

    return StreamBuilder(
      stream: userBloc.avatarImage(),
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {

          return FutureBuilder(
            future: userBloc.userInstance().first,
            builder: (context,snap){
              if(snap.hasData){

                UserModel user = snap.data;

                return Container(
                    width: _mediaQuery.width * widget.width,
                    height: _mediaQuery.height * widget.height,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.white, style: BorderStyle.solid, width: 1.0),
                      shape: BoxShape.circle,
                      //borderRadius: BorderRadius.circular(90.0)
                    ),
                    child: InkWell(
                      onTap: () {
                        try {
                          ImagePicker.pickImage(source: ImageSource.gallery)
                              .then((File image) {
                            userBloc.setFileImageProfile(image);
                            userBloc.changeAvatarImage(
                                SizedBox(
                                  child: CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      backgroundImage: FileImage(new File(image.path)),
                                      radius: (widget.height != 0.3)
                                          ? _mediaQuery.width * 0.1
                                          : _mediaQuery.width * 0.16
                                  ),
                                ));
                          });
                        } catch (e) {
                          ErrorController.instance.setErrorToShow("Error con la imagen, vuelva a elejir o elija otra");
                        }
                      },
                      child: SizedBox(
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: Image.network(user.imagen_perfil),
                            ),
                            maxRadius: 35,

                        ),
                      ),
                    ));
              }
              return Container(
                  width: _mediaQuery.width * widget.width,
                  height: _mediaQuery.height * widget.height,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white, style: BorderStyle.solid, width: 1.0),
                    shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(90.0)
                  ),
                  child: InkWell(
                    onTap: () {
                      try {
                        ImagePicker.pickImage(source: ImageSource.gallery)
                            .then((File image) {
                          userBloc.setFileImageProfile(image);
                          userBloc.changeAvatarImage(
                            //snap.data refers to this
                              SizedBox(
                                child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage: FileImage(image),
                                    radius: (widget.height != 0.3)
                                        ? _mediaQuery.width * 0.1
                                        : _mediaQuery.width * 0.16),
                              ));
                        });
                      } on Exception catch (e) {
                        ErrorController.instance.setErrorToShow("Error con la imagen, cuelva a elejir o elija otra");
                      }
                    },
                    child: Center(
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.white,
                          size: _mediaQuery.width * 0.1,
                        )),
                  ));
            },
          );
        } else {

          return Container(
              width: _mediaQuery.width * widget.width,
              height: _mediaQuery.height * widget.height,
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.white, style: BorderStyle.solid, width: 1.0),
                shape: BoxShape.circle,
              ),
              child: InkWell(
                onTap: () {
                  try {
                    ImagePicker.pickImage(source: ImageSource.gallery)
                        .then((File image) {
                      userBloc.setFileImageProfile(image);
                      userBloc.changeAvatarImage(
                          //snap.data refers to this
                          SizedBox(
                        child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: FileImage(
                              new File(image.path)
                            ),
                            radius: (widget.height != 0.3)
                                ? _mediaQuery.width * 0.1
                                : _mediaQuery.width * 0.16),
                      ));
                    });
                  } on Exception catch (e) {
                    ErrorController.instance.setErrorToShow("Error con la imagen, cuelva a elejir o elija otra");
                  }
                },
                child: Center(
                  child: snap.data,
                ),
              ));
        }
      },
    );
  }

}

class _AvatarImagePath extends State<AvatarImage> {
  UserBloc _userBloc;

  @override
  Widget build(BuildContext context) {
    _userBloc = BlocProvider.of<UserBloc>(context);

    return FutureBuilder<UserModel>(
      future: _userBloc.userInstance().first,
      builder: (context, snap) {
        var _mediaQuery = MediaQuery.of(context).size;

        if (!snap.hasData || snap.hasError) {
          return CircularProgressIndicator();
        } else {
          UserModel userData = snap.data;

          return SizedBox(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(userData.imagen_perfil),
              radius: (widget.height != 0.3)
                  ? _mediaQuery.width * 0.1
                  : _mediaQuery.width * 0.16,
            ),
          );
        }
      },
    );
  }
}
