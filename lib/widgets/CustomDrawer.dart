import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            margin: EdgeInsets.only(left: 0),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
            child: Text(
              'Travel Guide Cyprus 2024',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite_border_sharp),
            title: const Text('Favouries'),

              onTap: (){
              Navigator.pushNamed(context, '/FavouritePage');
              },

          ),
          ListTile(
            leading: const Icon(Icons.menu_book),
            title: const Text('History of Cyprus'),
            onTap: () {
             Navigator.pushNamed(context,'/History');
            },
          ),

        ],
      ),
    );
  }
}

