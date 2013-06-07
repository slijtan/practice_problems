require File.expand_path(File.dirname(__FILE__) + "/guess_animal.rb")

proctor = AnimalQuiz::Proctor.new("an elephant")
proctor.play_loop
