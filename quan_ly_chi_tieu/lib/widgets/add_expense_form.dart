import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:quan_ly_chi_tieu/models/expense.dart';
import 'package:quan_ly_chi_tieu/providers/expense_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddExpenseForm extends StatefulWidget {
  final Expense? expense;

  const AddExpenseForm({super.key, this.expense});

  @override
  _AddExpenseFormState createState() => _AddExpenseFormState();
}

class _AddExpenseFormState extends State<AddExpenseForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final Uuid uuid = const Uuid();
  String? _selectedCategory;
  String? _selectedType;
  DateTime _selectedDate = DateTime.now();
  final List<String> _categories = [
    'Chọn phân loại',
    'Ăn uống',
    'Nhà cửa',
    'Xe cộ',
    'Làm đẹp',
    'Quần áo',
    'Du lịch',
    'Lương',
    'Học phí',
    'Di chuyển',
    'Giải trí',
    'Sức khỏe',
    'Khác'
  ];
  final List<String> _types = ['Thu nhập', 'Chi tiêu'];
    bool _isLoading = false; // Loading indicator state

  @override
  void initState() {
    super.initState();
    if (widget.expense != null) {
      _titleController.text = widget.expense!.title;
      _amountController.text = widget.expense!.amount.abs().toString(); // Use absolute value
      _selectedCategory = widget.expense!.category;
      _selectedType = widget.expense!.type;
      _selectedDate = widget.expense!.date; // Initialize date
    }
  }
    @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(  // Add this
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // Dismiss keyboard when tapping outside of text fields
      },
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CupertinoTextFormFieldRow(
                controller: _titleController,
                placeholder: 'Tiêu đề',
                prefix: const Icon(CupertinoIcons.textformat),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập tiêu đề';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              CupertinoTextFormFieldRow(
                controller: _amountController,
                placeholder: 'Số tiền',
                prefix: const Icon(CupertinoIcons.money_dollar),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập số tiền';
                  }
                  try {
                    double.parse(value);
                  } catch (e) {
                    return 'Số tiền phải là một số hợp lệ';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
               CupertinoFormRow(
                prefix: const Text("Chọn loại giao dịch"),
                child: CupertinoSlidingSegmentedControl<String>(  // Use CupertinoSlidingSegmentedControl
                  children: {  // Build the segments
                    for (final type in _types)
                      type: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(type),
                      ),
                  },
                  groupValue: _selectedType,  // The currently selected value
                  onValueChanged: (String? newValue) { // Handle value changes
                    setState(() {
                      _selectedType = newValue;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16.0),
              CupertinoFormRow(
                prefix: const Text("Chọn phân loại"),
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  scrollController: FixedExtentScrollController(
                    initialItem: _selectedCategory != null
                        ? _categories.indexOf(_selectedCategory!)
                        : 0,
                  ),
                  onSelectedItemChanged: (int selectedIndex) {
                    setState(() {
                      _selectedCategory = _categories[selectedIndex];
                    });
                  },
                  children: List<Widget>.generate(_categories.length, (int index) {
                    return Center(child: Text(_categories[index]));
                  }),
                ),
              ),

              const SizedBox(height: 16.0),
                CupertinoFormRow( // Date Picker
                prefix: const Text("Chọn ngày"),
                child: CupertinoButton(

                  child: Text(
                    DateFormat('dd/MM/yyyy').format(_selectedDate), // Format the date
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    _showDatePicker(context); // Show the date picker
                  },
                ),
              ),

              const SizedBox(height: 32.0),

              if (_isLoading)  // Show loading indicator
                const CupertinoActivityIndicator()
              else
                CupertinoButton.filled(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      if (_selectedCategory == null) {
                        _showErrorDialog(context, 'Vui lòng chọn phân loại');
                        return;
                      }
                      if (_selectedType == null) {
                        _showErrorDialog(
                            context, 'Vui lòng chọn loại giao dịch');
                        return;
                      }
                      final expense = Expense(
                        id: widget.expense?.id ?? uuid.v4(),
                        title: _titleController.text,
                        amount: (_selectedType == "Chi tiêu")
                            ? -double.parse(_amountController.text)
                            : double.parse(_amountController.text),
                        date: _selectedDate, // Use selected date
                        category: _selectedCategory!,
                        type: _selectedType!,
                      );
                        setState(() {
                          _isLoading = true; // Show loading indicator
                        });
                      try {
                        if (widget.expense == null) {
                          // Add
                          await Provider.of<ExpenseProvider>(context, listen: false)
                              .addExpense(expense);
                               if (mounted) Navigator.pop(context);
                          _showSuccessDialog(context, true);
                        }
                        else {
                              // Update
                          await Provider.of<ExpenseProvider>(context, listen: false)
                            .updateExpense(expense);
                            if (mounted) Navigator.pop(context); // Go back after updating
                            _showSuccessDialog(context, false);
                        }

                      } catch (e) {
                        if(mounted) _showErrorDialog(context, e.toString());

                      } finally {
                        setState(() {
                            _isLoading = false; // Hide loading indicator
                        });
                      }
                    }
                  },
                  child: Text(widget.expense == null
                      ? 'Thêm giao dịch'
                      : 'Cập nhật giao dịch'), // Correct text
                ),
            ],
          ),
        ),
      ),
    );
  }

    void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoDatePicker(
              initialDateTime: _selectedDate,
              mode: CupertinoDatePickerMode.date, // Choose date mode
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
          ),
        );
      });
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Lỗi'),
          content: Text(errorMessage),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
}
 void _showSuccessDialog(BuildContext context, bool isAdd) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('Thành công'),
          content:  Text(isAdd ? 'Thêm giao dịch thành công!' : 'Cập nhật giao dịch thành công'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the dialog
              },
            ),
          ],
        );
      },
    );
  }
}