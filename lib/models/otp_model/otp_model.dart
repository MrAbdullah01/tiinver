/// error : false
/// message : "Mail send Successful"

class OtpModel {
  OtpModel({
      bool? error, 
      String? message,}){
    _error = error;
    _message = message;
}

  OtpModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
  }
  bool? _error;
  String? _message;
OtpModel copyWith({  bool? error,
  String? message,
}) => OtpModel(  error: error ?? _error,
  message: message ?? _message,
);
  bool? get error => _error;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    return map;
  }

}