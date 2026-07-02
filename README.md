# SmartPharma - Pharmacy Management System

A comprehensive pharmacy management application built with **Spring Boot 3.3.2**, **Java 21**, and **Hibernate JPA**. This system provides complete inventory tracking, POS billing, expiry alerts, and supplier management.

## 🎯 Features

- ✅ **Inventory Management** - Real-time medication stock tracking with automated alerts
- ✅ **Point of Sale (POS)** - Fast and efficient billing terminal for transactions  
- ✅ **Expiry Tracking** - Automated alerts for expired medicines
- ✅ **Supplier Management** - Manage supplier information and contact details
- ✅ **Sales Dashboard** - Track all sales and transaction history
- ✅ **Alert System** - Stock and expiry notifications
- ✅ **User Authentication** - Secure login and role-based access

## 🛠️ Tech Stack

| Component | Technology |
|-----------|------------|
| **Framework** | Spring Boot 3.3.2 |
| **Language** | Java 21 LTS |
| **Database** | H2 (In-Memory) / MySQL |
| **ORM** | Hibernate JPA |
| **View Engine** | JSP |
| **Build Tool** | Maven 3.9.6 |
| **Servlet** | Apache Tomcat (Embedded) |
| **Connection Pool** | HikariCP |

## 📋 Prerequisites

Before running this project, ensure you have:

- **Java 21 LTS** - [Download](https://www.oracle.com/java/technologies/downloads/#java21)
- **Maven 3.9.6+** - [Download](https://maven.apache.org/download.cgi)
- **Git** - [Download](https://git-scm.com)

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/jaydipparmar/smart_pharmacy.git
cd smart_pharmacy
```

### 2. Build the Project

```bash
mvn clean install
```

### 3. Run the Application

#### Option A: Using Maven
```bash
mvn spring-boot:run
```

#### Option B: Using JAR
```bash
java -jar target/smart-pharmacy-0.0.1-SNAPSHOT.jar
```

### 4. Access the Application

- **Home Page**: http://localhost:8080
- **Login Page**: http://localhost:8080/login
- **Dashboard**: http://localhost:8080/dashboard
- **Inventory**: http://localhost:8080/inventory
- **Billing**: http://localhost:8080/billing
- **Suppliers**: http://localhost:8080/suppliers
- **H2 Database Console**: http://localhost:8080/h2-console

## 📁 Project Structure

```
smart_pharmacy/
├── src/
│   └── main/
│       ├── java/com/pharmacy/
│       │   ├── PharmacyApplication.java       # Main entry point
│       │   ├── DataInitializer.java           # Sample data initialization
│       │   ├── controller/
│       │   │   ├── PageController.java        # View controllers
│       │   │   ├── AuthController.java        # Authentication
│       │   │   ├── MedicineController.java    # Medicine management
│       │   │   ├── SaleController.java        # Sales transactions
│       │   │   ├── SupplierController.java    # Supplier management
│       │   │   └── AlertController.java       # Alert management
│       │   ├── model/
│       │   │   ├── User.java
│       │   │   ├── Medicine.java
│       │   │   ├── Sale.java
│       │   │   ├── SaleItem.java
│       │   │   ├── Supplier.java
│       │   │   └── Alert.java
│       │   ├── repository/                    # JPA Repositories
│       │   └── service/                       # Business logic
│       ├── resources/
│       │   ├── application.properties         # Configuration
│       │   └── static/css/
│       │       └── style.css
│       └── webapp/WEB-INF/jsp/
│           ├── home.jsp
│           ├── login.jsp
│           ├── signup.jsp
│           ├── dashboard.jsp
│           ├── inventory.jsp
│           ├── billing.jsp
│           └── suppliers.jsp
├── pom.xml                                    # Maven configuration
├── Dockerfile                                 # Docker configuration
├── docker-compose.yml                        # Docker Compose
├── .gitignore
└── README.md
```

## 🔧 Configuration

### Database Configuration
Edit `src/main/resources/application.properties`:

```properties
# Default: H2 In-Memory Database
spring.datasource.url=jdbc:h2:mem:pharmacy_db
spring.datasource.driver-class-name=org.h2.Driver

# Or use MySQL
# spring.datasource.url=jdbc:mysql://localhost:3306/pharmacy_db
# spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver
# spring.datasource.username=root
# spring.datasource.password=password
```

### Server Configuration

```properties
# Change port (default: 8080)
server.port=8080

# JSP View Resolver
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

## 📝 API Endpoints

### Medicines
- `GET /api/medicines` - Get all medicines
- `POST /api/medicines` - Create new medicine
- `GET /api/medicines/{id}` - Get medicine by ID

### Sales
- `GET /api/sales` - Get all sales
- `POST /api/sales` - Create new sale
- `GET /api/sales/{id}` - Get sale by ID

### Suppliers
- `GET /api/suppliers` - Get all suppliers
- `POST /api/suppliers` - Create supplier
- `GET /api/suppliers/{id}` - Get supplier by ID

### Alerts
- `GET /api/alerts` - Get all alerts
- `GET /api/alerts/unresolved` - Get unresolved alerts

## 🐳 Docker Support

### Build Docker Image
```bash
docker build -t smart-pharmacy .
```

### Run with Docker
```bash
docker run -p 8080:8080 smart-pharmacy
```

### Use Docker Compose
```bash
docker-compose up
```

## 📦 Dependencies

### Spring Boot Starters
- `spring-boot-starter-data-jpa` - Data persistence
- `spring-boot-starter-web` - Web & REST APIs
- `spring-boot-starter-test` - Testing

### Database
- `h2database` - Embedded database
- `mysql-connector-j` - MySQL driver

### Additional Libraries
- `lombok` - Reduce boilerplate code
- `tomcat-embed-jasper` - JSP support
- `jakarta.servlet.jsp.jstl` - JSTL support

See `pom.xml` for complete dependency list.

## 🧪 Testing

Run tests with Maven:

```bash
# Run all tests
mvn test

# Run specific test class
mvn test -Dtest=MedicineControllerTest

# Run tests with coverage
mvn jacoco:report
```

## 🌐 Deployment

### Deploy to Railway.app

```bash
npm install -g @railway/cli
railway login
railway init
railway up
```

### Deploy to Render.com

1. Push to GitHub
2. Create New Web Service on Render.com
3. Connect GitHub repository
4. Set build command: `mvn clean install -DskipTests`
5. Set start command: `java -jar target/smart-pharmacy-0.0.1-SNAPSHOT.jar`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/AmazingFeature`
3. Commit changes: `git commit -m 'Add AmazingFeature'`
4. Push to branch: `git push origin feature/AmazingFeature`
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👤 Author

**Jaydip Parmar**

## 🙏 Acknowledgments

- Spring Boot team for excellent framework
- The open-source community

## 📞 Support

For issues, questions, or suggestions, please open an issue on [GitHub](https://github.com/jaydipparmar/smart_pharmacy/issues).

## 📅 Version History

### v0.0.1 (2026-07-02)
- Initial release
- Core pharmacy management features
- Inventory tracking system
- POS billing terminal
- Expiry alert system

---

**Happy coding! 🎉**
