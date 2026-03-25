import 'package:ecom_mini/view/cart/cart_view.dart';
import 'package:ecom_mini/view/product/product_detail_view.dart';
import 'package:ecom_mini/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchController = TextEditingController();
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _initialized) {
        return;
      }
      final viewModel = context.read<ProductViewModel>();
      _searchController.text = viewModel.searchQuery;
      viewModel.init();
      _handleErrorSnackBar(viewModel);
      _initialized = true;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Catalouge'),
        actions: [
          Consumer<ProductViewModel>(
            builder: (context, viewModel, widget) {
              return IconButton(
                onPressed: () {
                  if (viewModel.totalCartUnits == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Your cart is empty')),
                    );
                    return;
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const CartView()));
                },
                icon: Badge.count(
                  count: viewModel.totalCartUnits,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<ProductViewModel>(
        builder: (context, viewModel, _) {
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          viewModel.search(value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Search by title',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                      tooltip: 'Filter by category',
                      onSelected: (value) {
                        viewModel.setCategory(value);
                      },
                      itemBuilder: (context) {
                        final List<PopupMenuEntry<String>> items = [];
                        for (final category in viewModel.categories) {
                          final bool isSelected =
                              category == viewModel.selectedProductCategory;
                          items.add(
                            PopupMenuItem<String>(
                              value: category,
                              child: Row(
                                children: [
                                  Expanded(child: Text(category)),
                                  if (isSelected)
                                    const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                ],
                              ),
                            ),
                          );
                        }

                        return items;
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.filter_list),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(child: _buildBody(viewModel)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(ProductViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (viewModel.products.isEmpty) {
      return const Center(
        child: Text('No products found', style: TextStyle(fontSize: 16)),
      );
    }

    return GridView.builder(
      itemCount: viewModel.products.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.62,
      ),
      itemBuilder: (context, index) {
        final product = viewModel.products[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ProductDetailView(product: product),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      product.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(Icons.broken_image, size: 36),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
                  child: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleErrorSnackBar(ProductViewModel viewModel) async {
    var error = '';
    if (!await viewModel.hasNetwork()) {
      error = 'No internet connection. Please try again.';
    }

    if (!mounted) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(error),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Retry',
          onPressed: () {
            context.read<ProductViewModel>().loadProducts();
          },
        ),
      ),
    );
  }
}
