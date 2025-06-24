# Flutter Realtime Chat App 💬

A real-time chat application built with **Flutter** for the frontend and **Node.js with WebSocket** for the backend. This project demonstrates how to build a modern chat app with real-time messaging capabilities, user presence detection, and clean UI design.

## ✨ Features

- Real-time messaging using **WebSocket**
- User authentication and login
- Online/offline status indicator
- Typing indicators
- Private one-to-one chats
- Chat history and message timestamps
- Clean and responsive UI
- Works on Android & iOS

## 🛠️ Tech Stack

### Frontend (Flutter)
- Dart
- riverpod 
- WebSocket (native support via `web_socket_channel` package)
- Firebase (optional for auth and push notifications)

### Backend (Node.js)
- Node.js + Express
- `ws` for WebSocket server
- MongoDB or Firebase Realtime DB (for storing messages and user data)

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed
- Node.js installed
- MongoDB
  
### 1. Clone the repo
```bash
git clone https://github.com/yourusername/FlutterRealtimeChat.git
cd FlutterRealtimeChat
````

### 2. Setup the backend

```bash
cd backend
npm install
node index.js
```

> By default, the WebSocket server will run on `ws://localhost:3000`

### 3. Run the Flutter app

```bash
cd ../flutter_chat_app
flutter pub get
flutter run
```

## 📸 Screenshots
![c887d6a3aaeb944a7c6238bf1cac0a88](https://github.com/user-attachments/assets/bfd4e1d2-67f4-46ff-8c49-86446bed2a85)



## 🤝 Contributing

Feel free to fork this project and submit PRs! Here's how to contribute:

1. Fork the repo
2. Create a new branch (`git checkout -b feature/your-feature`)
3. Commit your changes
4. Push to the branch (`git push origin feature/your-feature`)
5. Open a pull request

## 📝 License

This project is licensed under the [MIT License](LICENSE).

## 📬 Contact

Made with ❤️ by \[Your Name]

* GitHub: [YacineHekkas](https://github.com/YacineHekkas)
* Email: [yac.hakkas@gmail.com](mailto:yourname@example.com)

```

---

Would you like me to generate a sample backend (Node.js WebSocket server) or Flutter WebSocket client code for this too?
```
