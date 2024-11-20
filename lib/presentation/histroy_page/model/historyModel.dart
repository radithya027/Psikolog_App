class HistoryItem {
  final int id;
  final int? bukuId;
  final int? paketId;
  final int? voucherId;
  final String name;
  final String detailedAddress;
  final String phoneNumber;
  final int totalPrice;
  final String status;
  final String? postalCode;
  final String? note;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;

  HistoryItem({
    required this.id,
    this.bukuId,
    this.paketId,
    this.voucherId,
    required this.name,
    required this.detailedAddress,
    required this.phoneNumber,
    required this.totalPrice,
    required this.status,
    this.postalCode,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory HistoryItem.fromJson(Map<String, dynamic> json) {
    return HistoryItem(
      id: json['id'],
      bukuId: json['buku_id'], // This can be null, so it's handled as an int?
      paketId: json['paket_id'], // This can be null, so it's handled as an int?
      voucherId:
          json['voucher_id'], // This can be null, so it's handled as an int?
      name: json['name'],
      detailedAddress: json['detailed_address'],
      phoneNumber: json['phone_number'],
      totalPrice: json['total_price'],
      status: json['status'],
      postalCode: json['postal_code'],
      note: json['note'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      address: json['address'],
    );
  }
}
