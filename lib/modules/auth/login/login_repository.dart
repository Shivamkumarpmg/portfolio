//
// import 'package:bvg_partner/services/api_services/api_dynamic_response.dart';
// import 'package:bvg_partner/services/dio/dio_client.dart';
// import 'package:bvg_partner/utils/common/common_functions.dart';
//
// import '../../../constants/constants.dart';
// import '../../../services/enc_dec/aes.dart';
//
// class LoginRepository{
//   Aes aes;
//   DioClient dioClient;
//
//   LoginRepository({required this.dioClient,required this.aes});
//
//
//   Future<ApisResponse> login(var loginBody)async{
//     try{
//       var encryptData = {'body': aes.aesEncrypted(loginBody)};
//       final response = await dioClient.post(Apis.login, data: encryptData);
//       Map responseData = Map<String, dynamic>.from(response.data);
//       response.data = aes.aesDecrypted(responseData['body']);
//       CommonFunctions.printLog("Response: ${response.data}");
//       return ApisResponse.withSuccess(response);
//     }catch (e){
//       return ApisResponse.withError(e);
//     }
//   }
//
//
// }