# db/seeds.rb

# Clear existing data
puts "Clearing existing data..."
OrderItem.destroy_all
Order.destroy_all
Review.destroy_all
Price.destroy_all
Product.destroy_all
Category.destroy_all
Booking.destroy_all
User.destroy_all

# Create admin user
puts "Creating admin user..."
admin = User.create!(
  name: "Tosin Adewumi",
  email: "admin@riseandresound.com",
  password: "password123",
  password_confirmation: "password123"
)

# Create sample users
puts "Creating sample users..."
users = []
5.times do |i|
  users << User.create!(
    name: "User #{i + 1}",
    email: "user#{i + 1}@example.com",
    password: "password123",
    password_confirmation: "password123"
  )
end

# Create categories
puts "Creating categories..."
categories = [
  Category.create!(name: "Digital eBooks"),
  Category.create!(name: "Affirmations"),
  Category.create!(name: "Speech Packages"),
  Category.create!(name: "Coaching Sessions"),
  Category.create!(name: "Merchandise"),
  Category.create!(name: "Workshops")
]

# Create products
puts "Creating products..."

# Digital eBooks
ebook_products = [
  {
    name: "Rise Above Adversity",
    description: "A comprehensive guide to building resilience and overcoming life's challenges. This digital eBook contains practical strategies, personal stories, and actionable steps to help you develop mental toughness and bounce back from setbacks.",
    stock_quantity: 999,
    price: 19.99
  },
  {
    name: "The Power of Your Story",
    description: "Learn how to harness the transformative power of storytelling for personal growth and inspiration. This eBook teaches you how to craft compelling narratives that motivate yourself and others.",
    stock_quantity: 999,
    price: 15.99
  },
  {
    name: "Youth Leadership Blueprint",
    description: "Essential leadership principles designed specifically for young people. Perfect for students, youth group leaders, and anyone looking to develop leadership skills early in life.",
    stock_quantity: 999,
    price: 24.99
  }
]

ebook_products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    description: product_data[:description],
    stock_quantity: product_data[:stock_quantity],
    category: categories[0] # Digital eBooks
  )

  Price.create!(
    product: product,
    price: product_data[:price],
    start_date: Time.current
  )
end

# Affirmations
affirmation_products = [
  {
    name: "Daily Motivation Pack",
    description: "30 powerful daily affirmations delivered as beautiful digital cards. Start each day with purpose and positivity with these carefully crafted motivational messages.",
    stock_quantity: 999,
    price: 9.99
  },
  {
    name: "Student Success Affirmations",
    description: "Specialized affirmations designed to boost confidence, focus, and academic performance. Perfect for students facing exams, presentations, or academic challenges.",
    stock_quantity: 999,
    price: 12.99
  }
]

affirmation_products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    description: product_data[:description],
    stock_quantity: product_data[:stock_quantity],
    category: categories[1] # Affirmations
  )

  Price.create!(
    product: product,
    price: product_data[:price],
    start_date: Time.current
  )
end

# Speech Packages
speech_products = [
  {
    name: "Resilience & Recovery Package",
    description: "Pre-recorded motivational speeches focusing on resilience, recovery, and personal growth. Includes 3 full-length presentations perfect for personal development or sharing with groups.",
    stock_quantity: 999,
    price: 39.99
  },
  {
    name: "Youth Empowerment Series",
    description: "Inspiring speeches specifically crafted for young audiences. Covers topics like goal setting, overcoming peer pressure, and building self-confidence.",
    stock_quantity: 999,
    price: 34.99
  }
]

speech_products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    description: product_data[:description],
    stock_quantity: product_data[:stock_quantity],
    category: categories[2] # Speech Packages
  )

  Price.create!(
    product: product,
    price: product_data[:price],
    start_date: Time.current
  )
end

# Coaching Sessions
coaching_products = [
  {
    name: "1-on-1 Speaking Coaching (1 Hour)",
    description: "Personal coaching session focused on developing your public speaking skills. Includes presentation review, delivery techniques, and confidence building exercises.",
    stock_quantity: 10,
    price: 99.99
  },
  {
    name: "Personal Development Coaching Package",
    description: "3-session coaching package focused on personal growth, goal setting, and overcoming limiting beliefs. Includes workbook and follow-up resources.",
    stock_quantity: 5,
    price: 249.99
  }
]

coaching_products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    description: product_data[:description],
    stock_quantity: product_data[:stock_quantity],
    category: categories[3] # Coaching Sessions
  )

  Price.create!(
    product: product,
    price: product_data[:price],
    start_date: Time.current
  )
end

# Merchandise
merch_products = [
  {
    name: "Rise and Resound T-Shirt",
    description: "Premium quality cotton t-shirt featuring the Rise and Resound logo and inspiring message. Available in multiple sizes and colors. Wear your motivation!",
    stock_quantity: 50,
    price: 24.99
  },
  {
    name: "Motivational Coffee Mug",
    description: "Start your day right with this inspiring coffee mug featuring daily affirmations and the Rise and Resound branding. Perfect for your morning routine.",
    stock_quantity: 30,
    price: 16.99
  },
  {
    name: "Inspirational Wall Poster Set",
    description: "Set of 5 beautifully designed motivational posters perfect for home, office, or classroom. High-quality prints with powerful messages to keep you inspired.",
    stock_quantity: 25,
    price: 29.99
  }
]

