const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const bcrypt = require('bcryptjs');
const mongoose = require('mongoose');
const User = require('../models/user');
const config = require('../config'); // Import config để lấy mongoURI

router.use(bodyParser.json());

router.post('/register', async (req, res) => {
    const { email, password, username } = req.body;
    
    try {
      let user = await User.findOne({ email });
      if (user) {
        console.error('Email already registered');
        return res.status(400).json({ message: 'Email already registered' });
      }
  
      // Đảm bảo username không bị null
      if (!username) {
        return res.status(400).json({ message: 'Username is required' });
      }
  
      // Tạo một người dùng mới và lưu vào cơ sở dữ liệu chính
      user = new User({
        email,
        password: await bcrypt.hash(password, 10),
        username, // Đảm bảo lưu trữ username
      });
  
      await user.save();
      console.log('User saved:', user);
  
      // Tạo collection riêng cho người dùng trong cơ sở dữ liệu chung
      const userDbConnection = mongoose.createConnection(config.mongoURI, {
        useNewUrlParser: true,
        useUnifiedTopology: true,
      });
      console.log('Connected to main database');
  
      // Khởi tạo collection hoặc document ban đầu trong collection mới của người dùng
      const InitialModel = userDbConnection.model(`Initial_${user._id}`, new mongoose.Schema({ message: String }));
      await InitialModel.create({ message: 'Welcome to your private collection!' });
      console.log('Initial document created in user collection');
  
      res.status(201).json({ message: 'Registration successful' });
    } catch (error) {
      console.error('Error during registration:', error);
      res.status(500).json({ message: 'Server error' });
    }
  });
  

router.post('/login', async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
      return res.status(401).json({ message: 'Invalid email or password' });
    }

    res.status(200).json({ message: 'Login successful', userId: user._id });
  } catch (error) {
    console.error('Error during login:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

router.post('/forgot-password', async (req, res) => {
  const { email } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) {
      return res.status(404).json({ message: 'Email not found' });
    }

    // Here you would normally send a reset email, but for now we just simulate success
    res.status(200).json({ message: 'Password reset email sent' });
  } catch (error) {
    console.error('Error during password reset:', error);
    res.status(500).json({ message: 'Server error' });
  }
});

module.exports = router;
