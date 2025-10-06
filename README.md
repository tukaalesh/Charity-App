
# 🤝 Hand By Hand: Charity Management System

A comprehensive mobile application built with **Flutter**, designed to revolutionize charitable work by seamlessly connecting donors and volunteers with impactful projects. It features a fully integrated financial system, including wallet management, guided **Zakat** calculation, and a unique **Time Donation** feature.


### ✨ Key Unique Features

We focused on delivering a complete and engaging donor experience:

  * **Donate Your Time:** A unique **"Time Donation"** feature allows donors to apply as volunteers, submit questionnaires, and track their application status directly within the app.
  * **Targeted Zakat Management:** Calculate and pay **Zakat** with the option to **designate the amount** to specific fields (Health, Education, Housing, etc.) for maximum impact.
  * **Wallet & Automation:** Fund the in-app wallet for smooth transactions, and activate the **Monthly Recurring Donation** feature for automated charity.
  * **Points & Rewards:** An integrated **points system** rewards donors for every contribution, featuring a **Top Donors Leaderboard** to foster community engagement.
  * **Secure Access:** A complete **Authentication** flow, including **OTP (One-Time Password)** email verification, to ensure account security.

-----

### ⚙️ Tech Stack & Architecture

The project is built following best practices to ensure performance and scalability:

  * **Framework:** **Flutter**
  * **State Management:**
      * **BLoC / flutter\_bloc:** We chose the **BLoC (Business Logic Component)** architecture for a clean separation of concerns, resulting in **clean, testable, and maintainable** code.
  * **Networking and Data:**
      * **`http`:** Handles all communications with the **Backend API**.
      * **`shared_preferences`:** Used for storing non-sensitive local data (e.g., user session tokens).
  * **UI/UX Enhancements:**
      * **`pin_code_fields`:** Provides a reliable UI for **OTP** entry.
      * **`carousel_slider`** and **`smooth_page_indicator`:** Used for professional sliders and indicators.
      * **`flutter_spinkit`:** Adds high-quality **loading animations (Loaders)**.
  * **Utilities:**
      * **`intl`:** Used for accurate **formatting of currencies** and dates.

-----

## 🚀 Local Setup and Installation

Follow these steps to get the project running locally:

### Prerequisites:

  * **Flutter SDK**
  * **Dart SDK**

### 1\. Clone the Repository:

Use the `git clone` command and navigate into the project directory:

```bash
git clone https://github.com/tukaalesh/Charity-App.git
```

### 2\. Get Dependencies:

Download all required packages:

```bash
flutter pub get
```

### 3\. Run the App:

Launch the application on an attached device or emulator:

```bash
flutter run
```

