import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Text(
                  "ShipShop",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: null,
                  iconSize: 30,
                  icon: Icon(Icons.search, color: Colors.white),
                ),
                IconButton(
                  onPressed: null,
                  iconSize: 30,
                  icon: Icon(Icons.person_2_rounded, color: Colors.white),
                ),
              ],
            )),
      ),
    );
  }
}
