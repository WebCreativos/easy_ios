import 'package:easygymclub/User/repository/container_tabs_api.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class ContainerTabsBloc extends Bloc{

  ContainerTabsApi _containerTabsApi = ContainerTabsApi();

  void setStream(window) => _containerTabsApi.setStream(window);
  Stream<Widget> getWindow() => _containerTabsApi.getWindow();

  Stream<String> get getTabState => _containerTabsApi.getTabState;
  void setTabState(String selected) => _containerTabsApi.setTabState(selected);

  @override
  void dispose() {
    _containerTabsApi.dispose();
  }

}