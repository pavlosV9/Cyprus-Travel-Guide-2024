import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:tourismappofficial/const/Text_Styles.dart';
import 'package:tourismappofficial/provider/Provider_page.dart';
class CityPage extends StatelessWidget {
  const CityPage({super.key});


  @override
  Widget build(BuildContext context) {

   var providerbrain= Provider.of<Data>(context, listen: false);

    return Scaffold(

      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView.builder(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0), // Corrected MediaQuery call
          itemCount: 5,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
               providerbrain.selectCity(index);
               Navigator.pushNamed(context, '/TheCityPage');

              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.99,
                    height: MediaQuery.of(context).size.height * 0.189,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black54,
                        width: 2
                      ),

                      image: DecorationImage(
                        image: AssetImage('images/City$index.jpg'),
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.60), // Darken the image
                          BlendMode.darken, // Use darken to ensure text stands out
                        ),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(15), // Add a border radius
                    ),
                    child: Stack(
                      alignment: Alignment.center, // Center the text inside the stack
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Explore ${providerbrain.cityList[index]}',
                            style: overImage
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
