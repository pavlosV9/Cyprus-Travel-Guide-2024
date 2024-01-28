import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tourismappofficial/const/Text_Styles.dart';
import 'package:tourismappofficial/pages/Detail_page.dart';
import 'package:tourismappofficial/provider/Provider_page.dart';
import 'package:provider/provider.dart';
import 'package:tourismappofficial/ad_state.dart';
class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  late Future<void> loadFuture;
  BannerAd? banner;
  bool isAdLoaded = false;
  @override
  void dispose() {
    banner?.dispose();
    super.dispose();
  }

  @override
  void initState() {

    loadFuture = Provider.of<Data>(context, listen: false).loadPlaces();
    final adState = Provider.of<AdState>(context, listen: false); // Set listen to false to avoid unnecessary rebuilds
    adState.initialization.then((status) {
      banner = BannerAd(
        size: AdSize.banner,
        adUnitId: adState.bannerAdUnitId,
        listener: adState.listener,
        request: AdRequest(),
      )..load();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final Data providerbrain1 = Provider.of<Data>(context); // Get provider data

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Favourites',
          style: kFavourites
        ),
      ),
      body: FutureBuilder(
        future: loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {

            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (providerbrain1.favouriteList.isEmpty) {

            return const Center(child: Text('Your favorites will show up here'));
          } else{

            return Consumer<Data>(
              builder: (context, brain, child) {
                return ListView.builder(
                    itemCount: brain.favouriteList.length+(isAdLoaded ? 1 : 0),
                    itemBuilder: (context, index) {
                      if(index==brain.favouriteList.length && isAdLoaded){
                        return banner!=null
                            ?Container(height: 100, child: AdWidget(ad: banner!),
                            alignment: Alignment.center,)
                            : SizedBox(height: 50);
                      }
                      var place = brain.favouriteList[index];
                      if (place.imagePath == null || place.imagePath!.isEmpty) {
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => DetailPage(place: place)
                          ));
                        },
                        child: Dismissible(
                          key: Key(place.lat.toString()), // Unique key for Dismissible
                          onDismissed: (direction) {
                            brain.removeFromFavouriteList(index);

                          },
                          child: Hero(
                            tag: 'picture${brain.favouriteList[index].lat}',
                            child: Material(
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                height: 150,
                                width: double.infinity,
                                // Set width to double.infinity for full width
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                    image: DecorationImage(
                                      image: AssetImage(place.imagePath ?? 'images/WelcomeImage3.jpg'),
                                      // Placeholder image asset
                                      fit: BoxFit.cover,)
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                        top: 5,
                                        left: 50,
                                        child:
                                        Text('${place.name}, ${place.category } ',
                                          overflow: TextOverflow.ellipsis,
                                          style: kOverTabBar
                                        )
                                    ),
                                    Positioned(
                                        top: 25,
                                        left: 50,
                                        child:
                                        Text('${place.city} ',
                                          overflow: TextOverflow.ellipsis,
                                          style: kOverTabBar
                                        )
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ); //
                    });
              },
            );
          }
        },
      ),
    );
  }}