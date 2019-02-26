
class Dictionary
    def self.make_set(file)
        words = File.readlines(file).map(&:chomp)
        dictionary = Set.new

        words.each do |word|
            dictionary.add(word)
        end
        dictionary
    end
end