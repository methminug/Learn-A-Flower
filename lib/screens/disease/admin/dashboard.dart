import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/models/disease.dart';
import 'package:learn_a_flower_app/routes/app_routes.dart';
import 'package:learn_a_flower_app/services/disease_service.dart';

class DiseaseDashboard extends StatefulWidget {
  const DiseaseDashboard({Key? key}) : super(key: key);

  @override
  _DiseaseDashboardState createState() => _DiseaseDashboardState();
}

class _DiseaseDashboardState extends State<DiseaseDashboard> {
  DiseaseService diseaseService = DiseaseService();
  Future<List<Disease>>? diseaseList;
  List<Disease>? retrievedDiseaseList;

  @override
  void initState() {
    super.initState();
    _initRetrieval();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Dashboard'),
                Icon(
                  Icons.local_florist_sharp,
                  size: 35,
                  // color: Color(0xff00A02E),
                ),
              ],
            )),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Explore Flower Diseases',
                      style: TextStyle(
                          color: Color(0xff00A02E),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: FutureBuilder(
                    future: diseaseList,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Disease>> snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                            itemCount: retrievedDiseaseList!.length,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                child: Dismissible(
                                    onDismissed: ((direction) async {
                                      await diseaseService.deleteDisease(
                                          retrievedDiseaseList![index]
                                              .id
                                              .toString());
                                      _dismiss();
                                    }),
                                    background: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                          BorderRadius.circular(16.0)),
                                      padding:
                                      const EdgeInsets.only(right: 28.0),
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
                                            context, AppRoutes.EDIT_DISEASE,
                                            arguments: retrievedDiseaseList![index]);
                                      },
                                      child: Card(
                                        semanticContainer: true,
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(10.0),
                                        ),
                                        elevation: 5,
                                        child: Row(
                                          children: [
                                            Image.network(
                                              retrievedDiseaseList![index].disease_image,
                                              height: 130,
                                              width: 150,
                                              fit: BoxFit.fill,
                                            ),
                                            Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 10.0,
                                                      bottom: 10.0,
                                                      left: 2.0,
                                                      right: 2.0),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        retrievedDiseaseList![index].disease_name,
                                                        textAlign: TextAlign.center,
                                                        style: const TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                        const EdgeInsets.only(
                                                            left: 5.0),
                                                        child: Text(
                                                          retrievedDiseaseList![index].disease_description,
                                                          style: const TextStyle(
                                                              fontSize: 14.0),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    )),
                              );
                            });
                      } else if (snapshot.connectionState ==
                          ConnectionState.done &&
                          retrievedDiseaseList!.isEmpty) {
                        return Center(
                          child: ListView(
                            children: const [
                              Align(
                                alignment: AlignmentDirectional.center,
                                child: Text('No flower disease to display'),
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
          onPressed: (() {
            Navigator.pushNamed(context, AppRoutes.ADD_DISEASE);
          }),
          tooltip: 'add',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _initRetrieval() async {
    diseaseList = diseaseService.retrieveDisease();
    retrievedDiseaseList = await diseaseService.retrieveDisease();
  }

  Future<void> _refresh() async {
    diseaseList = diseaseService.retrieveDisease();
    retrievedDiseaseList = await diseaseService.retrieveDisease();
    setState(() {});
  }

  void _dismiss() {
    diseaseList = diseaseService.retrieveDisease();
  }
}

