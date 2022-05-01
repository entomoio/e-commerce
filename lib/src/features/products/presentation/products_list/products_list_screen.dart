import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localization_ecommerce/src/common_widgets/responsive_center.dart';
import 'package:localization_ecommerce/src/constants/app_sizes.dart';
import 'package:localization_ecommerce/src/features/products/presentation/home_app_bar/home_app_bar.dart';
import 'package:localization_ecommerce/src/features/products/presentation/products_list/products_grid.dart';
import 'package:localization_ecommerce/src/features/products/presentation/products_list/products_search_text_field.dart';

import '../../data/fake_search_repository.dart';

/// Shows the list of products with a search field at the top.
class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({Key? key}) : super(key: key);

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  // When the search text field gets the focus, the keyboard appears on mobile.
  // This method is used to dismiss the keyboard when the user scrolls.
  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer(
        builder: (context, ref, _) {
          final searchRepository = ref.watch(searchRepositoryProvider);
          final query = searchRepository.currentQuery;
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              ResponsiveSliverCenter(
                padding: const EdgeInsets.all(Sizes.p16),
                child: ProductsSearchTextField(
                  searchRepository: searchRepository,
                ),
              ),
              ResponsiveSliverCenter(
                padding: const EdgeInsets.all(Sizes.p16),
                child: ProductsGrid(
                  searchRepository: searchRepository,
                  titleQuery: query ?? '',
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
