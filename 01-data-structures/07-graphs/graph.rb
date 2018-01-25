require_relative 'node'

class Actor
    def initialize(actor_name, movies)
        @actor_name = actor_name
        @movies = movies
    end
end

class Movie
    def initialize(movie_name, actors)
        @movie_name = movie_name
        @actors = actors
    end
end

class Graph
  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node] = node
  end

  def add_edge(node1, node2)
    @nodes[node1].add_edge(@nodes[node2])
    @nodes[node2].add_edge(@nodes[node1])
  end

  def add_movies(movies)
    movies.each do |key, array|
      length = array.length - 1

      add_node(array[length])

      until length == 0
        nodeNum = length - 1
        until nodeNum == -1
          add_node(array[nodeNum])
          add_edge(array[length], array[nodeNum])
          nodeNum -= 1
        end
        length -= 1
      end
    end
  end

  def add_actors(actors)
    actors.each do |key, array|
      length = array.length - 1

      add_node(array[length])

      until length == 0
        nodeNum = length - 1
        until nodeNum == -1
          add_node(array[nodeNum])
          add_edge(array[length], array[nodeNum])
          nodeNum -= 1
        end
        length -= 1
      end
    end
  end

  def traversal(root_node, search_value, movies, actors)
    # Add nodes & edges
    initialize
    add_node(root_node)

    add_movies(movies)
    add_actors(actors)

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
