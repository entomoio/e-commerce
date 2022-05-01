import 'package:localization_ecommerce/src/features/products/data/fake_search_repository.dart';
import 'package:localization_ecommerce/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';

/// Search field used to filter products by name
class ProductsSearchTextField extends StatefulWidget {
  const ProductsSearchTextField({Key? key, required this.searchRepository})
      : super(key: key);
  final FakeSearchRepository searchRepository;
  @override
  State<ProductsSearchTextField> createState() =>
      _ProductsSearchTextFieldState();
}

class _ProductsSearchTextFieldState extends State<ProductsSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // See this article for more info about how to use [ValueListenableBuilder]
    // with TextField:
    // https://codewithandrea.com/articles/flutter-text-field-form-validation/
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
          controller: _controller,
          autofocus: false,
          style: Theme.of(context).textTheme.headline6,
          decoration: InputDecoration(
            hintText: context.loc.searchProducts,
            icon: const Icon(Icons.search),
            suffixIcon: value.text.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      _controller.clear();
                      widget.searchRepository.clearSearch();
                    },
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          onChanged: (query) {
            widget.searchRepository.createSearch(query);
          },
        );
      },
    );
  }
}
