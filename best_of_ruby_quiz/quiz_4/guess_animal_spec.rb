require File.expand_path(File.dirname(__FILE__) + '/guess_animal.rb')

describe AnimalQuiz::Proctor do
  before do
    @stdin = double(:stdin)
    @stdout = double(:stdout)
    @proctor = AnimalQuiz::Proctor.new("an elephant", @stdin, @stdout)
  end

  it "can guess correctly" do
    i = -1
    @stdin.stub(:gets) do
      %w{y}[i+=1]
    end

    @stdout.should_receive(:puts).with("Think of an animal...\n")
    @stdout.should_receive(:puts).with("Is it an elephant? (y or n)\n")
    #y
    @stdout.should_receive(:puts).with("I win. Pretty smart, aren' t I?\n")

    @proctor.play.should be_true
  end

  it "can learn by adding a question" do
    i = -1
    @stdin.stub(:gets) do
      ["a rabbit", "Is it a small animal?", "y", "y", "y"][i+=1]
    end

    @stdout.should_receive(:puts).with("What animal were you thinking of?\n")
    #a rabbit
    @stdout.should_receive(:puts).with("Give me a question to distinguish a rabbit from an elephant.\n")
    #Is it a small animal?
    @stdout.should_receive(:puts).with("For a rabbit, what is the answer to your question? (y or n)\n")
    #y
    @stdout.should_receive(:puts).with("Thanks.\n")

    @proctor.learn

    @stdout.should_receive(:puts).with("Think of an animal...\n")
    @stdout.should_receive(:puts).with("Is it a small animal?\n")
    #y
    @stdout.should_receive(:puts).with("Is it a rabbit? (y or n)\n")
    #y
    @stdout.should_receive(:puts).with("I win. Pretty smart, aren' t I?\n")

    @proctor.play.should be_true
  end

  it "can chain 2 questions"



end
