require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'pry'
require 'date'

HOURS = []
W_DAYS = []

def target_times(date)
  # month/day/year hour:minute
  sign_up_date = DateTime.strptime(date, '%m/%d/%y %H:%M')
  W_DAYS.push(sign_up_date.wday)
  HOURS.push(sign_up_date.hour)
end

def num_to_date(num)
  case num
  when 0 then "sunday"
  when 1 then "monday"
  when 2 then "tuesday"
  when 3 then "wednesday"
  when 4 then "thursday"
  when 5 then "friday"
  when 6 then "saturday"
  end
end

def dirty_number?(num)
  invalids = %w( ( ) - . / )
  num.split('').any? { |c| bad_char = c if invalids.include? (c) } 
end

def clean_homephone(phone_num)
  invalids = %w( ( ) - . / )
  bad_char = ""
  phone_num.split('').any? { |c| bad_char = c if invalids.include? (c) } 
  phone_num.gsub!(bad_char, '')
  return phone_num
end


def clean_phone_numbers(phone_num)
  while dirty_number?(phone_num)
    phone_num = clean_homephone(phone_num)
  end
  phone_num = phone_num.split(' ').join
  if phone_num.length < 10 || phone_num.length > 11 || ( phone_num.length == 11 && !phone_num[0].eql?('1') ) 
    "invalid phone number"
  elsif phone_num.length == 10
    phone_num
  elsif phone_num.length == 11 && phone_num[0].eql?('1')
    phone_num[1..phone_num.length - 1]
  end
end

def thank_you_letters(id, form_letter)
  Dir.mkdir('output') unless Dir.exists?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end



def zip_legislators(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin 
    legislators = civic_info.representative_info_by_address(
      address: zip,
      levels: 'country',
      roles: ['legislatorUpperBody', 'legislatorLowerBody']
    ).officials
  rescue
    'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end

end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

puts 'Event manager intialized!'

template_letter = File.read('../form_letter.erb')
erb_template = ERB.new template_letter

contents = CSV.open('../event_attendees.csv', headers: true, header_converters: :symbol)
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])

  phone_number = clean_phone_numbers(row[:homephone])
  sign_up_hour = target_times(row[:regdate])
  
  legislators = zip_legislators(zipcode)

  form_letter = erb_template.result(binding)

  thank_you_letters(id, form_letter)
end

hr_tally = HOURS.tally
most_joined_time = hr_tally.values.max
puts "the most joined times were"
hr_tally.each { |k, v| puts "#{ k > 12 ? (k - 12).to_s << "pm" : k.to_s << "am" }" if v == most_joined_time }

puts ""
puts "the most joined days of the week were"
day_tally = W_DAYS.tally
most_joined_date = day_tally.values.max
day_tally.each { |k, v| puts num_to_date(k) if v == most_joined_date }
