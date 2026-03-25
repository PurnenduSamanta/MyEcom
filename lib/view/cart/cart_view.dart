import 'dart:async';

import 'package:ecom_mini/view/checkout/checkout_success_view.dart';
import 'package:ecom_mini/viewmodel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  bool _isCheckoutInProgress = false;
  CheckoutStage _checkoutStage = CheckoutStage.none;
  double _checkoutProgress = 0;

  Future<void> _startCheckout() async {
    final viewModel = context.read<ProductViewModel>();
    if (viewModel.isCartEmpty || _isCheckoutInProgress) {
      if (viewModel.isCartEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Your cart is empty')));
      }
      return;
    }

    setState(() {
      _isCheckoutInProgress = true;
      _checkoutStage = CheckoutStage.loading;
      _checkoutProgress = 0;
    });

    await Future<void>.delayed(const Duration(seconds: 2));
    if (!mounted) {
      return;
    }

    setState(() {
      _checkoutStage = CheckoutStage.progress;
    });

    await _runProgressForTwoSeconds();
    if (!mounted) {
      return;
    }

    viewModel.clearCart();

    if (!mounted) {
      return;
    }

    await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const CheckoutSuccessView()));

    if (!mounted) {
      return;
    }

    setState(() {
      _isCheckoutInProgress = false;
      _checkoutStage = CheckoutStage.none;
      _checkoutProgress = 0;
    });
  }

  Future<void> _runProgressForTwoSeconds() async {
    const totalSteps = 20;
    for (var i = 1; i <= totalSteps; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
      if (!mounted) {
        return;
      }
      setState(() {
        _checkoutProgress = i / totalSteps;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(title: const Text('My Cart')),
          body: Consumer<ProductViewModel>(
            builder: (context, viewModel, _) {
              return Column(
                children: [
                  Expanded(
                    child: viewModel.cartItems.isEmpty
                        ? const Center(
                            child: Text(
                              'Your cart is empty',
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.all(12),
                            itemCount: viewModel.cartItems.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 8),
                            itemBuilder: (context, index) {
                              final item = viewModel.cartItems[index];
                              return Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 64,
                                        height: 64,
                                        child: Image.network(
                                          item.product.image,
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, _, _) => const Icon(
                                            Icons.broken_image,
                                            size: 28,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.product.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              '\$${item.product.price.toStringAsFixed(2)}',
                                              style: const TextStyle(
                                                color: Colors.green,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              'Total: \$${item.lineTotal.toStringAsFixed(2)}',
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            onPressed: _isCheckoutInProgress
                                                ? null
                                                : () => viewModel
                                                      .decrementCartItem(
                                                        item.product.id,
                                                      ),
                                            icon: const Icon(
                                              Icons.remove_circle_outline,
                                            ),
                                          ),
                                          Text(
                                            '${item.quantity}',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: _isCheckoutInProgress
                                                ? null
                                                : () => viewModel
                                                      .incrementCartItem(
                                                        item.product.id,
                                                      ),
                                            icon: const Icon(
                                              Icons.add_circle_outline,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: const Border(
                        top: BorderSide(color: Colors.black12),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _summaryRow('Subtotal', viewModel.subtotal),
                        const SizedBox(height: 6),
                        _summaryRow('Tax (12%)', viewModel.tax),
                        const Divider(height: 20),
                        _summaryRow(
                          'Grand Total',
                          viewModel.grandTotal,
                          isBold: true,
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed:
                                viewModel.isCartEmpty || _isCheckoutInProgress
                                ? null
                                : _startCheckout,
                            child: const Text('Buy Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        if (_checkoutStage != CheckoutStage.none)
          Positioned.fill(
            child: ColoredBox(
              color: Colors.black45,
              child: Center(
                child: Card(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: _checkoutStage == CheckoutStage.loading
                        ? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 3,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Processing your order...'),
                            ],
                          )
                        : SizedBox(
                            width: 260,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Finalizing Purchase',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                LinearProgressIndicator(
                                  value: _checkoutProgress,
                                ),
                                const SizedBox(height: 8),
                                Text('${(_checkoutProgress * 100).toInt()}%'),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _summaryRow(String label, double value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            fontSize: isBold ? 17 : 15,
          ),
        ),
        Text(
          '\$${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
            fontSize: isBold ? 17 : 15,
          ),
        ),
      ],
    );
  }
}

enum CheckoutStage { none, loading, progress }
