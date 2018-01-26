require_relative 'node'

class Movie_list
    def initialize(movie_name, actor_array)
        @movie_name = movie_name
        @actor_array = actor_array
    end
end

class Actor_list
    def initialize(actor_name, movie_array)
        @actor_name = actor_name
        @movie_array = movie_array
    end
end

class Graph
    def traversal; end
end

# Actor nodes
kevin_bacon = Actor_node.new('Kevin Bacon')
marisa_tomei = Actor_node.new('Marisa Tomei')
joey_king = Actor_node.new('Joey King')
john_carroll_lynch = Actor_node.new('John Carroll Lynch')

# Movie nodes
crazy_stupid_love = Movie_node.new('Crazy, Stupid, Love.')

crazy_stupid_love.film_hash['Crazy, Stupid, Love.'] = [john_carroll_lynch, joey_king, kevin_bacon, marisa_tomei]
