// To parse this JSON data, do
//
//     final quickpaymentmodel = quickpaymentmodelFromJson(jsonString);

import 'dart:convert';

Quickpaymentmodel quickpaymentmodelFromJson(String str) => Quickpaymentmodel.fromJson(json.decode(str));

String quickpaymentmodelToJson(Quickpaymentmodel data) => json.encode(data.toJson());

class Quickpaymentmodel {
    Quickpaymentmodel({
        required this.getpaymentlinkList,
        required this.status,
    });

    GetpaymentlinkList getpaymentlinkList;
    int status;

    factory Quickpaymentmodel.fromJson(Map<String, dynamic> json) => Quickpaymentmodel(
        getpaymentlinkList: GetpaymentlinkList.fromJson(json["getpaymentlinkList"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "getpaymentlinkList": getpaymentlinkList.toJson(),
        "status": status,
    };
}

class GetpaymentlinkList {
    GetpaymentlinkList({
        required this.currentPage,
        required this.data,
        required this.firstPageUrl,
        required this.from,
        required this.lastPage,
        required this.lastPageUrl,
        this.nextPageUrl,
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
    dynamic nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory GetpaymentlinkList.fromJson(Map<String, dynamic> json) => GetpaymentlinkList(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
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
        required this.id,
        required this.txnid,
        required this.amount,
        this.currencyType,
        required this.productinfo,
        required this.firstname,
        this.lastname,
        this.zipcode,
        required this.email,
        required this.phone,
        required this.address1,
        this.address2,
        this.city,
        this.state,
        this.country,
        this.pg,
        this.jsone,
        required this.emailStatus,
        required this.paymentStatus,
        required this.rmId,
        required this.clientId,
        required this.clcikCount,
        required this.paymentKeyType,
        required this.createdAt,
        required this.updatedAt,
        required this.servicesName,
        required this.symbol,
        required this.encodeurl,
    });

    int id;
    String txnid;
    String amount;
    dynamic currencyType;
    String productinfo;
    String firstname;
    dynamic lastname;
    dynamic zipcode;
    String email;
    String phone;
    String address1;
    dynamic address2;
    dynamic city;
    dynamic state;
    dynamic country;
    dynamic pg;
    dynamic jsone;
    String emailStatus;
    String paymentStatus;
    String rmId;
    String clientId;
    String clcikCount;
    String paymentKeyType;
    DateTime createdAt;
    DateTime updatedAt;
    String servicesName;
    String symbol;
    String encodeurl;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        txnid: json["txnid"],
        amount: json["amount"],
        currencyType: json["currency_type"],
        productinfo: json["productinfo"],
        firstname: json["firstname"],
        lastname: json["Lastname"],
        zipcode: json["Zipcode"],
        email: json["email"],
        phone: json["phone"],
        address1: json["address1"],
        address2: json["address2"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        pg: json["Pg"],
        jsone: json["jsone"],
        emailStatus: json["email_status"],
        paymentStatus: json["payment_status"],
        rmId: json["rm_id"],
        clientId: json["client_id"],
        clcikCount: json["clcik_count"],
        paymentKeyType: json["payment_key_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        servicesName: json["services_name"],
        symbol: json["symbol"],
        encodeurl: json["encodeurl"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "txnid": txnid,
        "amount": amount,
        "currency_type": currencyType,
        "productinfo": productinfo,
        "firstname": firstname,
        "Lastname": lastname,
        "Zipcode": zipcode,
        "email": email,
        "phone": phone,
        "address1": address1,
        "address2": address2,
        "city": city,
        "state": state,
        "country": country,
        "Pg": pg,
        "jsone": jsone,
        "email_status": emailStatus,
        "payment_status": paymentStatus,
        "rm_id": rmId,
        "client_id": clientId,
        "clcik_count": clcikCount,
        "payment_key_type": paymentKeyType,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "services_name": servicesName,
        "symbol": symbol,
        "encodeurl": encodeurl,
    };
}
