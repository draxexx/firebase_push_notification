import 'package:get/get.dart';

class NotificationProvider extends GetConnect {
  void createNotification() async {
    var response = await post(
      "arn:aws:sns:eu-central-1:718051928080:endpoint/GCM/TestPushNotification/5a186faf-b051-3493-b93d-03af92c27d40",
      {
        "GCM":
            "{ \"notification\": { \"body\": \"Sample message for Android endpoints\", \"title\": \"From AWS\" } }"
      },
    );

    print(response.body);
  }
}
