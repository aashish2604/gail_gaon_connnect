import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjs_app/models/resale_model.dart';
import 'package:sjs_app/repository/resale_repo.dart';
import 'package:sjs_app/screens/home/tabs/resale/add_new_item.dart';
import 'package:sjs_app/widgets/resale_card.dart';

class ResaleHome extends StatefulWidget {
  const ResaleHome({super.key});

  @override
  State<ResaleHome> createState() => _ResaleHomeState();
}

class _ResaleHomeState extends State<ResaleHome> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            right: 8.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 2.0,
                ),
                const SizedBox(
                  height: 14.0,
                ),
                Center(
                  child: StreamBuilder<List<ResaleModel>>(
                      stream: ResaleRepository().getAvailableItemsStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<ResaleModel>> snapshot) {
                        List<ResaleModel> data =
                            snapshot.data ?? <ResaleModel>[];
                        if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CupertinoActivityIndicator(
                            radius: 16.0,
                          );
                        }
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final details = data[index];
                              return ResaleCard(
                                data: details,
                              );
                            });
                      }),
                ),
                const SizedBox(
                  height: 60.0,
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => const AddNewResaleItem()))
                  .then((value) {});
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
