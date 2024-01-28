import 'package:flutter/material.dart';
import 'package:tourismappofficial/Places/place.dart';
import 'package:tourismappofficial/const/Text_Styles.dart';
import 'package:tourismappofficial/provider/Provider_page.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:tourismappofficial/widgets/DynamicMap.dart';

class DetailPage extends StatefulWidget {
 final Place place;

   const DetailPage({super.key, required this.place});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isExpanded=false;
  double descriptionHeight = 40;
  bool? favouritepress;
  @override
  Widget build(BuildContext context) {
    final Data providerbrain = Provider.of<Data>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Hero(
          tag: 'picture${widget.place.lat}',
          child: Material(
            child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(widget.place.imagePath!),
                fit: BoxFit.cover
            ),
          ),

   child: Stack(
            children: [
              Positioned(
                  top: 0,
                     right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Flexible(
                  child: Material( color: Colors.transparent,

                      child: IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_sharp, color: Colors.black, size: 35))),
                ),
                  Flexible(
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (providerbrain.favouriteList.any((p) => p.lat == widget.place.lat)) {

                              // Find the place in the list with the same latitude and remove it
                              Place foundPlace = providerbrain.favouriteList.firstWhere((p) => p.lat == widget.place.lat);
                              providerbrain.removeFromFavouriteListByPlace(foundPlace);
                            } else {

                              providerbrain.addToFavouriteList(widget.place.name,widget.place.imagePath!,widget.place.lat,widget.place.long,widget.place.city,widget.place.category, widget.place.description,widget.place.id! );
                            }

                          });
                        },
                        icon: providerbrain.favouriteList.any((p) => p.lat == widget.place.lat)
                            ? StreamBuilder<Object>(
                              stream: null,
                              builder: (context, snapshot) {
                                return const Icon(Icons.favorite, color: Colors.red, size: 35);
                              }
                            ) // If a place with the same latitude is in favorites, show filled heart
                            : const Icon(Icons.favorite_outline, color: Colors.red, size: 35,), // Otherwise, show outlined heart
// Otherwise, show outlined heart
                      ),
                    ),
                  )
                ],
              )),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
        curve: Curves.easeInBack,

        top: isExpanded? MediaQuery.sizeOf(context).height/18: MediaQuery.sizeOf(context).height/1.8 ,
        left: 20,
        right: 20,
        bottom: 20,
        child: SingleChildScrollView(
          child: ClipRRect(

        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCirc,
                decoration: BoxDecoration(
                    color:  Colors.transparent.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.transparent.withOpacity(0.0),
                          spreadRadius: 0,
                          blurRadius: 8,
                          offset: const Offset(0, 3)
                      )
                    ]
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(height:10 ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          height: 5,
                          width: 70,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          height: 20,
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Flexible(child: Text('${widget.place.name}', style:  klocation2, textAlign: TextAlign.center,))
                      ],
                    ),
                    Row(

                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                            width: 10
                        ),
                        const Icon(Icons.location_on_outlined, color: Colors.white),
                        const SizedBox(width: 5),
                        Flexible(child: Text('${widget.place.city}', style:  overTransition)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(Icons.travel_explore_outlined, color: Colors.white),
                        const SizedBox(width: 5),
                        Flexible(child: Text('${widget.place.category}', style: kDescription))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(Icons.description_outlined, color: Colors.white),
                        ),
                        const SizedBox(width: 5),
                        // Conditional statement based on whether Expanded is true or false
                        if (isExpanded) // assuming `expanded` is a boolean variable
                          Expanded(
                            child: Text(
                              '${widget.place.description}',
                              style: kDescription
                            ),
                          )
                        else
                          Expanded(
                            child: Text(
                              '${widget.place.description}',
                              overflow: TextOverflow.ellipsis,
                              style: kDescription,
                              maxLines: 1,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Visibility(
                      visible: isExpanded,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: AnimatedContainer(
                                  curve: Curves.easeIn,
                                  duration: const Duration(milliseconds: 300),
                                  height: 200,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage('${widget.place.imagePath}'), fit: BoxFit.cover)
                                  ),
                                ),
                              )
                            ],
                          ),

                              const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text('Location', style: overTransition,),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                       Row(
                         children: [
                         Expanded(child: MapSample(widget.place))
                         ],
                       )
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
                            child: GestureDetector(
                              onTap: (){
                                setState(() {
                                  isExpanded=!isExpanded;
                                });

                              },
                              child: Container(

                                  alignment: Alignment.center,
                                  decoration:BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.transparent,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2), // Adjust color opacity as needed
                                        spreadRadius: 0,
                                        blurRadius:0, // Adjust blur radius to change the extent of the shadow
                                        offset: const Offset(3, 3), // Changes position of shadow
                                      ),
                                    ],
                                  ),
                                  width: 300,
                                  height: 70,
                                  child:

                                  Text( !isExpanded ?'See More': 'See Less', style: kTextButton

                                  )

                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )

            ),
        ),
          ),
        ))
    ]
    )),
          ))));

  }
}
