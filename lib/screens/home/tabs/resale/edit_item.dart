import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sjs_app/models/resale_model.dart';
import 'package:sjs_app/services/database.dart';

class EditItem extends StatefulWidget {
  final ResaleModel resaleModel;
  const EditItem({super.key, required this.resaleModel});

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemTypeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  File? imageFile;
  bool isLoading = false;
  late Widget containerChild;
  @override
  void initState() {
    itemNameController.text = widget.resaleModel.sellItem;
    itemTypeController.text = widget.resaleModel.type;
    descriptionController.text = widget.resaleModel.description;
    priceController.text = widget.resaleModel.price.toString();
    containerChild = ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        child: Image.network(
          widget.resaleModel.imageUrl,
          fit: BoxFit.fill,
        ));
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
                        "Edit Item \nDetails",
                        style: GoogleFonts.oswald(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Item name"),
                        controller: itemNameController,
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Item type"),
                        controller: itemTypeController,
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
                        controller: priceController,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Description"),
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                        controller: descriptionController,
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
                            setState(() {
                              isLoading = true;
                            });

                            final databaseServices = DatabaseServices();
                            String? url;
                            if (imageFile != null) {
                              url = await databaseServices
                                  .uploadImage(imageFile!);
                            } else {
                              url = widget.resaleModel.imageUrl;
                            }
                            await databaseServices
                                .updateResaleItem(
                                    widget.resaleModel.docId,
                                    itemNameController.text,
                                    itemTypeController.text,
                                    double.parse(priceController.text),
                                    descriptionController.text,
                                    url!,
                                    widget.resaleModel.buyDate)
                                .then((value) {
                              setState(() {
                                isLoading = false;
                              });
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            });
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
