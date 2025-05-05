import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:journijots/core/helper/extensions.dart';
import 'package:journijots/core/routes/routes.dart';
import 'package:journijots/core/utils/constants.dart';
import 'package:journijots/core/utils/debouncer.dart';
import 'package:journijots/core/utils/widgets/image_base.dart';
import 'package:journijots/features/explore/presentation/manager/cubits/search_cubit/search_cubit.dart';
import 'package:journijots/features/home/presentation/screens/widgets/profile_picture.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key, this.city, this.hintText});
  final String? city;
  final String? hintText;
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  late final Debouncer _debouncer;

  @override
  void initState() {
    super.initState();
    _debouncer = Debouncer(delay: const Duration(milliseconds: 400));
    _controller.addListener(_onTextChanged);
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _hideOverlay();
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    _focusNode.removeListener(_onFocusChanged);
    _focusNode.dispose();
    _debouncer.dispose();

    super.dispose();
  }

  void _onTextChanged() {
    if (_controller.text.isNotEmpty) {
      _debouncer.run(() {
        context.read<SearchCubit>().search(
              text: _controller.text,
              city: widget.city,
            );
        if (_focusNode.hasFocus) {
          _showOverlay();
        }
      });
    } else {
      _hideOverlay();
    }
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus && _controller.text.isNotEmpty) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
  }

  void _showOverlay() {
    _hideOverlay(); // Remove existing overlay before creating a new one

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 4),
          child: Material(
            elevation: 4.0,
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            child: Container(
              constraints: BoxConstraints(
                  maxHeight:
                      MediaQuery.of(context).size.height * 0.4), // Limit height
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          color: kprimarycolor,
                        ),
                      ),
                    );
                  } else if (state is SearchFailure) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.search_off, color: Colors.grey),
                          const SizedBox(height: 8),
                          Text(
                            state.errMessage,
                            style: const TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  } else if (state is SearchSuccess) {
                    return state.results.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              'No matches found',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: state.results.length,
                            itemBuilder: (context, index) {
                              final result = state.results[index];
                              return ListTile(
                                leading: (state.results[index].type == "User")
                                    ? ProfilePicture(
                                        picture: state.results[index].image,
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: ClipOval(
                                          child: (state.results[index].image !=
                                                      null &&
                                                  state.results[index].image!
                                                      .contains("data:image"))
                                              ? Base64Image(
                                                  base64String: state
                                                      .results[index]
                                                      .image, // Paste your full base64 string
                                                  width: 50.w,
                                                  height: 50.h,
                                                  fit: BoxFit.cover,
                                                )
                                              : CachedNetworkImage(
                                                  height: 50.h,
                                                  width: 50.w,
                                                  imageUrl: state
                                                      .results[index].image!,
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                        ),
                                      ),
                                title: Text(result.name),
                                subtitle: Text(
                                  result.type,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                dense: true,
                                onTap: () {
                                  // Handle selection - e.g., navigate to detail page
                                  if (state.results[index].type == "User") {
                                    context.pushNamed(Routes.profileScreen,
                                        arguments:
                                            state.results[index].id.toString());
                                  }
                                  _hideOverlay();
                                  // Navigate or perform action with selected result
                                },
                              );
                            },
                          );
                  } else {
                    // Initial state or any other state
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: false,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: widget.hintText ?? "  What are you looking for?",
          hintStyle: const TextStyle(color: kprimarycolor),
          suffixIcon: const Icon(Icons.search, color: kprimarycolor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
        ),
      ),
    );
  }
}
