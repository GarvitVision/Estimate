import 'package:newapp/Utils/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String SETUP_STATUS = "0.0";
Future setupStatus() async {
  num count = 0.0;
  var pref = await SharedPreferences.getInstance();
  for (var i = 0; i < modelPrefs.length; i++) {
    num totalCount = 1 / modelPrefs.length;
    if (pref.getString(modelPrefs[i]) == "Done") {
      count = count + totalCount;
    }
  }
  print("COUNTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT==== $count");
  pref.setString(SETUP_STATUS, "$count");
}
