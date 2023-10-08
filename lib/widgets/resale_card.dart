import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sjs_app/models/resale_model.dart';
import 'package:sjs_app/screens/home/tabs/resale/resale_item_details.dart';

class ResaleCard extends StatelessWidget {
  final ResaleModel data;
  const ResaleCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ResaleItemDetails(model: data))),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Builder(builder: (context) {
                // double screenHeight = MediaQuery.of(context).size.height;
                return Column(
                  children: [
                    SizedBox(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          data.imageUrl,
                          fit: BoxFit.fill,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: SizedBox(
                                height: 200,
                                width: 200,
                                child: Padding(
                                  padding: const EdgeInsets.all(80),
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              ),
                            );
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return const Center(child: Text('No image'));
                          },
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        data.sellItem.length > 13
                            ? '${data.sellItem.substring(0, 13)}...'
                            : data.sellItem,
                        style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 18.0),
                      ),
                      subtitle: Text(
                        "${data.type} •  ${DateFormat("d MMM yyyy").format(data.buyDate)}",
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
