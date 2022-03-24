import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sih_final/commons/commons.dart';
import 'package:sih_final/screens/splash_screen.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;
import 'package:metadata/metadata.dart' as meta;

class LodgeComplaint extends StatefulWidget {
  @override
  State<LodgeComplaint> createState() => _LodgeComplaintState();
}

class _LodgeComplaintState extends State<LodgeComplaint> {
  File childPhotograph;
  File attendanceProof;
  String _selectedType;
  String globalImageUrl;
  File globalFile;
  bool hasFace;
  List<String> _typeList = ['Male', 'Female', "Can't Determine"];
  TextEditingController childNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  bool uploadingImage = false;
  Future<File> _getFromCamera() async {
    File imageFile;
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    return imageFile;
  }

  Future<bool> detectFaces(String imageURL) async {
    const url = "https://api-us.faceplusplus.com/facepp/v3/detect";
    var body = {
      "api_key": "cjk36lpa4beeXF_Ed6mCdzyGfEFN3CNf",
      "api_secret": "3D31Lo9qWyW4fL73JdlGHLBtcHRivSvY",
      "image_url": imageURL,
    };
    var response = await http.post(Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: body,
        encoding: Encoding.getByName("utf-8"));
    print(response.body);
    var parsed = jsonDecode(response.body)['face_num'];
    return parsed > 0 ? true : false;
  }

  Future<String> _getUrl(file) async {
    // String uploadedPhotoUrl;
    // var _firebaseStorage = FirebaseStorage.instance;
    // Reference _reference = _firebaseStorage
    //     .ref()
    //     .child('images');
    // await _reference
    //     .putData(
    //   await file.readAsBytes(),
    //   SettableMetadata(contentType: 'image/jpeg'),
    // )
    //     .whenComplete(() async {
    //   await _reference.getDownloadURL().then((value) {
    //     uploadedPhotoUrl = value;
    //   });
    //   return uploadedPhotoUrl;
    // });

    // String _downloadUrl;
    // final Reference storageRef = FirebaseStorage.instance.ref();
    // var _snapshot = await storageRef.child('images/').putFile(file);
    // _downloadUrl = await _snapshot.ref.getDownloadURL();
    // return _downloadUrl;

    final Reference storageReference =
        FirebaseStorage.instance.ref().child("images/${Uuid().v4()}");
    String downloadURL;

    UploadTask uploadTask = storageReference.putFile(file);

    downloadURL = await (await uploadTask).ref.getDownloadURL();
    return downloadURL;
  }

  Future<File> _getFromGallery() async {
    File imageFile;
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
    return imageFile;
  }

