require_relative "lib/glance"
require 'terminfo' #ruby-terminfo
deck = ARGV[0]
deck ||= "ruby"
def getkey
  begin
    system("stty raw -echo")
    str = STDIN.getc
  ensure
    system("stty -raw echo")
  end

  str

end
s =  Glance::Session.new(15)
s.load!()
s.load_deck "decks/#{deck}.yml"
s.play do |f|
  puts "\e[H\e[2J"
  TermInfo.screen_size[1].times {print "-"}
  puts f.question
  getkey
  TermInfo.screen_size[1].times {print "-"}
  puts f.answer
  puts "\n"
  puts "How did you do? [1-3]"

  f.score getkey

  puts "Would you like another question? [q to quit]"

  k = getkey

  f.continue = false if k == "q"

end
s.save
