import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WishPage extends StatefulWidget {
  const WishPage({Key? key}) : super(key: key);

  @override
  _WishPageState createState() => _WishPageState();
}

class _WishPageState extends State<WishPage> {
  String? wishText;
  bool isSending = false;
  final nameController = TextEditingController();

  void _sendWish() {
    final enteredText = nameController.text;
    if (enteredText.isNotEmpty) {
      setState(() {
        isSending = true;
        nameController.clear(); // Clear the text in the TextFormField
      });

      // Simulate sending time
      Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          isSending = false;
          wishText = enteredText;
        });
        _showWishSentDialog();
      });
    }
  }

  void _showWishSentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wish Sent'),
          content: SizedBox(
            height: Get.height * 0.3,
            width: Get.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: Get.height * 0.2,
                  width: Get.width * 0.5,
                  child: LottieBuilder.asset(
                    'assets/lottie/plane1.json',
                    fit: BoxFit.contain,
                  ),
                ),
                const Text('Your wish has been sent to the sky.',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: wishText ?? ''));
                Get.snackbar('Notice', 'Yourwish has been copied');
              },
              child: const Text('Copy Your Wish'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Harapan kamu'),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
              child: TextFormField(
                maxLength: 2500,
                controller: nameController,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(width: 2.0),
                  ),
                  labelText: 'Your Wish...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Harapan tidak boleh kosong';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isSending ? null : _sendWish,
              child: isSending
                  ? const CircularProgressIndicator()
                  : const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Send to the sky.. '),
                        Icon(Icons.send),
                      ],
                    ),
            ),
            const SizedBox(height: 20),
            // if (wishText != null)
            //   Column(
            //     children: [
            //       const Text(
            //         'Your wish:',
            //         style: TextStyle(
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(height: 10),
            //       Text(wishText!),
            //     ],
            //   ),
          ],
        ),
      ),
    );
  }
}
