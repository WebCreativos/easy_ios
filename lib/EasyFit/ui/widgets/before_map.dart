import 'package:easygymclub/EasyFit/bloc/contador_google_maps_bloc.dart';
import 'package:easygymclub/Maps/ui/screens/google_maps.dart';
import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:location/location.dart';
import 'package:transparent_image/transparent_image.dart';

class BeforeMap extends StatefulWidget {

  _BeforeMapState createState() => _BeforeMapState();
}



class _BeforeMapState extends State<BeforeMap> {
  Widget build(BuildContext context) {

    return StreamBuilder<bool>(
      stream: BlocProvider
          .of<ContadorGoogleMapsBloc>(context)
          .startMap,
      initialData: false,
      builder: (context, snap) {
        bool startMap = snap.data;
        if (startMap) {
          return GoogleMaps();
        }
        return ImageMap();
      },
    );
  }
}

class ImageMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<LocationData>(
      future: _locationUser(),
      builder: (context, snap) {
        if (!snap.hasData || snap.hasError) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        LocationData userLocation = snap.data;
        double h = (MediaQuery.of(context).size.height -
                (Scaffold.of(context).appBarMaxHeight)) /
            2;
        double w = MediaQuery.of(context).size.width;
        String url =
            "https://api.mapbox.com/v4/mapbox.emerald/${userLocation.longitude},${userLocation.latitude},16/${w.round()}x${h.round() + 10}@2x.png?access_token=pk.eyJ1IjoiZHJvbGVnYyIsImEiOiJjazk2OHk4Y3IwdGs1M2hwM2w1cXJ1NmFxIn0.gCK3KirTodscAZeXIVOvMQ";

        return Stack(
          children: < Widget > [
            FadeInImage.memoryNetwork(
            height: double.infinity,
            width: double.infinity,
            fadeInDuration: const Duration(milliseconds: 500),
              placeholder: kTransparentImage,
              image: url), 
              Container(
                color:Colors.black54, 
                height:double.infinity, 
                width:double.infinity  
              ),
              Center( 
                child:Text("Para iniciar presiona start", style: TextStyle(color: Colors.white,fontStyle: FontStyle.italic,fontSize: 25),) ,
              )
              
          ]
        );
      },
    );
  }

  Future<LocationData> _locationUser() async {
    Location location = Location();
    return await location.getLocation();
  }
}
