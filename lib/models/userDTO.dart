class userDTO {
  String _email;
  String _password;
  String _phoneNumber;
  String _address;
  String _username;
  String _firstName;
  String _lastName;
  String _middleName;
  String _nextOfKinPhone;
  String _nextOfKinName;
  String _dateOfBirth;
  int _id;
  int _gender;
  String _otp;

  userDTO(
      this._email,
      this._password,
      this._phoneNumber,
      this._address,
      this._username,
      this._firstName,
      this._lastName,
      this._middleName,
      this._nextOfKinPhone,
      this._nextOfKinName,
      this._dateOfBirth,
      this._gender, this._otp);

  // ignore: non_constant_identifier_names
  userDTO.WithId(
      this._email,
      this._password,
      this._phoneNumber,
      this._address,
      this._username,
      this._firstName,
      this._lastName,
      this._middleName,
      this._nextOfKinPhone,
      this._nextOfKinName,
      this._dateOfBirth,
      this._id,
      this._gender, this._otp);

  int get id => _id;
  String get email => _email;
  String get password => _password;
  String get phoneNumber => _phoneNumber;
  String get address => _address;
  String get username => _username;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get middleName => _middleName;
  int get gender => _gender;
  String get nextOfKinName => _nextOfKinName;
  String get nextOfKinPhone => _nextOfKinPhone;
  String get dateOfBirth => _dateOfBirth;
  String get otp => _otp;


  set id(int newId) {
    _id = newId;
  }

  set nextOfKinName(String newNOK) {
    _nextOfKinName = newNOK;
  }
  set nextOfKinPhone(String newnextOfKinPhone) {
    _nextOfKinPhone = newnextOfKinPhone;
  }

  set gender(int newGender) {
    _gender = newGender;
  }
  set firstName(String newFirstName) {
    _firstName = newFirstName;
  }

  set middleName(String newUserId) {
    _middleName = newUserId;
  }

  set lastName(String newLastName) {
    _lastName = newLastName;
  }

  set email(String newEmail) {
    _email = newEmail;
  }

  set password(String newpassword) {
    _password = newpassword;
  }

  set phoneNumber(String newPhoneNumber) {
    _phoneNumber = newPhoneNumber;
  }

  set dateOfBirth(String newdateOfBirth) {
    _dateOfBirth = newdateOfBirth;
  }

  set username(String newusername) {
    _username = newusername;
  }

  set address(String newAddress) {
    _address = newAddress;
  }
  set otp(String newOTP) {
    _otp = newOTP;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["middleName"] = _middleName;
    map["password"] = _password;
    map["email"] = _email;
    map["address"] = _address;
    map["username"] = _username;
    map["phoneNumber"] = _phoneNumber;
    map["gender"] = _gender;
    map["nextOfKinPhone"] = _nextOfKinPhone;
    map["nextOfKinName"] = _nextOfKinName;
    map["dateOfBirth"] = _dateOfBirth;
    map["otp"] = _otp;
    if (_id != null) {
      map["id"] = _id;
    }
    if (_gender != null) {
      map["gender"] = _gender;
    }
    return map;
  }

  userDTO.fromObject(dynamic o) {
    this._id = o["id"];
    this._firstName = o["firstName"];
    this._lastName = o["lastName"];
    this._middleName = o["middleName"];
    this._dateOfBirth = o["dateOfBirth"];
    this._email = o["email"];
    this._address = o["address"];
    this._nextOfKinName = o["nextOfKinName"];
    this._nextOfKinPhone = o["nextOfKinPhone"];
    this._phoneNumber = o["phoneNumber"];
    this._username = o["username"];
    this._gender = o["gender"];
    this._password = o["password"];
    this._otp = o["otp"];
  }
}

enum UserType
{
  Administrator,
  Employee,
  Partner,
  Customer
}


