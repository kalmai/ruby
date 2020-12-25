 "   \033[30mBlack (30)\033[0m\n"
 "   \033[31mRed (31)\033[0m\n"
 "   \033[32mGreen (32)\033[0m\n"
 "   \033[33mYellow (33)\033[0m\n"
 "   \033[34mBlue (34)\033[0m\n" 
 "   \033[35mMagenta (35)\033[0m\n"
 "   \033[36mCyan (36)\033[0m\n"
 "   \033[37mWhite (37)\033[0m\n"
 ''
 "\033[1mBackground Colors...\033[0m\n"
 "   \033[40m\033[37mBlack (40), White Text\033[0m\n"
 "   \033[41mRed (41)\033[0m\n"
 "   \033[42mGreen (42)\033[0m\n"
 "   \033[43mYellow (43)\033[0m\n"
 "   \033[44mBlue (44)\033[0m\n"
 "   \033[45mMagenta (45)\033[0m\n"
 "   \033[46mCyan (46)\033[0m\n"
 "   \033[47mWhite (47)\033[0m\n"
 ''
 "\033[1mModifiers...\033[0m\n"
 "   Reset (0)"
 "   \033[1mBold (1)\033[0m\n"
 "   \033[4mUnderlined (4)\033[0m\n"

require 'pry'

module Color
  def self.colorize(input_color, str)
    colors = {
      "black" => 30,
      "red" => 31,
      "green" => 32,
      "yellow" => 33,
      "blue" => 34,
      "magenta" => 35,
      "cyan" => 36,
      "white" => 37,
    }
    color = colors.select { |k, _| k.eql?(input_color) }.values.first
    "\033[#{color}m#{str}\033[0m"
  end
end

#puts Color::colorize("red", "this is a test")
#puts colorize("black", "this is a test")
#puts colorize("green", "this is a test")
#puts colorize("yellow", "this is a test")
#puts colorize("blue", "this is a test")
#puts colorize("cyan", "this is a test")
#puts colorize("magenta", "this is a test")
#puts colorize("white", "this is a test")
