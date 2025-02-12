const express = require('express');
const mongoose = require('mongoose');

const router = express.Router();

const expenseSchema = new mongoose.Schema({
  title: { type: String, required: true },
  amount: { type: Number, required: true },
  date: { type: Date, required: true, default: Date.now },
  category: { type: String, required: true }
});

const Expense = mongoose.model('Expense', expenseSchema);

// Lấy tất cả các chi tiêu
router.get('/', async (req, res) => {
  try {
    const expenses = await Expense.find();
    res.json(expenses);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Tạo một chi tiêu mới
router.post('/', async (req, res) => {
  const expense = new Expense({
    title: req.body.title,
    amount: req.body.amount,
    date: req.body.date,
    category: req.body.category
  });

  try {
    const newExpense = await expense.save();
    res.status(201).json(newExpense);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Lấy một chi tiêu theo ID
router.get('/:id', getExpense, (req, res) => {
  res.json(res.expense);
});

// Cập nhật một chi tiêu theo ID
router.patch('/:id', getExpense, async (req, res) => {
  if (req.body.title != null) {
    res.expense.title = req.body.title;
  }
  if (req.body.amount != null) {
    res.expense.amount = req.body.amount;
  }
  if (req.body.date != null) {
    res.expense.date = req.body.date;
  }
  if (req.body.category != null) {
    res.expense.category = req.body.category;
  }

  try {
    const updatedExpense = await res.expense.save();
    res.json(updatedExpense);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Xóa một chi tiêu theo ID
router.delete('/:id', getExpense, async (req, res) => {
  try {
    await res.expense.remove();
    res.json({ message: 'Đã xóa chi tiêu' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Middleware để lấy chi tiêu theo ID
async function getExpense(req, res, next) {
  let expense;
  try {
    expense = await Expense.findById(req.params.id);
    if (expense == null) {
      return res.status(404).json({ message: 'Không tìm thấy chi tiêu' });
    }
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }
  res.expense = expense;
  next();
}

module.exports = router;
