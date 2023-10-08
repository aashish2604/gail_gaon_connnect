import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sjs_app/models/pooling_model.dart';
import 'package:sjs_app/screens/home/tabs/pooling/pooling_details.dart';
import 'package:sjs_app/services/theme.dart';

class PoolingCard extends StatelessWidget {
  final PoolingModel data;
  const PoolingCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: SizedBox(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => PoolingDetails(model: data))),
          child: Card(
            elevation: 5.0,
            color: kCatsKillWhiteColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Builder(builder: (context) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        data.name.length > 13
                            ? '${data.name.substring(0, 13)}...'
                            : data.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 18.0),
                      ),
                      subtitle: Text(
                        DateFormat("d MMM yyyy").format(data.date),
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: Colors.grey[500]),
                      ),
                      trailing: Text(
                        "₹ ${data.price.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[900],
                            fontSize: 18),
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Divider(color: Colors.black26, height: 1.5),
                    const SizedBox(
                      height: 15.0,
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
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              data.travellingFrom,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "To:",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            Text(
                              data.travellingTo,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
