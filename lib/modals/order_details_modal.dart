// To parse this JSON data, do
//
//     final orderDetailsModals = orderDetailsModalsFromJson(jsonString);

import 'dart:convert';

OrderDetailsModals orderDetailsModalsFromJson(String str) => OrderDetailsModals.fromJson(json.decode(str));

String orderDetailsModalsToJson(OrderDetailsModals data) => json.encode(data.toJson());

class OrderDetailsModals {
    OrderDetailsModals({
        required this.userData,
        required this.screenshot,
        required this.status,
    });

    UserData userData;
    String screenshot;
    int status;

    factory OrderDetailsModals.fromJson(Map<String, dynamic> json) => OrderDetailsModals(
        userData: UserData.fromJson(json["userData"]?? "-"),
        screenshot: json["Screenshot"]?? "-",
        status: json["status"]?? "-",
    );

    Map<String, dynamic> toJson() => {
        "userData": userData.toJson(),
        "Screenshot": screenshot,
        "status": status,
    };
}

class UserData {
    UserData({
        required this.enId,
        required this.enFirstName,
        this.enLastName,
        required this.enEmail,
        required this.phoneCode,
        required this.enMobile,
        required this.enService,
        required this.enSubject,
        required this.enQuery,
        this.enAttachment,
        this.enAttachment2,
        this.enAttachment3,
        required this.enCreatedAt,
        required this.screenshot,
        required this.rmId,
        required this.userType,
        required this.orderType,
        required this.orderNumber,
        required this.paymentType,
        required this.emailStatus,
        required this.moduleName,
        required this.deadline,
        required this.paymentTime,
        required this.wordCount,
        required this.tranxid,
        required this.assignmentType,
        required this.currencyType,
        required this.clientAmount,
        required this.inrAmount,
        required this.audAmount,
        required this.univercityName,
        required this.workAllocation,
        required this.transactionId,
    });

    int enId;
    String enFirstName;
    dynamic enLastName;
    String enEmail;
    String phoneCode;
    String enMobile;
    String enService;
    String enSubject;
    String enQuery;
    dynamic enAttachment;
    dynamic enAttachment2;
    dynamic enAttachment3;
    DateTime enCreatedAt;
    String screenshot;
    String rmId;
    String userType;
    String orderType;
    String orderNumber;
    String paymentType;
    String emailStatus;
    String moduleName;
    DateTime deadline;
    String paymentTime;
    String wordCount;
    String tranxid;
    String assignmentType;
    String currencyType;
    String clientAmount;
    String inrAmount;
    String audAmount;
    dynamic univercityName;
    String workAllocation;
    dynamic transactionId;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        enId: json["en_id"] ?? "-",
        enFirstName: json["en_first_name"]?? "-",
        enLastName: json["en_last_name"]?? "-",
        enEmail: json["en_email"]?? "-",
        phoneCode: json["phone_code"]?? "-",
        enMobile: json["en_mobile"]?? "-",
        enService: json["en_service"]?? "-",
        enSubject: json["en_subject"]?? "-",
        enQuery: json["en_query"]?? "-",
        enAttachment: json["en_attachment"]?? "-",
        enAttachment2: json["en_attachment_2"]?? "-",
        enAttachment3: json["en_attachment_3"]?? "-",
        enCreatedAt: DateTime.parse(json["en_created_at"]?? "-"),
        screenshot: json["Screenshot"]?? "-",
        rmId: json["rm_id"]?? "-",
        userType: json["user_type"]?? "-",
        orderType: json["order_type"]?? "-",
        orderNumber: json["order_number"]?? "-",
        paymentType: json["payment_type"]?? "-",
        emailStatus: json["email_status"]?? "-",
        moduleName: json["module_name"]?? "-",
        deadline: DateTime.parse(json["deadline"]?? "-"),
        paymentTime: json["payment_time"]?? "-",
        wordCount: json["word_count"]?? "-",
        tranxid: json["tranxid"]?? "-",
        assignmentType: json["assignment_type"]?? "-",
        currencyType: json["currency_type"]?? "-",
        clientAmount: json["client_amount"]?? "-",
        inrAmount: json["inr_amount"]?? "-",
        audAmount: json["aud_amount"]?? "-",
        univercityName: json["univercity_name"]?? "-",
        workAllocation: json["work_allocation"]?? "-",
        transactionId: json["transaction_id"]?? "-",
    );

    Map<String, dynamic> toJson() => {
        "en_id": enId,
        "en_first_name": enFirstName,
        "en_last_name": enLastName,
        "en_email": enEmail,
        "phone_code": phoneCode,
        "en_mobile": enMobile,
        "en_service": enService,
        "en_subject": enSubject,
        "en_query": enQuery,
        "en_attachment": enAttachment,
        "en_attachment_2": enAttachment2,
        "en_attachment_3": enAttachment3,
        "en_created_at": enCreatedAt.toIso8601String(),
        "Screenshot": screenshot,
        "rm_id": rmId,
        "user_type": userType,
        "order_type": orderType,
        "order_number": orderNumber,
        "payment_type": paymentType,
        "email_status": emailStatus,
        "module_name": moduleName,
        "deadline": deadline.toIso8601String(),
        "payment_time": paymentTime,
        "word_count": wordCount,
        "tranxid": tranxid,
        "assignment_type": assignmentType,
        "currency_type": currencyType,
        "client_amount": clientAmount,
        "inr_amount": inrAmount,
        "aud_amount": audAmount,
        "univercity_name": univercityName,
        "work_allocation": workAllocation,
        "transaction_id": transactionId,
    };
}
