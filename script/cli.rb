def lookup_user(email)
  User.find_by_email(email)
end

def prompt_long_url
  puts "Enter your long URL:"
  gets.chomp
end

def create_short_url(user, long_url)
  if user.links_created_one_min > 5
    return "Please wait a while.."
  else
    ShortenedUrl.create_for_user_and_long_url!(user, long_url).short_url
  end
end

def prompt_short_url
  puts "Enter your short URL:"
  gets.chomp
end

def get_shortened_url(short_url)
  ShortenedUrl.find_by_short_url(short_url)
end

def browse(user, shortened_url)
  Launchy.open(shortened_url.long_url)
  Visit.record_visit!(user, shortened_url)
end

while true
  print "Input your email: "
  user = lookup_user(gets.chomp)
  if user.nil?
    puts "Only registered users can use this service!"
    next
  end
  print "Create or visit a short URL? [c, v] "
  case gets.chomp.downcase
  when "c"
    puts "Short URL: #{create_short_url(user, prompt_long_url)}"
  when "v"
    shortened_url = get_shortened_url(prompt_short_url)
    if shortened_url
      browse(user, shortened_url)
    else
      puts "Invalid short URL!"
    end
  else
    puts "Invalid choice!"
    next
  end
end