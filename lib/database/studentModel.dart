class Student{

  late String _prefix;
  late String _name;
  late String _email;
  late String _phone;
  late String _city;

  // Getters
  String get prefix => _prefix;
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get city => _city;

  // Setters
  set prefix(String value) {
    _prefix = value;
  }

  set name(String value) {
    _name = value;
  }

  set email(String value) {
    _email = value;
  }

  set phone(String value) {
    _phone = value;
  }

  set city(String value) {
    _city = value;
  }


  Student(String prefix, String name, String email, String phone, String city){
    _prefix = prefix;
    _name = name;
    _email = email;
    _phone = phone;
    _city = city;
  }

  @override
  String toString(){
    return '$_prefix $_name,  $_email,  $_phone,  $_city';
  }

  // Converting a Student object into a Map object
  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map['prefix'] = _prefix;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['city'] = _city;

    return map;
  }

  // Converting a Map object into a Student object
  Student.fromMapToStObj(Map<String, dynamic> map){
    this._prefix = map['prefix'];
    this._name = map['name'];
    this._email = map['email'];
    this._phone = map['phone'];
    this._city = map['city'];
  }
}