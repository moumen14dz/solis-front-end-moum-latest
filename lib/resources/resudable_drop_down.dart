import 'package:flutter/material.dart';
import 'package:newproject/utils/colors.dart';

import '../model/drop_down_item.dart';

// class ReusableDropdown<T> extends StatefulWidget {
//   final String hintText;
//   final List<DropdownItem<T>> items;
//   final void Function(DropdownItem<T>?)? onChanged;
//   final DropdownItem<T>? selectedItem;
//
//   const ReusableDropdown({
//     Key? key,
//     required this.hintText,
//     required this.items,
//     this.onChanged,
//     this.selectedItem,
//   }) : super(key: key);
//
//   @override
//   State<ReusableDropdown> createState() => _ReusableDropdownState();
// }
//
// class _ReusableDropdownState<T> extends State<ReusableDropdown<T>> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonFormField<DropdownItem<T>>(
//       decoration: InputDecoration(
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: mainTextFormColor),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: mainTextFormColor),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: mainTextFormColor),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: mainTextFormColor),
//           borderRadius: BorderRadius.circular(30),
//         ),
//         border: InputBorder.none,
//         fillColor: mainTextFormColor,
//         filled: true,
//         hintText: widget.hintText,
//         hintStyle: const TextStyle(color: Color(0xffA2A5AA)),
//       ),
//       items: widget.items.map((DropdownItem<T> item) {
//         return DropdownMenuItem<DropdownItem<T>>(
//           value: item,
//           child: Text(item.name.length >= 35 ? "${item.name.substring(0,32)} ..." : item.name, overflow: TextOverflow.ellipsis, softWrap: true,),
//         );
//       }).toList(),
//       onChanged: widget.onChanged,
//       value: widget.selectedItem,
//     );
//   }
// }

class ReusableDropdown<T> extends StatefulWidget {
  final String hintText;
  final List<DropdownItem<T>> items;
  final void Function(DropdownItem<T>?)?
      onSelected; // To notify the external state if needed
  final bool isExpanded;
  const ReusableDropdown({
    Key? key,
    required this.hintText,
    required this.items,
    this.onSelected,
    this.isExpanded = false, // Provide a default value

  }) : super(key: key);

  @override
  State<ReusableDropdown> createState() => _ReusableDropdownState<T>();
}

class _ReusableDropdownState<T> extends State<ReusableDropdown<T>> {
  DropdownItem<T>? dropdownValue; // Internal state

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<DropdownItem<T>>(
      isExpanded: widget.isExpanded, // Use the isExpanded parameter
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainTextFormColor),
          borderRadius: BorderRadius.circular(30),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainTextFormColor),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainTextFormColor),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: mainTextFormColor),
          borderRadius: BorderRadius.circular(30),
        ),
        border: InputBorder.none,
        fillColor: mainTextFormColor,
        filled: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Color(0xffA2A5AA)),
      ),
      items: widget.items.map((item) {
        return DropdownMenuItem<DropdownItem<T>>(
          key: ValueKey<DropdownItem<T>>(item),
          value: item,
          child: Text(item.name.length >= 35 ? "${item.name.substring(0,32)} ..." : item.name,
              overflow: TextOverflow.ellipsis, softWrap: true,
            style: TextStyle(color: dropdownValue == item ? Colors.white : Colors.black,  // Change these colors to your preference
            ),
            ),
        );
      }).toList(),
      // items: widget.items.map((DropdownItem<T> item) {
      //   return DropdownMenuItem<DropdownItem<T>>(
      //     value: dropdownValue,
      //     child: Text(item.name.length >= 35 ? "${item.name.substring(0,32)} ..." : item.name,
      //       overflow: TextOverflow.ellipsis, softWrap: true,
      //     style: TextStyle(color: dropdownValue == item ? Colors.white : Colors.black,  // Change these colors to your preference
      //     ),
      //     ),
      //   );
      // }).toList(),
      onChanged: (DropdownItem<T>? newItem) {
        setState(() {
          dropdownValue = newItem;
        });
        if (widget.onSelected != null) {
          widget.onSelected!(dropdownValue); // Notify external state if needed
        }
      },
      value: dropdownValue,
    );
  }
}
