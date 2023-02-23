// To parse this JSON data, do
//
//     final orderStatusModals = orderStatusModalsFromJson(jsonString);

import 'dart:convert';

OrderStatusModals orderStatusModalsFromJson(String str) => OrderStatusModals.fromJson(json.decode(str));

String orderStatusModalsToJson(OrderStatusModals data) => json.encode(data.toJson());

class OrderStatusModals {
    OrderStatusModals({
        required this.userData,
        required this.status,
    });

    UserData userData;
    int status;

    factory OrderStatusModals.fromJson(Map<String, dynamic> json) => OrderStatusModals(
        userData: UserData.fromJson(json["userData"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "userData": userData.toJson(),
        "status": status,
    };
}

class UserData {
    UserData({
        required this.orderTitle,
        required this.workStatus,
    });

    String orderTitle;
    List<WorkStatus> workStatus;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        orderTitle: json["order_title"],
        workStatus: List<WorkStatus>.from(json["workStatus"].map((x) => WorkStatus.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "order_title": orderTitle,
        "workStatus": List<dynamic>.from(workStatus.map((x) => x.toJson())),
    };
}

class WorkStatus {
    WorkStatus({
        required this.workStatusId,
        required this.firstEnquaryId,
        required this.comment,
        required this.status,
        this.writerId,
        required this.userType,
        this.fileLink,
        required this.createdAt,
        required this.updatedAt,
        required this.filename,
        this.afName,
    });

    int workStatusId;
    String firstEnquaryId;
    String comment;
    int status;
    String? writerId;
    String userType;
    String? fileLink;
    DateTime createdAt;
    DateTime updatedAt;
    String? afName;
    String filename;

    factory WorkStatus.fromJson(Map<String, dynamic> json) => WorkStatus(
        workStatusId: json["work_status_id"] ?? "",
        firstEnquaryId: json["first_enquary_id"] ?? "",
        comment: json["comment"] ?? "",
        status: int.parse(json["status"] ?? 0 ),
        writerId: json["writer_id"] ?? "",
        userType: json["user_type"] ?? "",
        fileLink: json["file_link"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? ""),
        updatedAt: DateTime.parse(json["updated_at"] ?? ""),
        afName: json["af_name"] ?? "",
        filename: json["file_name"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "work_status_id": workStatusId ?? "",
        "first_enquary_id": firstEnquaryId ?? "" ,
        "comment": comment ?? "",
        "status": status ?? "",
        "writer_id": writerId ?? "",
        "user_type": userType ?? "",
        "file_link": fileLink ?? null,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "af_name": afName ?? "",
        "file_name" : filename,
    };
}
