import 'package:get/get.dart';

// CheckBox를 반응형 변수로 자동으로 변경되게 만들기 위해 사용한 Controller
class checkBoxController extends GetxController {
  RxBool isChecked = false.obs;

  void check() {
    this.isChecked.value = !this.isChecked.value;
  }
}
