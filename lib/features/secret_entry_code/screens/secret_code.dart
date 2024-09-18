import 'package:auto_route/auto_route.dart';
import 'package:diary/core/utils/constants/Palette.dart';
import 'package:diary/core/utils/snack_bar/snack_bar.dart';
import 'package:diary/features/home/home.dart';
import 'package:diary/features/secret_entry_code/bloc/password_bloc.dart';
import 'package:diary/features/secret_entry_code/bloc/password_event.dart';
import 'package:diary/features/secret_entry_code/bloc/password_state.dart';
import 'package:diary/features/secret_entry_code/data/repositories/secret_code_repository.dart';
import 'package:diary/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class PinCodePage extends StatelessWidget {
  const PinCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector();
  }
}

class Selector extends StatelessWidget {
  const Selector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        return (state.isPasswordSet &&
                    state.status != PasswordStatus.validationSuccess) ||
                (!state.isPasswordSet &&
                    (state.status == PasswordStatus.settingPassword))
            ? const PinCodeView()
            : const HomePage();
      },
    );
  }
}

class PinCodeView extends StatefulWidget {
  const PinCodeView({super.key});

  @override
  State<PinCodeView> createState() => _PinCodeViewState();
}

class _PinCodeViewState extends State<PinCodeView> {
  final controller = TextEditingController();

  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: const Color.fromRGBO(70, 69, 66, 1),
      ),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 235, 241, 0.37),
        borderRadius: BorderRadius.circular(24),
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return Scaffold(
      body: BlocConsumer<PasswordBloc, PasswordState>(
        listener: (context, state) {
          if (state.status == PasswordStatus.validationSuccess) {
            AutoRouter.of(context).pushNamed("/home");
          }
          if (state.status == PasswordStatus.validationFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              AppSnackBar.show(
                  context, S.of(context).thePasswordWasEnteredIncorrectly,
                  color: Palette.unfinishedColor),
            );
            controller.clear();
          }
        },
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Введите PIN-код",
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: const Color.fromRGBO(70, 69, 66, 1),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Pinput(
                  length: 4,
                  controller: controller,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  separatorBuilder: (index) => const SizedBox(width: 16),
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                          offset: Offset(0, 3),
                          blurRadius: 16,
                        ),
                      ],
                    ),
                  ),
                  onCompleted: (pin) {
                    if (state.isPasswordSet &&
                        state.status != PasswordStatus.validationSuccess) {
                      context
                          .read<PasswordBloc>()
                          .add(ValidatePasswordEvent(pin));
                    } else if (!state.isPasswordSet &&
                        state.status == PasswordStatus.settingPassword) {
                      context.read<PasswordBloc>().add(SetPasswordEvent(pin));
                    }
                  },
                  showCursor: true,
                  cursor: cursor,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

// class RoundedWithShadow extends StatefulWidget {
//   const RoundedWithShadow({Key? key}) : super(key: key);

//   @override
//   _RoundedWithShadowState createState() => _RoundedWithShadowState();

//   @override
//   String toStringShort() => 'Rounded With Shadow';
// }

// class _RoundedWithShadowState extends State<RoundedWithShadow> {
//   final controller = TextEditingController();
//   final focusNode = FocusNode();

//   @override
//   void dispose() {
//     controller.dispose();
//     focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {

//     return Pinput(
//       length: 4,
//       controller: controller,
//       focusNode: focusNode,
//       defaultPinTheme: defaultPinTheme,
//       separatorBuilder: (index) => const SizedBox(width: 16),
//       focusedPinTheme: defaultPinTheme.copyWith(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: const [
//             BoxShadow(
//               color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
//               offset: Offset(0, 3),
//               blurRadius: 16,
//             ),
//           ],
//         ),
//       ),
//       onCompleted: (pin) =>
//           context.read<PasswordBloc>().add(SetPasswordEvent(pin)),
//       showCursor: true,
//       cursor: cursor,
//     );
//   }
// }
