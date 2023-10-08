import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sjs_app/models/pooling_model.dart';
import 'package:sjs_app/repository/pooling_repo.dart';
import 'package:sjs_app/screens/home/tabs/pooling/create_new_pool.dart';
import 'package:sjs_app/widgets/pooling_card.dart';

class PoolingHome extends StatelessWidget {
  const PoolingHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 2.0,
                ),
                Center(
                  child: StreamBuilder<List<PoolingModel>>(
                      stream: PoolingRepository().getAllPoolStream(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<PoolingModel>> snapshot) {
                        List<PoolingModel> data =
                            snapshot.data ?? <PoolingModel>[];

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CupertinoActivityIndicator(
                            radius: 16.0,
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Something went wrong'),
                          );
                        }
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return PoolingCard(data: data[index]);
                            });
                      }),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                      builder: (context) => const CreateNewPool()))
                  .then((value) {});
            },
            child: const Icon(Icons.add)),
      ),
    );
  }
}
