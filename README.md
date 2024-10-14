# Yahay

Flutter stable version

Yahay is a Flutter project designed to allow users to video chat with other people using WebRTC. The project also integrates a file picker implementation through Telegram. This project is currently under development and is not yet finished.

## Features

- **Flutter Frontend**
- **Laravel + PHP Backend**  
  You can find the backend project here: [Yahay Laravel Backend](https://github.com/sb-dor/Yahay-Laravel)
- **WebRTC Integration**  
  Enables video chat functionality between users.
- **Telegram File Picker**  
  Allows users to select and share files using a Telegram file picker.

## How to Run the Project

### Prerequisites

- **Flutter**: Make sure you have Flutter installed on your machine.
- **Laravel Backend**: Make sure you have Php installed on your machine.

### Laravel Setup

1. Clone the backend repository from the link above.
2. Add a `.env` file with the following configuration in main project folder:

```env
MAIN_URL=YOUR_LOCAL_URL

PUSHER_APP_ID=yahapappid
PUSHER_APP_KEY=D4C11397CF5822DDA8516843BFE7AE0944E36A01
PUSHER_APP_SECRET=yahayappsecret
PUSHER_HOST=192.168.100.3
PUSHER_PORT=6001
PUSHER_SCHEME=ws
```

Run the following commands in the backend project:

    composer install
    php artisan migrate
    php artisan serve
    php artisan websocket:serve

Add host by adding --host if you want:

    --host HOST --port PORT_NUMBERS