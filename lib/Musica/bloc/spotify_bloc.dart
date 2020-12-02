import 'package:easygymclub/Musica/models/play_list_data_model.dart';
import 'package:easygymclub/Musica/repository/spotify_api.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';

class SpotifyBloc extends Bloc{

  final SpotifyApi _spotifyApi = SpotifyApi();

  Stream<bool> isConnected() => _spotifyApi.isConnected();
  Stream<bool> isPaused() => _spotifyApi.isPaused;
  Future<List<PlayListDataModel>> userPlaylists() => _spotifyApi.userPlaylists();
  void connectToSpotify() => _spotifyApi.connectToSpotify();
  Future<void> playUri(String uri) => _spotifyApi.playUri(uri);
  Future<void> skipPrevious() => _spotifyApi.skipPrevious();
  Future<void> skipNext() => _spotifyApi.skipNext();
  Future<void> resume() => _spotifyApi.resume();
  Future<void> pause() => _spotifyApi.pause();
  Future<void> queue() => _spotifyApi.queue();
  void setStopOrPlay(bool state) => _spotifyApi.setStopOrPlay(state);



  @override
  void dispose() {
    _spotifyApi.dispose();
  }

}