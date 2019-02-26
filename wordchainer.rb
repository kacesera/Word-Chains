require_relative "get_dictionary"

class Wordchainer
    attr_reader :current_words, :all_seen_words, :dictionary, :path

    def initialize(file)
        @dictionary = Dictionary.make_set(file)
        @current_words = []
        @all_seen_words = {}
        @path = []
    end

    def adjacent_words(word)
        word = word.chars
        words = []

        @dictionary.each do |new_word|
            if new_word.length == word.length 
                differences = 0

                new_word.each_char.with_index do |letter, index|
                    differences += 1 if letter != word[index]
                end

                words << new_word if differences == 1
            end
        end
        words
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words = {source => nil}

        while current_words.length != 0  && !@all_seen_words[target]
            new_words = explore_current_words(target)
            @current_words = new_words
        end

        build_path(target)
        @path.reverse! << target
        return_path_and_reset
    end

    def return_path_and_reset
        word_path = @path
        @path = []
        if word_path.length == 1
            puts "No path found!"
            return
        else
            return word_path
        end
    end

    def explore_current_words(target)
        new_current_words = []
        return [] if @all_seen_words.include?(target)

        @current_words.each do |current_word|
            adjacents = adjacent_words(current_word)
            adjacents.each do |adj_word|
                if !@all_seen_words.include?(adj_word)
                    new_current_words << adj_word
                    @all_seen_words[adj_word] = current_word
                end
            end
        end
        new_current_words
    end

    def build_path(target)
        return nil if !all_seen_words[target]
        @path << all_seen_words[target]
        build_path(all_seen_words[target])
    end




    
end