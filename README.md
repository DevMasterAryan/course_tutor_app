# Course and Tutor Management API

[![Test Suite](https://github.com/DevMasterAryan/course_tutor_app/actions/workflows/test.yml/badge.svg)](https://github.com/DevMasterAryan/course_tutor_app/actions/workflows/test.yml)

A Rails API for managing courses and their associated tutors. Built with Rails 7.1, PostgreSQL, and comprehensive testing.

## What This App Does

This is a simple but well-structured Rails API that lets you:
- Create courses with multiple tutors in a single request
- List all courses with their tutors (with pagination)
- Get specific course details with tutor information
- Handle nested attributes for complex data relationships
- **JWT-based authentication** for secure API access
- **Pagination** for efficient data retrieval

The app demonstrates modern Rails development practices including proper testing, code quality tools, and CI/CD setup.

## Quick Start

### Using Docker (Recommended)

The easiest way to get started is with Docker. The setup includes automatic database initialization.

```bash
# Clone and navigate
git clone <repository-url>
cd course_tutor_app

# First time setup - builds everything from scratch
docker-compose up --build

# For subsequent runs (background)
docker-compose up -d

# Run tests
docker-compose run test
```

The app will be available at `http://localhost:3000` and the database at `localhost:5433`.

### Local Development

If you prefer to run it locally:

```bash
# Install dependencies
bundle install

# Setup database (update config/database.yml first)
rails db:create
rails db:migrate

# Run tests
bundle exec rspec

# Start server
rails server
```

## Database Seeding

The app includes a comprehensive seeds file with sample data for testing and demonstration.

### Populate with Sample Data

```bash
# With Rails
rails db:seed

# With Docker
docker-compose exec web rails db:seed
```

### Sample Data Includes

**Users (5 accounts):**
- `admin@example.com` / `password123`
- `user1@example.com` / `password123`
- `user2@example.com` / `password123`
- `developer@example.com` / `password123`
- `tester@example.com` / `password123`

**Courses (10 courses):**
- Ruby on Rails Fundamentals (40 hours, 3 tutors)
- JavaScript Mastery (35 hours, 2 tutors)
- Python for Data Science (45 hours, 3 tutors)
- React Development (30 hours, 2 tutors)
- DevOps Engineering (50 hours, 3 tutors)
- Database Design & SQL (25 hours, 1 tutor)
- Mobile App Development (55 hours, 2 tutors)
- Cybersecurity Fundamentals (40 hours, 2 tutors)
- Machine Learning Basics (60 hours, 3 tutors)
- Web Design & UX (30 hours, 2 tutors)

**Tutors (25 total):**
- Realistic names, emails, and phone numbers
- Varied experience levels (4-13 years)
- Perfect for testing pagination features

## Authentication

The API uses JWT (JSON Web Tokens) for authentication. All course endpoints require a valid token.

### Register a New User
```bash
POST /auth/register
Content-Type: application/json

{
  "user": {
    "email": "user@example.com",
    "password": "password123",
    "password_confirmation": "password123"
  }
}
```

### Login
```bash
POST /auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

### Using the Token
Include the token in the Authorization header for all API requests:
```bash
Authorization: Bearer <your_jwt_token>
```

## API Endpoints

### Authentication
- `POST /auth/register` - Register a new user
- `POST /auth/login` - Login and get JWT token

### Protected Endpoints (require authentication)
- `POST /courses` - Create course with tutors using nested attributes
- `GET /courses` - List all courses with their tutors (paginated)
- `GET /courses/:id` - Get specific course with tutors

## Pagination

The courses index endpoint supports pagination with the following parameters:

- `page` - Page number (default: 1)
- `per_page` - Items per page (default: 10, max: 100)

### Example Pagination Request
```bash
GET /courses?page=2&per_page=5
Authorization: Bearer <your_jwt_token>
```

### Pagination Response Format
```json
{
  "courses": [
    {
      "id": 1,
      "name": "Ruby on Rails",
      "description": "Learn Ruby on Rails",
      "duration_hours": 40,
      "tutors": [...]
    }
  ],
  "pagination": {
    "page": 2,
    "per_page": 5,
    "total_count": 25,
    "total_pages": 5,
    "has_next": true,
    "has_prev": true
  }
}
```

## Testing

The app includes a comprehensive test suite:

```bash
# Run all tests
bundle exec rspec

# Run specific test types
bundle exec rspec spec/models/
bundle exec rspec spec/controllers/
bundle exec rspec spec/services/

# With Docker
docker-compose run test
```

Tests cover:
- Model validations and associations
- Controller endpoints and error handling
- Factory data generation
- API response formats
- Authentication and authorization
- Pagination functionality

## Code Quality

The project uses RuboCop for code style enforcement and Brakeman for security scanning:

```bash
# Check code style
bundle exec rubocop

# Auto-fix safe violations
bundle exec rubocop -a

# Security scan
bundle exec brakeman
```

## CI/CD Pipeline

GitHub Actions automatically runs on every push and pull request:
- Runs all RSpec tests
- Checks code style with RuboCop
- Scans for security vulnerabilities with Brakeman
- Uses Docker for consistent testing environment

Check the badge at the top for current build status.

## Project Structure

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── auth_controller.rb
│   └── courses_controller.rb
├── models/
│   ├── course.rb
│   ├── tutor.rb
│   └── user.rb
├── services/
│   ├── jwt_service.rb
│   └── pagination_service.rb
spec/
├── factories/
├── models/
├── controllers/
└── services/
config/
├── database.yml
└── routes.rb
db/
├── seeds.rb
└── migrate/
```

## Key Features

- **Nested Attributes**: Create courses and tutors in one request
- **Email Validation**: Case-insensitive email uniqueness
- **JWT Authentication**: Secure token-based authentication
- **Pagination**: Efficient data retrieval with configurable page sizes
- **Sample Data**: Comprehensive seeds file for testing
- **Comprehensive Testing**: Full RSpec test coverage
- **Docker Support**: Easy setup with automatic database initialization
- **Code Quality**: RuboCop and Brakeman integration
- **CI/CD**: Automated testing and quality checks

## Database Schema

**Users:**
- email (string, unique)
- password_digest (string)

**Courses:**
- name (string, unique)
- description (text)
- duration_hours (integer)

**Tutors:**
- name (string)
- email (string, unique, case-insensitive)
- phone (string)
- experience_years (integer)
- course_id (foreign key)

## Development Notes

This was built as a demonstration of Rails API development skills. The code follows Rails conventions and includes:

- Proper error handling with appropriate HTTP status codes
- FactoryBot for test data generation
- Database Cleaner for test isolation
- Nested attributes for complex form handling
- Comprehensive validation rules
- JWT-based authentication system
- Pagination service for efficient data handling
- Sample data seeding for easy testing

## Environment Setup

The app uses PostgreSQL. For local development, update `config/database.yml` with your database credentials.

For Docker, the database is automatically configured:
- Host: `db`
- Database: `course_tutor_development`
- Username: `postgres`
- Password: `postgres`

## Contributing

Feel free to submit issues or pull requests. Make sure to run the test suite before submitting changes.

## License

This project was created for demonstration purposes.
