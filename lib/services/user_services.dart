import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userIMMOXL = Firestore.instance.collection('users');

  Future<void> updateUserData(String name, String email) async {
    return await userIMMOXL.document(uid).setData({
      'name': name,
      'email': email,
    });
  }

  Future<void> updateAvatar(String avatar) async {
    return await userIMMOXL.document(uid).updateData({
      'avatar': avatar,
    });
  }

  Future<void> updateUserType(bool isAgent, String company) async {
    return await userIMMOXL.document(uid).updateData({
      'isAgent': isAgent,
      'company': company,
    });
  }

  Future<void> updateUserLocation(
      String address, String longitude, String latitude, String state) async {
    return await userIMMOXL.document(uid).updateData({
      'address': address,
      'longitude': longitude,
      'latitude': latitude,
      'state': state,
    });
  }

  Future<void> updateProfile(
      String name, String phonenumber, String website) async {
    return await userIMMOXL.document(uid).updateData({
      'name': name,
      'phonenumber': phonenumber,
      'website': website,
    });
  }

}
