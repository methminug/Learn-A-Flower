import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/flower.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/services/flower_service.dart';

class FlowerList extends StatefulWidget {
  const FlowerList({Key? key}) : super(key: key);

  @override
  _FlowerListState createState() => _FlowerListState();
}

class _FlowerListState extends State<FlowerList> {
  FlowerService flowerService = FlowerService();
  Future<List<Flower>>? flowerList;
  List<Flower>? retrievedFlowerList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Flowers"),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder(
            future: flowerList,
            builder:
                (BuildContext context, AsyncSnapshot<List<Flower>> snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemCount: retrievedFlowerList!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(retrievedFlowerList![index].flowerName),
                        decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(15)),
                      );
                    });
              } else if (snapshot.connectionState == ConnectionState.done &&
                  retrievedFlowerList!.isEmpty) {
                return Center(
                  child: ListView(
                    children: const [
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Text('No flowers to display'),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Navigator.pushNamed(context, AppRoutes.ADD_FLOWER);
        }),
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _initRetrieval() async {
    flowerList = flowerService.getFlowers();
    retrievedFlowerList = await flowerService.getFlowers();
  }

  Future<void> _refresh() async {
    flowerList = flowerService.getFlowers();
    retrievedFlowerList = await flowerService.getFlowers();
    setState(() {});
  }

  void _dismiss() {
    flowerList = flowerService.getFlowers();
  }
}
