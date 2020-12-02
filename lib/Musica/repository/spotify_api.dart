import 'package:easygymclub/Musica/models/play_list_data_model.dart';
import 'package:easygymclub/Musica/repository/spotify_repository.dart';

class SpotifyApi{

  final SpotifyRepository _spotifyRepository = SpotifyRepository();

  Stream<bool> isConnected() => _spotifyRepository.isConnected;
  Stream<bool> get isPaused => _spotifyRepository.isPaused;
  void connectToSpotify() => _spotifyRepository.connectToSpotify();
  Future<List<PlayListDataModel>> userPlaylists() => _spotifyRepository.userPlaylists();
  Future<void> playUri(String uri) => _spotifyRepository.playUri(uri);
  Future<void> skipPrevious() => _spotifyRepository.skipPrevious();
  Future<void> skipNext() => _spotifyRepository.skipNext();
  Future<void> resume() => _spotifyRepository.resume();
  Future<void> pause() => _spotifyRepository.pause();
  Future<void> queue() => _spotifyRepository.queue();
  void setStopOrPlay(bool state) => _spotifyRepository.setStopOrPlay(state);


  void dispose(){
    _spotifyRepository.dispose();
  }

}