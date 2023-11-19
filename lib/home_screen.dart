import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var name;
  var data;
  var loading = false;

  File? Image1;
  final _picker = ImagePicker();
  Future picImage_gallery() async {
    final pciked_image = await _picker.pickImage(source: ImageSource.gallery);
    Image1 = File(pciked_image!.path);
    loading = true;
    setState(() {});
    await resp();
    loading = false;
    setState(() {});
  }

  Future picImage_camer() async {
    final pciked_image = await _picker.pickImage(source: ImageSource.camera);
    Image1 = File(pciked_image!.path);
    loading = true;
    setState(() {});
    await resp();
    loading = false;
    setState(() {});
  }

  Future resp() async {
    var stream = Image1!.readAsBytes().asStream();
    stream.cast();
    // Map<String, dynamic> data = {
    //   "file": http.MultipartFile('file', stream, length),
    // };
    // var response = await http
    //     .post(Uri.parse('http://122.248.246.22:7263/predict'), body: data);
    var url = Uri.parse('http://122.248.246.22:7263/predict');
    // var url = Uri.parse('tcp://0.tcp.ap.ngrok.io:15571');
    var request = new http.MultipartRequest('POST', url);
    // request.fields['name'] = Image1!.length().toString();
    request.headers;
    // var multipart = MultipartFile("file", stream, length);
    request.files.add(await http.MultipartFile.fromPath('file', Image1!.path));
    debugPrint(request.toString());
    var response = await http.Response.fromStream(await request.send());
    data = jsonDecode(response.body);

    // if (response.statusCode.toInt() == 200) {
    //   print(response.body.toString());
    // } else {
    //   print(await response.body.toString());
    // }
    // if (response.statusCode == 200) {
    //   print('success');
    // } else {
    //   print(response.body.toString());
    // }
  }

  Future selectFile() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Wellcome',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 1,
              height: MediaQuery.of(context).size.height * 0.3,
              child: Image1 == null
                  ? Center(
                      child: Text('No image Selected'),
                    )
                  : Center(
                      child: Image.file(
                        File(Image1!.path).absolute,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: loading == true
                  ? CircularProgressIndicator()
                  : data == null
                      ? Text('')
                      : Text(
                          data['class'].toString(),
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  picImage_gallery();
                },
                child: Center(
                  child: Text(
                    'Pick Image',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  picImage_camer();
                },
                child: Center(
                  child: Text(
                    'Camera',
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
