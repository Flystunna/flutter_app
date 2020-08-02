class  EmployeeDTO {
  int _id;
  String _userId;
  String _firstName;
  String _lastName;
  int _locationId;
  String _roleName;
  int _gender;
  String _address;
  String _creatorUserName;
  String _email;
  String _employeeCode;
  String _phoneNumber;
  String _stateName;
  String _divisionName;
  String _creationTime;
  String _dateOfEmployment;

  //String _dateOfEmployment;

  EmployeeDTO(
      this._address,
      this._creatorUserName,
      this._divisionName,
      this._email,
      this._employeeCode,
      this._firstName,
      this._lastName,
      this._locationId,
      this._phoneNumber,
      this._roleName,
      this._stateName,
      this._userId,
      this._gender,
      this._creationTime,
      this._dateOfEmployment);

  // ignore: non_constant_identifier_names
  EmployeeDTO.WithId(
      this._address,
      this._creatorUserName,
      this._divisionName,
      this._email,
      this._employeeCode,
      this._firstName,
      this._id,
      this._lastName,
      this._locationId,
      this._phoneNumber,
      this._roleName,
      this._stateName,
      this._userId,
      this._gender,
      this._creationTime,
      this._dateOfEmployment);

  int get id => _id;

  String get userId => _userId;

  String get firstName => _firstName;

  String get lastName => _lastName;

  int get locationId => _locationId;

  String get roleName => _roleName;

  int get gender => _gender;

  String get address => _address;

  String get creatorUserName => _creatorUserName;

  String get email => _email;

  String get employeeCode => _employeeCode;

  String get phoneNumber => _phoneNumber;

  String get stateName => _stateName;

  String get divisionName => _divisionName;

  String get creationTime => _creationTime;
  String get dateOfEmployment => _dateOfEmployment;

  set id(int newId) {
    _id = newId;
  }

  set locationId(int newLocationId) {
    _locationId = newLocationId;
  }

  set gender(int newGender) {
    _gender = newGender;
  }

  set firstName(String newFirstName) {
    _firstName = newFirstName;
  }

  set userId(String newUserId) {
    _userId = newUserId;
  }

  set lastName(String newLastName) {
    _lastName = newLastName;
  }

  set email(String newEmail) {
    _email = newEmail;
  }

  set employeeCode(String newEmployeeCode) {
    _employeeCode = newEmployeeCode;
  }

  set phoneNumber(String newPhoneNumber) {
    _phoneNumber = newPhoneNumber;
  }

  set stateName(String newStateName) {
    _stateName = newStateName;
  }

  set divisionName(String newDivisionName) {
    _divisionName = newDivisionName;
  }

  set roleName(String newRoleName) {
    _roleName = newRoleName;
  }

  set address(String newAddress) {
    _address = newAddress;
  }

  set creatorUserName(String newCreatorUserName) {
    _creatorUserName = newCreatorUserName;
  }

  set creationTime(String newCreationTime) {
    _creationTime = newCreationTime;
  }
  set dateOfEmployment(String newCreationTime) {
    _dateOfEmployment = newCreationTime;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["firstName"] = _firstName;
    map["lastName"] = _lastName;
    map["roleName"] = _roleName;
    map["userId"] = _userId;
    map["email"] = _email;
    map["address"] = _address;
    map["creatorUserName"] = _creatorUserName;
    map["divisionName"] = _divisionName;
    map["stateName"] = _stateName;
    map["phoneNumber"] = _phoneNumber;
    map["employeeCode"] = _employeeCode;
    map["gender"] = _gender;
    map["locationId"] = _locationId;
    map["dateOfEmployment"] = _dateOfEmployment;

    if (_id != null) {
      map["id"] = _id;
    }
    if (_locationId != null) {
      map["locationId"] = _locationId;
    }
    return map;
  }

  EmployeeDTO.fromObject(dynamic o) {
    this._id = o["id"];
    this._firstName = o["firstName"];
    this._lastName = o["lastName"];
    this._roleName = o["roleName"];
    this._userId = o["userId"];
    this._email = o["email"];
    this._address = o["address"];
    this._creatorUserName = o["creatorUserName"];
    this._divisionName = o["divisionName"];
    this._stateName = o["stateName"];
    this._phoneNumber = o["phoneNumber"];
    this._employeeCode = o["employeeCode"];
    this._gender = o["gender"];
    this._locationId = o["locationId"];
    this._creationTime = o["creationTime"];
    this._dateOfEmployment = o["dateOfEmployment"];
  }
}


