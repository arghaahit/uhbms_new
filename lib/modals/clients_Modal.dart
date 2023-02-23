// To parse this JSON data, do
//
//     final clientsListMadal = clientsListMadalFromJson(jsonString);

import 'dart:convert';

ClientsListMadal clientsListMadalFromJson(String str) =>
    ClientsListMadal.fromJson(json.decode(str));

String clientsListMadalToJson(ClientsListMadal data) =>
    json.encode(data.toJson());

class ClientsListMadal {
  ClientsListMadal({
    required this.usersList,
    required this.status,
  });

  UsersList usersList;
  int status;

  factory ClientsListMadal.fromJson(Map<String, dynamic> json) =>
      ClientsListMadal(
        usersList: UsersList.fromJson(json["usersList"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "usersList": usersList.toJson(),
        "status": status,
      };
}

class UsersList {
  UsersList({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  String nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
        currentPage: json["current_page"] ?? "-",
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"] ?? "-",
        from: json["from"] ?? "-",
        lastPage: json["last_page"] ?? "-",
        lastPageUrl: json["last_page_url"] ?? "-",
        nextPageUrl: json["next_page_url"] ?? "-",
        path: json["path"] ?? "-",
        perPage: json["per_page"] ?? "-",
        prevPageUrl: json["prev_page_url"] ?? "-",
        to: json["to"] ?? "-",
        total: json["total"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
  Datum({
    required this.userId,
    required this.userName,
    required this.userEmail,
    required this.userPassword,
    required this.userStatus,
    required this.userCreatedAt,
    required this.rmId,
    required this.mobile,
    required this.phoneCode,
    required this.univercityName,
    required this.tokenId,
    required this.rmUserName,
    required this.isApproved,
    required this.isMultipal,
  });

  int userId;
  String userName;
  String userEmail;
  String userPassword;
  String userStatus;
  DateTime userCreatedAt;
  String rmId;
  String mobile;
  String phoneCode;
  String univercityName;
  String? tokenId;
  String rmUserName;
  String isMultipal;
  String isApproved;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        userId: json["user_id"] ?? "-",
        userName: json["user_name"] ?? "-",
        userEmail: json["user_email"] ?? "-",
        userPassword: json["user_password"] ?? "-",
        userStatus: json["user_status"],
        userCreatedAt: DateTime.parse(json["user_created_at"] ?? "-"),
        rmId: json["rm_id"] ?? "-",
        mobile: json["mobile"] ?? "-",
        phoneCode: json["phone_code"] ?? "-",
        univercityName: json["univercity_name"] ?? "-",
        tokenId: json["_token_id"] == null ? "-" : json["_token_id"],
        rmUserName: json["rm_user_name"] ?? "-",
        isMultipal: json["is_multipal"] ?? "-",
        isApproved: json["is_approved"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? "-" : userId,
        "user_name": userName == null ? "-" : userName,
        "user_email": userEmail == null ? "-" : userEmail,
        "user_password": userPassword == null ? "-" : userPassword,
        "user_status": userStatus == null ? "-" : userStatus,
        "user_created_at": userCreatedAt.toIso8601String(),
        "rm_id": rmId == null ? "-" : rmId,
        "mobile": mobile == null ? "-" : mobile,
        "phone_code": phoneCode == null ? "-" : phoneCode,
        "univercity_name": univercityName == null ? "-" : univercityName,
        "_token_id": tokenId == null ? "-" : tokenId,
        "rm_user_name": rmUserName == null ? "-" : rmUserName,
        "is_multipal": isMultipal == null ? "-" : isMultipal,
        "is_approved": isApproved == null ? "-" : isApproved,
      };
}
