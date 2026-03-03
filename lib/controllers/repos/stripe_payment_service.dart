import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:rivala/config/network/api_client.dart';
import 'package:rivala/config/network/endpoints.dart';

class StripePaymentService {
  static const String baseUrl = 'http://192.168.1.194:5002/v1/api/payments';

  // Step 1: Create Payment Intent
  static Future<Map<String, dynamic>> createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    try {
      final response = await ApiClient().postResponse(
        endpoints: Endpoints.paymentIntent,
        data: {
          'amount': amount,
          'currency': currency,
        },
      );
      return response['clientSecret'];
    } catch (e) {
      print('Error creating payment intent: $e');
      rethrow;
    }
  }

  // Step 2: Initialize Payment Sheet
  static Future<void> initializePaymentSheet({
    required String clientSecret,
    required String merchantName,
  }) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: merchantName,
          style: ThemeMode.system,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Colors.blue,
            ),
          ),
        ),
      );
      print('Payment sheet initialized successfully');
    } catch (e) {
      print('Error initializing payment sheet: $e');
      rethrow;
    }
  }

  // Step 3: Present Payment Sheet
  static Future<bool> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Payment completed successfully');
      return true;
    } on StripeException catch (e) {
      print('Stripe Error: ${e.error.localizedMessage}');
      if (e.error.code == FailureCode.Canceled) {
        print('Payment cancelled by user');
      }
      return false;
    } catch (e) {
      print('Error presenting payment sheet: $e');
      return false;
    }
  }

  // Complete Payment Flow
  static Future<bool> makePayment({
    required String amount,
    required String currency,
    String merchantName = 'Rivala',
  }) async {
    try {
      // Step 1: Create payment intent
      final paymentIntent = await createPaymentIntent(
        amount: amount,
        currency: currency,
      );

      final clientSecret = paymentIntent['clientSecret'];
      if (clientSecret == null || clientSecret.isEmpty) {
        throw Exception('Invalid client secret received');
      }

      // Step 2: Initialize payment sheet
      await initializePaymentSheet(
        clientSecret: clientSecret,
        merchantName: merchantName,
      );

      // Step 3: Present payment sheet
      final success = await presentPaymentSheet();

      return success;
    } catch (e) {
      print('Payment error: $e');
      return false;
    }
  }
}
