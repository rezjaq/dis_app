class Account {
  final String id;
  final String bank;
  final String name;
  final String number;

  Account({
    required this.id,
    required this.bank,
    required this.name,
    required this.number,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bank': bank,
      'name': name,
      'number': number,
    };
  }

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      bank: json['bank'],
      name: json['name'],
      number: json['number'],
    );
  }
}