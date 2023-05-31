class OrderInquiry {
  final String id;
  final String user_id;
  final int price;
  final int distance;
  final int duration;
  final String origin;
  final String destination;
  final String routes;
  final DateTime created_at;
  final DateTime updated_at;

  OrderInquiry ({
    required this.id,
    required this.user_id,
    required this.price,
    required this.distance,
    required this.duration,
    required this.origin,
    required this.destination,
    required this.routes,
    required this.created_at,
    required this.updated_at,
  });
}