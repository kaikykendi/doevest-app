class Roupa {
  int? id;
  String tipo;
  String descricao;
  String tamanho;
  String condicao;

  Roupa({
    this.id,
    required this.tipo,
    required this.descricao,
    required this.tamanho,
    required this.condicao,
  });

  // Converter objeto para map (salvar no banco)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'descricao': descricao,
      'tamanho': tamanho,
      'condicao': condicao,
    };
  }

  // Converter map do banco para objeto (listar roupas)
  factory Roupa.fromMap(Map<String, dynamic> map) {
    return Roupa(
      id: map['id'],
      tipo: map['tipo'],
      descricao: map['descricao'],
      tamanho: map['tamanho'],
      condicao: map['condicao'],
    );
  }
}
