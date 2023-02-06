import 'package:online_check_in/screens/payment/payment_repository.dart';
import 'package:online_check_in/screens/payment/payment_state.dart';
import 'package:online_check_in/screens/seat_map/seat_map_state.dart';

import '../../core/dependency_injection.dart';
import '../../core/interfaces/controller.dart';

class PaymentController extends MainController {
  final PaymentState paymentState = getIt<PaymentState>();
  final PaymentRepository paymentRepository = getIt<PaymentRepository>();

  void calculatePrices() {
    // final myUpgradesStepController = Get.put(UpgradesStepController(model));
    final SeatMapState seatMapState = getIt<SeatMapState>();
    paymentState.setTotalPrice(0);
    paymentState.setSeatPrices(seatMapState.seatPrices);
    paymentState.setTotalPrice(paymentState.totalPrice + paymentState.seatPrices);
    paymentState.seatExtrasDetail = [];
    paymentState.taxes.clear();
    paymentState.taxes.add({"title": "Seats price", "price": paymentState.seatPrices});

    // for (int i = 0; i < myUpgradesStepController.entertainmentsList.length; ++i) {
    //   int numOFSelected = myUpgradesStepController.entertainmentsNumberOfSelected[i];
    //   if (numOFSelected > 0) {
    //     Extra e = myUpgradesStepController.entertainmentsList[i];
    //     seatExtrasDetail.add({
    //       "Id": e.id,
    //       "Price": e.price * numOFSelected,
    //       "Count": numOFSelected,
    //       "SubTotal": e.price * numOFSelected,
    //     });
    //     taxes.add(
    //       {"title": e.title, "price": e.price * numOFSelected},
    //     );
    //     totalPrice.value += e.price * numOFSelected;
    //   }
    // }
    //
    // for (int i = 0; i < myUpgradesStepController.winesList.length; ++i) {
    //   int numOFSelected = myUpgradesStepController.winesNumberOfSelected[i];
    //   if (numOFSelected > 0) {
    //     Extra e = myUpgradesStepController.winesList[i];
    //     seatExtrasDetail.add({
    //       "Id": e.id,
    //       "Price": e.price * numOFSelected,
    //       "Count": numOFSelected,
    //       "SubTotal": e.price * numOFSelected,
    //     });
    //     taxes.add(
    //       {"title": e.title, "price": e.price * numOFSelected},
    //     );
    //     totalPrice.value += e.price * numOFSelected;
    //   }
    // }
    paymentState.setState();
  }

  // void showResultDialog() {
  //   String text = wasPayed ? "Payment was successful" : "Payment failed";
  //   String title = wasPayed ? "" : "Error";
  //   showFlash(
  //     context: Get.context!,
  //     duration: const Duration(seconds: 4),
  //     builder: (context, controller) {
  //       return CustomFlashBar(
  //         controller: controller,
  //         contentMessage: text,
  //         titleMessage: title,
  //         colors: [Colors.greenAccent, Colors.green],
  //       );
  //     },
  //   );
  // }

  @override
  void onInit() {
    calculatePrices();
    super.onInit();
  }
}