  Future<Map> getImageMetadata(File image) async {
    double latitude = 0;
    double longitude = 0;
    var bytes = File(image.path).readAsBytesSync();
    var result = meta.MetaData.exifData(bytes);
    if (result.error == null) {
      var content = result.exifData;
      print(content);
      if (content['gps']['GPSLatitude'] == null) {
        print('nullll value here');
        return {"latitude": 0, "longitude": 0};
      }
      var latitude_list = content['gps']['GPSLatitude'];
      var longitude_list = content['gps']['GPSLongitude'];
      double latitude = latitude_list[0] +
          (latitude_list[1] / 60) +
          (latitude_list[2] / 3600);
      double longitude = longitude_list[0] +
          (longitude_list[1] / 60) +
          (longitude_list[2] / 3600);
      print(latitude);
      print(longitude);
      return {"latitude": latitude, "longitude": longitude};
    } else {
      print('File: $image.jpg, Error: ${result.error}');
    }
    return {"latitude": latitude, "longitude": longitude};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.of(context).pop();
            }),
        title: Text('Add a complaint'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // Text(
                        //   "Add a new complaint",
                        //   style: TextStyle(
                        //     fontSize: 30,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        children: [
                          makeInput(childNameController,
                              label: "Child Name",
                              hintText: "Raj Kumar",
                              iconValue: Icons.person),
                          SizedBox(
                            height: 25,
                          ),
                          // Padding(
                          //     padding: const EdgeInsets.all(8),
                          //     child: TextFormField(
                          //         decoration: const InputDecoration(
                          //       prefixIcon: Icon(
                          //         Icons.person,
                          //         color: Colors.grey,
                          //       ),
                          //       labelText: 'Child Name',
                          //     ))),
                          // makeInput(label: ""),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Upload proof",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87),
                                ),
                                const SizedBox(height: 20),
                                Row( mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      iconSize: 50.0,

                                        onPressed: () async {
                                          attendanceProof =
                                              await _getFromCamera();
                                        },
                                        icon: Icon(Icons.camera_alt)),
                                    Text("or"),
                                    IconButton(
                                        iconSize: 50.0,
                                        onPressed: () async {
                                          uploadingImage = true;
                                          setState(() {});
                                          attendanceProof =
                                              await _getFromGallery();
                                          globalFile = attendanceProof;
                                          String imageUrl =
                                              await _getUrl(attendanceProof);
                                          globalImageUrl = imageUrl;
                                          uploadingImage = false;
                                          hasFace = await detectFaces(imageUrl);
                                          if (!hasFace) {
                                            showInSnackBar(context, 'No face');
                                          }
                                          setState(() {});
                                        },
                                        icon: Icon(Icons.file_upload_sharp)),
                                  ],
                                ),
                                // SizedBox(height: 20),
                                // const Text(
                                //   "Upload child's photograph",
                                //   textAlign: TextAlign.left,
                                //   style: TextStyle(
                                //       fontSize: 15,
                                //       fontWeight: FontWeight.w400,
                                //       color: Colors.black87),
                                // ),
                                // const SizedBox(height: 20),
                                // Row(
                                //   children: [
                                //     IconButton(
                                //         onPressed: () async {
                                //           childPhotograph =
                                //               await _getFromCamera();
                                //         },
                                //         icon: Icon(Icons.camera_alt)),
                                //     Text("or"),
                                //     IconButton(
                                //         onPressed: () async {
                                //           childPhotograph =
                                //               await _getFromGallery();
                                //         },
                                //         icon: Icon(Icons.file_upload_sharp)),
                                //   ],
                                // ),
                                // SizedBox(height: 20),
                              ]),

                          SizedBox(height: 25),
                          makeInput(mobileNumberController,
                              label: "Mobile Number",
                              hintText: '+919876543210',
                              iconValue: Icons.phone),
                          SizedBox(height: 25),
                          DropdownButton(
                            hint: Text('Please choose their gender', style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,)),
                            value: _selectedType,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedType = newValue;
                              });
                            },
                            items: _typeList.map((type) {
                              return DropdownMenuItem(
                                child: new Text(type,style: TextStyle(
                                  fontSize: 20,
                                  )),
                                value: type,
                              );
                            }).toList(),
                          ),
                          SizedBox(height: 110),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        padding: EdgeInsets.only(top: 3, left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Container(
                          height: 50.0,
                          margin: const EdgeInsets.all(10),
                          child: uploadingImage
                              ? CircularProgressIndicator()
                              : RaisedButton(
                                  onPressed: () async {
                                    // print(getImageMetadata(globalFile));
                                    print(childNameController.text);
                                    print(mobileNumberController.text);
                                    print(_selectedType);
                                    print(globalImageUrl);
                                    print(getImageMetadata(globalFile));
                                    Map locationResult =
                                        await getImageMetadata(globalFile);
                                    print(locationResult);
                                    complaintDetailsRef.add({
                                      'child_id': Uuid().v4(),
                                      'child_name': childNameController.text,
                                      'complaint_owner_id': Uuid().v4(),
                                      'complaint_owner_number':
                                          mobileNumberController.text,
                                      'location': locationResult,
                                      'child_gender': _selectedType,
                                      'image': globalImageUrl,
                                      'is_rescued': false,
                                      'is_approved': false,
                                      'created_on': DateTime.now()
                                    });
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(80.0)),
                                  padding: const EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xff374ABE),
                                            Color(0xff64B6FF)
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0)),
                                    child: Container(
                                      constraints: BoxConstraints(
                                          maxWidth: 250.0, minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Submit",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget makeInput(TextEditingController controller,
    {label, hintText, iconValue, obsureText = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold, color: Colors.black87),
      ),
      SizedBox(
        height: 30,
      ),
      Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 2),
                ),
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              obscureText: obsureText,
              controller: controller,
              decoration: InputDecoration(
                icon: Icon(iconValue),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                hintText: hintText,
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.grey[400],
                //   ),
                // ),
                border: InputBorder.none,
              ),
            ),
          )),
      SizedBox(
        height: 30,
      )
    ],
  );
}
