import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class TopBarWidget extends StatelessWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: responsiveValue(context, 20, 60), vertical: responsiveValue(context, 10, 18)),
      child: Row(
        children: [
          SizedBox(width: responsiveValue(context, 4, 12)),
          Text("Pet Adoption App",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: responsiveValue(context, 18, 24),
              )),
          const Spacer(),
        ],
      ),
    );
  }
} 