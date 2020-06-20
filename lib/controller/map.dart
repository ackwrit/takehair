
//import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:platform_maps_flutter/platform_maps_flutter.dart';
//import 'package:platform_maps_flutter/platform_maps_flutter.dart';





class map extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return mapState();
  }

}

class mapState extends State<map>{
  Position coords;
  Position position;
  CameraPosition cameraPosition;
  //AppleMapController mapController;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configuration();

  }










  @override
  Widget build(BuildContext context) {
    position = coords;




    // TODO: implement build
    return body();


  }



  void configuration() async {

    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      coords = position;
    });




  }


  void _onMapCreated( controller) {
    //mapController = controller;
    Future.delayed(Duration(seconds: 2)).then((_)
    {
      setState(() {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(


              target: LatLng(position.latitude, position.longitude),



              zoom: 14.3,

            ),
          ),
        );

      });

    });

  }




  Widget body()
  {

    return new Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: (coords!=null)?
              PlatformMap(
                  initialCameraPosition: CameraPosition(
                      target: LatLng(0.0, 0.0)
                  ),
                onMapCreated:(controller)
                {
                  Future.delayed(Duration(seconds: 2)).then((_)
                  {
                    setState(() {
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(


                            target: LatLng(position.latitude, position.longitude),



                            zoom: 14.3,

                          ),
                        ),
                      );

                    });

                  });
                },
                onTap: (controller){
                    setState(() {
                      configuration();
                      controller.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(
                              target: LatLng(position.latitude,position.longitude)
                          )

                        )

                      );

                    });
                },
                markers: Set<Marker>.of(
                  [
                    Marker
                      (
                      markerId: MarkerId("ici"),
                      position: LatLng(position.latitude,position.longitude),
                      infoWindow: InfoWindow(
                        title: 'Moi'
                      ),
                      onTap: (){
                        print('tapper');
                      }

                    )
                  ]
                ),
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                compassEnabled: true,


              )
          //versionMap()
              :chargement(),





        );


  }





  Widget chargement()
  {
    return Container(
      height: MediaQuery.of(context).size.height/6,
      width: MediaQuery.of(context).size.width/6,
      child: Center(
        child: CircularProgressIndicator(
        ),
      ),

    );
  }





}
















