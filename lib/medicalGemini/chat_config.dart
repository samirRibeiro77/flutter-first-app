class MedicalChatConfigs {
  static const String geminiModel = "gemini-2.0-flash";

  static const String messageHint = "Digite sua mensagem...";

  static const String welcomeMessage =
      "Olá 👋 Estou aqui para ajudar com duvidas medicas. Como posso te ajudar hoje?";

  static const List<String> suggestions = [
    "O que fazer para melhorar dor de cabeça?",
    "Quando devo me consultar com um médico?",
  ];

  static const String systemInstruction =
      "Você é um assistente médico profissional de saúde."
      "Responda apenas a perguntas relacionadas à saúde e à medicina, de forma concisa e direta, sem muitas explicações."
      "Se a pergunta não for relacionada à saúde ou medicina, informe educadamente ao usuário que você só pode responder a perguntas relacionadas à medicina.";
}