merch_products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    description: product_data[:description],
    stock_quantity: product_data[:stock_quantity],
    category: categories[4] # Merchandise
  )

  Price.create!(
    product: product,
    price: product_data[:price],
    start_date: Time.current
  )
end

# Workshop Products
workshop_products = [
  {
    name: "Corporate Team Building Workshop",
    description: "Full-day workshop designed to build team cohesion, improve communication, and boost morale. Includes interactive exercises, group activities, and take-home materials.",
    stock_quantity: 5,
    price: 499.99
  },
  {
    name: "Student Leadership Workshop",
    description: "Half-day workshop for student groups focusing on leadership development, goal setting, and peer influence. Perfect for schools and youth organizations.",
    stock_quantity: 8,
    price: 299.99
  }
]

workshop_products.each do |product_data|
  product = Product.create!(
    name: product_data[:name],
    description: product_data[:description],
    stock_quantity: product_data[:stock_quantity],
    category: categories[5] # Workshops
  )

  Price.create!(
    product: product,
    price: product_data[:price],
    start_date: Time.current
  )
end

# Create sample orders
puts "Creating sample orders..."
3.times do |i|
  user = users.sample

  # Create order items first, then calculate total
  order_items_data = []
  rand(1..3).times do
    product = Product.all.sample
    quantity = rand(1..2)
    order_items_data << {
      product: product,
      quantity: quantity,
      unit_price: product.current_price
    }
  end

  # Calculate total price
  total_price = order_items_data.sum { |item| item[:quantity] * item[:unit_price] }

  # Create order with correct total
  order = Order.create!(
    user: user,
    status: ['pending', 'processing', 'delivered'].sample,
    total_price: total_price
  )

  # Create order items
  order_items_data.each do |item_data|
    OrderItem.create!(
      order: order,
      product: item_data[:product],
      quantity: item_data[:quantity],
      unit_price: item_data[:unit_price]
    )
  end
end

# Create sample reviews
puts "Creating sample reviews..."
Product.all.each do |product|
  # Add 1-3 reviews per product
  rand(1..3).times do
    Review.create!(
      user: users.sample,
      product: product,
      rating: rand(3..5),
      comment: [
        "Great product! Really helped me with my personal development.",
        "Excellent content and very inspiring. Highly recommend!",
        "Good value for money. The material is well-presented.",
        "This really motivated me to pursue my goals. Thank you!",
        "Perfect for anyone looking to improve their mindset.",
        "Well worth the investment. Quality content throughout."
      ].sample
    )
  end
end

# Create sample bookings
puts "Creating sample bookings..."
sample_bookings = [
  {
    name: "Sarah Johnson",
    email: "sarah.johnson@school.edu",
    event_type: "school_assembly",
    organization: "Lincoln High School",
    preferred_date: 2.weeks.from_now,
    notes: "Looking for an inspiring presentation for our grade 9-12 students about overcoming challenges and setting goals."
  },
  {
    name: "Mike Chen",
    email: "mike.chen@company.com",
    event_type: "corporate_workshop",
    organization: "Tech Solutions Inc.",
    preferred_date: 3.weeks.from_now,
    notes: "Need a team-building workshop for our sales department. About 25 people."
  },
  {
    name: "Lisa Williams",
    email: "lisa@youthcenter.org",
    event_type: "youth_event",
    organization: "Community Youth Center",
    preferred_date: 1.month.from_now,
    notes: "Annual youth leadership conference. Expecting 50-75 participants aged 16-22."
  },
  {
    name: "David Thompson",
    email: "dthompson@conference.org",
    event_type: "conference",
    organization: "Personal Development Conference",
    preferred_date: 6.weeks.from_now,
    notes: "Keynote speaker needed for our annual conference. Audience of 200+ professionals."
  }
]

sample_bookings.each do |booking_data|
  # Some bookings will be linked to registered users, others won't
  user = [nil, users.sample].sample

  Booking.create!(
    user: user,
    name: booking_data[:name],
    email: booking_data[:email],
    event_type: booking_data[:event_type],
    organization: booking_data[:organization],
    preferred_date: booking_data[:preferred_date],
    notes: booking_data[:notes]
  )
end

puts "Seed data created successfully!"
puts "Created:"
puts "- 1 admin user (admin@riseandresound.com / password123)"
puts "- 5 sample users (user1@example.com through user5@example.com / password123)"
puts "- #{Category.count} categories"
puts "- #{Product.count} products"
puts "- #{Order.count} sample orders"
puts "- #{Review.count} sample reviews"
puts "- #{Booking.count} sample speaking bookings"
puts ""
puts "You can now:"
puts "1. Visit the site at localhost:3000"
puts "2. Login as admin to access the dashboard"
puts "3. Browse products, add to cart, and test checkout"
puts "4. Submit speaking booking requests"