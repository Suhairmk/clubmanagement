import 'package:flutter/material.dart';
import 'package:groundbooking/api.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen(
      {super.key,
      required this.purpose,
      required this.amount,
      required this.date});
  final purpose;
  final amount;
  final date;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

String selectedPaymentMethod = 'UPI';

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Payment Method:',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: 'UPI',
                groupValue: selectedPaymentMethod,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPaymentMethod = newValue!;
                  });
                },
              ),
              Text('UPI'),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Radio<String>(
                value: 'COD',
                groupValue: selectedPaymentMethod,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPaymentMethod = newValue!;
                  });
                },
              ),
              Text('COD'),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement payment logic here
              print('Payment method selected: $selectedPaymentMethod');
              storeDataToApiWithIdAndToken({
                'purpose': widget.purpose,
                'membid':id,
                'bookdate':widget.date,
                'bookeddate':DateTime.now().toString().substring(0,10),
                'amount':widget.amount,

                
              },context);
              // You can add logic for handling the payment process here
            },
            child: Text('Pay'),
          ),
        ],
      ),
    );
  }
}
