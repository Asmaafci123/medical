import 'dart:io';

import 'package:equatable/equatable.dart';

class RequestMedication extends Equatable {
  final String? createdBy;
  final int? requestedBy;
  final int? requestedFor;
  final int? requestType;
  final DateTime? requestDate;
  final bool? monthlyMedication;
  final List<File>? attachment;
  final bool? selfRequest;
  final String? comment;
  final int? placeId;
  final String? reason;
  const RequestMedication({
    this.createdBy,
    this.requestedBy,
    this.requestedFor,
    this.requestType,
    this.requestDate,
    this.monthlyMedication,
    this.attachment,
    this.selfRequest,
    this.comment,
    this.placeId,
    this.reason,
  });

  @override
  List<Object?> get props => [
        createdBy,
        requestedBy,
        requestedFor,
        requestType,
        requestDate,
        monthlyMedication,
        attachment,
        selfRequest,
        comment,
        placeId,
        reason,
      ];
}
