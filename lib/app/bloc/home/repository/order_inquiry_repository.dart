import 'dart:convert';
import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:mangjek_app/app/models/order_inquiry.dart';
class OrderInquiryRepository {
  Future<List<OrderInquiry>> getAll() async {
    const url = 'https://mangjek.nabiel.my.id/api/v1/orders-inquiries';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    if(response.statusCode == 200) {
      final json = jsonDecode(response.body) as List;
      final result = json.map((e) {
        return OrderInquiry(id: e['id'], user_id: e['user_id'], price: e['price'], distance: e['distance'], duration: e['duration'], origin: e['origin'], destination: e['destination'], routes: e['routes'], created_at: e['created_at'], updated_at: e['updated_at'],);
      }).toList();
      return result;
    }else {
      throw "Something went wrong code ${response.statusCode})";
    }
  }
}