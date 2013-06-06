class MadLib
  def initialize(story_template)
    @story_template = story_template
  end

  def tell_story(input = STDIN, output = STDOUT)
    story = @story_template
    stored_words = {}

    while match_data = story.match(/(\(\((.+?)\)\))/)
      word_space = match_data[2]
      start, finish = match_data.offset(1)
      var_name = nil

      if(word_parts = MadLib.should_store_word?(word_space))
        var_name, word_space = word_parts
      end

      unless(user_word = stored_words[word_space])
        user_word = input.gets
        output.puts "Please provide #{word_space}"
      end

      story[start...finish] = user_word

      stored_words[var_name] = user_word if var_name
    end

    story
  end

  private

  def self.should_store_word?(word)
    if (match = word.match(/(.+):(.+)/))
      return [match[1], match[2]]
    end
  end
end
