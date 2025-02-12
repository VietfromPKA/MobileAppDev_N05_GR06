const mongoose = require('mongoose');

const expenseSchema = new mongoose.Schema({
  title: String,
  amount: Number,
  date: Date,
  category: String,
});

module.exports = mongoose.model('Expense', expenseSchema);
