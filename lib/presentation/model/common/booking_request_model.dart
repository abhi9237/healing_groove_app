class BookingRequestModel {
  int? center;
  int? package;
  String? startDate;
  int? groupSize;
  int? totalAmount;
  String? status;
  List<BookingGuest>? guests;

  BookingRequestModel({
    this.center,
    this.package,
    this.startDate,
    this.groupSize,
    this.totalAmount,
    this.status,
    this.guests,
  });

  Map<String, dynamic> toJson() {
    return {
      "center": center,
      "package": package,
      "startDate": startDate,
      "groupSize": groupSize,
      "totalAmount": totalAmount,
      "status": status,
      "guests": guests?.map((e) => e.toJson()).toList(),
    };
  }
}

class BookingGuest {
  String? fullName;
  int? age;
  String? gender;

  BookingGuest({
    this.fullName,
    this.age,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "age": age,
      "gender": gender,
    };
  }
}