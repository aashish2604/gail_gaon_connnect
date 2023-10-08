import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sjs_app/services/database.dart';

class AddNewResaleItem extends StatefulWidget {
  const AddNewResaleItem({super.key});

  @override
  State<AddNewResaleItem> createState() => _AddNewResaleItemState();
}

class _AddNewResaleItemState extends State<AddNewResaleItem> {
  late String itemName, itemType, description;
  late double price;
  File? imageFile;
  bool isLoading = false;
  Widget defaultContainerChild = const Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Icon(Icons.image), Text("Click to add image")],
    ),
  );
  late Widget containerChild;
  @override
  void initState() {
    containerChild = defaultContainerChild;
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    Widget imageBox() {
      return Center(
        child: GestureDetector(
          onTap: () async {
            final result =
                await FilePicker.platform.pickFiles(type: FileType.image);
            if (result != null) {
              imageFile = File(result.files.single.path!);
              Image img = Image.file(
                imageFile!,
                fit: BoxFit.fill,
              );
              setState(() {
                containerChild = ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: img,
                );
              });
            }
          },
          child: Container(
            height: 200.0,
            width: screenWidth - 32,
            decoration: BoxDecoration(
                color: Colors.black26,
                border: Border.all(width: 1.5, color: Colors.black38),
                borderRadius: const BorderRadius.all(Radius.circular(20.0))),
            child: containerChild,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(
                radius: 20.0,
              ),
            )
          : Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      Text(
                        "Add Item \nDetails",
                        style: GoogleFonts.oswald(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Item name"),
                        onChanged: (value) => itemName = value,
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Item type"),
                        onChanged: (value) => itemType = value,
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Price"),
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                        onChanged: (value) => price = double.parse(value),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Description"),
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                        onChanged: (value) => description = value,
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      imageBox(),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Note : Prefer a landscape image for better visibility",
                        style: TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      Center(
                          child: TextButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (containerChild != defaultContainerChild) {
                              setState(() {
                                isLoading = true;
                              });

                              final databaseServices = DatabaseServices();
                              final url = await databaseServices
                                  .uploadImage(imageFile!);
                              if (url != null) {
                                await databaseServices
                                    .addResaleItem(itemName, itemType, price,
                                        description, url)
                                    .then((value) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context).pop();
                                });
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Upload image to proceed");
                            }
                          }
                        },
                        style:
                            TextButton.styleFrom(backgroundColor: Colors.blue),
                        child: const Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                    ],
                  ),
                ),
              )),
    );
  }
}
