# Clear existing data
puts "Clearing existing data..."
User.destroy_all
Course.destroy_all
Tutor.destroy_all

# Create sample users
puts "Creating sample users..."
users = [
  { email: 'admin@example.com', password: 'password123' },
  { email: 'user1@example.com', password: 'password123' },
  { email: 'user2@example.com', password: 'password123' },
  { email: 'developer@example.com', password: 'password123' },
  { email: 'tester@example.com', password: 'password123' }
]

users.each do |user_attrs|
  User.create!(user_attrs)
  puts "Created user: #{user_attrs[:email]}"
end

# Create sample courses with tutors
puts "Creating sample courses with tutors..."

# Course 1: Ruby on Rails
ruby_course = Course.create!(
  name: 'Ruby on Rails Fundamentals',
  description: 'Learn the basics of Ruby on Rails framework including MVC architecture, routing, and database interactions.',
  duration_hours: 40
)

ruby_course.tutors.create!([
  {
    name: 'John Smith',
    email: 'john.smith@example.com',
    phone: '+1-555-0101',
    experience_years: 8
  },
  {
    name: 'Sarah Johnson',
    email: 'sarah.johnson@example.com',
    phone: '+1-555-0102',
    experience_years: 5
  },
  {
    name: 'Mike Davis',
    email: 'mike.davis@example.com',
    phone: '+1-555-0103',
    experience_years: 12
  }
])

puts "Created course: #{ruby_course.name} with #{ruby_course.tutors.count} tutors"

# Course 2: JavaScript
js_course = Course.create!(
  name: 'JavaScript Mastery',
  description: 'Master JavaScript programming including ES6+, DOM manipulation, and modern frameworks.',
  duration_hours: 35
)

js_course.tutors.create!([
  {
    name: 'Emily Wilson',
    email: 'emily.wilson@example.com',
    phone: '+1-555-0201',
    experience_years: 6
  },
  {
    name: 'David Brown',
    email: 'david.brown@example.com',
    phone: '+1-555-0202',
    experience_years: 9
  }
])

puts "Created course: #{js_course.name} with #{js_course.tutors.count} tutors"

# Course 3: Python
python_course = Course.create!(
  name: 'Python for Data Science',
  description: 'Learn Python programming with focus on data analysis, machine learning, and scientific computing.',
  duration_hours: 45
)

python_course.tutors.create!([
  {
    name: 'Lisa Chen',
    email: 'lisa.chen@example.com',
    phone: '+1-555-0301',
    experience_years: 7
  },
  {
    name: 'Alex Rodriguez',
    email: 'alex.rodriguez@example.com',
    phone: '+1-555-0302',
    experience_years: 10
  },
  {
    name: 'Maria Garcia',
    email: 'maria.garcia@example.com',
    phone: '+1-555-0303',
    experience_years: 4
  }
])

puts "Created course: #{python_course.name} with #{python_course.tutors.count} tutors"

# Course 4: React
react_course = Course.create!(
  name: 'React Development',
  description: 'Build modern web applications with React, including hooks, context, and state management.',
  duration_hours: 30
)

react_course.tutors.create!([
  {
    name: 'Tom Anderson',
    email: 'tom.anderson@example.com',
    phone: '+1-555-0401',
    experience_years: 6
  },
  {
    name: 'Jennifer Lee',
    email: 'jennifer.lee@example.com',
    phone: '+1-555-0402',
    experience_years: 8
  }
])

puts "Created course: #{react_course.name} with #{react_course.tutors.count} tutors"

# Course 5: DevOps
devops_course = Course.create!(
  name: 'DevOps Engineering',
  description: 'Learn DevOps practices including CI/CD, containerization, and cloud deployment strategies.',
  duration_hours: 50
)

