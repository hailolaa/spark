import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/glassmorphic_container.dart';


class GlassAuthInput extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const GlassAuthInput({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<GlassAuthInput> createState() => _GlassAuthInputState();
}

class _GlassAuthInputState extends State<GlassAuthInput> {
  /// Controls whether the password text is hidden (true) or visible (false)
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    // We wrap our TextFormField inside the GlassmorphicContainer we built in Phase 1!
    return GlassmorphicContainer(
      // Less padding than a full card
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      borderRadius: 16,
      blurAmount: 10,
      
      child: TextFormField(
        // The controller reads what the user types
        controller: widget.controller,
        
        // Hides text if it's a password AND the eye icon hasn't been tapped
        obscureText: widget.isPassword ? _obscureText : false,
        
        // Keyboard type (e.g., email keyboard has the '@' symbol easy to reach)
        keyboardType: widget.keyboardType,
        
        // Text styling
        style: AppTextStyles.bodyLarge.copyWith(color: AppColors.textPrimary),
        
        // Flashes white cursor
        cursorColor: AppColors.primary,

        // Input Decoration (how the field looks)
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textHint),
          
          // Remove default borders because the GlassContainer is our border
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          
          // Transparent fill because the GlassContainer provides the frosted background
          filled: true,
          fillColor: Colors.transparent,

          // Prefix icon (the icon on the LEFT)
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.textSecondary,
            size: 22,
          ),

          // Suffix icon (the eye icon on the RIGHT, only for passwords)
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.textSecondary,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
