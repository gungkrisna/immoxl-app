import 'dart:io';

import 'package:IMMOXL/components/maps/src/widget/setUserLocation.dart';
import 'package:IMMOXL/services/services.dart';
import 'package:IMMOXL/theme/styles.dart';
import 'package:IMMOXL/all_translations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  File avatar;
  String avatarURL;
  bool isEmailValid = false;
  bool isAgent = false;
  DocumentReference userRef;

  Future getLocationWithNominatim() async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return SetUserLocation(
            searchHint: 'Search',
            customMarkerIcon: Icon(
              Icons.place,
              color: IMMOXLTheme.purple,
              size: 30,
            ),
          );
        });
    return;
  }

  @override
  void initState() {
    super.initState();
    _getUserDoc();
  }

  Future<void> _getUserDoc() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;

    FirebaseUser user = await _auth.currentUser();
    setState(() {
      userRef = _firestore.collection('users').document(user.uid);
    });
  }

  Future pickCamera() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 40);
    setState(() {
      avatar = image;
    });
    uploadFile();
  }

  Future pickPhotos() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 40);
    setState(() {
      avatar = image;
    });
    uploadFile();
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('avatar/${Path.basename(avatar.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(avatar);
    await uploadTask.onComplete;
    storageReference.getDownloadURL().then((fileURL) {
      _updateUserAvatar(avatar: fileURL, context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userRef == null)
      return Center(
        child: Container(
            width: 50,
            height: 50,
            margin: EdgeInsets.only(top: 40, bottom: 30),
            child: SpinKitPulse(
              color: IMMOXLTheme.purple,
            )),
      );
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.arrow_back, color: Colors.black)),
              actions: <Widget>[
                GestureDetector(
                  onTap: () async {
                    _updateProfile(
                      name: nameController.text,
                      phonenumber: phoneNumberController.text,
                      website: websiteController.text,
                      context: context,
                    );
                  },
                  child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          fontFamily: 'PTSans',
                        ),
                      )),
                ),
                SizedBox(
                  width: 16,
                ),
              ],
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  fontFamily: 'PTSans',
                ),
              ),
              centerTitle: true,
              backgroundColor: IMMOXLTheme.lightgrey,
            ),
            body: StreamBuilder(
                stream: userRef.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null)
                    return Center(
                      child: Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.only(top: 40, bottom: 30),
                          child: SpinKitPulse(
                            color: IMMOXLTheme.purple,
                          )),
                    );
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Center(
                                  child: GestureDetector(
                                    onTap: () => _updateAvatar(context),
                                    child: Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: avatar != null
                                              ? FileImage(avatar)
                                              : snapshot.data['avatar'] != null
                                                  ? NetworkImage(
                                                      snapshot.data['avatar'])
                                                  : AssetImage(
                                                      "assets/images/avatar.png"),
                                        ),
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                Colors.black.withOpacity(0.6)),
                                        child: Center(
                                          child: Icon(Icons.photo_camera,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  allTranslations.text('main', 'Name'),
                                  style: TextStyle(
                                    color: IMMOXLTheme.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 10),
                                  child: TextFormField(
                                    controller: nameController =
                                        TextEditingController(
                                            text: snapshot.data['name'] != null
                                                ? snapshot.data['name']
                                                : null),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'PTSans',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Full Name",
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: IMMOXLTheme.darkgrey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PTSans',
                                      ),
                                      fillColor: IMMOXLTheme.lightgrey,
                                      filled: true,
                                      prefixIcon: Container(
                                        height: 20,
                                        width: 20,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: SvgPicture.asset(
                                            'assets/icons/account_circle.svg',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  allTranslations.text(
                                      'profile', 'Phone Number'),
                                  style: TextStyle(
                                    color: IMMOXLTheme.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: phoneNumberController =
                                        TextEditingController(
                                            text: snapshot
                                                        .data['phonenumber'] !=
                                                    null
                                                ? snapshot.data['phonenumber']
                                                : null),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'PTSans',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Phone Number",
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: IMMOXLTheme.darkgrey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PTSans',
                                      ),
                                      fillColor: IMMOXLTheme.lightgrey,
                                      filled: true,
                                      prefixIcon: Container(
                                        height: 20,
                                        width: 20,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Icon(
                                            Icons.call,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  allTranslations.text('profile', 'Website'),
                                  style: TextStyle(
                                    color: IMMOXLTheme.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: TextFormField(
                                    controller: websiteController =
                                        TextEditingController(
                                            text:
                                                snapshot.data['website'] != null
                                                    ? snapshot.data['website']
                                                    : null),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'PTSans',
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "https://immoxl.com",
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: IMMOXLTheme.darkgrey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PTSans',
                                      ),
                                      fillColor: IMMOXLTheme.lightgrey,
                                      filled: true,
                                      prefixIcon: Container(
                                        height: 20,
                                        width: 20,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: SvgPicture.asset(
                                            'assets/icons/web.svg',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  allTranslations.text('profile', 'Location'),
                                  style: TextStyle(
                                    color: IMMOXLTheme.purple,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 5, bottom: 5),
                                  child: TextFormField(
                                    onTap: () {
                                      _updateTemporaryProfile(
                                        name: nameController.text,
                                        phonenumber: phoneNumberController.text,
                                        website: websiteController.text,
                                        context: context,
                                      );
                                      getLocationWithNominatim();
                                    },
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: snapshot.data['address'] == null
                                          ? allTranslations.text(
                                              'profile', 'Set Location')
                                          : snapshot.data['address'],
                                      hintStyle: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PTSans',
                                      ),
                                      fillColor: IMMOXLTheme.lightgrey,
                                      filled: true,
                                      prefixIcon: Container(
                                        height: 20,
                                        width: 20,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: SvgPicture.asset(
                                            'assets/icons/my_location.svg',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          )),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ]),
                        ),
                        Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: IMMOXLTheme.lightblue.withOpacity(0.4),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  allTranslations.text(
                                      "profile", "Who can see my profile?"),
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  allTranslations.text("profile",
                                      "Everyone who has an account on IMMOXL can see your profile details. When some of details are private, don't fill them in."),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'PTSans',
                                  ),
                                ),
                              ],
                            )),
                      ]));
                })));
  }

  void _updateAvatar(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    title: Text(
                      'Take Photo',
                    ),
                    onTap: () {
                      _updateTemporaryProfile(
                        name: nameController.text,
                        phonenumber: phoneNumberController.text,
                        website: websiteController.text,
                        context: context,
                      );
                      Navigator.pop(context);
                      pickCamera();
                    }),
                ListTile(
                    title: Text(
                      'Choose from Photos',
                    ),
                    onTap: () => () {
                          _updateTemporaryProfile(
                            name: nameController.text,
                            phonenumber: phoneNumberController.text,
                            website: websiteController.text,
                            context: context,
                          );
                          Navigator.pop(context);
                          pickPhotos();
                        }),
              ],
            ),
          );
        });
  }

  void _updateUserAvatar({String avatar, BuildContext context}) async {
    try {
      await Auth.updateAvatar(avatar);
    } catch (e) {}
  }

  void _updateProfile(
      {String name,
      String phonenumber,
      String website,
      BuildContext context}) async {
    try {
      await Auth.updateProfile(name, phonenumber, website).then((uid) {
        Navigator.pop(context);
        Flushbar(
          message: 'Profile updated',
          duration: Duration(milliseconds: 1500),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Color(0xFF25d366),
        )..show(context);
      });
    } catch (e) {
      String exception = Auth.getExceptionText(e);
      Flushbar(
        message: exception,
        duration: Duration(milliseconds: 1500),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Color(0xFFFF5C83),
      )..show(context);
    }
  }

  void _updateTemporaryProfile(
      {String name,
      String phonenumber,
      String website,
      BuildContext context}) async {
    try {
      await Auth.updateProfile(name, phonenumber, website);
    } catch (e) {}
  }
}
