include RSpec

require_relative 'graph'
require_relative 'node'

RSpec.describe Graph, type: Class do
    let(:graph) { Graph.new }

    # Actor nodes
    let(:kevin_bacon) { Node.new('Kevin Bacon') }
    let(:marisa_tomei) { Node.new('Marisa Tomei') }

    # Movie nodes
    let(:crazy_stupid_love) { Node.new('Crazy, Stupid, Love.') }

    let(:filmHash) { Hash.new }
    let(:actorHash) { Hash.new }

    before do
        actorHash['Kevin Bacon'] = [crazy_stupid_love, diner]
        actorHash['Marisa Tomei'] = [crazy_stupid_love]

        filmHash['Crazy, Stupid, Love.'] = [john_carroll_lynch, joey_king, kevin_bacon, marisa_tomei]
    end

    describe '#traversal' do
        it 'Infinity - Looks for Kevin Bacon and Shabba Ranks to not be connected' do
            expect(graph.traversal(kevin_bacon, shabba_ranks, filmHash, actorHash)).to eq 'Not found!'
            # 'Infinite. No connection.'
        end
    end
end
