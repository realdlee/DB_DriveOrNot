
module Driveornot
  BART_API_KEY = "5SHZ-XLUS-U9U5-MN24"

  class Interface

    def initialize(output)
      @output = output
    end

    def start
      @output.puts "Welcome to Drive Or Not!"
      @output.puts "Where are you coming from?"
      @origin = gets.chomp
      @output.puts "Where are you going to?"
      @destination = gets.chomp

      # controller = Controller.new(origin, destination)
    end

  end
end

