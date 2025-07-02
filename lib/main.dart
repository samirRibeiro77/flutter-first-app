import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sjr77_first_project/alcoolGasolina/main.dart';
import 'package:sjr77_first_project/appAbas/main.dart';
import 'package:sjr77_first_project/database/main.dart';
import 'package:sjr77_first_project/devicePixelRatio/main.dart';
import 'package:sjr77_first_project/executaMidia/main.dart';
import 'package:sjr77_first_project/imagePicker/main.dart';
import 'package:sjr77_first_project/jokenpo/main.dart';
import 'package:sjr77_first_project/lista/main.dart';
import 'package:sjr77_first_project/maps/main.dart';
import 'package:sjr77_first_project/medicalGemini/main.dart';
import 'package:sjr77_first_project/multipleScreens/first.dart';
import 'package:sjr77_first_project/my_apps.dart';
import 'package:sjr77_first_project/precoBitcoin/main.dart';
import 'package:sjr77_first_project/sharedPreferences/main.dart';
import 'package:sjr77_first_project/testingWidgets/main.dart';
import 'package:sjr77_first_project/frasesDoDia/main.dart';
import 'package:sjr77_first_project/videoPlayer/main.dart';
import 'package:sjr77_first_project/webService/main.dart';

import 'firebase/main.dart';
import 'firebase_options.dart';

void main() async {
  final appToRunName = MyApps.devicePixelRatio;

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  switch (appToRunName) {
    case MyApps.fraseDoDia:
      runApp(const FrasesDoDia());
      break;
    case MyApps.jokenpo:
      runApp(const Jokenpo());
      break;
    case MyApps.alcoolOuGasolina:
      runApp(const AlcoolGasolina());
      break;
    case MyApps.testWidgets:
      runApp(const TestingWidgetsApp());
      break;
    case MyApps.multipleScreens:
      runApp(const MultipleScreens());
      break;
    case MyApps.webService:
      runApp(const WebServices());
      break;
    case MyApps.precoDoBitcoin:
      runApp(const PrecoBitcoin());
      break;
    case MyApps.listaDePostagens:
      runApp(const AppLista());
      break;
    case MyApps.sharedPreferences:
      runApp(const SharedPrefs());
      break;
    case MyApps.appSQLiteDatabase:
      runApp(const AppDatabase());
      break;
    case MyApps.executandoMidia:
      runApp(const ExecMedia());
      break;
    case MyApps.abas:
      runApp(const AppAbas());
      break;
    case MyApps.videoPlayer:
      runApp(const AppVideoPlayer());
      break;
    case MyApps.firebase:
      runApp(const AppFirebase());
      break;
    case MyApps.imagePicker:
      runApp(const AppImagePicker());
      break;
    case MyApps.maps:
      runApp(const AppMaps());
      break;
    case MyApps.devicePixelRatio:
      runApp(const DevicePixelRatioApp());
      break;

    // Extra app with Gemini
    case MyApps.chatMedicoGemini:
      runApp(const MedicalChat());
      break;
  }
}