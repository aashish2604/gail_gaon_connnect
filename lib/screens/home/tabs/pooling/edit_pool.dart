import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sjs_app/models/pooling_model.dart';
import 'package:sjs_app/services/database.dart';

class EditPool extends StatefulWidget {
  final PoolingModel poolingModel;
  const EditPool({super.key, required this.poolingModel});

  @override
  State<EditPool> createState() => _EditPoolState();
}

class _EditPoolState extends State<EditPool> {
  TextEditingController poolNameController = TextEditingController();
  TextEditingController noOfSeatsController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController travellingFromController = TextEditingController();
  TextEditingController travellingToController = TextEditingController();
  TextEditingController vacantSeatsController = TextEditingController();
  bool isLoading = false;
  @override
  void initState() {
    poolNameController.text = widget.poolingModel.name;
    noOfSeatsController.text = widget.poolingModel.noOfSeats.toString();
    priceController.text = widget.poolingModel.price.toString();
    travellingFromController.text = widget.poolingModel.travellingFrom;
    travellingToController.text = widget.poolingModel.travellingTo;
    vacantSeatsController.text = widget.poolingModel.vacantSeats.toString();
    super.initState();
  }

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                        "Edit Pool \nDetails",
                        style: GoogleFonts.oswald(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Pool Name"),
                        controller: poolNameController,
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        decoration:
                            const InputDecoration(labelText: "Number of seats"),
                        controller: noOfSeatsController,
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
                            const InputDecoration(labelText: "Travelling from"),
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                        controller: travellingFromController,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Travelling To"),
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                        controller: travellingToController,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Vacant Seats"),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                        controller: vacantSeatsController,
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

                            await databaseServices
                                .updatePool(
                                    poolNameController.text,
                                    int.parse(noOfSeatsController.text),
                                    double.parse(priceController.text),
                                    travellingFromController.text,
                                    travellingToController.text,
                                    int.parse(vacantSeatsController.text),
                                    widget.poolingModel.docId)
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
