desc "Import wish list"
task :import_list, [:name] => [:environment ] do |t ,word|
  require 'rubygems'
  require 'mechanize'
  agent = Mechanize.new
  
  agent.get("http://www.mca.gov.in/mcafoportal/showCheckCompanyName.do")
   #puts agent.page.forms
   puts "#{word[:name]}"
  form = agent.page.forms.last
  form.name1 = "#{word[:name]}"
  form.submit
  puts "~"*100

  #agent.page.link_with(:text => "Wish List").click
  agent.page.search(".table-row").each do |item|
    Project.create!(:name => item.text.strip)
  end
end