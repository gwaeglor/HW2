# encoding: UTF-8
x, y, guess_x, guess_y = ARGV
x_guessed = x == guess_x
y_guessed = y == guess_y

case
when (x_guessed && y_guessed)
  puts "Точка найдена!"
when (x_guessed && !y_guessed)
  puts 'х координата верна, y нет'
when (y_guessed && !x_guessed)
  puts 'y координата верна, x нет'
else
  puts 'Близко, но нет'
end
