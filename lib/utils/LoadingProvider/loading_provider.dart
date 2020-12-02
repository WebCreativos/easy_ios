
import 'package:rxdart/rxdart.dart';

enum StageLoading {
  Loading,
  Loaded,
  Error,
}

class LoadingProvider {

  BehaviorSubject<StageLoading> _loadingState = BehaviorSubject<StageLoading>.seeded(StageLoading.Loaded);

  Stream<StageLoading> get isLoading => _loadingState.stream;

  void setLoadingState(StageLoading state){
    _loadingState.sink.add(state);
  }
}