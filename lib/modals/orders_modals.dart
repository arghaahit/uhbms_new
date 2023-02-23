// To parse required this JSON data, do
//
//     final orderModals = orderModalsFromJson(jsonString);

import 'dart:convert';

OrderModals orderModalsFromJson(String str) =>
    OrderModals.fromJson(json.decode(str));

String orderModalsToJson(OrderModals data) => json.encode(data.toJson());

class OrderModals {
  OrderModals({
    required this.usersList,
    required this.status,
  });

  UsersList usersList;
  int status;

  factory OrderModals.fromJson(Map<String, dynamic> json) => OrderModals(
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
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
    required this.data,
  });

  int currentPage;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  String prevPageUrl;
  int to;
  int total;
  List<Datum> data;

  factory UsersList.fromJson(Map<String, dynamic> json) => UsersList(
        currentPage: json["current_page"] ?? 0,
        firstPageUrl: json["first_page_url"] ?? "-",
        from: json["from"] ?? 0,
        lastPage: json["last_page"] ?? 0,
        lastPageUrl: json["last_page_url"] ?? 0,
        nextPageUrl: json["next_page_url"] ?? 0,
        path: json["path"] ?? "-",
        perPage: json["per_page"] ?? 0,
        prevPageUrl: json["prev_page_url"] ?? "-",
        to: json["to"] ?? 0,
        total: json["total"] ?? 0,
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
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
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.enId,
    required this.orderNumber,
    required this.orderDate,
    required this.clientName,
    required this.servicesName,
    required this.tranxid,
    required this.writerId,
    required this.screenshot,
  });

  int enId;
  String orderNumber;
  String orderDate;
  String clientName;
  String servicesName;
  dynamic tranxid;
  String writerId;
  String screenshot;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        enId: json["en_id"],
        orderNumber: json["order_number"] ?? "-",
        orderDate: json["order_date"] ?? "-",
        clientName: json["client_name"] ?? "-",
        servicesName: json["services_name"] ?? "-",
        tranxid: json["tranxid"] ?? "-",
        writerId: json["writer_id"] ?? "-",
        screenshot: json["Screenshot"] ?? "-",
      );

  Map<String, dynamic> toJson() => {
        "en_id": enId,
        "order_number": orderNumber,
        "order_date": orderDate,
        "client_name": clientName,
        "services_name": servicesName,
        "tranxid": tranxid,
        "writer_id": writerId,
        "Screenshot": screenshot,
      };
}
