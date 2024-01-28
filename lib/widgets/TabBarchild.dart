import 'package:flutter/material.dart';
import 'package:tourismappofficial/const/Text_Styles.dart';
import 'package:tourismappofficial/pages/Detail_page.dart';
import 'package:location/location.dart';
import 'package:tourismappofficial/Places/place.dart';
import 'package:tourismappofficial/LocationBrain/LocaitonUtils.dart';

class TabBarchild extends StatefulWidget {
  final LocationData? userLocation;
  final bool isLocationFetched;
  final List<Place> sortedPlaces;
  final List<Place> unsortedPlaces;

  const TabBarchild({
    Key? key,
    required this.isLocationFetched,
    required this.sortedPlaces,
    required this.unsortedPlaces,
    required this.userLocation,
  }) : super(key: key);

  @override
  State<TabBarchild> createState() => _TabBarchildState();
}

class _TabBarchildState extends State<TabBarchild> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.isLocationFetched ? widget.sortedPlaces.length : widget.unsortedPlaces.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        if ((widget.isLocationFetched && widget.sortedPlaces.isEmpty) || (!widget.isLocationFetched && widget.unsortedPlaces.isEmpty)) {
          return const Center(child: Text("No places available"));
        }

        Place place = widget.isLocationFetched ? widget.sortedPlaces[index] : widget.unsortedPlaces[index];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(place: place),
              ),
            );
          },
          child: Hero(
            tag: 'picture${place.lat}',
            child: Material(
              child: Stack(
                children: [
                  Opacity(
                    opacity: 0.85,
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width / 2.8,
                      margin: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 10,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(place.imagePath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 25,
                    bottom: 25,
                    child: FutureBuilder<double>(
                      future: widget.userLocation != null
                          ? LocationUtils.calculateDistance(
                          widget.userLocation!.latitude!,
                          widget.userLocation!.longitude!,
                          place.lat!,
                          place.long!)
                          : Future.value(0.0),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const SizedBox(width: 20, height: 20, child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Text("Error");
                        } else {
                          String distanceDisplay = snapshot.data == 0.0 ? '? km' : '${snapshot.data!.toStringAsFixed(1)} km';
                          return Container(
                            height: 30,
                            width: 190,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Flexible(child: Icon(Icons.directions_walk, color: Colors.white)),
                                const SizedBox(width: 5),
                                Flexible(
                                  child: Text(
                                    distanceDisplay,
                                    overflow: TextOverflow.ellipsis,
                                    style: kOverTabBar,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  Positioned(
                    bottom: 50,
                    left: 20,
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                          place.name!,
                          style: kOverTabBar2
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
