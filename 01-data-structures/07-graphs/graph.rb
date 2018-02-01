require_relative 'node'

class Graph
    def initialize
        @nodes = {}
    end

    def add_node(node)
        @nodes[node] = node
    end

    def add_movie_nodes(movies)
        movies.each do |actor_key, movie_array|
            length = movie_array.length - 1

            until length == -1
                # puts movie_array[length]
                puts movie_array[length].value
                add_node(movie_array[length])
                length -= 1
            end
        end
    end

    def add_actor_nodes(actors)
        actors.each do |movie_key, actor_array|
            length = actor_array.length - 1

            until length == -1
                # puts actor_array[length]
                puts actor_array[length].value

                add_node(actor_array[length])
                length -= 1
            end
        end
    end

    def add_edge(node1, node2)
        # puts ' '
        # puts "Inside internal add_edge method!!!"
        # puts "node1 = #{node1}"
        # puts "nil" if @nodes[node1].nil?

        @nodes[node1].add_edge(@nodes[node2])
        @nodes[node2].add_edge(@nodes[node1])
    end

    def add_edges_from_hashes(actors, movies)
        actors.each do |movie_key, actor_array|
            actor_array.each do |actor|
                movies.each do |actor_key, movie_array|
                    movie_array.each do |movie|
                        if movie.value == movie_key
                            # puts ' '
                            # puts "It Matches!!!"
                            # puts "movie.value = #{movie.value}"
                            # puts "movie_key = #{movie_key}"
                            # puts "actor = #{actor}"
                            add_edge(movie, actor)
                        end
                    end
                end
            end
        end
    end

    def traversal(root_node, search_value, movies, actors)
        puts ' '
        # Add nodes & edges
        initialize
        add_node(root_node)
        @actor_count = {}

        add_movie_nodes(movies)
        add_actor_nodes(actors)
        add_edges_from_hashes(actors, movies)

        visited = []
        to_visit = []

        # add root node to visited list and to_visit queue
        visited << root_node
        to_visit << root_node

        to_visit.each do |visitNode|
        end

        until to_visit.empty?
            current_node = to_visit.shift

            if current_node == search_value
                # Node Found
                return 'Found it!'
            else
                # Node Not Found - Searching deeper.
                current_node.adjacent_nodes.each do |node|
                    unless visited.include?(node)
                        visited << node
                        to_visit << node
                    end
                end
            end
        end
        'Not found!'
    end
end
