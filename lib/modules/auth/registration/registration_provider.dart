import 'package:bvg_partner/utils/common/common_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../constants/global_data_store.dart';
import '../../../services/device_info/device_model.dart';
import '../../../services/location/location_model.dart';

class RegistrationProvider with ChangeNotifier{

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  DeviceModel? deviceInfo = GlobalDataStore.deviceInfo;
  LocationModel? locationInfo = GlobalDataStore.currentLocation;


  bool showPassword = true;
  String passwordMatchError = '';

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  matchPassword(){
    if(passController.text != confirmPassController.text){
      passwordMatchError = 'Password does not match';
      notifyListeners();
      return false;
    }else{
      passwordMatchError = '';
      notifyListeners();
      return true;
    }
  }

  void addUser()async {
  try{
    var userData = {
      "email": mailController.value.text.trim(),
      "password": passController.value.text.trim(),
      'phone': phoneController.text.trim(),
      "device_type": deviceInfo?.deviceType ?? '',
      "device_ip": deviceInfo?.deviceIp ?? '',
      "device_id": deviceInfo?.deviceId ?? '',
      "device_model": deviceInfo?.deviceModel ?? '',
      "latitude": locationInfo?.longitude ?? '',
      "longitude": locationInfo?.latitude ?? "",
      'timestamp': FieldValue.serverTimestamp(),
    };
    DocumentReference<Map<String, dynamic>> response = await firestore.collection('users').add(userData);
    CommonFunctions.printLog("Document added with ID: ${response.id}");
  }catch(e){
    CommonFunctions.printLog("Error: $e");
  }
  }


  Future<void> register() async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mailController.text.trim(),
        password: passController.text.trim(),
        // phone: phoneController.text.trim(),
        // displayName: nameController.text.trim(),
      );
      print("User registered: ${credential.user?.email}");
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text("Registered: ${credential.user?.email}")),
      // );
    } on FirebaseAuthException catch (e) {
      print("Registration error: ${e.message}");

    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    phoneController.dispose();
    mailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
  }
}