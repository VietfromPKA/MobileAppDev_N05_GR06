const express = require('express');
const router = express.Router();
const Expense = require('../models/expense');

// Lấy tất cả các expense
router.get('/', async (req, res) => {
  try {
    const expenses = await Expense.find();
    res.json(expenses);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Thêm một expense mới
router.post('/', async (req, res) => {
  const expense = new Expense({
    title: req.body.title,
    amount: req.body.amount,
    date: req.body.date,
    category: req.body.category,
    type: req.body.type
  });

  try {
    const newExpense = await expense.save();
    res.status(201).json(newExpense);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Cập nhật một expense
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
  if (req.body.type != null) {
    res.expense.type = req.body.type;
  }
  
  try {
    const updatedExpense = await res.expense.save();
    res.json(updatedExpense);
  } catch (err) {
    res.status(400).json({ message: err.message });
  }
});

// Xóa một expense
router.delete('/:id', getExpense, async (req, res) => {
  try {
    await res.expense.remove();
    res.json({ message: 'Deleted Expense' });
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// Middleware để lấy expense theo ID
async function getExpense(req, res, next) {
  let expense;
  try {
    expense = await Expense.findById(req.params.id);
    if (expense == null) {
      return res.status(404).json({ message: 'Cannot find expense' });
    }
  } catch (err) {
    return res.status(500).json({ message: err.message });
  }

  res.expense = expense;
  next();
}

module.exports = router;
