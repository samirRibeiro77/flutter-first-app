import 'package:flutter/material.dart';
import 'package:flutter_ai_toolkit/flutter_ai_toolkit.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:sjr77_first_project/medicalGemini/chat_config.dart';
import 'package:sjr77_first_project/medicalGemini/keys.dart';

class MedicalChat extends StatelessWidget {
  const MedicalChat({super.key});

  final appName = "Gemini médico";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: LlmChatView(
          suggestions: MedicalChatConfigs.suggestions,
          style: LlmChatViewStyle(
            chatInputStyle: ChatInputStyle(
              hintText: MedicalChatConfigs.messageHint,
              decoration: const BoxDecoration().copyWith(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
          provider: GeminiProvider(
            model: GenerativeModel(
              model: MedicalChatConfigs.geminiModel,
              apiKey: ApiKeys.gemini,
              systemInstruction: Content.system(MedicalChatConfigs.systemInstruction),
            ),
          ),
          welcomeMessage: MedicalChatConfigs.welcomeMessage
      ),
    );
  }
}
