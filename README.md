# Course and Tutor Management API

[![Test Suite](https://github.com/yourusername/course_tutor_app/actions/workflows/test.yml/badge.svg)](https://github.com/yourusername/course_tutor_app/actions/workflows/test.yml)

A Rails API application with PostgreSQL database for managing courses and tutors. This project demonstrates RESTful API design, comprehensive testing, and modern Rails development practices.

## 🚀 Features

- **RESTful API**: Clean, well-structured API endpoints
- **Course Management**: Create and list courses with nested tutor creation
- **Tutor Management**: Manage tutors associated with courses  
- **Data Relationships**: One course can have many tutors, each tutor belongs to one course
- **Comprehensive Testing**: Full RSpec test suite with model, controller, and integration tests
- **Data Validation**: Robust validation with case-insensitive email uniqueness
- **Error Handling**: Proper error responses and status codes
- **Docker Support**: Fully containerized application with PostgreSQL and automatic database setup
- **Modern Rails**: Built with Rails 7.1 and Ruby 3.3.0
- **CI/CD Pipeline**: Automated testing on every commit and pull request

## 📋 Prerequisites

### For Docker Setup
- Docker and Docker Compose installed
- Git

### For Local Setup
- Ruby 3.3.0
- PostgreSQL 12+ 
- Rails 7.1+
- Bundler

## 🛠 Installation & Setup

### Option 1: Docker Setup (Recommended)

The Docker setup includes automatic database initialization and migration handling.

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd course_tutor_app
   ```

2. **First time setup - Build and start the application**
   ```bash
   # This builds images from scratch and shows build logs
   docker-compose up --build
   ```
   
   **What happens automatically:**
   - Docker builds the application image
   - PostgreSQL database starts
   - Database is created and migrations run automatically
   - Rails server starts on http://localhost:3000
   
   **Note**: Use `--build` flag for first-time setup or when you've made code changes. This forces Docker to rebuild images and shows logs in the terminal.

3. **For subsequent runs - Start in background**
   ```bash
   # This uses existing images and runs in background
   docker-compose up -d
   ```
   
   **Note**: Use `-d` flag for subsequent runs. This starts services in the background and returns your terminal immediately.

4. **Run tests**
   ```bash
   docker-compose run test
   ```

5. **Access the application**
   - API: http://localhost:3000
   - Database: localhost:5433 (PostgreSQL)

6. **Useful Docker commands**
   ```bash
   # View logs when running in background
   docker-compose logs -f web
   docker-compose logs -f db
   
   # Stop services
   docker-compose down
   
   # Stop and remove volumes (clears database)
   docker-compose down -v
   
   # Rebuild specific service
   docker-compose build web
   
   # View running containers
   docker-compose ps
   
   # Execute Rails commands
   docker-compose exec web rails console
   docker-compose exec web rails routes
   ```

### Option 2: Local Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd course_tutor_app
   ```

2. **Install dependencies**
   ```bash
   bundle install
   ```

3. **Configure database**
   ```bash
   # Copy and edit database configuration
   cp config/database.yml.example config/database.yml
   # Update database.yml with your PostgreSQL credentials
   ```

4. **Create and setup databases**
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed  # optional
   ```

5. **Run tests**
   ```bash
   bundle exec rspec
   ```

6. **Start the server**
   ```bash
   rails server
   ```

## 🗄 Database Configuration

### Docker Environment
The application uses PostgreSQL with automatic setup handled by `docker-entrypoint.sh`:
- **Host**: `db` (Docker service)
- **Port**: `5432`
- **Database**: `course_tutor_development`
- **Username**: `postgres`
- **Password**: `postgres`

**Automatic Setup Process:**
1. Waits for PostgreSQL to be ready
2. Creates database if it doesn't exist
3. Runs all pending migrations
4. Starts the Rails server

### Local Environment
Update `config/database.yml` with your PostgreSQL credentials:
```yaml
development:
  adapter: postgresql
  database: course_tutor_development
  host: localhost
  username: your_username
  password: your_password

test:
  adapter: postgresql
  database: course_tutor_test
  host: localhost
  username: your_username
  password: your_password
```

## 🧪 Testing

### Running Tests with Docker
```bash
# Run all tests (uses separate test service)
docker-compose run test

# Run specific test files
docker-compose exec web bundle exec rspec spec/models/
docker-compose exec web bundle exec rspec spec/controllers/

# Run with coverage (if configured)
docker-compose exec web bundle exec rspec --format documentation
```

### Running Tests Locally
```bash
# Run all tests
bundle exec rspec

# Run specific test files
bundle exec rspec spec/models/
bundle exec rspec spec/controllers/

# Run with coverage
bundle exec rspec --format documentation
```

### Test Coverage
The test suite includes:
- **Model Tests**: Validations, associations, and business logic
- **Controller Tests**: API endpoints and error handling
- **Factory Tests**: Data generation and relationships
- **Integration Tests**: End-to-end API functionality

## 📚 API Documentation

### Base URL
- **Docker**: `http://localhost:3000`
- **Local**: `http://localhost:3000`

### Authentication
Currently, the API does not require authentication for demonstration purposes.

### Endpoints

#### 1. Create Course with Tutors
**POST** `/courses`

Creates a new course along with its tutors in a single request.

**Request Body:**
```json
{
  "course": {
    "name": "Ruby on Rails Fundamentals",
    "description": "Learn the basics of Ruby on Rails framework",
    "duration_hours": 40,
    "tutors_attributes": [
      {
        "name": "John Doe",
        "email": "john@example.com",
        "phone": "+1-555-0123",
        "experience_years": 5
      },
      {
        "name": "Jane Smith", 
        "email": "jane@example.com",
        "phone": "+1-555-0124",
        "experience_years": 3
      }
    ]
  }
}
```

**Response (201 Created):**
```json
{
  "id": 1,
  "name": "Ruby on Rails Fundamentals",
  "description": "Learn the basics of Ruby on Rails framework",
  "duration_hours": 40,
  "created_at": "2025-01-01T10:00:00.000Z",
  "updated_at": "2025-01-01T10:00:00.000Z",
  "tutors": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "+1-555-0123",
      "experience_years": 5,
      "course_id": 1,
      "created_at": "2025-01-01T10:00:00.000Z",
      "updated_at": "2025-01-01T10:00:00.000Z"
    }
  ]
}
```

#### 2. List All Courses with Tutors
**GET** `/courses`

Retrieves all courses along with their associated tutors.

**Response (200 OK):**
```json
[
  {
    "id": 1,
    "name": "Ruby on Rails Fundamentals",
    "description": "Learn the basics of Ruby on Rails framework",
    "duration_hours": 40,
    "created_at": "2025-01-01T10:00:00.000Z",
    "updated_at": "2025-01-01T10:00:00.000Z",
    "tutors": [
      {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "phone": "+1-555-0123",
        "experience_years": 5,
        "course_id": 1,
        "created_at": "2025-01-01T10:00:00.000Z",
        "updated_at": "2025-01-01T10:00:00.000Z"
      }
    ]
  }
]
```

#### 3. Get Specific Course with Tutors
**GET** `/courses/:id`

Retrieves a specific course with its associated tutors.

**Response (200 OK):**
```json
{
  "id": 1,
  "name": "Ruby on Rails Fundamentals",
  "description": "Learn the basics of Ruby on Rails framework",
  "duration_hours": 40,
  "created_at": "2025-01-01T10:00:00.000Z",
  "updated_at": "2025-01-01T10:00:00.000Z",
  "tutors": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "+1-555-0123",
      "experience_years": 5,
      "course_id": 1,
      "created_at": "2025-01-01T10:00:00.000Z",
      "updated_at": "2025-01-01T10:00:00.000Z"
    }
  ]
}
```

**Error Response (404 Not Found):**
```json
{
  "error": "Course not found"
}
```

### Error Handling

The API returns appropriate HTTP status codes and error messages:

- **400 Bad Request**: Invalid request format
- **404 Not Found**: Resource not found
- **422 Unprocessable Entity**: Validation errors
- **500 Internal Server Error**: Server errors

**Validation Error Example:**
```json
{
  "errors": [
    "Name can't be blank",
    "Description can't be blank",
    "Duration hours must be greater than 0"
  ]
}
```

## 🏗 Project Structure

```
course_tutor_app/
├── app/
│   ├── controllers/
│   │   ├── application_controller.rb
│   │   └── courses_controller.rb
│   ├── models/
│   │   ├── course.rb
│   │   └── tutor.rb
│   └── ...
├── config/
│   ├── database.yml
│   ├── routes.rb
│   └── ...
├── db/
│   ├── migrate/
│   │   ├── 001_create_courses.rb
│   │   └── 002_create_tutors.rb
│   └── schema.rb
├── spec/
│   ├── factories/
│   │   ├── courses.rb
│   │   └── tutors.rb
│   ├── models/
│   │   ├── course_spec.rb
│   │   └── tutor_spec.rb
│   ├── controllers/
│   │   └── courses_controller_spec.rb
│   ├── rails_helper.rb
│   └── spec_helper.rb
├── docker-compose.yml
├── docker-entrypoint.sh
├── Dockerfile
├── Gemfile
└── README.md
```

## 🔧 Key Technologies & Gems

### Core Technologies
- **Ruby**: 3.3.0
- **Rails**: 7.1.5.1
- **PostgreSQL**: 15
- **Docker**: Containerization with automatic setup

### Testing Gems
- **RSpec**: Testing framework
- **FactoryBot**: Test data generation
- **Faker**: Realistic test data
- **Shoulda Matchers**: Simplified test assertions
- **Database Cleaner**: Test database management

### Development Gems
- **Puma**: Web server
- **Bootsnap**: Application boot optimization

## 🧪 Testing Strategy

### Test Coverage
- **Model Tests**: Validations, associations, and business logic
- **Controller Tests**: API endpoints, status codes, and responses
- **Factory Tests**: Data generation and relationships
- **Integration Tests**: End-to-end API functionality

### Test Data
- Uses FactoryBot for consistent test data generation
- Faker gem for realistic data
- Database Cleaner for test isolation

### Key Test Scenarios
- ✅ Course creation with nested tutors
- ✅ Email uniqueness (case-insensitive)
- ✅ Validation error handling
- ✅ API response formats
- ✅ Error status codes
- ✅ Database relationships
