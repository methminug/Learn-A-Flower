import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/models/flower.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/screens/flower/admin/widgets/form_image.dart';
import 'package:learn_a_flower_app/screens/flower/admin/widgets/text_content.dart';
import 'package:learn_a_flower_app/services/flower_service.dart';

class FlowerDashboardScreen extends StatefulWidget {
  const FlowerDashboardScreen({Key? key}) : super(key: key);

  @override
  _FlowerDashboardScreenState createState() => _FlowerDashboardScreenState();
}

class _FlowerDashboardScreenState extends State<FlowerDashboardScreen> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0Xffe7f5e7),
        appBar: AppBar(
            backgroundColor: AppColors.blueGreen,
            elevation: 10,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Flower Management',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: flowerList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Flower>> snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            itemCount: retrievedFlowerList!.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Dismissible(
                                    onDismissed: ((direction) async {
                                      await flowerService.deleteFlower(retrievedFlowerList![index].id.toString());
                                      _dismiss();
                                    }),
                                    background: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(20.0)),
                                      padding: const EdgeInsets.only(right: 28.0),
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: const Text(
                                        'Delete',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    direction: DismissDirection.endToStart,
                                    resizeDuration:
                                        const Duration(milliseconds: 200),
                                    key: UniqueKey(),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, AppRoutes.EDIT_FLOWER,
                                            arguments: retrievedFlowerList![index]);
                                      },
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Row(
                                            children: [
                                              FormImageBox(imageUrl: retrievedFlowerList![index].flowerImage, width: 125, height: 120),
                                              const SizedBox(width: 20.0,),
                                              Expanded(
                                                  child: TextContent(flowerName:  retrievedFlowerList![index].flowerName, flowerDescription:  retrievedFlowerList![index].flowerDescription)
                                                  )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            });
                      } else if (snapshot.connectionState ==
                              ConnectionState.done &&
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
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.blueGreen,
          onPressed: (() {
            Navigator.pushNamed(context, AppRoutes.ADD_FLOWER);
          }),
          tooltip: 'Add New Flower',
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
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

  // Widget textContent(
  //     BuildContext context, String flowerName, String flowerDescription) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.stretch,
  //     children: [
  //       Text(
  //         flowerName,
  //         maxLines: 2,
  //         overflow: TextOverflow.ellipsis,
  //         style: const TextStyle(
  //           fontWeight: FontWeight.w600,
  //           fontSize: 18.0,
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 5.0,
  //       ),
  //       Text(
  //         flowerDescription,
  //         maxLines: 3,
  //         overflow: TextOverflow.ellipsis,
  //         style: const TextStyle(
  //           color: Color.fromRGBO(139, 144, 165, 1),
  //         ),
  //       ),
  //       const SizedBox(
  //         height: 5.0,
  //       ),
  //     ],
  //   );
  // }
}
