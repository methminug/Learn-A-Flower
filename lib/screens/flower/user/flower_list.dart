import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/models/flower.dart';
import 'package:learn_a_flower_app/screens/flower/user/flower_details.dart';
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
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0Xffe7f5e7),
            appBar: AppBar(
              elevation: 10,
              backgroundColor: AppColors.blueGreen,
              title: const Text("Learn About Flowers", style: TextStyle(color: Colors.white),),
            ),
            body: RefreshIndicator(
                onRefresh: _refresh,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            // References: https://www.geeksforgeeks.org/flutter-carousel-slider/ & https://pub.dev/packages/carousel_slider
                            CarouselSlider(
                              items: [
                                textSlider(context, Colors.indigo, 'Flowers can help heal the common cold.', Colors.white, Icons.ac_unit_rounded),
                                textSlider(context, Colors.deepPurpleAccent, 'Flowers can help improve people mood.', Colors.white, Icons.tag_faces_sharp),
                                textSlider(context, Colors.blueGrey, 'Flowers increase energy.', Colors.white, Icons.wb_sunny_sharp)
                              ],
                              //Slider Container properties
                              options: CarouselOptions(
                                height: 100,
                                enlargeCenterPage: true,
                                autoPlay: true,
                                // aspectRatio: 2 / 3,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll: true,
                                autoPlayAnimationDuration:
                                    const Duration(milliseconds: 800),
                                viewportFraction: 0.8,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Explore Flowers',
                              style: TextStyle(
                                  color: Color(0xff00A02E),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Expanded(
                          child: FutureBuilder(
                            future: flowerList,
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Flower>> snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  //References: https://www.kindacode.com/article/flutter-gridview-builder-example/
                                  child: GridView.builder(
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              childAspectRatio: 1,
                                              maxCrossAxisExtent: 200,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20
                                          ),
                                      itemCount: retrievedFlowerList!.length,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      padding: const EdgeInsets.all(8),
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            // References: https://medium.flutterdevs.com/custom-dialog-in-flutter-7ca5c2a8d33a
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return CustomDialogBox(
                                                    title: retrievedFlowerList![index].flowerName,
                                                    descriptions: retrievedFlowerList![index].flowerDescription,
                                                    img: retrievedFlowerList![index].flowerImage,
                                                    url: retrievedFlowerList![index].flowerInfoURL,
                                                  );
                                                });
                                          },
                                          //References: https://api.flutter.dev/flutter/material/GridTile-class.html
                                          child: GridTile(
                                              footer: gridTileFooter(
                                                  context,
                                                  retrievedFlowerList![index].flowerName),
                                              child: imageBox(
                                                  context,
                                                  retrievedFlowerList![index].flowerImage)
                                          ),
                                        );
                                      }),
                                );
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
                      ]),
                ))));
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

  //TODO:
  Widget gridTileFooter(BuildContext context, String flowerName) {
    return Material(
      color: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      clipBehavior: Clip.antiAlias,
      child: GridTileBar(
        backgroundColor: Colors.black45,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            flowerName,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget imageBox(BuildContext context, String flowerImage) {
    return Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        flowerImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget textSlider(
      BuildContext context, Color color, String text, Color textColor, IconData icon) {
    return Stack(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(6.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: color),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
              alignment: Alignment.centerRight,
              child: Icon(
                icon,
                size: 50,
                color: Colors.white,
              )),
        ),
        Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                text,
                style: TextStyle(fontSize: 20, color: textColor),
              ),
            ))
      ],
    );
  }
}
