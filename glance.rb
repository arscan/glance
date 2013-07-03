require_relative "lib/glance"



def getkey
  begin
    system("stty raw -echo")
    str = STDIN.getc
  ensure
    system("stty -raw echo")
  end

  str

end

deck = ARGV[0]
deck ||= "ruby"

s =  Glance::Session.new(30)
s.load!()
s.load_deck "decks/#{deck}.yml"
s.play do |f|
  puts "\e[H\e[2J"
  puts f.question
  getkey
  puts "-" * 20
  puts f.answer
  puts "\n"
  puts "How did you do? [1-3]"

  f.score getkey

  puts "W?ould you like another question? [q to quit]"

  k = getkey

  f.continue = false if k == "q"

end
s.save
