import 'dart:convert';

import 'package:adhara_socket_io_example/data.dart';
import 'package:flutter/material.dart';

class FetchAssistanceData extends ChangeNotifier {
  List<AssistanceRequest> assistanceReq = [];

//  fetchAssistRequests(data) { //done
  newRequests(data) {
    if (data is Map) {
      data = json.encode(data);
    }

    AssistanceRequest assist = AssistanceRequest.fromJson(jsonDecode(data));
    assistanceReq.add(assist);
  }

//  fetchAccepted(data) { //done
  accepted(data) {
    if (data is Map) {
      data = json.encode(data);
    }
    print(jsonDecode(data));
    assistanceReq.forEach((request) {
      if (request.oId == jsonDecode(data)['assistance_id']) {
        request.acceptedBy = jsonDecode(data)['staff_name'];
      }
    });
  }
}
