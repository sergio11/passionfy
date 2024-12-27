# Passionfy 💕✨ - Where Love Begins 🌟❤️

<img width="300px" align="left" src="./doc/main_logo.png" />

Welcome to **Passionfy** — a vibrant and innovative app crafted to help you forge connections, uncover shared passions, and ignite meaningful relationships! 🌟 Designed exclusively for **iOS 16** with the cutting-edge **SwiftUI**, Passionfy combines elegance, functionality, and seamless animations to deliver a truly engaging experience. 🎉

Built on the foundation of **SwiftUI**, Apple’s revolutionary declarative framework for modern UI development, Passionfy adheres to **Clean Code principles**, ensuring a robust, scalable, and high-performance architecture. Whether you’re exploring potential matches or diving into shared interests, Passionfy offers a polished, intuitive, and feature-rich platform to make every interaction meaningful. ❤️✨

I would like to express my sincere gratitude to the [AppStuff](https://www.youtube.com/@appstuff5778) YouTube channel for providing such valuable resources. I used one of the channel’s videos as a key learning tool and starting point for developing my SwiftUI app. The tutorial was incredibly helpful in understanding UI development, and it gave me a solid foundation to build upon. Since then, I’ve made significant modifications to the app with my own architecture approach and added new features. Your content has been a huge inspiration and has played a key role in my progress. Thanks again for all the help!

This app, **Passionfy**, includes images and resources designed by [Freepik](https://www.freepik.com). We would like to acknowledge and thank Freepik for their incredible design assets. The images used in the app are provided with attribution, as required by Freepik's licensing terms. For more information on Freepik's resources, please visit [www.freepik.com](https://www.freepik.com).

<p align="center">
  <img src="https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white" />
  <img src="https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white" />
  <img src="https://img.shields.io/badge/Xcode-007ACC?style=for-the-badge&logo=Xcode&logoColor=white" />
  <img src="https://img.shields.io/badge/Apple%20laptop-333333?style=for-the-badge&logo=apple&logoColor=white" />
  <img src="https://img.shields.io/badge/firebase-ffca28?style=for-the-badge&logo=firebase&logoColor=black" />
</p>

Slides are built using the  template from [Previewed](https://previewed.app/template/AFC0B4CB). I extend my gratitude to them for their remarkable work and contribution.


## ✨ Features That Make Passionfy Unique  

Passionfy is thoughtfully designed to offer a seamless and enjoyable experience for creating meaningful connections. Here’s a detailed look at the features that make it stand out:  

### 👤 **Create a Fully Personalized Profile**  
Showcase your personality and preferences with an in-depth profile creation process:  
- **📛 Username:** Choose a unique name that represents you.  
- **🎂 Age:** Share your age to help find compatible matches.  
- **🚻 Gender & 🏳️‍🌈 Orientation:** Specify your gender, sexual orientation, and the gender of your ideal partner for tailored matching.  
- **🎨 Hobbies:** Highlight your passions and interests to connect with like-minded individuals.  
- **🌍 Location:** Provide your location to discover matches near you, ensuring proximity and convenience.  
- **💑 Relationship Preferences:** Indicate the type of relationship you’re seeking, whether casual or long-term.  
- **📸 Photo Gallery:** Upload up to **6 photos** to showcase your best self.  
- **👔 Occupation:** Add your profession to give your profile a personal touch.  

### 🔒 **Secure and Convenient Login**  
- **📱 OTP Login:** Enjoy a hassle-free and secure sign-in experience using a one-time password sent to your mobile phone.  

### 🔍 **Explore & Discover**  
Passionfy makes finding connections both engaging and intuitive:  
- **🖼️ Browse Profiles:** Explore detailed profiles of other users, complete with their photos, hobbies, and preferences.  
- **🎮 Swipe to Match:** Play the swipe game to find your perfect match — swipe right if you're interested, left to pass.  

### 💬 **Real-Time Chat with Matches**  
Keep the conversation flowing with smooth and reliable messaging:  
- **📨 Instant Messaging:** Chat in real-time with your matches for seamless communication.  
- **📷 Multimedia Support:** Share photos and emojis to make conversations more vibrant and personal.  

### 🔒 **Safety and Moderation Tools**  
Passionfy prioritizes user safety and provides tools to maintain a respectful environment:  
- **🚨 Report Profiles:** Quickly flag inappropriate behavior or content.  
- **🚫 Block Users:** Take control of your experience by blocking profiles you no longer want to interact with.  

### 🛠️ **Edit Your Profile Anytime**  
Stay flexible with your information:  
- **🔄 Profile Management:** Update any details you provided during the onboarding process, including photos, preferences, and personal info.  

Passionfy combines robust functionality with an elegant interface to create an app that’s not just about finding matches but also about celebrating individuality, safety, and meaningful connections. Dive in and start your journey today! 💕✨  

## 👩‍💻 Technical Highlights  

Passionfy leverages modern technologies and best practices to deliver a seamless, robust, and engaging experience. Here’s what makes the app stand out from a technical perspective:  

### 🚀 **SwiftUI Framework**  
- Built entirely with **SwiftUI**, Apple’s cutting-edge declarative framework, ensuring:  
  - A sleek and responsive user interface.  
  - Smooth animations that enhance user interaction.  
  - Optimized performance tailored for iOS devices.

### 🛠️ **Clean and Scalable Architecture**  
- Developed following **Clean Architecture** principles to ensure:  
  - A modular and maintainable codebase.  
  - Scalability to support future features and enhancements.  
  - Separation of concerns for improved testability and reliability.  

### 📚 **Industry Best Practices**  
- Adheres to coding standards and guidelines to ensure:  
  - High code quality and consistency.  
  - Robust error handling and efficient data management.  
  - Compatibility with iOS 16 and future iOS updates.  

### 🎨 **Stunning, User-Centric Design**  
- Passionfy boasts an elegant, vibrant, and intuitive interface, focusing on:  
  - Aesthetic appeal with modern design elements.  
  - Accessibility for a diverse user base.  
  - Keeping users engaged and delighted throughout their journey.    

✨ With Passionfy, we’re bringing people closer while delivering a flawless, cutting-edge experience. 💕  

## 🏗️ Architecture  

**Passionfy** is designed with a modern **MVVM (Model-View-ViewModel)** pattern enhanced by **Clean Architecture** principles. This ensures a scalable, maintainable, and testable application structure while delivering an exceptional user experience.  


### MVVM + Clean Architecture  

#### MVVM:  
- **Model**: Represents the app’s core data structures, such as `User`, `Chat`, and `ChatMessage`.  
- **View**: Composed of SwiftUI views like `UserProfileView`, `ExploreView`, and `ChatDetailView`, responsible for presenting the user interface.  
- **ViewModel**: Acts as the bridge between the View and the business logic. The ViewModel transforms raw data into a format suitable for display and interacts with use cases to fetch and process data.  

#### Clean Architecture Layers:  
1. **Use Case Layer**:  
   - Contains the app’s core business logic, encapsulating user actions such as creating a profile, searching for matches, swiping, and chatting.  
   - Examples: `CreateChatUseCase`, `GetUserMatchesUseCase`, and `GetSuggestionsUseCase`.  

2. **Repository Layer**:  
   - Abstracts data-fetching and manipulation logic, providing a unified API for accessing user profiles, matches, and chats.  
   - Examples: `UserRepository`, `MessagingRepository`, and `AuthenticationRepository`.  
   - Interacts with external services like Firebase through well-defined interfaces, ensuring loose coupling.  

3. **Data Source Layer**:  
   - Manages communication with external services such as Firebase, handling tasks like reading and writing data.  
   - Examples: `UserMatchDataSource` and `AuthenticationDataSource`.  
   - Abstracts Firebase operations to simplify testing and scalability.  

### SwiftUI + Combine  

Passionfy takes full advantage of **SwiftUI** for its declarative UI framework, enabling dynamic and reactive interfaces. Paired with **Combine**, it ensures seamless state management and real-time updates, particularly for features like:  
- User profile updates.  
- Live chat functionality.  
- Dynamic match recommendations and swiping interactions.  

This combination guarantees a smooth and interactive user experience.  

### Inversion of Control (IoC) and Factory Pattern  

Passionfy employs an **IoC (Inversion of Control) container** along with the **Factory** design pattern for:  
- Managing dependency injection.  
- Simplifying class interactions by injecting required services (repositories, use cases, etc.) where needed.  
- Enhancing modularity and testability, making the app flexible for future growth.  

### Firebase Integration  

Passionfy leverages **Firebase** for its backend, offering real-time synchronization, scalability, and secure data management. All Firebase interactions are abstracted through repositories and data sources, ensuring the app is maintainable and testable.  

- **Firestore**: A NoSQL database for storing user profiles, chats, matches, and reports. Enables real-time updates for chat and swipe interactions.  
- **Firebase Authentication**: Provides secure login using OTP (One-Time Password) for a simple and safe sign-in experience.  
- **Firebase Storage**: Manages user-uploaded profile pictures, ensuring efficient and reliable image handling.  

## ⚙️ Technologies Used  

### Core Frameworks and Libraries  
- **SwiftUI**: A declarative framework for building the app's responsive and elegant user interface.  
- **Combine**: Powers reactive programming and state management, ensuring real-time data binding between the UI and backend.  
- **Firebase**: Backend as a Service (BaaS) for real-time data storage, authentication, and media handling.  

### Supporting Libraries  
- **Kingfisher**: Efficiently downloads and caches user profile images.  
- **SwipeActions**: Enhances UX with intuitive swipe gestures for user interactions, like reporting or blocking profiles.  

## 🛠️ Why This Architecture?  

- **Scalability**: Clean separation of concerns allows new features to be added with minimal impact on existing functionality.  
- **Maintainability**: Decoupled components make debugging and updating code straightforward.  
- **Testability**: Abstracted layers (repositories and data sources) make unit and integration testing easier.  

By combining modern tools, best practices, and a user-centric approach, Passionfy delivers not just a dating app, but a secure, scalable, and delightful space for creating meaningful connections. 🌟  


## App Screenshots

Here are some screenshots from our app to give you a glimpse of its design and functionality.

<img width="260px" align="left" src="doc/screenshots/picture_1.png" />
<img width="260px" align="left" src="doc/screenshots/picture_2.png" />
<img width="260px" src="doc/screenshots/picture_3.png" />

<img width="260px" align="left" src="doc/screenshots/picture_4.png" />
<img width="260px" align="left" src="doc/screenshots/picture_5.png" />
<img width="260px" src="doc/screenshots/picture_6.png" />

<img width="260px" align="left" src="doc/screenshots/picture_7.png" />
<img width="260px" align="left" src="doc/screenshots/picture_8.png" />
<img width="260px" src="doc/screenshots/picture_9.png" />

<img width="260px" align="left" src="doc/screenshots/picture_10.png" />
<img width="260px" align="left" src="doc/screenshots/picture_11.png" />
<img width="260px" src="doc/screenshots/picture_12.png" />

<img width="260px" align="left" src="doc/screenshots/picture_13.png" />
<img width="260px" align="left" src="doc/screenshots/picture_14.png" />
<img width="260px" src="doc/screenshots/picture_15.png" />

<img width="260px" align="left" src="doc/screenshots/picture_16.png" />
<img width="260px" align="left" src="doc/screenshots/picture_17.png" />
<img width="260px" src="doc/screenshots/picture_18.png" />

<img width="260px" align="left" src="doc/screenshots/picture_19.png" />
<img width="260px" align="left" src="doc/screenshots/picture_20.png" />
<img width="260px" src="doc/screenshots/picture_21.png" />

<img width="260px" align="left" src="doc/screenshots/picture_22.png" />
<img width="260px" align="left" src="doc/screenshots/picture_23.png" />
<img width="260px" src="doc/screenshots/picture_24.png" />

<img width="260px" align="left" src="doc/screenshots/picture_25.png" />
<img width="260px" align="left" src="doc/screenshots/picture_26.png" />
<img width="260px" src="doc/screenshots/picture_27.png" />

<img width="260px" align="left" src="doc/screenshots/picture_28.png" />
<img width="260px" align="left" src="doc/screenshots/picture_29.png" />
<img width="260px" src="doc/screenshots/picture_30.png" />

<img width="260px" align="left" src="doc/screenshots/picture_31.png" />
<img width="260px" align="left" src="doc/screenshots/picture_32.png" />
<img width="260px" src="doc/screenshots/picture_33.png" />

<img width="260px" align="left" src="doc/screenshots/picture_34.png" />
<img width="260px" align="left" src="doc/screenshots/picture_35.png" />
<img width="260px" src="doc/screenshots/picture_36.png" />

<img width="260px" align="left" src="doc/screenshots/picture_37.png" />
<img width="260px" align="left" src="doc/screenshots/picture_38.png" />
<img width="260px" src="doc/screenshots/picture_39.png" />

<img width="260px" align="left" src="doc/screenshots/picture_40.png" />
<img width="260px" align="left" src="doc/screenshots/picture_41.png" />
<img width="260px" src="doc/screenshots/picture_42.png" />

<img width="260px" align="left" src="doc/screenshots/picture_43.png" />
<img width="260px" align="left" src="doc/screenshots/picture_44.png" />
<img width="260px" src="doc/screenshots/picture_45.png" />

<img width="260px" align="left" src="doc/screenshots/picture_46.png" />
<img width="260px" align="left" src="doc/screenshots/picture_47.png" />
<img width="260px" src="doc/screenshots/picture_48.png" />

<img width="260px" align="left" src="doc/screenshots/picture_49.png" />
<img width="260px" align="left" src="doc/screenshots/picture_50.png" />
<img width="260px" src="doc/screenshots/picture_51.png" />

<img width="260px" align="left" src="doc/screenshots/picture_52.png" />
<img width="260px" align="left" src="doc/screenshots/picture_53.png" />
<img width="260px" src="doc/screenshots/picture_54.png" />

<img width="260px" align="left" src="doc/screenshots/picture_55.png" />
<img width="260px" align="left" src="doc/screenshots/picture_56.png" />
<img width="260px" src="doc/screenshots/picture_57.png" />

<img width="260px" align="left" src="doc/screenshots/picture_58.png" />
<img width="260px" align="left" src="doc/screenshots/picture_59.png" />
<img width="260px" src="doc/screenshots/picture_60.png" />

<img width="260px" align="left" src="doc/screenshots/picture_61.png" />
<img width="260px" align="left" src="doc/screenshots/picture_62.png" />
<img width="260px" src="doc/screenshots/picture_63.png" />

<img width="260px" align="left" src="doc/screenshots/picture_64.png" />
<img width="260px" align="left" src="doc/screenshots/picture_65.png" />
<img width="260px" src="doc/screenshots/picture_66.png" />

## Contributing 🤝

Contributions are welcome! If you'd like to contribute to Passionfy, please fork the repository and create a pull request with your changes.

## Acknowledgements 🙏

Passionfy is inspired by the functionality and design of Tinder.

This app, **Passionfy**, includes images and resources designed by [Freepik](https://www.freepik.com). We would like to acknowledge and thank Freepik for their incredible design assets. The images used in the app are provided with attribution, as required by Freepik's licensing terms. For more information on Freepik's resources, please visit [www.freepik.com](https://www.freepik.com).

I would like to express my sincere gratitude to the [AppStuff](https://www.youtube.com/@appstuff5778) YouTube channel for providing such valuable resources. I used one of the channel’s videos as a key learning tool and starting point for developing my SwiftUI app. The tutorial was incredibly helpful in understanding UI development, and it gave me a solid foundation to build upon. Since then, I’ve made significant modifications to the app with my own architecture approach and added new features. Your content has been a huge inspiration and has played a key role in my progress. Thanks again for all the help!

Template mockup from https://previewed.app/template/AFC0B4CB

## Visitors Count


## Please Share & Star the repository to keep me motivated.
<a href = "https://github.com/sergio11/passionfy/stargazers">
   <img src = "https://img.shields.io/github/stars/sergio11/passionfy" />
</a>

## License ⚖️

This project is licensed under the MIT License, an open-source software license that allows developers to freely use, copy, modify, and distribute the software. 🛠️ This includes use in both personal and commercial projects, with the only requirement being that the original copyright notice is retained. 📄

Please note the following limitations:

- The software is provided "as is", without any warranties, express or implied. 🚫🛡️
- If you distribute the software, whether in original or modified form, you must include the original copyright notice and license. 📑
- The license allows for commercial use, but you cannot claim ownership over the software itself. 🏷️

The goal of this license is to maximize freedom for developers while maintaining recognition for the original creators.

```
MIT License

Copyright (c) 2024 Dream software - Sergio Sánchez 

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

