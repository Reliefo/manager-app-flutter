import 'package:adhara_socket_io_example/fetchData/session.dart';

class Login {
  Session loginSession = Session();
  String connectingURI =
      "http://ec2-13-232-202-63.ap-south-1.compute.amazonaws.com:5050/login";
  String uri =
      "http://ec2-13-232-202-63.ap-south-1.compute.amazonaws.com:5050/";

  login() async {
    var output = await loginSession
        .post(connectingURI, {"username": "MID001", "password": "password123"});
    print("I am loggin in ");

    print(output);
  }
}
