import 'package:easygymclub/User/ui/screens/configuracion/bloc/configuration_bloc.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ImagenTipoDeCuerpo extends StatefulWidget {
  @override
  _ImagenTipoDeCuerpoState createState() => _ImagenTipoDeCuerpoState();
}

class _ImagenTipoDeCuerpoState extends State<ImagenTipoDeCuerpo> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: BlocProvider.of<ConfigurationBloc>(context).tipoDeFigura,
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return Image.memory(kTransparentImage);
        }

        return Container(
          margin: EdgeInsets.only(bottom: 5),
          child: Image(
              image:
                  AssetImage('assets/img/' + snap.data.toLowerCase() + '.png')),
        );
      },
    );
  }
}
