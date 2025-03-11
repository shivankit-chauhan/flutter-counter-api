import 'package:flutter/material.dart';
import 'api_service.dart';

class CounterProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  int counter = 0;
  bool isLoading = false;
  String errorMessage = '';

  Future<void> fetchCounter(String namespace, String counterKey) async {
    try {
      isLoading = true;
      notifyListeners();
      counter = await _apiService.getCounter(namespace, counterKey);
      errorMessage = "";
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> increment(String namespace, String counterKey) async {
    try {
      await _apiService.incrementCounter(namespace, counterKey);
      counter++;
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> decrement(String namespace, String counterKey) async {
    try {
      await _apiService.decrementCounter(namespace, counterKey);
      counter--;
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  Future<void> update(String namespace, String counterKey, int value) async {
    try {
      await _apiService.updateCounter(namespace, counterKey, value);
      counter = value;
    } catch (e) {
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
