import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceModel {
  String childId;
  String schoolId;
  DateTime createdOn;
  DateTime startDate;
  DateTime endDate;
  int workingDays;
  int absentDays;
  String photoUrl;
  String proofUrl;

  AttendanceModel({
    this.childId,
    this.schoolId,
    this.createdOn,
    this.startDate,
    this.endDate,
    this.workingDays,
    this.absentDays,
    this.photoUrl,
    this.proofUrl,
  });

  factory AttendanceModel.fromDocument(DocumentSnapshot doc) {
    return AttendanceModel(
      childId: doc['child_id'],
      schoolId: doc['school_id'],
      createdOn: doc['created_on'].toDate(),
      startDate: doc['start_date'].toDate(),
      endDate: doc['end_date'].toDate(),
      workingDays: doc['working_days'],
      absentDays: doc['absent_days'],
      photoUrl: doc['photo_url'],
      proofUrl: doc['proof_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['school_id'] = this.schoolId;
    data['created_on'] = this.createdOn;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['working_days'] = this.workingDays;
    data['absent_days'] = this.absentDays;
    data['photo_url'] = this.photoUrl;
    data['proof_url'] = this.proofUrl;
    return data;
  }
}
