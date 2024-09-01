import 'package:flutter/material.dart';
import '../../domain/entities/employee_relatives_api.dart';
import '../../domain/entities/user.dart';



var scaffoldKey = GlobalKey<ScaffoldState>();
var homeKey = GlobalKey();

const appBarsTextStyle = TextStyle(
  color: Colors.white,
);


User? userData;
int? languageId=1;
String? accessToken;
String? refreshToken;
Map<String,String>?env;
int? userNumber;
bool isOffline=false;
String? medicationRequestId;
int userUnSeenNotificationCount=0;
int? pendingRequestMedicalCount;
int? pendingRequestsCountMore4u;
int? relativeCount;
String? medicalCoverage;
EmployeeRelativeApi? currentEmployeeConstants;
List<String>? recentlySearchOurPartners=[];



enum MedicalRequestTypes {  medication ,  checkup, sickLeave}