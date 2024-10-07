import 'package:more4u/data/models/medical_item_model.dart';

import '../../../domain/entities/medical_item.dart';
import '../../../domain/entities/response/search_medical_items_response.dart';

class  SearchMedicalItemsModelResponse extends  SearchMedicalItemsResponse{
  const  SearchMedicalItemsModelResponse({
    required bool flag,
    required String message,
    required List<MedicalItem> items,
  }) : super(
    flag: flag,
    message: message,
    items: items,
  );

  factory SearchMedicalItemsModelResponse.fromJson(Map<String, dynamic> json) {
    return  SearchMedicalItemsModelResponse(
      flag: json['flag'],
      message: json['message'],
      items: List<MedicalItem>.from(
          json['data'].map((x) =>MedicalItemModel.fromJson(x)).toList()),
    );
  }
}
