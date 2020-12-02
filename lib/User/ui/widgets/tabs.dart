import 'package:easygymclub/User/bloc/container_tabs_bloc.dart';
import 'package:easygymclub/User/ui/widgets/common_form.dart';
import 'package:easygymclub/User/ui/widgets/trainer_form.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class Tabs extends StatefulWidget{

  String title;
  Tabs({Key key, this.title});

  @override
  State<StatefulWidget> createState() {

    return _Tabs();
  }
}

class _Tabs extends State<Tabs>{

  ContainerTabsBloc _containerTabsBloc;

  @override
  Widget build(BuildContext context) {

    _containerTabsBloc = BlocProvider.of<ContainerTabsBloc>(context);

    return StreamBuilder(
      stream: _containerTabsBloc.getTabState,
      builder: (context, snap){

        if( !snap.hasData || snap.hasError ){
          return InkWell(
            child: Container(
              margin: EdgeInsets.only(
                //right: 5.0
              ),
              padding: EdgeInsets.all(10.0),
              child: Text(
                widget.title, 
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                ),
                textAlign: TextAlign.center,
              ),
            ),
            onTap: (){
              switch(widget.title){
                case "DEPORTISTA":
                  _containerTabsBloc.setStream(CommonForm());
                  break;
                case "PERSONAL TRAINER":
                  _containerTabsBloc.setStream(TrainerForm());
                  break;
                default:
                  print("Nada");
              }
            },
          );
        }else{

          String isSelected = snap.data;
          if(isSelected == widget.title){
            return Expanded(
              child: InkWell(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: Color(0xFF5937b2),
                              width: 2.0,
                              style: BorderStyle.solid
                          )
                      )
                  ),
                  margin: EdgeInsets.only(
                    //right: 5.0
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){
                  switch(widget.title){
                    case "DEPORTISTA":
                      _containerTabsBloc.setStream(CommonForm());
                      break;
                    case "PERSONAL TRAINER":
                      _containerTabsBloc.setStream(TrainerForm());
                      break;
                    default:
                      print("Nada");
                  }
                },
              ),
            );
          }else{
            return Expanded(
              child: InkWell(
                child: Container(
                  margin: EdgeInsets.only(
                    //right: 5.0
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: (){
                  switch(widget.title){
                    case "DEPORTISTA":
                      _containerTabsBloc.setStream(CommonForm());
                      _containerTabsBloc.setTabState("DEPORTISTA");
                      break;
                    case "PERSONAL TRAINER":
                      _containerTabsBloc.setStream(TrainerForm());
                      _containerTabsBloc.setTabState("PERSONAL TRAINER");
                      break;
                    default:
                      print("Nada");
                  }
                },
              ),
            );
          }
        }
        return null;
      },
    );
  }

}
