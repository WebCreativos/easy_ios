import 'package:easygymclub/utils/LoadingProvider/color_loader.dart';
import 'package:easygymclub/utils/LoadingProvider/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LoadingScreen();
  }

}

class _LoadingScreen extends State<LoadingScreen> {

  LoadingProvider _provider;

  @override
  Widget build(BuildContext context) {

    _provider = Provider.of<LoadingProvider>(context);
    return StreamBuilder(
      stream: _provider.isLoading,
      builder: (context,snap){
        if(!snap.hasData){
          return SizedBox.shrink();
        }
        StageLoading stateLoading = snap.data;
        if(stateLoading == StageLoading.Loading){
          return Container(
            decoration: BoxDecoration(
              color: Colors.white54
            ),
            child: Center(
                child: ColorLoader3(dotRadius: 10.0,radius: 40.0,)
            ),
          );
        }
        return SizedBox.shrink();

      },
    );
  }

}