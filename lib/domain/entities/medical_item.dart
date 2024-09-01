import 'package:equatable/equatable.dart';

class MedicalItem extends Equatable {
  final String? itemId;
  final String? itemName;
  final String? itemType;
  final String? itemQuantity;
  final String? itemDateFrom;
  final String? itemDateTo;
  final String? itemImage;

  const MedicalItem({
    required this.itemId,
    required this.itemName,
    required this.itemType,
    required this.itemQuantity,
    required this.itemDateFrom,
    required this.itemDateTo,
    required this.itemImage
  });

  @override
  List<Object?> get props => [
        itemId,
        itemName,
        itemType,
        itemQuantity,
        itemDateFrom,
        itemDateTo,
    itemImage
      ];
}
