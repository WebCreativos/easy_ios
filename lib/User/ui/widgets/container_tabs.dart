import 'package:easygymclub/User/bloc/container_tabs_bloc.dart';
import 'package:easygymclub/User/bloc/user_bloc.dart';
import 'package:easygymclub/User/ui/widgets/common_form.dart';
import 'package:easygymclub/User/ui/widgets/trainer_form.dart';
import 'package:easygymclub/User/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ContainerTabs extends StatefulWidget{

  List<String> titles;
  List<Widget> containers;

  ContainerTabs({
    Key key,
    this.titles,
    this.containers
  });

  @override
  State<StatefulWidget> createState() {
    return _ContainerTabs();
  }

}

class _ContainerTabs extends State<ContainerTabs>{

  int index = 0;

  ContainerTabsBloc _containerTabsBloc;

  @override
  void initState() {

    _containerTabsBloc = ContainerTabsBloc();
    _containerTabsBloc.setStream(CommonForm());
    _containerTabsBloc.setTabState("DEPORTISTA");

    super.initState();
  }

  @override
  void dispose() {
    _containerTabsBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      bloc: _containerTabsBloc,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 15.0),
              padding: EdgeInsets.only(right: 30.0,left:30.0),
              child: Row(
                children: _tabs(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15.0),
              padding: EdgeInsets.only(right: 33.0,left:33.0),
              child: _show(),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _tabs(){
    return widget.titles.map(
        (title) => Tabs(title: title,)
    ).toList();
  }

  Widget _show(){

   return StreamBuilder(
     stream: _containerTabsBloc.getWindow(),
     builder: (context,AsyncSnapshot<Widget> snap){
       if(!snap.hasData || snap.hasError){

         return CommonForm();
       }else{

         switch(snap.connectionState){

           case ConnectionState.none:
           case ConnectionState.waiting:
             return CommonForm();
           case ConnectionState.active:
           case ConnectionState.done:
             return snap.data;
         }
       }
       return null;
     },
   );
  }

}