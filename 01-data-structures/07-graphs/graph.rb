require_relative 'node'

class Graph
    def initialize
        @nodes = {}
    end

    def add_node(node, type, previous, distance)
        @nodes[node] = node
        @nodes[node].type = type
        @nodes[node].previous = previous
        @nodes[node].distance = distance
    end

    def add_movie_nodes(movies)
        movies.each do |_actor_key, movie_array|
            length = movie_array.length - 1

            until length == -1
                add_node(movie_array[length], 'actor', nil, 0)
                length -= 1
            end
        end
    end

    def add_actor_nodes(actors)
        actors.each do |_movie_key, actor_array|
            length = actor_array.length - 1

            until length == -1
                add_node(actor_array[length], 'movie', nil, 0)
                length -= 1
            end
        end
    end

    def add_edge(node1, node2)
        @nodes[node1].add_edge(@nodes[node2])
        @nodes[node2].add_edge(@nodes[node1])
    end

    def add_edges_from_hashes(actors, movies)
        actors.each do |movie_key, actor_array|
            actor_array.each do |actor|
                movies.each do |_actor_key, movie_array|
                    movie_array.each do |movie|
                        add_edge(movie, actor) if movie.value == movie_key
                    end
                end
            end
        end
    end

    def traversal(root_node, search_value, movies, actors)
        # Add nodes & edges
        initialize
        add_node(root_node, 'actor', nil, 0)
        @actor_count = {}

        add_movie_nodes(movies)
        add_actor_nodes(actors)
        add_edges_from_hashes(actors, movies)

        path = ''
        visited = []
        to_visit = []

        # add root node to visited list and to_visit queue
        visited << root_node
        to_visit << root_node

        until to_visit.empty?
            current_node = to_visit.shift

            if current_node == search_value
                # Node Found

                parent = current_node.previous

                until parent.nil?
                    if parent.type == 'movie'
                        path << ', ' unless path == ''
                        path << parent.value
                    end
                    parent = parent.previous
                end

                return path
            else
                # Node Not Found - Searching deeper.
                current_node.adjacent_nodes.each do |node|
                    break if node.distance > 6
                    next if visited.include?(node)
                    visited << node
                    to_visit << node
                    node.previous = current_node
                    node.distance = if node.type == 'movie'
                                        (current_node.distance + 1)
                                    else
                                        current_node.distance
                                    end

                    puts node.distance
                end
            end
        end
        'Not found!'
    end
end
