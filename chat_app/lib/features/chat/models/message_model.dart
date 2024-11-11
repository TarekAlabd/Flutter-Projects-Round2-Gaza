class MessageModel {
  final String id;
  final String message;
  final String senderId;
  final String senderName;
  final String senderPhotoUrl;
  final DateTime dateTime;
  final bool isMine;

  const MessageModel({
    required this.id,
    required this.message,
    required this.senderId,
    required this.senderName,
    required this.senderPhotoUrl,
    required this.dateTime,
    this.isMine = false,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'message': message});
    result.addAll({'senderId': senderId});
    result.addAll({'senderName': senderName});
    result.addAll({'senderPhotoUrl': senderPhotoUrl});
    result.addAll({'dateTime': dateTime.millisecondsSinceEpoch});

    return result;
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? '',
      message: map['message'] ?? '',
      senderId: map['senderId'] ?? '',
      senderName: map['senderName'] ?? '',
      senderPhotoUrl: map['senderPhotoUrl'] ?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }

  MessageModel copyWith({
    String? id,
    String? message,
    String? senderId,
    String? senderName,
    String? senderPhotoUrl,
    DateTime? dateTime,
    bool? isMine,
  }) {
    return MessageModel(
      id: id ?? this.id,
      message: message ?? this.message,
      senderId: senderId ?? this.senderId,
      senderName: senderName ?? this.senderName,
      senderPhotoUrl: senderPhotoUrl ?? this.senderPhotoUrl,
      dateTime: dateTime ?? this.dateTime,
      isMine: isMine ?? this.isMine,
    );
  }
}
