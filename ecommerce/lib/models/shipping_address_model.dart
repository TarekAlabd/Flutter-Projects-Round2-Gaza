class ShippingAddress {
  final String id;
  final String imgUrl;
  final String city;
  final String country;
  final bool isChosen;

  const ShippingAddress({
    required this.id,
    required this.imgUrl,
    required this.city,
    required this.country,
    this.isChosen = false,
  });

  ShippingAddress copyWith({
    String? id,
    String? imgUrl,
    String? city,
    String? country,
    bool? isChosen,
  }) {
    return ShippingAddress(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      city: city ?? this.city,
      country: country ?? this.country,
      isChosen: isChosen ?? this.isChosen,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'city': city});
    result.addAll({'country': country});
    result.addAll({'isChosen': isChosen});

    return result;
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      id: map['id'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      city: map['city'] ?? '',
      isChosen: map['isChosen'] ?? '',
      country: map['country'] ?? '',
    );
  }
}
