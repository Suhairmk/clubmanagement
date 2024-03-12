import 'package:flutter/material.dart';
import 'package:groundbooking/api.dart';
import 'package:groundbooking/main.dart';
import 'package:groundbooking/screens/paymentscreen.dart';
import 'package:groundbooking/widjents/textfield.dart';

// List<String> purposeList = [
//   'selectPurpose',
//   'marriage',
//   'party',
//   'sports',
//   'festival',
// ];

DateTime? selectedDateTime;

class GroundBookingScreen extends StatefulWidget {
  GroundBookingScreen({super.key});

  @override
  State<GroundBookingScreen> createState() => _GroundBookingScreenState();
}

class _GroundBookingScreenState extends State<GroundBookingScreen> {
  String selectedPuspose = 'select';
  String selectedpurposeId='0';
  bool isDateSelected = false;
  TextEditingController datecontroller = TextEditingController();
  TextEditingController amountContrpller = TextEditingController();
  Set<String> dropDownListValues = Set();


  @override
  void initState() {
    getDatas();
    super.initState();
  }

  void getDatas() async {
    await getDropdownListFromApi();
    await getDatesFromApi();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    dropDownListValues.add('select');
    for (Map purpose in dropDownList) {
      dropDownListValues.add(purpose['purpose_name']);
      if (purpose['purpose_name'] == selectedPuspose) {
        amountContrpller.text = purpose['payment_perday'].toString() ?? 'null';
        selectedpurposeId=purpose['purposeid'].toString();
      }
    }

    print('dropdown list  ' + dropDownListValues.toString());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: Colors.black)),
              child: DropdownButton<String>(
                underline: SizedBox(),
                isExpanded: true,
                elevation: 0,
                value: selectedPuspose,
                onChanged: (String? newValue) {
                  setState(() {
                    
                    amountContrpller.text = 'Amount';
                    selectedPuspose = newValue!;
                   

                  });
                },
                items: dropDownListValues
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              labelText: 'Date',
              prefixIcon: IconButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: Icon(Icons.calendar_month_sharp)),
              controller: datecontroller,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              readonly: true,
              labelText: 'Amount',
              controller: amountContrpller,
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  if(dateList.contains(datecontroller.text)){
                    showSnackbar(context, 'this date already booked');
                  }
                 else if (selectedPuspose != 'select' &&
                      amountContrpller.text != 'Amount' &&
                      selectedDateTime != null) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        amount: amountContrpller.text,
                        date: datecontroller.text,
                        purpose: selectedpurposeId,
                      ),
                    ));
                  } else {
                    showSnackbar(context, 'fielsd can\'t be empty');
                  }
                },
                child: Text("Pay Now"))
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      final DateTime combinedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );

      setState(() {
        selectedDateTime = combinedDateTime;
        datecontroller.text = combinedDateTime.toString().substring(0, 10);
        isDateSelected = true;
      });
    }
  }
}
