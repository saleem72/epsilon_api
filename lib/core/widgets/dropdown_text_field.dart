//

import 'package:epsilon_api/configuration/styling/colors/app_colors.dart';
import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:flutter/material.dart';

class DropdownTextField extends StatefulWidget {
  const DropdownTextField({
    super.key,
    required this.hint,
    required this.onSelection,
    required this.customers,
  });
  final String hint;
  final Function(String) onSelection;
  final List<String> customers;
  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  final TextEditingController _controller = TextEditingController();
  final LayerLink layerLink = LayerLink();
  final FocusNode focusNode = FocusNode();

  OverlayEntry? entry;
  Size size = Size.zero;
  bool isEditing = true;
  String searchTerm = '';

  List<String> get filtered {
    return _controller.text.trim() == ''
        ? widget.customers
        : widget.customers
            .where((element) => element
                .toLowerCase()
                .contains(_controller.text.trim().toLowerCase()))
            .toList();
  }

  bool _valueExsits() {
    final customers = widget.customers
        .where((element) => element == _controller.text)
        .toList();
    return customers.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  _handleFocusChange() {
    if (focusNode.hasFocus) {
      showOverlay();
      setState(() {
        isEditing = true;
      });
    } else {
      hideOverlay();
      if (!_valueExsits()) {
        _controller.clear();
        widget.onSelection('');
      }
    }
  }

  @override
  void dispose() {
    hideOverlay();
    _controller.dispose();
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildIverlay() {
    return Material(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...filtered.map(
              (e) => ListTile(
                title: Text(e),
                onTap: () async {
                  widget.onSelection(e);
                  setState(() {
                    isEditing = false;
                  });
                  _controller.text = e;
                  hideOverlay();
                  focusNode.unfocus();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _doSomething() {
    entry = OverlayEntry(
      builder: (context) => Positioned(
        // left: offset.dx,
        // top: offset.dy + size.height + 8,
        width: size.width,
        height: 165,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: _buildIverlay(),
        ),
      ),
    );
  }

  showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    // final offset = renderBox.localToGlobal(Offset.zero);
    size = renderBox.size;
    entry?.remove();
    entry = null;
    _doSomething();
    overlay.insert(entry!);
  }

  hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: TextField(
        controller: _controller,
        focusNode: focusNode,
        style: Topology.body.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.primaryDark,
        ),
        onChanged: (value) {
          // if (isEditing) {
          //   entry = _doSomething();
          // }
          // print(value);
          // setState(() {
          //   searchTerm = value;
          // });
          showOverlay();
          widget.onSelection(value);
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: Topology.body.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade400,
          ),
          isCollapsed: true,
        ),
      ),
    );
  }
}
