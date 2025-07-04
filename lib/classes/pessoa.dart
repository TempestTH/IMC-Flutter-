class Pessoa {
  String _nome = "";
  double _altura = 0.0;
  double _peso = 0;

  void setNome(String nome) {
    _nome = nome;
  }

  void setAltura(double altura) {
    _altura = altura;
  }

  void setPeso(double peso) {
    _peso = peso;
  }

  double getPeso() {
    return _peso;
  }

  double getAltura() {
    return _altura;
  }

  String getNome() {
    return _nome;
  }
}
