import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mangjek_app/app/bloc/home/repository/order_inquiry_repository.dart';
import 'package:mangjek_app/app/models/order_inquiry.dart';
import 'package:nylo_framework/nylo_framework.dart';

part 'order_inquiry_state.dart';

class OrderInquiryCubit extends Cubit<OrderInquiryState> {
  final OrderInquiryRepository _repository;
  OrderInquiryCubit(this._repository) : super(OrderInquiryInitial());

  Future<void> fetchOrderInquiry() async {
    emit(OrderInquiryLoading());
    try {
      final response = await _repository.getAll();
      emit(OrderInquiryResponse(response));
    } catch (e) {
      emit(OrderInquiryError(e.toString()));
    }
  }
}
