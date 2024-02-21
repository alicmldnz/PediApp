import 'package:flutter/material.dart';
import 'package:pediapp/Classes/activity.dart';

class CategoryCardWidget extends StatefulWidget {
  const CategoryCardWidget({super.key, required this.category});

  final Activity category;

  @override
  State<CategoryCardWidget> createState() => _CategoryCardWidgetState();
}

class _CategoryCardWidgetState extends State<CategoryCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(int.parse(widget.category.categoryColor)),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Color(0x5C000000),
              offset: Offset(0, 3),
              blurRadius: 6,
            )
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            print("Tapped to ${widget.category.categoryName}");
          },
          borderRadius: BorderRadius.circular(20),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.category.categoryName,
                style: const TextStyle(
                    color: Colors.white,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.bold),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
