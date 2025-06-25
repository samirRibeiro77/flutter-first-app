import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sjr77_first_project/alcoolGasolina/main.dart';
import 'package:sjr77_first_project/appAbas/main.dart';
import 'package:sjr77_first_project/database/main.dart';
import 'package:sjr77_first_project/executaMidia/main.dart';
import 'package:sjr77_first_project/imagePicker/main.dart';
import 'package:sjr77_first_project/jokenpo/main.dart';
import 'package:sjr77_first_project/lista/main.dart';
import 'package:sjr77_first_project/maps/main.dart';
import 'package:sjr77_first_project/medicalGemini/main.dart';
import 'package:sjr77_first_project/multipleScreens/first.dart';
import 'package:sjr77_first_project/precoBitcoin/main.dart';
import 'package:sjr77_first_project/sharedPreferences/main.dart';
import 'package:sjr77_first_project/testingWidgets/main.dart';
import 'package:sjr77_first_project/frasesDoDia/main.dart';
import 'package:sjr77_first_project/videoPlayer/main.dart';
import 'package:sjr77_first_project/webService/main.dart';

import 'firebase/main.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //runApp(const FrasesDoDia());
  //runApp(const Jokenpo());
  //runApp(const AlcoolGasolina());
  //runApp(const TestingWidgetsApp());
  //runApp(const MultipleScreens());
  // runApp(const WebServices());
  // runApp(const PrecoBitcoin());
  // runApp(const AppLista());
  // runApp(const SharedPrefs());
  // runApp(const AppDatabase());
  // runApp(const ExecMedia());
  // runApp(const AppAbas());
  // runApp(const AppVideoPlayer());
  // runApp(const AppFirebase());
  // runApp(const AppImagePicker());
  runApp(const AppMaps());

  // runApp(const MedicalChat());
}