import 'package:flutter/material.dart';
import 'package:forniture_app/components/title_text.dart';
import 'package:forniture_app/models/Categories.dart';
import 'package:forniture_app/screens/home/components/category_card.dart';
import 'package:forniture_app/screens/home/components/recommend_products.dart';
import 'package:forniture_app/services/fetchCategories.dart';
import 'package:forniture_app/services/fetchProducts.dart';
import 'package:forniture_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //Alinhamento a esquerda
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(defaultSize * 2),
            child: TitleText(
              title: "Browse by Categories",
            ),
          ),
          FutureBuilder(
            future: fetchCategories(),
            builder: (context, snapshot) => snapshot.hasData
                ? Categories(
                    categories: snapshot.data,
                  )
                : Image.asset("assets/ripple.gif"),
          ),
          Divider(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.all(defaultSize * 2),
            child: TitleText(title: "Recommends for you"),
          ),
          FutureBuilder(
            future: fetchProducts(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? RecommendProducts(
                      products: snapshot.data,
                    )
                  : Image.asset("assets/ripple.gif");
            },
          ),
        ],
      ),
    );
  }
}

class Categories extends StatelessWidget {
  const Categories({
    Key key,
    this.categories,
  }) : super(key: key);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          categories.length,
          (index) => CategoryCard(
            category: categories[index],
          ),
        ),
      ),
    );
  }
}
