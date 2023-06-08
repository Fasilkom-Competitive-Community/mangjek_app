import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mangjek_app/app/bloc/home/map/map_cubit.dart';
import 'package:mangjek_app/app/bloc/home/map_camera/map_camera_cubit.dart';
import 'package:mangjek_app/app/bloc/home/order_inquiry/cubit/order_inquiry_cubit.dart';
import 'package:mangjek_app/app/bloc/home/profile/profile_cubit.dart';
import 'package:mangjek_app/app/bloc/home/repository/order_inquiry_repository.dart';
import 'package:mangjek_app/app/bloc/home/select_location/select_location_cubit.dart';
import 'package:mangjek_app/app/bloc/order/order_cubit.dart';

SelectLocationCubit selectLocationCubit = SelectLocationCubit();
MapCubit mapCubit = MapCubit();
MapCameraCubit mapCameraCubit = MapCameraCubit();
ProfileCubit profileCubit = ProfileCubit();
OrderCubit orderCubit = OrderCubit();
OrderInquiryCubit orderInquiryCubit = OrderInquiryCubit(OrderInquiryRepository());

final GlobalProviders = [
  BlocProvider<SelectLocationCubit>(
    create: (context) => selectLocationCubit,
  ),
  BlocProvider<MapCubit>(
    create: (context) => mapCubit,
  ),
  BlocProvider<MapCameraCubit>(
    create: (context) => mapCameraCubit,
  ),
  BlocProvider<ProfileCubit>(
    create: (context) => profileCubit,
  ),
  BlocProvider<OrderCubit>(
    create: (context) => orderCubit,
  ),
  BlocProvider<OrderInquiryCubit>(
    create: (context) => orderInquiryCubit
  ),
];
