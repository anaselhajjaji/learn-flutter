import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO the common way to retrieve the product from provider,
    // here in the file we use another way using Consumer()
    final firstLoadedProduct = Provider.of<Product>(context, listen: false);

    //TODO the advantage of the Consumer is that we can add it in a place in
    // the widget tree and it won't rebuild all the tree but only the subtree
    return ClipRRect(
      //TODO wil help us to have rounded conrners
      borderRadius: BorderRadius.circular(10),
      //TODO a nice widget that can be used particularly in Grids
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: firstLoadedProduct.id,
            );
          },
          child: Image.network(
            firstLoadedProduct.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        //TODO here we update only the footer part
        // The child is a constant widget that we can pass to consumer using child:
        // and it will just pass it back to us in the builder
        footer: Consumer<Product>(
          builder: (context, product, child) => GridTileBar(
            backgroundColor: Colors.black87,
            leading: IconButton(
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus();
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
            title: Text(
              product.title,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
