import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flash Light',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const FlashlightScreen(title: 'Flashlight'),
    );
  }
}

class FlashlightScreen extends StatelessWidget {
  const FlashlightScreen({super.key, requrired this.title});

  final String title;

  @override
  State<FlashlightScreen> createState() => State<FlashlightScreen>

  {

  bool _isTorchOn = false;

  Future<void> _toggleTorch() async {
    try {
      if (_isTorchOn) {
        await TorchLight.disableTorch();
      } else {
        await TorchLight.enableTorch();
      }
      setState(() {
        _isTorchOn = !_isTorchOn;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error toggling flashlight: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scafold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversPrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        chile: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.power_settings_new,
              size: 100,
              color: _isTorchOn ? Colors.yellow : Colors.grey,
            ),
            const SizedBox(height: 30),
            ElevateButton(
              style: ElevateButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                backgroundColro: _isTorchOn ? Colors.red : Colors.green,
              ),
              onPressed: _toggleTorch,
              chile: Text(
                _isTorchOn ? 'TURN OFF' : 'TURN ON',
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}