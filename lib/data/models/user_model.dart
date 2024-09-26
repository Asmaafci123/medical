import 'package:more4u/data/models/relative_model.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {userName,
      email,
      required userNumber,
      positionName,
      departmentName,
      required birthDate,
      required joinDate,
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
      isMedicalAdmin,
      isDoctor,
      hasMedicalService,
      country,
          relatives,
          hasMore4uService
      })
      : super(
            userName: userName,
            email: email,
            userNumber: userNumber,
            positionName: positionName,
            departmentName: departmentName,
            birthDate: birthDate,
            joinDate: joinDate,
            gender: gender,
            maritalStatus: maritalStatus,
            entity: entity,
            nationality: nationality,
            phoneNumber: phoneNumber,
            address: address,
            collar: collar,
            sapNumber: sapNumber,
            id: id,
            supervisorName: supervisorName,
            profilePictureAPI: profilePictureAPI,
            workDuration: workDuration,
            hasRequests: hasRequests,
            pendingRequestsCount: pendingRequestsCount,
            isTheGroupCreator: isTheGroupCreator,
            isAdmin: isAdmin,
            hasRoles: hasRoles,
            isMedicalAdmin: isMedicalAdmin,
            isDoctor: isDoctor,
            hasMedicalService: hasMedicalService,
            country: country,
      relatives:relatives,
      hasMore4uService:hasMore4uService
  );
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
       userName: json['userName'],
       email: json['email'],
       userNumber: json['userNumber'],
       positionName: json['positionName'],
       departmentName: json['departmentName'],
       birthDate: json['birthDate'],
       joinDate: json['joinDate'],
       gender: json['gender'],
       maritalStatus: json['maritalStatus'],
        entity: json['entity'],
        nationality: json['nationality'],
        phoneNumber: json['phoneNumber'],
        address: json['address'],
        collar: json['collar'],
        sapNumber: json['sapNumber'],
        id: json['id'],
        supervisorName: json['supervisorName'],
        profilePictureAPI: json['profilePictureAPI'],
        workDuration: json['workDuration'],
        hasRequests: json['hasRequests'],
        pendingRequestsCount: json['pendingRequestsCount'],
        isTheGroupCreator: json['isTheGroupCreator'],
        isAdmin: json['isAdmin'],
        hasRoles: json['hasRoles'],
       isMedicalAdmin: json['isMedicalAdmin'],
       isDoctor: json['isDoctor'],
       hasMedicalService: json['hasMedicalService'],
        hasMore4uService: json['hasMore4uService'],
        country: json['country'],
        relatives:json['relatives']!=null?List<RelativeModel>.from(json['relatives']
            .map((x) => RelativeModel.fromJson(x))
            .toList()):null
    );
  }
}
