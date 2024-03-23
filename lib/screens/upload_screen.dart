import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasheh/utils/color_utils.dart';

import 'package:tasheh/utils/upload.dart';
import 'package:tasheh/resources/image_store_methods.dart';




class up_screen extends StatefulWidget {
  const up_screen({super.key});

 /*
 , required this.title
 final String title;
*/
  @override
  State<up_screen> createState() => _up_screenState();
}

class _up_screenState extends State<up_screen> {

  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();

  bool _isLoading = false;
  void postImage() async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await ImageStoreMethods().uploadPost(
          _descriptionController.text,
          _file!
      );
      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackBar('Posted', context);
        clearImage();
      } else {
        setState(() {
          _isLoading = false;
        });
        showSnackBar(res, context);
      }
    } catch (err) {
      showSnackBar(err.toString(), context);
    }
  }

  void clearImage(){
    setState(() {
      _file = null;
    });
  }



  _imageSelect(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text('Select Image'),
            children: [

              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Take a Photo'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.camera,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),

              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Choose From Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickImage(
                    ImageSource.gallery,
                  );
                  setState(() {
                    _file = file;
                  });
                },
              ),

              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),



            ],
          );
        });

  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(72, 6, 7, 1),
        elevation: 0,
        title: Text('Add Event'),
      ),
      body:

      _file == null ?
      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: Center(
          child: Column(
            children: [
              SizedBox(height: 220),
              IconButton(
                icon: const Icon(Icons.camera_alt,
                  color: Color.fromRGBO(72, 6, 7, 1),
                ),
                onPressed: () => _imageSelect(context),
                iconSize: 150,
              ),
              const Text(
                'Add Event',
                style: TextStyle(fontSize: 36.0 , color: Color.fromRGBO(72, 6, 7, 1)),
              ),

            ],
          ),
        ),
      )
          :

      Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : const Padding(
                  padding: EdgeInsets.only(
                    top: 0,
                  ),
                ),

                const Divider(),
                SizedBox(
                  height: 300,
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: MemoryImage(_file!),
                        fit: BoxFit.fill,
                        alignment: FractionalOffset.topCenter,
                      ),
                    ),
                  ),
                ),

                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.20,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          hintText: 'Write a Description',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    ElevatedButton(onPressed: postImage, child: Text("Post"))
                  ],
                )
              ],
            ),
          ),
        ),
      ),

    );
  }
}