# 📚 Library Management System (LMS) Mobile Application

A modern, mobile-first Library Management System (LMS) prototype built using the **Flutter UI Toolkit**. This application digitizes and automates core library administrative workflows and user interactions, moving away from error-prone, traditional manual registers toward a responsive, centralized cross-platform system.

---------------------------------------------------------------------------------

## ✨ Features

### 🧑‍💼 Admin Module
* **Interactive Dynamic Dashboard:** Real-time metrics visualization tracking total book inventories, active registered members, and pending issue/return requests.
* **Book Inventory Management (CRUD):** Complete Create, Read, Update, and Delete capabilities allowing administrators to dynamically alter book records, including tracking custom fields like total vs. available copies.
* **Member Oversight:** Administrative terminal to view, verify, and monitor registered member profiles and structural details.
* **Issue & Return Request Processing:** Digital validation workflows to approve or reject item requests dynamically mapped against database constraints.


---------------------------------------------------------------------------------
## 🏗️ Architecture & Developer Highlights

* **MVVM Design Pattern:** Built using Model-View-ViewModel (MVVM) architecture to enforce a strict separation of concerns between UI layouts and core business logic.
* **Relational Data Mapping:** Uses explicit relational links between user models and book models via Foreign Keys (`User ID` ↔ `Book ID`) for accurate query resolution.
* **State Management:** Leverages `setState()` for local, single-widget UI state alongside the `Provider` package for reactive, app-wide asynchronous data flows.
* **Asynchronous Execution Flow:** Uses Dart `Futures` and `async/await` blocks to handle non-blocking, multi-threaded database queries and RESTful API network configurations safely.
* **Form Validation Protocols:** Text fields utilize programmatic regex verification to screen user entry points during login, registration, and credential resets (e.g., verifying email formats and password lengths).

---------------------------------------------------------------------------------

## 🛠️ Tech Stack & Library Dependencies

* **Framework:** [Flutter SDK](https://flutter.dev/) (v3.10+ stable branch compatibility) 
* **Language:** [Dart](https://dart.dev/) (Object-oriented, native compilation) 
* **Local Persistence:** [SQLite Engine](https://www.sqlite.org/) via the `sqflite` plugin for relational transaction storage 
* **Static Storage:** Localized JSON structures (`registered_users.json`) managing user authentication baselines
* **Network Client:** `http` package for processing network handshakes and fetching real-world data points 
* **External Core API:** RESTful endpoint via FreeTestAPI (`https://www.freetestapi.com/api/v1/books`) to stream dynamic book items 
* **Design Guidelines:** Google Material Design components safeguarding responsive viewport metrics via `MediaQuery` and `Flexible` wrappers 

---------------------------------------------------------------------------------

## 🚀 Getting Started

### Project Hardware & Software Constraints
* Operating System: Windows 10/11 or macOS.
* Target Testing Platform: Android Emulator or physical Android device.

### Quick Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git](https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git)
   cd YOUR_REPO_NAME


-------------------------------------

## 🧑‍💻 Behind the Project: An Engineer's Note

This repository holds a special place for me. Built as my final-year internship project, it represents the realization of a childhood curiosity. As a kid, I was always fascinated by how mobile apps worked, never imagining I would one day build one myself. 

Although this is a UI prototype with mock data, deploying it onto my own physical device for the first time was an incredibly rewarding milestone. As a Computer Science Engineering student, building things is expected—but experiencing the actual transition from a blank screen to a functional app felt completely different. While my long-term career goals lie outside of dedicated mobile app development, this opportunity allowed me to dive into a new ecosystem, learn Flutter, and truly appreciate the craft of building software.

### 🌟 A Note on the Journey

> "Life is all about exploration. When an unexpected opportunity knocks, embrace it fully and enjoy the experience. Never regret the detours; if you truly love something, you will always find a way back to it. Every unique experience just makes you a more versatile engineer."

