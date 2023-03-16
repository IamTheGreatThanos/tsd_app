import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pharmacy_arrival/core/error/failure.dart';
import 'package:pharmacy_arrival/data/model/product_dto.dart';
import 'package:pharmacy_arrival/data/repositories/accept_containers_repository.dart';

@freezed
part 'accept_cont_list_state.dart';
part 'accept_cont_list_cubit.freezed.dart';

class AcceptContListCubit extends Cubit<AcceptContListState> {
  List<ProductDTO> containers = [];
  ProductDTO selectedProduct = const ProductDTO(id: -1);
  String number = "";
  final AcceptContainersRepository _acceptContainersRepository;
  AcceptContListCubit(this._acceptContainersRepository)
      : super(const AcceptContListState.initialState());

  Future<void> getContainers() async {
    await getContainerNumberFromCache();
    emit(const AcceptContListState.loadingState());
    final result =
        await _acceptContainersRepository.getContainersByAng(number: number);
    result.fold(
      (l) {
        emit(AcceptContListState.errorState(message: mapFailureToMessage(l)));
      },
      (r) async {
        containers = r;
        emit(
          AcceptContListState.loadedState(
            containers: containers,
            selectedProduct: const ProductDTO(id: -1),
          ),
        );
      },
    );
  }

  Future<void> finishAcceptContainer() async {
    final result =
        await _acceptContainersRepository.deleteContainerNumberFromCache();

    result.fold((l) {
      emit(AcceptContListState.errorState(message: mapFailureToMessage(l)));
    }, (r) {
      emit(const AcceptContListState.acceptFinishState());
    });
  }

  Future<void> getContainerNumberFromCache() async {
    final result =
        await _acceptContainersRepository.getContainerNumberFromCache();
    result.fold((l) {
      log(l.toString());
    }, (r) {
      number = r;
    });
  }

  Future<void> updateRefundProductById({
    required ProductDTO product,
  }) async {
    final result = await _acceptContainersRepository.updateContainer(
      name: product.name ?? "",
      status: 1,
    );

    result.fold(
      (l) {
        log(mapFailureToMessage(l));
        emit(
          AcceptContListState.errorState(message: mapFailureToMessage(l)),
        );
      },
      (r) async {
        emit(
          const AcceptContListState.successScannedState(
            message: 'Контейнер отсканирован',
          ),
        );

        log("Container accepted success:::::");
        await getContainers();
      },
    );
  }

  Future<void> refundScannerBarCode(
    String scannedResult,
  ) async {
    if (checkProductBarCodeFromScanned(scannedResult) != null) {
      final ProductDTO productDTO =
          checkProductBarCodeFromScanned(scannedResult)!;
      if (productDTO.status == 1) {
        emit(
          const AcceptContListState.errorState(
            message: 'Контейнер уже отсканирован!',
          ),
        );
        changeToLoadedState();
      } else {
        updateRefundProductById(
          product: productDTO,
        );
        log("SCANNED SUCCESSFULLY");
      }
    } else {
      emit(
        const AcceptContListState.errorState(
          message: 'Нет такого контейнер в списке',
        ),
      );
      changeToLoadedState();
      log("SCANNED FAILED");
    }
  }

  ProductDTO? checkProductBarCodeFromScanned(String barcode) {
    ProductDTO? product;
    for (final ProductDTO productDTO in containers) {
      if (productDTO.name!.contains(barcode)) {
        product = productDTO;
        break;
      }
    }
    return product;
  }

  Future<void> changeToLoadedState() async {
    emit(
      AcceptContListState.loadedState(
        containers: containers,
        selectedProduct: selectedProduct,
      ),
    );
  }
}
