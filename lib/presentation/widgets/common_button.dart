import 'package:auto_size_text/auto_size_text.dart';
import 'package:dash_weather/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CommonButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final String? text;
  final double? width;
  final int? maxLines;
  final Function() onPressed;

  CommonButton({
    Key? key,
    this.backgroundColor = const Color(0xFFFED058),
    this.textColor = const Color(0xFF040402),
    this.icon,
    this.text,
    this.width,
    this.maxLines,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: width ?? constraints.maxWidth,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 18.0,
              ),
              primary: backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
                side: BorderSide(
                  color: textColor!,
                  width: 2.0,
                ),
              ),
              elevation: 12.0,
            ),
            child: icon == null
                ? AutoSizeText(
                    text!,
                    minFontSize: 1,
                    maxLines: maxLines ?? 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: textColor,
                      fontWeight: FontWeight.w900,
                    ),
                  )
                : Row(
                    children: [
                      FaIcon(
                        icon,
                        color: textColor,
                        size: 28.0,
                      ),
                      Gaps.h8,
                      Expanded(
                        child: AutoSizeText(
                          text!,
                          minFontSize: 1,
                          textAlign: TextAlign.center,
                          maxLines: maxLines ?? 1,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: textColor,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
