require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

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
  
  legislators = zip_legislators(zipcode)

  form_letter = erb_template.result(binding)

  thank_you_letters(id, form_letter)
end
