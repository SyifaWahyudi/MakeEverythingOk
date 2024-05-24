import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:make_everything_ok/send_wish.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = false;
  bool isDark = false;

  void _makeEverythingOK() {
    setState(() {
      isLoading = true;
    });

    // Simulate loading time
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
      _showProblemSolvedDialog();
    });
  }

  void _showProblemSolvedDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Masalah selesai'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Keren banget! Masalah kamu udah selesai.'),
              SizedBox(height: 10),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (innerContext) {
                    return AlertDialog(
                      title: const Text('Keep Going!'),
                      content: const Text(
                        'Kamu sudah berusaha dan masalah selesai!\n'
                        'Ketika kamu menghadapi kendala, jangan menyerah.\n'
                        'Selalu cek lagi, dan pastikan tidak ada yang terlewatkan.',
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(innerContext)
                                .pop(); // Close the inner dialog
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Nothing Happen?'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              setState(() {
                isDark = !isDark;
                Get.changeThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
              });
            },
            icon: isDark
                ? const Icon(Icons.shield_moon_outlined)
                : const Icon(Icons.sunny),
          ),
          title: ElevatedButton.icon(
            onPressed: () {
              Get.to(const WishPage());
            },
            icon: const Icon(Icons.send),
            label: const Text('Send Your wish'),
          ),
          centerTitle: true,
          backgroundColor: isDark ? Colors.black : Colors.white,
          elevation: 0,
          
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                focusColor: Colors.red,
                onTap: isLoading ? null : _makeEverythingOK,
                child: Container(
                  height: 50,
                  width: 200,
                  decoration: !isDark
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        )
                      : BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Make Everything OK',
                            textAlign: TextAlign.center),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Click the button to make everything OK 😊')
            ],
          ),
        ),
      ),
    );
  }
}
