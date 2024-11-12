class Log {
  final String? id;
  final String idUsuario;
  final String emailUsuarioLogado;
  final DateTime dataSessao;
  final int vezesLogadoHoje;

  Log({
    this.id,
    required this.idUsuario,
    required this.emailUsuarioLogado,
    required this.dataSessao,
    required this.vezesLogadoHoje,
  });

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      id: json['id'],
      idUsuario: json['idUsuario'],
      emailUsuarioLogado: json['emailUsuarioLogado'],
      dataSessao: DateTime.parse(json['dataSessao']),
      vezesLogadoHoje: json['vezesLogadoHoje'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUsuario': idUsuario,
      'emailUsuarioLogado': emailUsuarioLogado,
      'dataSessao': dataSessao.toIso8601String(),
      'vezesLogadoHoje': vezesLogadoHoje,
    };
  }
}