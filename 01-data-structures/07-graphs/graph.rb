require_relative 'node'

class Movie_list
    def initialize(movie_name, actor_array)
        @movie_name = movie_name
        @actor_array = actor_array
    end

    def movie
        @movie_name
    end

    def actors
        @actor_array
    end
end

class Actor_list
    def initialize(actor_name, movie_array)
        @actor_name = actor_name
        @movie_array = movie_array
    end

    def actor
        @actor_name
    end

    def movies
        @movie_array
    end
end

def add_edges(node1, node2)
    @nodes[node1].add_edge(@nodes[node2])
end

def movie_iteration(movie_to_iterate)
    movie_to_iterate.each do|movie, actors|
        actors.each do|actor|
            add_edges(movie, actor)
        end
    end
end

def actor_iteration(actor_to_iterate)
    movie_to_iterate.each do|actor, movies|
        movies.each do|movie|
            add_edges(actor, movie)
        end
    end
end

# Actor nodes
kevin_bacon = Node.new('Kevin Bacon')
marisa_tomei = Node.new('Marisa Tomei')
joey_king = Node.new('Joey King')
john_carroll_lynch = Node.new('John Carroll Lynch')

# Movie nodes
crazy_stupid_love = Node.new('Crazy, Stupid, Love.')

# Movie_list Class
crazy_stupid_love = Movie_list.new(crazy_stupid_love, [john_carroll_lynch, joey_king, kevin_bacon, marisa_tomei])

# Actor_list Class
kevin_bacon = Actor_list.new(kevin_bacon, [crazy_stupid_love])
marisa_tomei = Actor_list.new(marisa_tomei, [crazy_stupid_love])
joey_king = Actor_list.new(joey_king, [crazy_stupid_love])
john_carroll_lynch = Actor_list.new(john_carroll_lynch, [crazy_stupid_love])

puts "Movie_list Actor Nodes:"
puts crazy_stupid_love.actors

puts "Movie_list Movie Nodes:"
puts crazy_stupid_love.movie

puts "Actor_list Actor Nodes:"
puts kevin_bacon.actor

puts "Actor_list Movie Nodes:"
puts kevin_bacon.movies

# class Graph
#     def traversal; end
# end
#
#
# crazy_stupid_love.film_hash['Crazy, Stupid, Love.'] = [john_carroll_lynch, joey_king, kevin_bacon, marisa_tomei]
