import 'package:easygymclub/User/repository/container_tabs_repository.dart';
import 'package:flutter/material.dart';

class ContainerTabsApi {

  ContainerTabsRepository _containerTabsRepository = ContainerTabsRepository();

  void setStream(window) => _containerTabsRepository.setStream(window);
  Stream<Widget> getWindow() => _containerTabsRepository.getWindow;

  Stream<String> get getTabState => _containerTabsRepository.getTabState;
  void setTabState(String selected) => _containerTabsRepository.setTabState(selected);

  void dispose() => _containerTabsRepository.dispose();
}