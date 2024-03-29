import 'package:flutter/material.dart';
import 'package:geo_tek/config/app_config.dart';
import 'package:geo_tek/screens/auth/authentication_screen.dart';
import 'package:geo_tek/screens/introduction_screen/splash_screen1.dart';
import 'package:geo_tek/screens/introduction_screen/splash_screen2.dart';
import 'package:get/get.dart';

import 'screens/introduction_screen/splaash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
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