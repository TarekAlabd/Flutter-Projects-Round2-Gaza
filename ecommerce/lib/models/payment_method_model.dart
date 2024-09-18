import 'dart:convert';

class PaymentMethod {
  final String id;
  final String imgUrl;
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final bool isChosen;
  final String cvv;

  const PaymentMethod({
    required this.id,
    required this.imgUrl,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    this.isChosen = false,
    required this.cvv,
  });

  PaymentMethod copyWith({
    String? id,
    String? imgUrl,
    String? cardNumber,
    String? cardHolderName,
    String? expiryDate,
    bool? isChosen,
    String? cvv,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      imgUrl: imgUrl ?? this.imgUrl,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      expiryDate: expiryDate ?? this.expiryDate,
      isChosen: isChosen ?? this.isChosen,
      cvv: cvv ?? this.cvv,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'id': id});
    result.addAll({'imgUrl': imgUrl});
    result.addAll({'cardNumber': cardNumber});
    result.addAll({'cardHolderName': cardHolderName});
    result.addAll({'expiryDate': expiryDate});
    result.addAll({'isChosen': isChosen});
    result.addAll({'cvv': cvv});
  
    return result;
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] ?? '',
      imgUrl: map['imgUrl'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      cardHolderName: map['cardHolderName'] ?? '',
      expiryDate: map['expiryDate'] ?? '',
      isChosen: map['isChosen'] ?? false,
      cvv: map['cvv'] ?? '',
    );
  }
}
