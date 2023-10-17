//

import 'package:epsilon_api/configuration/styling/topology/topology.dart';
import 'package:epsilon_api/features/customer_account/customer_search/domain/models/compact_customer.dart';
import 'package:flutter/material.dart';

class DropdownTextField extends StatefulWidget {
  const DropdownTextField({
    super.key,
    required this.hint,
    required this.onSelection,
    required this.customers,
  });
  final String hint;
  final Function(CompactCustomer) onSelection;
  final List<CompactCustomer> customers;
  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  final TextEditingController _controller = TextEditingController();
  OverlayEntry? entry;
  final LayerLink layerLink = LayerLink();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  _handleFocusChange() {
    if (focusNode.hasFocus) {
      showOverlay();
    } else {
      hideOverlay();
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
            ...widget.customers.map(
              (e) => ListTile(
                title: Text(e.customerName),
                onTap: () {
                  _controller.text = e.customerName;
                  hideOverlay();
                  widget.onSelection(e);
                  focusNode.unfocus();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    // final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
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
