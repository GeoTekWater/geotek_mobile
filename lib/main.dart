import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geo_tek/auth_controller.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'screens/introduction_screen/splaash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) => Get.put(AuuthController()));

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]);

  runApp(
      //Provider(
      ///  auth: AuthServices(),
      //  child:
      GetMaterialApp(
    home: const SplashScreen(),

    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: AppStyles.bgPrimary,
    ),
    // routes: <String, WidgetBuilder>{
    //   '/home':(BuildContext context)=>HomeController(),
    //   '/signUp':(BuildContext context)=>SignUpPage(authFormType: AuthFormType.signUp,),
    //   '/signIn':(BuildContext context)=>SignUpPage(authFormType: AuthFormType.signIn,),
    //   '/signInAnonymous':(BuildContext context)=>SignUpPage(authFormType: AuthFormType.anonymous),
    //   '/convertUser':(BuildContext contex)=>SignUpPage(authFormType: AuthFormType.convert),
    //   // '/table':(BuildContext contex)=>TablePro(),

    // },
  ));
}

// class HomeController extends StatelessWidget {
//   const HomeController({ Key ?key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final AuthServices auth = Provider.of(context).auth;
//     return StreamBuilder(
//         stream: auth.authStateChanges,
//         builder: (context, AsyncSnapshot<String>snapshot){
//           if(snapshot.connectionState == ConnectionState.active){
//             final bool signedIn = snapshot.hasData;
//             return signedIn? Home():First();
//           }
//           return CircularProgressIndicator();
//         });
//   }
// }


// class Provider extends InheritedWidget{
//   final AuthServices auth;
//   @override
//   Provider({ Key? key,required Widget child,required this.auth}):super(key: key, child: child);
//   bool updateShouldNotify(covariant InheritedWidget oldWidget) {
//     // TODO: implement updateShouldNotify
//     //throw UnimplementedError();
//     return true;
//   }
//   static Provider of(BuildContext context)=>(context.dependOnInheritedWidgetOfExactType<Provider>() as Provider);

// }