class LoginResponse {
  bool? status;
  String? message;
  Data? data;
  int? statusCode;

  LoginResponse({this.status, this.message, this.data, this.statusCode});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['statusCode'] = statusCode;
    return data;
  }
}

class Data {
  String? token;
  UserDetails? userDetails;

  Data({this.token, this.userDetails});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userDetails = json['userDetails'] != null
        ? UserDetails.fromJson(json['userDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (userDetails != null) {
      data['userDetails'] = userDetails!.toJson();
    }
    return data;
  }
}

class UserDetails {
  String? sId;
  String? firstName;
  String? lastName;
  String? phone;
  String? branchCode;
  String? email;
  String? profilePic;
  RoleId? roleId;
  bool? isEmailVerified;

  UserDetails(
      {this.sId,
        this.firstName,
        this.lastName,
        this.phone,
        this.branchCode,
        this.email,
        this.profilePic,
        this.roleId,
        this.isEmailVerified});

  UserDetails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    phone = json['phone'];
    branchCode = json['branchCode'];
    email = json['email'];
    profilePic = json['profilePic'];
    roleId =
    json['roleId'] != null ? RoleId.fromJson(json['roleId']) : null;
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['phone'] = phone;
    data['branchCode'] = branchCode;
    data['email'] = email;
    data['profilePic'] = profilePic;
    if (roleId != null) {
      data['roleId'] = roleId!.toJson();
    }
    data['isEmailVerified'] = isEmailVerified;
    return data;
  }
}

class RoleId {
  String? sId;
  String? name;

  RoleId({this.sId, this.name});

  RoleId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    return data;
  }
}
