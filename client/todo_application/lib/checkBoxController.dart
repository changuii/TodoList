import 'package:get/get.dart';

class checkBoxController extends GetxController {
  RxBool isChecked = false.obs;

  void check() {
    this.isChecked.value = !this.isChecked.value;
  }
}
