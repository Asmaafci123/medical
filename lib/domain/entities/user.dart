import 'package:equatable/equatable.dart';
import 'package:more4u/domain/entities/relative.dart';

class User extends Equatable {
  final String? userName;
  final String? email;
  final int userNumber;
  final String? positionName;
  final String? departmentName;
  final String birthDate;
  final String joinDate;
  final String? gender;
  final String? maritalStatus;
  final String? entity;
  final String? nationality;
  final String? phoneNumber;
  final String? address;
  final String? collar;
  final int? sapNumber;
  final String? id;
  final String? supervisorName;
  final String? profilePictureAPI;
  final String? workDuration;
  final bool? hasRequests;
  final int? pendingRequestsCount;
  final bool? isTheGroupCreator;
  final bool? isAdmin;
  final bool? hasRoles;
  final bool? isMedicalAdmin;
  final bool? isDoctor;
  final bool? hasMedicalService;
  final bool? hasMore4uService;
  final String? country;
 final List<Relative>?relatives;

  const User(
      {this.userName,
      this.email,
      required this.userNumber,
      this.positionName,
      this.departmentName,
      required this.birthDate,
      required this.joinDate,
      this.gender,
      this.maritalStatus,
      this.entity,
      this.nationality,
      this.phoneNumber,
      this.address,
      this.collar,
      this.sapNumber,
      this.id,
      this.supervisorName,
      this.profilePictureAPI,
      this.workDuration,
      this.hasRequests,
      this.pendingRequestsCount,
      this.isTheGroupCreator,
      this.isAdmin,
      this.hasRoles,
      this.country,
      this.hasMedicalService,
      this.isDoctor,
      this.isMedicalAdmin,
        this.relatives,
        this.hasMore4uService
      });

  @override
  List<Object?> get props => [
        userName,
        email,
        userNumber,
        positionName,
        departmentName,
        birthDate,
        joinDate,
        gender,
        maritalStatus,
        entity,
        nationality,
        phoneNumber,
        address,
        collar,
        sapNumber,
        id,
        supervisorName,
        profilePictureAPI,
        workDuration,
        hasRequests,
        pendingRequestsCount,
        isTheGroupCreator,
        isAdmin,
        hasRoles,
        country,
        hasMedicalService,
        isDoctor,
        isMedicalAdmin,
    relatives,
    hasMore4uService
      ];
}
