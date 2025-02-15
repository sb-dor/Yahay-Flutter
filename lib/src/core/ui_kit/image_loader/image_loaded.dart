import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:yahay/src/core/global_usages/constants/constants.dart';

class ImageLoaderWidget extends StatelessWidget {
  final String url;
  final String? errorImageUrl;
  final String? imageBlurHash;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final EdgeInsets? marginShimmerContainer;
  final EdgeInsets? paddingShimmerContainer;
  final BorderRadius? borderRadius;
  final Widget? errorWidget;

  const ImageLoaderWidget({
    super.key,
    required this.url,
    this.errorImageUrl,
    this.imageBlurHash,
    this.height,
    this.width,
    this.boxFit,
    this.marginShimmerContainer,
    this.paddingShimmerContainer,
    this.borderRadius,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return CachedNetworkImage(
          imageUrl: url,
          width: width,
          httpHeaders: const {
            "Accept": "application/json",
            "Connection": "Keep-Alive",
            "Keep-Alive": "timeout=10, max=1000",
          },
          fit: boxFit ?? BoxFit.scaleDown,
          placeholder: (context, url) {
            if (imageBlurHash != null) {
              return Container(
                  margin: marginShimmerContainer,
                  padding: paddingShimmerContainer,
                  width: width,
                  height: height,
                  decoration: BoxDecoration(borderRadius: borderRadius),
                  child: BlurHash(
                    hash: imageBlurHash ?? 'L00w16X:L#qZf,fke.e.HXm*y?UH',
                    imageFit: boxFit ?? BoxFit.scaleDown,
                    duration: const Duration(seconds: 2),
                    curve: Curves.linear,
                  ),);
            } else {
              return Container(
                margin: marginShimmerContainer,
                padding: paddingShimmerContainer,
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: borderRadius,
                ),
              );
            }
          },
          errorWidget: (context, url, error) => errorWidget ?? Image.asset(
              errorImageUrl ?? Constants.userErrorImage,
              height: height,
              width: width,
              fit: boxFit ?? BoxFit.scaleDown,),);
    },);
  }
}
