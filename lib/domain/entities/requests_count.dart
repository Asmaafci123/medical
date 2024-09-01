import 'package:equatable/equatable.dart';

class RequestsCount extends Equatable {
  final String  medications ;
  final String  checkups ;
  final String  sickleave;
  final String  totalRequest ;


  const  RequestsCount ({
    required this.medications,
    required this.checkups,
    required this.sickleave,
    required this.totalRequest,

  });

  @override
  List<Object?> get props => [
    medications,
    checkups,
    sickleave,
    totalRequest,
  ];
}
