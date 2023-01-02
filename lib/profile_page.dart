
import 'dart:io';
import 'package:avesproj/prediction_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key?key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        centerTitle: true,
        title: const Text('Aves Detection'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
    final ImagePicker _picker = ImagePicker();
    final img =
    await _picker.pickImage(source: ImageSource.gallery);
    final XFile imageTemp = XFile(img!.path);
    setState(() {
    image = img;
    });

    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PredictionPage(image: (imageTemp))));
    },
                label: const Text('Choose Image'),
                icon: const Icon(Icons.image),
                style: ElevatedButton.styleFrom(primary: Colors.black),
              ),
              ElevatedButton.icon(
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();
                  final img =
                  await _picker.pickImage(source: ImageSource.camera);
    final XFile imageTemp = XFile(img!.path);
                  setState(() {
                    image = img;
                  });
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => PredictionPage(image: (imageTemp))));
    },
                label: const Text('Take Photo'),
                icon: const Icon(Icons.camera_alt_outlined),
                style: ElevatedButton.styleFrom(primary: Colors.black),
              ),
            ],
          ),
          if (image != null)
            Expanded(
              child: Column(
                children: [
                  Expanded(child: Image.file(File(image!.path))),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        image = null;
                      });
                    },
                    label: const Text('Remove Image'),
                    icon: const Icon(Icons.close),
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                  ),
                ],
              ),
            )
          else
            const SizedBox(),
        ],
      ),
    );



  }
}
