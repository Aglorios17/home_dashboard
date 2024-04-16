import 'package:flutter/material.dart';
import 'package:home_dashboard/constants.dart';

class Header extends  StatelessWidget {
  
  const Header({super.key, required this.name});
  
  final String name;
  
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      const Spacer(flex: 2),
      const Expanded(child: SearchField()),
      const ProfileCard()
    ],);
  }
}

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: secondaryColor,
        filled: true,
        border: const OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child : Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding/2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10))
            ),
            child: const Icon(Icons.search),
          ),
        ),
      )
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: defaultPadding),
      padding: const EdgeInsets.symmetric(
        horizontal: defaultPadding,
        vertical: defaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Image.asset(
            'images/Me.jpg', 
            height: 38,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding/2), 
            child: Text("Alessio Glorioso"),
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      )
    );
  }
}