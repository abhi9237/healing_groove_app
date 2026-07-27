import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:healing/core/color_constant/color_constant.dart';

void showCountrySelectionPicker(
  BuildContext context, {
  required bool showPhoneCode,
  required Function(Country country) onSelect,
})
{
  showCountryPicker(
    context: context,
    showPhoneCode: showPhoneCode,
    onSelect: onSelect,
    countryListTheme: CountryListThemeData(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      backgroundColor: ColorConstant.whiteColor,
      textStyle: const TextStyle(
        fontSize: 16,
        color: ColorConstant.lightBlackColor,
      ),
      searchTextStyle: const TextStyle(
        fontSize: 16,
        color: ColorConstant.lightBlackColor,
      ),
      inputDecoration: InputDecoration(
        hintText: 'Search country...',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: const Icon(Icons.search, color: ColorConstant.appColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(
            color: ColorConstant.appColor,
            width: 1.5,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
      ),
    ),
  );
}

Future<void> showGenderBottomSheet({
  required BuildContext context,
  required String title,
  required List<String> items,
  required RxString selectedValue,
  required Function(String) onSelected,
}) {
  return showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (_) {
      return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 20),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.lightBlackColor,
                  ),
                ),
              ),

              ...items.map((item) {
                final isSelected = selectedValue.value == item;

                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorConstant.appColor.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: isSelected
                          ? ColorConstant.appColor
                          : Colors.grey.shade200,
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 2,
                    ),
                    title: Text(
                      item,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                        color: isSelected
                            ? ColorConstant.appColor
                            : ColorConstant.lightBlackColor,
                      ),
                    ),
                    trailing: Icon(
                      isSelected
                          ? Icons.check_circle_rounded
                          : Icons.radio_button_unchecked_rounded,
                      color: isSelected ? ColorConstant.appColor : Colors.grey,
                    ),
                    onTap: () {
                      onSelected(item);
                      Navigator.pop(context);
                    },
                  ),
                );
              }),
            ],
          ),
        );

    },
  );
}
