// import 'package:baxton/features/klant_flow/task_screen/controller/signature_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:signature/signature.dart' hide SignatureController;

// class CustomerSignatureScreen extends StatelessWidget {
//   final controller = Get.put(SignatureController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Customer Signature")),
//       body: Column(
//         children: [
//           Signature(
//             controller: controller.signaturePadController,
//             height: 300,
//             backgroundColor: Colors.grey[300]!,
//           ),
//           Row(
//             children: [
//               ElevatedButton(
//                 onPressed: () => controller.saveSignature(),
//                 child: Text("Save Signature"),
//               ),
//               ElevatedButton(
//                 onPressed: () => controller.clearSignature(),
//                 child: Text("Clear"),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
