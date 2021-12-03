class LoginResponseModel {
  final String token;
  final String status;
  final String pesan;
  final String npm;
  final int thnmasuk;
  final String panggilan;
  final String prodi;

  LoginResponseModel({
    this.token,
    this.status,
    this.pesan,
    this.npm,
    this.thnmasuk,
    this.panggilan,
    this.prodi,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"],
      pesan: json["pesan"],
      panggilan: json["panggilan"],
      npm: json['npm'],
      prodi: json["iD_PRODI"],
      thnmasuk: json["thN_MASUK"],
    );
  }
}

class LoginRequestModel {
  String username;
  String password;

  LoginRequestModel({
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': username.trim(),
      'password': password.trim(),
    };

    return map;
  }
}

class PasswordResponseModel {
  final bool status;
  final String pesan;

  PasswordResponseModel({
    this.status,
    this.pesan,
  });

  factory PasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return PasswordResponseModel(
      status: json["status"],
      pesan: json["pesan"],
    );
  }
}

class PasswordRequestModel {
  String passwordlama;
  String password;

  PasswordRequestModel({
    this.passwordlama,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'passwordlama': passwordlama.trim(),
      'password': password.trim(),
    };

    return map;
  }
}
