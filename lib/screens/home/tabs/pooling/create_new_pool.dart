import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sjs_app/services/database.dart';

class CreateNewPool extends StatefulWidget {
  const CreateNewPool({super.key});

  @override
  State<CreateNewPool> createState() => _CreateNewPoolState();
}

class _CreateNewPoolState extends State<CreateNewPool> {
  late String poolName, travellingFrom, travellingTo;
  late double price;
  late int noOfSeats, vacantSeats;
  bool isLoading = false;
  @override
  void initState() {
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
                        "Add Pool \nDetails",
                        style: GoogleFonts.oswald(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 18.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Pool Name"),
                        onChanged: (value) => poolName = value,
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
                        onChanged: (value) => noOfSeats = int.parse(value),
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
                            const InputDecoration(labelText: "Travelling from"),
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                        onChanged: (value) => travellingFrom = value,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Travelling To"),
                        validator: (value) =>
                            value!.isEmpty ? "This is a required field" : null,
                        onChanged: (value) => travellingTo = value,
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
                        onChanged: (value) => vacantSeats = int.parse(value),
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
                                .addNewPool(poolName, noOfSeats, price,
                                    travellingFrom, travellingTo, vacantSeats)
                                .then((value) {
                              setState(() {
                                isLoading = false;
                              });
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
