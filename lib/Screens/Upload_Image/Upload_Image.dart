// import 'dart:io';

// import 'package:firebase1/Utiles/message_Utiles.dart';
// import 'package:firebase1/constant/RoundedButton.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// class UploadImage extends StatefulWidget {
//   const UploadImage({super.key});

//   @override
//   State<UploadImage> createState() => _UploadImageState();
// }

// class _UploadImageState extends State<UploadImage> {
//   bool loading = false;
//   final databaseRef = FirebaseDatabase.instance.ref('Post');
//   firebase_storage.FirebaseStorage storage =
//       firebase_storage.FirebaseStorage.instance;

//   File? _image;
//   final _imagePicker = ImagePicker();

//   Future getGallaryImage() async {
//     final pickedFile = await _imagePicker.pickImage(
//         source: ImageSource.gallery, imageQuality: 80);
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         debugPrint('No Image Selected');
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Upload Image"),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: InkWell(
//                 onTap: () {
//                   getGallaryImage();
//                 },
//                 child: Container(
//                   width: 200,
//                   height: 200,
//                   decoration:
//                       BoxDecoration(border: Border.all(color: Colors.black)),
//                   child: _image != null
//                       ? Image.file(_image!.absolute)
//                       : const Icon(
//                           Icons.image,
//                           size: 50,
//                         ),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 50),
//             RoundedButton(
//               loading: loading,
//               title: 'Upload',
//               ontap: () async {
//                 setState(() {
//                   loading = true;
//                 });
//                 String id = DateTime.now().millisecondsSinceEpoch.toString();
//                 firebase_storage.Reference ref =
//                     firebase_storage.FirebaseStorage.instance.ref('/Image/$id');
//                 firebase_storage.UploadTask uploadTask =
//                     ref.putFile(_image!.absolute);

//                 Future.value(uploadTask).then((value) {
//                   var newURL = ref.getDownloadURL();
//                   String id = DateTime.now().millisecondsSinceEpoch.toString();
//                   databaseRef.child('id').set(
//                       {'id': id, 'title': newURL.toString()}).then((value) {
//                     setState(() {
//                       loading = false;
//                     });
//                     Uitles().meesage('Image Uploaded');
//                   }).onError((error, stackTrace) {
//                     setState(() {
//                       loading = false;
//                     });
//                     Uitles().meesage(error.toString());
//                   });
//                 }).onError(
//                   (error, stackTrace) {
//                     Uitles().meesage(error.toString());
//                   },
//                 );
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
