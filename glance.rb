require 'yaml'

def getkey
  begin
    system("stty raw -echo")
    str = STDIN.getc
  ensure
    system("stty -raw echo")
  end

  str

end

deck = "ruby"
deck = ARGV[0] if ARGV[0]


deck = YAML::load(File.open("decks/#{deck}.yml"))


begin
  # pick a random question
  puts "\e[H\e[2J"

  cardnumber = rand(deck["cards"].length)

  puts deck["cards"][cardnumber]["question"]

  getkey
  puts "-" * 20

  puts deck["cards"][cardnumber]["answer"]
  puts "\n"
  puts "How did you do? [1-3]"

  score = getkey

  puts "Would you like another question? [q to quit]"

end until getkey == 'q'

