part of 'order_inquiry_cubit.dart';

abstract class OrderInquiryState extends Equatable {
  const OrderInquiryState();

  @override
  List<Object> get props => [];
}

class OrderInquiryInitial extends OrderInquiryState {}
class OrderInquiryLoading extends OrderInquiryState {}

class OrderInquiryError extends OrderInquiryState {
  final String message;
  OrderInquiryError(this.message);
}

class OrderInquiryResponse extends OrderInquiryState {
  final List<OrderInquiry> inquiry;
  OrderInquiryResponse(this.inquiry);
  }


