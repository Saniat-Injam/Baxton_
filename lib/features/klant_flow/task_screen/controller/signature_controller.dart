import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:signature/signature.dart';

class SharedSignatureController extends GetxController {
  final signaturePadController = SignatureController(
    penStrokeWidth: 2,
    penColor: const Color(0xFF000000),
  );
  var signatureBase64 = ''.obs;

  Future<void> saveSignature() async {
    final bytes = await signaturePadController.toPngBytes();
    if (bytes != null) {
      signatureBase64.value = base64Encode(bytes);
    }
  }

  void clearSignature() {
    signaturePadController.clear();
    signatureBase64.value = '';
  }
}
