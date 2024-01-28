import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:tourismappofficial/LocationBrain/Location.dart';
import 'package:tourismappofficial/Places/Nightlife.dart';
import 'package:tourismappofficial/Places/sights.dart';
import 'package:tourismappofficial/Places/Beaches.dart';
import 'package:tourismappofficial/const/Text_Styles.dart';
import 'package:tourismappofficial/pages/Detail_page.dart';
import 'package:tourismappofficial/provider/Provider_page.dart';
import 'package:provider/provider.dart';
import 'package:tourismappofficial/Places/place.dart';
import 'package:tourismappofficial/Places/restaurants.dart';
import 'package:tourismappofficial/LocationBrain/LocaitonUtils.dart';
import 'package:tourismappofficial/widgets/CustomDrawer.dart';
import 'package:tourismappofficial/Places/Hotels.dart';
import 'package:tourismappofficial/widgets/TabBarchild.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tourismappofficial/ad_state.dart';

class TheCityPage extends StatefulWidget {
  const TheCityPage({super.key});

  @override
  State<TheCityPage> createState() => _TheCityPageState();
}

class _TheCityPageState extends State<TheCityPage> {
  BannerAd? banner;
  String selectedPage= '';
  bool loadingScreen = false;
  List<Place> sortedRestaurants = [];
  List<Place> unsortedRestaurants = [];
  List<Place> sortedHotels = [];
  List<Place> unsortedHotels = [];
  List<Place> sortedNigthlife = [];
  List<Place> unsortedNigthlife = [];
  List<Place> sortedBeaches = [];
  List<Place> unsortedBeaches = [];
  List<Place> sortedSights = [];
  List<Place> unsortedSights = [];
  bool isLocationFetched = false;
  LocationData? userLocation;

  void sortPlacesByLocation(LocationData locationData, List<Place> placesToSort, Function(List<Place>) setSortedPlaces) async {
    List<Place> sortedList = await LocationUtils.sortPlacesByLocation(placesToSort, locationData);
    setState(() {
      setSortedPlaces(sortedList); // Update the appropriate sorted list
      isLocationFetched = true;
    });
  }
  bool isBannerAdLoaded = false; // Add this state variable

  Widget adWidget() {
    if (banner != null && isBannerAdLoaded) {
      return Container(
        height: banner!.size.height.toDouble(),
        width: double.infinity,
        child: AdWidget(ad: banner!),
        alignment: Alignment.center,
      );
    } else {
      return Container(); // Return an empty container when the ad is not loaded
    }
  }





  List<Place> allItems= [];
@override
  void dispose() {
  banner?.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
    final adState = Provider.of<AdState>(context, listen: false);

    adState.initialization.then((status) {
      banner = BannerAd(
        size: AdSize.banner,
        adUnitId: adState.bannerAdUnitId,
        listener: BannerAdListener(
          onAdLoaded: (Ad ad) {
            setState(() {
              isBannerAdLoaded = true; // Set this state when the ad is loaded
            });
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
          },
        ),
        request: AdRequest(),
      )..load();
    });
    var providerbrain = Provider.of<Data>(context, listen: false);
    Restaurants restaurants = Restaurants();
    Hotels hotels= Hotels();
    Sights sights = Sights();
    Beaches beaches = Beaches();
    Nightlife nightlife = Nightlife();

    if(providerbrain.city=='Nicosia') {
       allItems = hotels.nicosiaHotels + sights.nicosiaSights + beaches.nicosiaBeach +
          nightlife.nicosiaNight + restaurants.nicosiaRest;
    }
    if(providerbrain.city=='Famagusta') {
       allItems = hotels.famagustaHotels + sights.famagustaSights + beaches.famagustaBeach +
          nightlife.famagustaNight + restaurants.famagustaRest;
    }
    if(providerbrain.city=='Limassol') {
       allItems = hotels.limassolHotels + sights.limassolSights + beaches.limassolBeach +
          nightlife.limassolNight + restaurants.limassolRest;
    }

    if(providerbrain.city=='Larnaca') {
       allItems = hotels.larnacaHotels + sights.larnacaSights + beaches.larnacaBeach +
          nightlife.larnacaNight + restaurants.larnacaRest;
    }
    if(providerbrain.city=='Paphos') {
       allItems= hotels.paphosHotels + sights.paphosSights + beaches.paphosBeach +
          nightlife.paphosNight + restaurants.paphosRest;
    }

    unsortedRestaurants = restaurants.getRestoraunt(providerbrain.city);
    unsortedHotels = hotels.getHotel(providerbrain.city);
    unsortedSights = sights.getSight(providerbrain.city);
    unsortedBeaches = beaches.getBeach(providerbrain.city);
    unsortedNigthlife = nightlife.getNight(providerbrain.city);
    isLocationFetched = false;

  }
  List<Place> suggestions = []; // List of Place objects for suggestions

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    var providerbrain = Provider.of<Data>(context, listen: false);
  

