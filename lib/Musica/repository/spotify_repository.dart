import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easygymclub/Musica/models/play_list_data_model.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

const String clientId = "86282420ad5d47a799a2fb2ea2089e28" ;
const String redirectUrl = "easy://callback";

class SpotifyRepository {

  // Stream to check if the users its connected to Spotify

  BehaviorSubject<bool> _connected = BehaviorSubject<bool>.seeded(false);
  BehaviorSubject<bool> _isPaused = BehaviorSubject<bool>.seeded(true);
  Stream<bool> get isPaused => _isPaused.stream;
  Stream<bool> get isConnected => _connected.stream;
  String _authenticationToken;
  final Logger _logger = Logger();
  bool isLogued = false;

  void connectToSpotify() {
    getAuthenticationToken();
    isLogued = !isLogued;
  }

  Future<void> getAuthenticationToken() async {
    try {
      _authenticationToken = await SpotifySdk.getAuthenticationToken(
          clientId: clientId, redirectUrl: redirectUrl);
      setStatus("Got a token: $_authenticationToken");
      await connectToSpotifyRemote();
    } catch (e) {
      setStatus(e.code, message: e.message);
    }
  }

  Future<void> playUri(String uri) async {
    try {
      await SpotifySdk.play(spotifyUri: uri);
      //isPaused
      setStopOrPlay(false);
    } catch (e) {
      setStatus(e.code, message: e.message);
    }
  }

  Future<List<PlayListDataModel>> userPlaylists() async {

    const url = "https://api.spotify.com/v1/me/playlists";

    Map<String,String> header = {
      HttpHeaders.authorizationHeader: "Bearer $_authenticationToken",
      HttpHeaders.userAgentHeader: "dio",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader:  "application/json"
    };

    var dio = Dio(BaseOptions(
        headers: header,
    ));

    Response response;

    try {
      response = await dio.get(url);
    } catch (e) {
      print(" ### Error Spotify Web Api ###");
    }

    List<PlayListDataModel> dataPlaylist = List<PlayListDataModel>();
    for(var data in response.data['items']){
      dataPlaylist.add(PlayListDataModel(
          nombre: data['name'],
          imgPath:(data['images'].last)['url'],
          uri: data['uri']
      ));
    }

    return dataPlaylist;
  }

  Future<void> connectToSpotifyRemote() async {
    try {

      var result = await SpotifySdk.connectToSpotifyRemote(
          clientId: "86282420ad5d47a799a2fb2ea2089e28", redirectUrl: "easy://callback");

      _connected.add(result);

      setStatus(result
          ? "connect to spotify successful"
          : "conntect to spotify failed");

    } catch (e) {
      setStatus(e.code, message: e.message);
    }
  }

  Future<void> skipPrevious() async {
    try {
      await SpotifySdk.skipPrevious();
    } catch (e) {
      setStatus(e.code, message: e.message);
    }
  }

  Future<void> resume() async {
    try {
      await SpotifySdk.resume();
      //isPaused
      setStopOrPlay(false);
    } catch (e) {
      setStatus(e.code, message: e.message);
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
      //isPaused
      setStopOrPlay(true);
    } catch (e) {
      setStatus(e.code, message: e.message);
    }
  }

  Future<void> skipNext() async {
    try {
      await SpotifySdk.skipNext();
    } catch (e) {
      setStatus(e.code, message: e.message);
    }
  }

  Future<void> queue() async {
    try {
      await SpotifySdk.queue(
          spotifyUri: "spotify:track:3cun7DzGeFGrJSgJgl5yQq");
    } catch (e) {
      setStatus(e.code, message: e.message);
    }
  }

  void setStopOrPlay(bool state){
    _isPaused.sink.add(state);
  }

  void setStatus(String code, {String message = ""}) {
    var text = message.isEmpty ? "" : " : $message";
    _logger.d("$code$text");
  }

  void dispose(){
    if (isLogued) {
      SpotifySdk.logout();
      isLogued = !isLogued;
    }
    //_connected.close();
    _isPaused.close();
  }

}