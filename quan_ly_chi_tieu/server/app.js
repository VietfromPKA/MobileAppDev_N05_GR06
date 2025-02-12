const express = require('express');
const mongoose = require('mongoose');
const expensesRoutes = require('./routes/expense_routes');

const app = express();
app.use(express.json());

mongoose.connect('mongodb+srv://22010019:12345aA@expenses.i16kc.mongodb.net/quan_ly_chi_tieu?retryWrites=true&w=majority', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
}).then(() => {
  console.log('Connected to MongoDB Atlas');
}).catch(err => {
  console.error('Connection error', err.message);
});

app.use('/expenses', expensesRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
