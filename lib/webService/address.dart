class Address {
  late String cep, logradouro, complemento, bairro, cidade, uf;

  Address(Map<String, dynamic> json) {
    cep = json["cep"];
    logradouro = json["logradouro"];
    complemento = json["complemento"];
    bairro = json["bairro"];
    cidade = json["localidade"];
    uf = json["uf"];
  }

  @override
  String toString() {
    return "${this.logradouro}, ${this.complemento}, ${this.bairro}, ${this.cidade} - ${this.uf}";
  }
}