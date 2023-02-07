// ignore_for_file: use_build_context_synchronously, sized_box_for_whitespace

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sellers_app/brandsScreens/home_screen.dart';
import 'package:sellers_app/global/global.dart';
import 'package:sellers_app/splashScreen/my_splash_screen.dart';
import 'package:uuid/uuid.dart';

import '../widgets/progress_bar.dart';

class UploadBrandsScreen extends StatefulWidget {
  const UploadBrandsScreen({super.key});

  @override
  State<UploadBrandsScreen> createState() => _UploadBrandsScreenState();
}

class _UploadBrandsScreenState extends State<UploadBrandsScreen> {
  XFile? imageFile;

  TextEditingController brandInfoTextEditingController =
      TextEditingController();
  TextEditingController brandTitleTextEditingController =
      TextEditingController();

  bool isUploading = false;
  String downloadUrl = '';
  String brandUniqueId = const Uuid().v4();

  @override
  void dispose() {
    brandInfoTextEditingController.dispose();
    brandTitleTextEditingController.dispose();
    super.dispose();
  }

  saveBrandInfoToFirestore() {
    FirebaseFirestore.instance.collection('sellers').doc(sharedPreferences!.getString('uid')).collection('brands').doc(brandUniqueId).set({
      'brandID': brandUniqueId,
      'sellerID': sharedPreferences!.getString('uid'),
      'brandTitle': brandTitleTextEditingController.text.trim(),
      'brandInfo': brandInfoTextEditingController.text.trim(),
      'thumbnailUrl': downloadUrl,
      'publishedDate': DateTime.now(),
      'status': 'available',
    }).then((value) {
      Fluttertoast.showToast(
          msg: 'Brand added successfully', gravity: ToastGravity.CENTER);
      setState(() {
        isUploading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>  HomeScreen()));
    });
  }

  validateUploadForm() async{
    if (imageFile != null) {
      if (brandInfoTextEditingController.text.isNotEmpty &&
          brandTitleTextEditingController.text.isNotEmpty) {
        setState(() {
          isUploading = true;
        });
        //1. upload brand to storage - get download url
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          final storageRef = FirebaseStorage.instance.ref().child("sellersBrandImages").child("$fileName.jpg");
          final uploadTask = storageRef.putFile(File(imageFile!.path));
          downloadUrl = await (await uploadTask).ref.getDownloadURL();
        //2. upload brand info to firestore
         saveBrandInfoToFirestore();
      } else {
        Fluttertoast.showToast(
            msg: 'Please fill all the fields', gravity: ToastGravity.CENTER);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Please select an image', gravity: ToastGravity.CENTER);
    }
  }

  uploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purpleAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MySplashScreen()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30.0,
          ),
        ),
        title: const Text(
          'Upload New Brand',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
              isUploading? const Center(
                child: SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child: CircularProgressIndicator(color: Colors.white,))) : IconButton(
                  onPressed: () {
                    // validate upload form
                    validateUploadForm();
                  },
                  icon: const Icon(
                    Icons.cloud_upload,
                    color: Colors.white,
                    size: 30.0,
                  ),
                ),
          const SizedBox(
            width: 10.0,
          )
        ],
        centerTitle: true,
        elevation: 0.0,
      ),
      body: ListView(
        children: [

          isUploading ? linearProgressBar() :  Container(),

          SizedBox(
            height: 240.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(imageFile!.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
            indent: 22,
            endIndent: 22,
          ),
          ListTile(
            leading: const Icon(
              Icons.perm_device_information,
              color: Colors.deepPurple,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: brandInfoTextEditingController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'brand info',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
            indent: 22,
            endIndent: 22,
          ),
          ListTile(
            leading: const Icon(
              Icons.title,
              color: Colors.deepPurple,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                controller: brandTitleTextEditingController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'brand title',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const Divider(
            color: Colors.pinkAccent,
            thickness: 1,
            indent: 22,
            endIndent: 22,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return imageFile == null ? defaultScreen() : uploadFormScreen();
  }

  defaultScreen() {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.pinkAccent, Colors.purpleAccent],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text(
          'Add New Brand',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.purpleAccent],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_photo_alternate_outlined,
                color: Colors.white,
                size: 200.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                onPressed: () {
                  obtainImageDialogBox();
                },
                child: const Text(
                  'Add New Brand',
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  obtainImageDialogBox() {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            'Brand Image',
            style: TextStyle(
                color: Colors.deepPurple, fontWeight: FontWeight.bold),
          ),
          children: [
            SimpleDialogOption(
              child: const Text(
                'Capture image with Camera',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                pickImage(ImageSource.camera);
              },
            ),
            SimpleDialogOption(
              child: const Text(
                'Select image from Gallery',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                pickImage(ImageSource.gallery);
              },
            ),
            SimpleDialogOption(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  final ImagePicker _picker = ImagePicker();
  void pickImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    setState(() {
      imageFile = image;
    });
    Navigator.pop(context);
  }
}
