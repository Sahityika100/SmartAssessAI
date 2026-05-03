# 🎓 SmartAssessAI

> An AI-powered assessment platform for students and administrators — built with Spring Boot, MySQL, and Google Gemini AI.


## 📌 About

**SmartAssessAI** is a full-stack web application that allows students to take AI-generated assessments, receive instant feedback, and download certificates. Admins can manage courses, students, and question banks from a dedicated dashboard.

---

## ✨ Features

### 👨‍🎓 Student
- Register and login securely with JWT authentication
- Browse and enroll in available courses
- Attempt AI-generated MCQ tests (powered by Google Gemini)
- Get instant AI feedback after each test
- View detailed result reports and analytics
- Download certificates on course completion

### 🛠️ Admin
- Secure admin dashboard
- Add, edit, and delete courses
- Manage student accounts
- View student performance and analytics
- Manage question banks

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Backend | Spring Boot 2.7.15, Spring Security, Spring Data JPA |
| Frontend | JSP, HTML, CSS, JavaScript |
| Database | MySQL 8.0, Hibernate ORM |
| AI | Google Gemini API |
| Auth | JWT (JSON Web Tokens) |
| PDF | iTextPDF 5.5 |
| Build Tool | Maven |
| Java Version | Java 17 |

---

## 🚀 Getting Started

### Prerequisites

- Java 17+
- Maven 3.8+
- MySQL 8.0+
- Git

### 1. Clone the Repository

```bash
git clone https://github.com/Sahityika100/SmartAssessAI.git
cd SmartAssessAI
```

### 2. Configure the Database

Login to MySQL and create the database:

```sql
CREATE DATABASE mydb1;
CREATE USER 'smartuser'@'localhost' IDENTIFIED BY 'YourPassword';
GRANT ALL PRIVILEGES ON mydb1.* TO 'smartuser'@'localhost';
FLUSH PRIVILEGES;
```

### 3. Configure application.properties

Open `src/main/resources/application.properties` and set:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/mydb1?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
spring.datasource.username=smartuser
spring.datasource.password=YourPassword

gemini.api.key=YOUR_GEMINI_API_KEY
jwt.secret=YOUR_JWT_SECRET
```

### 4. Build and Run

```bash
mvn clean package -DskipTests
mvn spring-boot:run
```

### 5. Open in Browser

```
http://localhost:8081
```

---
## 📁 Project Structure

```
SmartAssessAI/
├── src/
│   ├── main/
│   │   ├── java/com/example/
│   │   │   ├── controller/        # REST Controllers
│   │   │   ├── entity/            # JPA Entities
│   │   │   ├── repo/              # Repositories
│   │   │   ├── service/           # Business Logic
│   │   │   └── jwt/               # JWT & Security Config
│   │   ├── resources/
│   │   │   └── application.properties
│   │   └── webapp/WEB-INF/views/  # JSP Pages
│   └── test/
├── pom.xml
└── README.md
```

---

## 🔐 Environment Variables

| Variable | Description |
|---|---|
| `DB_URL` | MySQL JDBC connection URL |
| `DB_USERNAME` | MySQL username |
| `DB_PASSWORD` | MySQL password |
| `JWT_SECRET` | Secret key for JWT token signing |
| `GEMINI_API_KEY` | Google Gemini AI API key |
| `PORT` | Server port (default: 8081) |


---

## 🤝 Contributing

1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature`
3. Commit your changes: `git commit -m "Add your feature"`
4. Push to the branch: `git push origin feature/your-feature`
5. Open a Pull Request

---

## 👩‍💻 Author

**Sahityika** — [GitHub](https://github.com/Sahityika100)

---

> Built with ❤️ using Spring Boot and Google Gemini AI