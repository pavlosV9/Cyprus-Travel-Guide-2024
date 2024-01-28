import 'package:flutter/material.dart';
import 'package:tourismappofficial/const/Text_Styles.dart';
import 'package:tourismappofficial/widgets/ReusableButton.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int index = 0;  // Renamed for clarity
  List<String> images = [
    'images/WelcomeImage1.jpg', // Correct paths to the images
    'images/WelcomeImage2.jpg',
    'images/WelcomeImage3.jpg'
    // Add more paths if you have more images
  ];
  List<String> textMain = [
    'WELCOME TO CYPRUS',
    '4 MILLION TOURISTS EVERY YEAR',
    'NATURAL PARADISE'

  ];
  List<String> textSecondary= [
    'Explore the Birthplace of Afrodite',
    'Four Times the Total Population',
    'The Beauty of Nature'

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xFF009CFF),
      body: Stack(
        children: [
          // Add Padding here
          PageView.builder(
            onPageChanged: (int newindex){
              setState(() {
                index=newindex;
              });
            },
            scrollDirection: Axis.vertical,
            itemCount: 3,
            itemBuilder: (context, pageIndex) {
              return Container(
                color: index==0 ?
                const Color(0xFF009CFF)
                :index==1
                ? const Color(0xFF060107)
                : const Color(0xFF2499DC),
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4.2),
                child: Container(

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(images[index]),

                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 7.9,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start (left)
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: Text(
                    textMain[index],
                    overflow: TextOverflow.visible,
                    style: kMainOverImage
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  child: Text(
                    textSecondary[index], // Additional text
                    style: kSecondOverImage
                  ),
                ),
                const SizedBox(height: 30,),
                ReusableButton(index)
              ],
            ),
          ),

          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (indexList) {
                return AnimatedContainer(
                     duration: const Duration(microseconds: 10),

                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: index == indexList ? 45 : 20,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == indexList
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }),
            ),
          ),

        ],
      ),
    );
  }
}
