import 'package:url_launcher/url_launcher.dart';

class Auth {
  Future<void> signInWithGihub() async {
    String clientId = '4e6c090ef94aeea57d25';
    String url = "https://github.com/login/oauth/authorize" +
        "?client_id=" +
        clientId +
        "&scope=public_repo%20read:user%20user:email";

    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
      return true;
    } else {
      return false;
    }
  }
}
