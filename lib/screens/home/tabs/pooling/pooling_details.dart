import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sjs_app/models/pooling_model.dart';
import 'package:sjs_app/screens/home/tabs/pooling/edit_pool.dart';
import 'package:sjs_app/services/database.dart';
import 'package:url_launcher/url_launcher.dart';

class PoolingDetails extends StatelessWidget {
  final PoolingModel model;
  const PoolingDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        actions: uid == model.uid
            ? [
                PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem<int>(value: 0, child: Text("Edit")),
                    const PopupMenuItem<int>(value: 1, child: Text("Delete")),
                  ],
                  onSelected: (val) async {
                    if (val == 0) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditPool(poolingModel: model)));
                    } else {
                      await DatabaseServices()
                          .deletePool(model.docId)
                          .then((value) {
                        Fluttertoast.showToast(msg: "Deleted successfully");
                        Navigator.of(context).pop();
                      });
                    }
                  },
                )
              ]
            : null,
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Row(
                            children: [
                              Text(
                                model.name,
                                style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            "${DateFormat("d MMM yyyy").format(model.date)} ",
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 12,
                                color: Colors.grey),
                          ),
                          trailing: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border: Border.all(color: Colors.grey)),
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black),
                                ),
                                Text(
                                  '₹ ${model.price.toString()}',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.green),
                                )
                              ],
                            ),
                          ),
                        ),
                        div(),
                        const SizedBox(
                          height: 14.0,
                        ),
                        decoratedItemBox(itemText: "Details"),
                        const SizedBox(
                          height: 12.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "From:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  model.travellingFrom,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                )
                              ],
                            ),
                            const Divider(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "To:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  model.travellingTo,
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 36.0,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Numnber of Seats:  ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: model.noOfSeats.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.black))
                        ])),
                        RichText(
                            text: TextSpan(children: [
                          const TextSpan(
                              text: "Vacant Seats:  ",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          TextSpan(
                              text: model.vacantSeats.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.black))
                        ])),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(width: 1.0, color: Colors.black26),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 8, top: 8.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      const TextSpan(
                          text: "Phone No:  ",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey)),
                      TextSpan(
                          text: model.contactNo,
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.black))
                    ])),
                    TextButton.icon(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Uri uri = Uri(scheme: "tel", path: model.contactNo);
                        launchUrl(uri);
                      },
                      label: const Text(
                        "Call",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

SizedBox comBox({required String postpay, required String text}) {
  return SizedBox(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
            text: TextSpan(
                text: "₹$postpay",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade900),
                children: [
              TextSpan(
                text: "/post",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700]),
              )
            ])),
        Text(
          "$text ",
          style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Colors.grey[400]),
        )
      ],
    ),
  );
}

Padding reqBoxText({required String leadtext, required String endText}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: RichText(
      text: TextSpan(
          text: "\u2022 $leadtext : ",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[400],
          ),
          children: [
            TextSpan(
              text: "$endText ",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            )
          ]),
    ),
  );
}

Divider div() {
  return const Divider(
    color: Colors.black12,
    thickness: 1.5,
  );
}

Padding cardList({required String cardText, required String icon}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    child: Row(
      children: [
        SizedBox.square(dimension: 25, child: Image.asset(icon)),
        const SizedBox(
          width: 8,
        ),
        Text(
          cardText,
          style: const TextStyle(fontWeight: FontWeight.w400),
        )
      ],
    ),
  );
}

decoratedItemBox({required String itemText}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.black38)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                text: const TextSpan(
                  text: "✦ ",
                  style: TextStyle(color: Color(0xffF8476E), fontSize: 15),
                ),
              ),
              Text(
                itemText,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
