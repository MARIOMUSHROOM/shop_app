import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shop_app/provider/cart_provider.dart';
import 'package:shop_app/provider/favorite_provider.dart';

final List<SingleChildWidget> stateIndex = [
  ChangeNotifierProvider<FavoriteProvider>(
    create: (_) => FavoriteProvider(),
  ),
  ChangeNotifierProvider<CartProvider>(
    create: (_) => CartProvider(),
  ),
];
