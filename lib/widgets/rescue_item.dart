import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sih_final/screens/splash_screen.dart';
import 'package:uuid/uuid.dart';

class RescueItem extends StatelessWidget {
  final String childName;
  final bool isApproved;
  final String imageUrl;
  final String docId;
  final String childId;
  final String schoolId;

  RescueItem({
    this.childName,
    this.isApproved,
    this.imageUrl,
    this.docId,
    this.childId,
    this.schoolId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Text(childName),
          Expanded(child: Container()),
          GestureDetector(
            onTap: () {
              _showMyDialog(context);
              // complaintDetailsRef.doc(docId).update({
              //   'is_approved': true,
              // });
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  Text(
                    'Rescue',
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<File> _getFromGallery() async {
    File imageFile;
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      // setState(() {
      imageFile = File(pickedFile.path);
      // });
    }
    return imageFile;
  }

  Future<String> _getUrl(file) async {
    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${Uuid().v4()}");
    String downloadURL;

    UploadTask uploadTask = storageReference.putFile(file);

    downloadURL = await (await uploadTask).ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> _showMyDialog(context) async {
    bool isLoading = false;
    TextEditingController childNameController = TextEditingController();
    TextEditingController guardianNameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rescue Child'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormField(
                  controller: childNameController,
                  decoration: InputDecoration(
                    hintText: 'Child Name',
                  ),
                ),
                TextFormField(
                  controller: guardianNameController,
                  decoration: InputDecoration(
                    hintText: 'Guardian Name',
                  ),
                ),
                TextFormField(
                  controller: ageController,
                  decoration: InputDecoration(
                    hintText: 'Age',
                  ),
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(
                    hintText: 'Address',
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    isLoading = true;
                    (context as Element).markNeedsBuild();
                    File attendanceProof = await _getFromGallery();
                    // globalFile = attendanceProof;
                    String imageUrl = await _getUrl(attendanceProof);
                    isLoading = false;
                    (context as Element).markNeedsBuild();
                    // globalImageUrl = imageUrl;
                    // uploadingImage = false;
                  },
                  child: isLoading
                      ? CircularProgressIndicator()
                      : Icon(Icons.upload),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                childDetailsRef.add({
                  'child_id': childId,
                  'child_name': childName,
                  'age': ageController.text,
                  'school_id': '12345',
                  'guardian_name': guardianNameController.text,
                  'image_url': imageUrl,
                  'child_address': addressController.text,
                  'created_on': DateTime.now()  
                });
                complaintDetailsRef.doc(docId).update({
                  'is_rescued': true,
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
