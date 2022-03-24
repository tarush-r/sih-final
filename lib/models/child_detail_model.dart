import 'package:cloud_firestore/cloud_firestore.dart';

class ChildDetailModel {
  String childId;
  String childName;
  String schoolId;
  String guardianName;
  String imageUrl;
  int age;
  String childAddress;
  DateTime createdOn;

  ChildDetailModel({
    this.childId,
    this.childName,
    this.schoolId,
    this.guardianName,
    this.imageUrl,
    this.age,
    this.childAddress,
    this.createdOn,
  });

  factory ChildDetailModel.fromDocument(DocumentSnapshot doc) {
    return ChildDetailModel(
      childId: doc['child_id'],
      childName: doc['child_name'],
      schoolId: doc['school_id'],
      guardianName: doc['guardian_name'],
      imageUrl: doc['image_url'],
      age: doc['age'],
      childAddress: doc['child_address'],
      createdOn: doc['created_on'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['child_id'] = this.childId;
    data['child_name'] = this.childName;
    data['school_id'] = this.schoolId;
    data['guardian_name'] = this.guardianName;
    data['image_url'] = this.imageUrl;
    data['age'] = this.age;
    data['child_address'] = this.childAddress;
    data['created_on'] = this.createdOn;
    return data;
  }
}
