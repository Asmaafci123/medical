import 'package:equatable/equatable.dart';
import 'package:more4u/domain/entities/medical_item.dart';

class SearchMedicalItemsResponse extends  Equatable{
  final bool flag;
  final String message;
  final List<MedicalItem> items;

  const SearchMedicalItemsResponse({
    required this.flag,
    required this.message,
    required this.items,
  });

  @override
  List<Object?> get props => [
    flag,
    message,
    items
  ];
}
