class Actor_node
    attr_accessor :value
    attr_accessor :adjacent_movies

    def initialize(value)
        @value = value
        @adjacent_movies = []
    end

    def add_edge(adjacent_node)
        @adjacent_movies << adjacent_node
    end
end

class Movie_node
    attr_accessor :value
    attr_accessor :adjacent_actors

    def initialize(value)
        @value = value
        @adjacent_actors = []
    end

    def add_edge(adjacent_node)
        @adjacent_actors << adjacent_node
    end
end
