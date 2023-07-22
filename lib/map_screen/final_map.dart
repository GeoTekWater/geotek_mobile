// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:permission_handler/permission_handler.dart';



// class GoogleMapScreen extends StatefulWidget {
//   const GoogleMapScreen({ Key?  key }) : super(key: key);

//   @override
//   _GoogleMapScreenState createState() => _GoogleMapScreenState();
// }


// class _GoogleMapScreenState extends State<GoogleMapScreen> {

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

  

//   @override
//   Widget build(BuildContext context) {
//     //final applicationBloc = Provider.of<ApplicationBloc>(context);
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.grey[700],
//         title:const Text('Where Am I???', style: TextStyle(color: Colors.white),),
//         ),

//       body: 
//     ListView(
//         children: [

//           Container(
//             height: 500,
//             child: const GoogleMap(
//             myLocationEnabled: true,
//             mapType: MapType.satellite,
//             // onMapCreated: onMapCreated,
//             // markers: _marker,
//             initialCameraPosition: CameraPosition(
//               target: LatLng(9.92849,8.89212),
//               zoom: 15,
//               )
//         ),
//           ),
//         ], 
//       )
//     );
//   }
// }