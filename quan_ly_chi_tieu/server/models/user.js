const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    unique: true,
  },
  password: {
    type: String,
    required: true,
  },
  username: {
    type: String,
    unique: true, // Đảm bảo rằng username là unique
    default: null, // Thêm giá trị mặc định nếu cần thiết
  },
});

const User = mongoose.model('User', UserSchema);

module.exports = User;
