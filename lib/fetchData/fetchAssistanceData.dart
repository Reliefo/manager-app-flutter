import 'package:flutter/material.dart';
import 'package:manager_app/data.dart';

class AssistanceData extends ChangeNotifier {
  final List<AssistanceRequest> assistanceReq;
  AssistanceData({
    this.assistanceReq,
  });
//  fetchAssistRequests(data) { //done
//  newAssistanceRequests(data) {
//    if (data is Map) {
//      data = json.encode(data);
//    }
//    print("assistance req");
//    print(jsonDecode(data));
//    AssistanceRequest assist = AssistanceRequest.fromJson(jsonDecode(data));
//    assistanceReq.add(assist);
//
//
//  }

//  fetchAccepted(data) { //done
//  acceptedAssistanceReq(data) {
//    if (data is Map) {
//      data = json.encode(data);
//    }
//    print(jsonDecode(data));
//    assistanceReq.forEach((request) {
//      if (request.oId == jsonDecode(data)['assistance_id']) {
//        request.acceptedBy = jsonDecode(data)['staff_name'];
//      }
//    });
//    notifyListeners();
//  }
}
