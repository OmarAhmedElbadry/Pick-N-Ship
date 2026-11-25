/// ============================================================
/// order_history_screen.dart — Order History (Real-time)
/// ============================================================
/// Displays all orders for the logged-in customer using
/// StreamBuilder for real-time Firestore updates.
/// When rider changes status → customer sees it instantly.
/// ============================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../utils/currency.dart';
import '../../providers/auth_provider.dart';
import '../../models/order_model.dart';
import '../../config/app_router.dart';
import '../../config/app_theme.dart';
import '../../config/demo_data.dart';
import '../../providers/order_provider.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final uid = context.read<AuthProvider>().uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.go(AppRouter.home),
        ),
      ),
      body: DemoData.isDemoMode
          ? Consumer<OrderProvider>(
              builder: (context, orders, _) =>
                  _buildOrderList(context, orders.orders),
            )
          : StreamBuilder<QuerySnapshot>(
              // Real-time stream — updates instantly when rider changes status
              stream: FirebaseFirestore.instance
                  .collection('orders')
                  .where('customerId', isEqualTo: uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return _buildOrderList(context, const []);
                }

                // Parse and sort orders
                final orders = snapshot.data!.docs
                    .map((doc) => OrderModel.fromFirestore(doc))
                    .toList();
                orders.sort((a, b) => b.placedAt.compareTo(a.placedAt));

                return _buildOrderList(context, orders);
              },
            ),
    );
  }

  Widget _buildOrderList(BuildContext context, List<OrderModel> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📋', style: TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Text(
              'No orders yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Your order history will appear here',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRouter.home),
              child: const Text('Start Shopping'),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => _buildOrderCard(context, orders[index]),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderModel order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row: Order ID + Status badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.orderId.length > 8 ? order.orderId.substring(0, 8) : order.orderId}',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                _statusBadge(order.status),
              ],
            ),
            const SizedBox(height: 8),

            // Shop name and type
            Row(
              children: [
                const Icon(Icons.store, size: 16, color: AppTheme.textMuted),
                const SizedBox(width: 6),
                Text(
                  order.shopName,
                  style: const TextStyle(color: AppTheme.textMuted),
                ),
                const Text(' · ', style: TextStyle(color: AppTheme.textMuted)),
                Text(
                  order.orderType,
                  style: TextStyle(
                    color:
                        AppTheme.categoryColors[order.orderType] ??
                        AppTheme.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Total and time
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatEgp(order.totalAmount),
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primaryColor,
                  ),
                ),
                Text(
                  DateFormat('MMM d, h:mm a').format(order.placedAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            // Track Order button (only for active orders)
            if ([
              'pending',
              'accepted',
              'picked_up',
            ].contains(order.status)) ...[
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  context.push('${AppRouter.orderTracking}/' + order.orderId);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.secondaryColor,
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 20, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Track Order',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    final color = switch (status) {
      'pending' => AppTheme.warningAmber,
      'confirmed' => AppTheme.secondaryColor,
      'accepted' => Colors.indigo,
      'picked_up' => AppTheme.secondaryColor,
      'delivered' => AppTheme.successGreen,
      'cancelled' => AppTheme.errorRed,
      _ => AppTheme.textMuted,
    };
    final label = switch (status) {
      'pending' => 'Pending',
      'confirmed' => 'Confirmed',
      'accepted' => 'Rider Assigned',
      'picked_up' => 'Picked Up',
      'delivered' => 'Delivered ✅',
      'cancelled' => 'Cancelled',
      _ => status,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
