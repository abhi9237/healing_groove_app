import 'package:get/get.dart';
import 'package:healing/presentation/model/common/doc_model.dart';
import 'package:healing/presentation/model/common/centre_model.dart';
import 'package:healing/presentation/model/common/guests_model.dart';
import 'package:healing/presentation/model/common/location_model.dart';
import 'package:healing/presentation/model/common/packages_model.dart';

class EnquiriesDetailController extends GetxController {
  final String enquiryId;
  final DocModel? enquiryDetail;
  DocModel? detailData;
  bool isLoading = true;

  EnquiriesDetailController({required this.enquiryId, this.enquiryDetail});

  @override
  void onInit() {
    super.onInit();
    if (enquiryDetail != null) {
      detailData = enquiryDetail;
      isLoading = false;
      update();
    }
  }
}
