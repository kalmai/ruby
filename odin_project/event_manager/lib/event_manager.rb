require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'
require 'pry'

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
  
  legislators = zip_legislators(zipcode)

  form_letter = erb_template.result(binding)
  puts form_letter

#  thank_you_letters(id, form_letter)
end
