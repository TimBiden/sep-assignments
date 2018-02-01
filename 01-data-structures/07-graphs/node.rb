class Node
    attr_accessor :value
    attr_accessor :type
    attr_accessor :adjacent_nodes
	attr_accessor :previous


    def initialize(value, type)
        @value = value
        @type = type
        @adjacent_nodes = []
    end

    def add_edge(adjacent_node)
        @adjacent_nodes << adjacent_node
    end
end
