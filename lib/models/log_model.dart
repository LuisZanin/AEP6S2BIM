class Log {
  final String id;
  final String idUsuario;
  final String emailUsuarioLogado;
  final DateTime dataSessao;

  Log({
    String? id,  
    required this.idUsuario,
    required this.emailUsuarioLogado,
    required this.dataSessao,
  }) : id = id ?? _generateId(); 

  static String _generateId() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = timestamp.toString().substring(7);
    return random;
  }

  factory Log.fromJson(Map<String, dynamic> json) {
    return Log(
      id: json['id'],
      idUsuario: json['idUsuario'],
      emailUsuarioLogado: json['emailUsuarioLogado'],
      dataSessao: DateTime.parse(json['dataSessao']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idUsuario': idUsuario,
      'emailUsuarioLogado': emailUsuarioLogado,
      'dataSessao': dataSessao.toIso8601String(),
    };
  }
}