    return SafeArea(
      child: DefaultTabController(
        length: 5,
        child: Column(
          children: [
            Expanded(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
                drawer: const CustomDrawer(),
                body: SafeArea(
                  child: Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_sharp, size: 28)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, right: 12),
                            child: IconButton(
                              onPressed: () async {
                                try {
                                  setState(() {
                                    loadingScreen = true;
                                  });

                                  MyLocationService locationbrain = MyLocationService();
                                  LocationData? locationData = await locationbrain.getLocation();
                                  if (locationData != null) {
                                    setState(() {
                                      userLocation = locationData;
                                      sortPlacesByLocation(locationData, unsortedRestaurants, (sortedList) => sortedRestaurants = sortedList);
                                      sortPlacesByLocation(locationData, unsortedHotels, (sortedList) => sortedHotels = sortedList);
                                      sortPlacesByLocation(locationData, unsortedBeaches, (sortedList) => sortedBeaches = sortedList);
                                      sortPlacesByLocation(locationData, unsortedNigthlife, (sortedList) => sortedNigthlife = sortedList);
                                      sortPlacesByLocation(locationData, unsortedSights, (sortedList) => sortedSights = sortedList);
                                    });
                                  }
                                }
                                 finally {
                                  setState(() {
                                    loadingScreen = false;
                                  });
                                }
                              },
                              icon: const Icon(Icons.location_on_outlined, size: 40 , color: Colors.black,),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, top: 20, bottom: 50),
                        child: Text(
                          'Explore ${providerbrain.city}',
                          style: kCityText
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20, right: 20),
                                child: TypeAheadField<Place>(
                                  textFieldConfiguration: TextFieldConfiguration(
                                    autofocus: false, // focus when open page
                                    controller: controller, // We create a textEditing Controller
                                    decoration: InputDecoration(
                                      hintText: 'Search', // the hint text
                                      prefixIcon: const Icon(Icons.search), // Search icon
                                      border: OutlineInputBorder( // border Decoration
                                        borderRadius: BorderRadius.circular(30.0),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true, // text color
                                      fillColor: Colors.grey[200], // Light grey fill color for text
                                    ),
                                  ),
                                  suggestionsCallback: (pattern) {
                                    return allItems
                                        .where((country) => country.name!.toLowerCase().contains(pattern.toLowerCase()))
                                        .toList();
                                  }, // the list of suggestions
                                  itemBuilder: (context, Place suggestion) {
                                    return ListTile(
                                      title: Text(suggestion.name!),
                                    );
                                  }, // each suggestion which appears
                                  onSuggestionSelected: (Place suggestion) {
                                    // Handle when a suggestion is selected.
                                    controller.text = suggestion.name!;
                                   
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(place: suggestion),
                                      ),); }
                                  , // when suggestion selected
                                ),
                              ),
                            ),
                          ),
                        ],)
                      ,Row(
                        children: [
                          Expanded(
                            child: TabBar(
                              isScrollable: true,
                              labelColor: Colors.black.withOpacity(0.6), // Non-const expression
                              tabs: const [
                                Tab(text: 'Food'),
                                Tab(text: 'Hotels'),
                                Tab(text: 'Venues'),
                                Tab(text: 'Beaches'),
                                Tab(text: 'Attractions')
                              ],
                            ),
                          ),
                        ],
                      ),

                      Flexible(
                        child: loadingScreen
                            ? const Center(child:  CircularProgressIndicator())
                            : SizedBox(
                          height: 300,
                          width: double.infinity,
                          child: TabBarView(
                            children: [
                              TabBarchild(isLocationFetched: isLocationFetched, sortedPlaces: sortedRestaurants, unsortedPlaces: unsortedRestaurants, userLocation: userLocation),
                              TabBarchild(isLocationFetched: isLocationFetched, sortedPlaces: sortedHotels, unsortedPlaces: unsortedHotels, userLocation: userLocation),
                              TabBarchild(isLocationFetched: isLocationFetched, sortedPlaces: sortedNigthlife, unsortedPlaces: unsortedNigthlife, userLocation: userLocation),
                              TabBarchild(isLocationFetched: isLocationFetched, sortedPlaces: sortedBeaches, unsortedPlaces: unsortedBeaches, userLocation: userLocation),
                              TabBarchild(isLocationFetched: isLocationFetched, sortedPlaces: sortedSights, unsortedPlaces: unsortedSights, userLocation: userLocation),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height/15,),
                      adWidget()


              ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}








