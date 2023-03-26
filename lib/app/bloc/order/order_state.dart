part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  final PaymentMethods selectedPaymentMethod;
  const OrderState(this.selectedPaymentMethod);


  @override
  List<Object> get props => [this.selectedPaymentMethod];
}

class OrderInitial extends OrderState {
  const OrderInitial() : super(PaymentMethods.CASH);
}

class OrderCreating extends OrderState {

  const OrderCreating(PaymentMethods paymentMethod) : super(paymentMethod);

}
