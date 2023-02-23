// To parserequired this JSON data, do
//
//     final dashbordmodal = dashbordmodalFromJson(jsonString);

import 'dart:convert';

Dashbordmodal dashbordmodalFromJson(String str) =>
    Dashbordmodal.fromJson(json.decode(str));

String dashbordmodalToJson(Dashbordmodal data) => json.encode(data.toJson());

class Dashbordmodal {
  Dashbordmodal({
    required this.data,
    required this.status,
  });

  Data data;
  int status;

  factory Dashbordmodal.fromJson(Map<String, dynamic> json) => Dashbordmodal(
        data: Data.fromJson(json["data"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
      };
}

class Data {
  Data({
    required this.weekTotalAmount,
    required this.mothTotalCurrencyAmount,
  });

  Amount weekTotalAmount;
  Amount mothTotalCurrencyAmount;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        weekTotalAmount: Amount.fromJson(json["weekTotalAmount"]),
        mothTotalCurrencyAmount:
            Amount.fromJson(json["mothTotalCurrencyAmount"]),
      );

  Map<String, dynamic> toJson() => {
        "weekTotalAmount": weekTotalAmount.toJson(),
        "mothTotalCurrencyAmount": mothTotalCurrencyAmount.toJson(),
      };
}

class Amount {
  Amount({
    required this.inr,
    required this.aud,
  });

  String inr;
  String aud;

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        inr: json["inr"],
        aud: json["aud"],
      );

  Map<String, dynamic> toJson() => {
        "inr": inr,
        "aud": aud,
      };
}
