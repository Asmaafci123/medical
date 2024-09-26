import 'package:more4u/domain/entities/medical_item.dart';

class MedicalItemModel extends MedicalItem {
  const MedicalItemModel(
      {required String? itemId,
      required String? itemName,
      required String? itemType,
      required String? itemQuantity,
      required String? itemDateFrom,
      required String? itemDateTo,
      required String? itemImage,
      required String? itemDose})
      : super(
            itemId: itemId,
            itemName: itemName,
            itemType: itemType,
            itemQuantity: itemQuantity,
            itemDateFrom: itemDateFrom,
            itemDateTo: itemDateTo,
            itemImage: itemImage,
      itemDose:itemDose);
  factory MedicalItemModel.fromJson(Map<String, dynamic> json) {
    return MedicalItemModel(
        itemId: json['itemId'],
        itemName: json['itemName'],
        itemType: json['itemType'],
        itemQuantity: json['itemQuantity'],
        itemDateFrom: json['itemDateFrom'],
        itemDateTo: json['itemDateTo'],
        itemImage: json['itemImage'],
        itemDose:json['itemDose']);
  }
}
