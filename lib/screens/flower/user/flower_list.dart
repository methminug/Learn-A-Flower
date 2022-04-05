import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:learn_a_flower_app/helpers/colors.dart';
import 'package:learn_a_flower_app/models/flower.dart';
import 'package:learn_a_flower_app/screens/flower/user/flower_details.dart';
import 'package:learn_a_flower_app/screens/flower/user/widgets/grid_tile_footer.dart';
import 'package:learn_a_flower_app/screens/flower/user/widgets/image_box.dart';
import 'package:learn_a_flower_app/screens/flower/user/widgets/text_slider.dart';
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
              title: const Text(
                "Learn About Flowers",
                style: TextStyle(color: Colors.white),
              ),
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
                              items: const [
                                TextSlider(
                                    color: Colors.indigo,
                                    text:
                                        'Flowers can help heal the common cold.',
                                    icon: Icons.ac_unit_rounded),
                                TextSlider(
                                    color: Colors.deepPurpleAccent,
                                    text:
                                        'Flowers can help improve people mood.',
                                    icon: Icons.tag_faces_sharp),
                                TextSlider(
                                    color: Colors.blueGrey,
                                    text: 'Flowers increase energy.',
                                    icon: Icons.wb_sunny_sharp)
                              ],
                              //Slider Container properties
                              options: CarouselOptions(
                                height: 100,
                                enlargeCenterPage: true,
                                autoPlay: true,
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
                        const SizedBox(height: 15),
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
                                              mainAxisSpacing: 20),
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
                                                    title: retrievedFlowerList![
                                                            index]
                                                        .flowerName,
                                                    descriptions:
                                                        retrievedFlowerList![
                                                                index]
                                                            .flowerDescription,
                                                    img: retrievedFlowerList![
                                                            index]
                                                        .flowerImage,
                                                    url: retrievedFlowerList![
                                                            index]
                                                        .flowerInfoURL,
                                                  );
                                                });
                                          },
                                          //References: https://api.flutter.dev/flutter/material/GridTile-class.html
                                          child: GridTile(
                                              footer: GridTileFooter(
                                                  flowerName:
                                                      retrievedFlowerList![
                                                              index]
                                                          .flowerName),
                                              child: ImageBox(
                                                flowerImage:
                                                    retrievedFlowerList![index]
                                                        .flowerImage,
                                              )),
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
}
