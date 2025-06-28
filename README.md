# Course and Tutor Management API

[![Test Suite](https://github.com/DevMasterAryan/course_tutor_app/actions/workflows/test.yml/badge.svg)](https://github.com/DevMasterAryan/course_tutor_app/actions/workflows/test.yml)

A Rails API for managing courses and their associated tutors. Built with Rails 7.1, PostgreSQL, and comprehensive testing.

## What This App Does

This is a simple but well-structured Rails API that lets you:
- Create courses with multiple tutors in a single request
- List all courses with their tutors
- Get specific course details with tutor information
- Handle nested attributes for complex data relationships

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

## API Endpoints

### Create a Course with Tutors
```bash
POST /courses
```

Example request:
```json
{
  "course": {
    "name": "Ruby on Rails Fundamentals",
    "description": "Learn the basics of Ruby on Rails",
    "duration_hours": 40,
    "tutors_attributes": [
      {
        "name": "John Doe",
        "email": "john@example.com",
        "phone": "+1-555-0123",
        "experience_years": 5
      }
    ]
  }
}
```

### List All Courses
```bash
GET /courses
```

Returns all courses with their tutors included.

### Get Specific Course
```bash
GET /courses/:id
```

Returns a specific course with its tutors.

## Testing

The app includes a comprehensive test suite:

```bash
# Run all tests
bundle exec rspec

# Run specific test types
bundle exec rspec spec/models/
bundle exec rspec spec/controllers/

# With Docker
docker-compose run test
```

Tests cover:
- Model validations and associations
- Controller endpoints and error handling
- Factory data generation
- API response formats

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
│   └── courses_controller.rb
├── models/
│   ├── course.rb
│   └── tutor.rb
spec/
├── factories/
├── models/
└── controllers/
config/
├── database.yml
└── routes.rb
```

## Key Features

- **Nested Attributes**: Create courses and tutors in one request
- **Email Validation**: Case-insensitive email uniqueness
- **Comprehensive Testing**: Full RSpec test coverage
- **Docker Support**: Easy setup with automatic database initialization
- **Code Quality**: RuboCop and Brakeman integration
- **CI/CD**: Automated testing and quality checks

## Database Schema

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

## Environment Setup

The app uses PostgreSQL. For local development, update `config/database.yml` with your database credentials.

For Docker, the database is automatically configured:
- Host: `db`
- Database: `course_tutor_development`
- Username: `postgres`
- Password: `postgres`
