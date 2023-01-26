import 'package:app/model/cart_model.dart';
import 'package:app/utils/colors.dart';
import 'package:app/view/screens/food_page/main_food_page.dart';
import 'package:app/view/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/cart_controller.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/dimensionScale.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/bit_text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          AppBarWidget(),
          Container(
              height: Dimension.scaleHeight(
                  Dimension.screenHeight - Dimension.scaleHeight(210)),
              child: listWidget())
        ],
      ),
    ));
  }

  Widget AppBarWidget() {
    return Container(
      height: Dimension.scaleWidth(70),
      child: Container(
        padding: EdgeInsets.all(Dimension.scaleHeight(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AppIcon(
              icon: Icons.arrow_back_ios,
              ontap: () {
                Get.back();
              },
              color: AppColors.mainColor,
            ),
            SizedBox(
              width: Dimension.scaleWidth(50),
            ),
            AppIcon(
              icon: Icons.home,
              ontap: () {
                Get.to(MainFoodpage());
              },
              color: AppColors.mainColor,
            ),
            AppIcon(
              icon: Icons.shopping_cart,
              color: AppColors.mainColor,
            )
          ],
        ),
      ),
    );
  }

  Widget listWidget() {
    return GetBuilder<CartController>(builder: (cartController) {
      //recommedndedProduct.getRecommendedProductList();
      return ListView.builder(
          //  physics: NeverScrollableScrollPhysics(),
          // shrinkWrap: true,
          itemCount: cartController.listOfCartItems.length,
          itemBuilder: (_, index) {
            return itemView(
                cartController.listOfCartItems[index], cartController);
          });
    });
  }

  Widget itemView(CartModel cartModel, CartController cartController) {
    return InkWell(
        child: Container(
            height: Dimension.scaleWidth(150),
            padding: EdgeInsets.all(Dimension.scaleWidth(10)),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Dimension.scaleHeight(20)),
                  child: Image.network(
                    AppConstants.BASE_URI +
                        AppConstants.UPLOAD_URL +
                        cartModel.img!,
                    fit: BoxFit.cover,
                    width: Dimension.scaleWidth(130),
                    height: Dimension.scaleWidth(130),
                    cacheWidth: (Dimension.scaleWidth(130).ceil()),
                    cacheHeight: (Dimension.scaleWidth(130).ceil()),
                  ),
                ),
                SizedBox(
                  width: Dimension.scaleWidth(10),
                ),
                Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: Dimension.scaleHeight(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          BigText(text: cartModel.name!),
                          SmallText(text: "spicy"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BigText(
                                text: "\$ ${cartModel.price}",
                                color: Colors.red,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          Dimension.scaleHeight(24))),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            cartController
                                                .removeFromCart(cartModel.id!);
                                          },
                                          child: Container(
                                            //color: Colors.black45,
                                            child: Icon(
                                              Icons.remove,
                                              color: Colors.black45,
                                              size: Dimension.scaleWidth(28),
                                            ),
                                          )),
                                      SizedBox(width: Dimension.scaleWidth(8)),
                                      BigText(
                                          text: cartModel.quantity.toString(),
                                          size: Dimension.scaleHeight(24)),
                                      SizedBox(
                                        width: Dimension.scaleWidth(8),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            cartController
                                                .addToCart(cartModel.id!);
                                          },
                                          child: Icon(Icons.add,
                                              color: Colors.black45,
                                              size: Dimension.scaleHeight(24)))
                                    ],
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: Dimension.scaleHeight(10),
                                      horizontal: Dimension.scaleWidth(10))),
                            ],
                          )
                        ],
                      )),
                )
              ],
            )));
  }
}