devops_course.tutors.create!([
  {
    name: 'Robert Taylor',
    email: 'robert.taylor@example.com',
    phone: '+1-555-0501',
    experience_years: 11
  },
  {
    name: 'Amanda White',
    email: 'amanda.white@example.com',
    phone: '+1-555-0502',
    experience_years: 7
  },
  {
    name: 'Chris Martin',
    email: 'chris.martin@example.com',
    phone: '+1-555-0503',
    experience_years: 9
  }
])

puts "Created course: #{devops_course.name} with #{devops_course.tutors.count} tutors"

# Course 6: Database Design
db_course = Course.create!(
  name: 'Database Design & SQL',
  description: 'Master database design principles, SQL queries, and database optimization techniques.',
  duration_hours: 25
)

db_course.tutors.create!([
  {
    name: 'Kevin Thompson',
    email: 'kevin.thompson@example.com',
    phone: '+1-555-0601',
    experience_years: 13
  }
])

puts "Created course: #{db_course.name} with #{db_course.tutors.count} tutors"

# Course 7: Mobile Development
mobile_course = Course.create!(
  name: 'Mobile App Development',
  description: 'Build iOS and Android applications using React Native and modern mobile development tools.',
  duration_hours: 55
)

mobile_course.tutors.create!([
  {
    name: 'Rachel Green',
    email: 'rachel.green@example.com',
    phone: '+1-555-0701',
    experience_years: 8
  },
  {
    name: 'Daniel Kim',
    email: 'daniel.kim@example.com',
    phone: '+1-555-0702',
    experience_years: 6
  }
])

puts "Created course: #{mobile_course.name} with #{mobile_course.tutors.count} tutors"

# Course 8: Cybersecurity
security_course = Course.create!(
  name: 'Cybersecurity Fundamentals',
  description: 'Learn about network security, ethical hacking, and protecting applications from vulnerabilities.',
  duration_hours: 40
)

security_course.tutors.create!([
  {
    name: 'Sophie Turner',
    email: 'sophie.turner@example.com',
    phone: '+1-555-0801',
    experience_years: 10
  },
  {
    name: 'James Wilson',
    email: 'james.wilson@example.com',
    phone: '+1-555-0802',
    experience_years: 12
  }
])

puts "Created course: #{security_course.name} with #{security_course.tutors.count} tutors"

# Course 9: Machine Learning
ml_course = Course.create!(
  name: 'Machine Learning Basics',
  description: 'Introduction to machine learning algorithms, data preprocessing, and model evaluation.',
  duration_hours: 60
)

ml_course.tutors.create!([
  {
    name: 'Nina Patel',
    email: 'nina.patel@example.com',
    phone: '+1-555-0901',
    experience_years: 9
  },
  {
    name: 'Carlos Mendez',
    email: 'carlos.mendez@example.com',
    phone: '+1-555-0902',
    experience_years: 7
  },
  {
    name: 'Grace Wong',
    email: 'grace.wong@example.com',
    phone: '+1-555-0903',
    experience_years: 11
  }
])

puts "Created course: #{ml_course.name} with #{ml_course.tutors.count} tutors"

# Course 10: Web Design
design_course = Course.create!(
  name: 'Web Design & UX',
  description: 'Learn modern web design principles, user experience, and responsive design techniques.',
  duration_hours: 30
)

design_course.tutors.create!([
  {
    name: 'Olivia Davis',
    email: 'olivia.davis@example.com',
    phone: '+1-555-1001',
    experience_years: 6
  },
  {
    name: 'Ryan Cooper',
    email: 'ryan.cooper@example.com',
    phone: '+1-555-1002',
    experience_years: 8
  }
])

puts "Created course: #{design_course.name} with #{design_course.tutors.count} tutors"

# Summary
puts "\n=== SEEDING COMPLETE ==="
puts "Created #{User.count} users"
puts "Created #{Course.count} courses"
puts "Created #{Tutor.count} tutors"
puts "\nSample login credentials:"
puts "Email: admin@example.com, Password: password123"
puts "Email: user1@example.com, Password: password123"
puts "\nYou can now test the API with these credentials!" 