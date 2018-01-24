include RSpec

require_relative 'graph'
require_relative 'node'

RSpec.describe Graph, type: Class do
    let(:graph) { Graph.new }

    # Actor nodes
    let(:kevin_bacon) { Node.new('Kevin Bacon') }
    let(:marisa_tomei) { Node.new('Marisa Tomei') }
    let(:john_carroll_lynch) { Node.new('John Carroll Lynch') }
    let(:joey_king) { Node.new('Joey King') }
    let(:john_travolta) { Node.new('John Travolta') }
    let(:nicolas_cage) { Node.new('Nicolas Cage') }
    let(:gina_gershon) { Node.new('Gina Gershon') }
    let(:shabba_ranks) { Node.new('Shabba Ranks') }
    let(:carlos_valdes) { Node.new('Carlos Valdes') }
    let(:carla_quevedo) { Node.new('Carla Quevedo') }
    let(:danielle_panabaker) { Node.new('Danielle Panabaker') }
    let(:grant_gustin) { Node.new('Grant Gustin') }
    let(:steve_guttenberg) { Node.new('Steve Guttenberg') }
    let(:daniel_stern) { Node.new('Daniel Stern') }
    let(:mickey_rourke) { Node.new('Mickey Rourke') }
    let(:brian_emery) { Node.new('Brian Emery') }
    let(:jose_pena) { Node.new('Jose Pena') }
    let(:gary_guenat) { Node.new('Gary Guenat') }
    let(:joan_cole) { Node.new('Joan Cole') }
    let(:colleen_uphus) { Node.new('Colleen Uphus') }

    # Movie nodes
    let(:crazy_stupid_love) { Node.new('Crazy, Stupid, Love.') }
    let(:face_off) { Node.new('Face/Off') }
    let(:ting_a_ling) { Node.new('Ting-A-Ling') }
    let(:the_fastest_man_alive) { Node.new('The Fastest Man Alive') }
    let(:affluenza) { Node.new('Affluenza') }
    let(:diner) { Node.new('Diner') }
    let(:no_such_road) { Node.new('No Such Road') }
    let(:no_relation) { Node.new('No Relation') }
    let(:chester) { Node.new('Chester') }
    let(:opposites) { Node.new('Opposites') }
    let(:return_to_sender) { Node.new('Return To Sender') }

    let(:filmHash) { Hash.new }
    let(:actorHash) { Hash.new }

    before do
        actorHash['john_carroll_lynch'] = ['Crazy, Stupid, Love.', 'Face/Off']

        filmHash['Crazy, Stupid, Love.'] = [john_carroll_lynch, joey_king, kevin_bacon, marisa_tomei]
        filmHash['Face/Off'] = [john_travolta, nicolas_cage, john_carroll_lynch, gina_gershon]
        filmHash['Ting-A-Ling'] = [shabba_ranks]
        filmHash['The Fastest Man Alive'] = [carlos_valdes, danielle_panabaker, grant_gustin]
        filmHash['Affluenza'] = [steve_guttenberg, carla_quevedo, grant_gustin]
        filmHash['Diner'] = [steve_guttenberg, daniel_stern, mickey_rourke, kevin_bacon]
        filmHash['No Such Road'] = [carlos_valdes, brian_emery] # 4
        filmHash['No Relation'] = [jose_pena, brian_emery] # 5
        filmHash['Chester'] = [jose_pena, gary_guenat] # 6
        filmHash['Opposites'] = [joan_cole, gary_guenat] # 7
        filmHash['Return To Sender'] = [joan_cole, colleen_uphus] # 8
    end

    describe '#traversal' do
        it 'Infinity - Looks for Kevin Bacon and Shabba Ranks to not be connected' do
            expect(graph.traversal(kevin_bacon, kevin_bacon, shabba_ranks, filmHash)).to eq 'Not found!'
            # 'Infinite. No connection.'
        end

        it "One degree - Looks for Kevin Bacon and Marisa Tomei to be in 'Crazy, Stupid, Love.'" do
            expect(graph.traversal(kevin_bacon, kevin_bacon, marisa_tomei, filmHash)).to eq 'Found it!'
            # 'Crazy, Stupid, Love.'
        end

        it "Two degrees - Looks for Kevin Bacon and John Travolta via John Carroll Lynch with the movies 'Crazy, Stupid, Love.' and 'Face/Off'" do
            expect(graph.traversal(kevin_bacon, kevin_bacon, john_travolta, filmHash)).to eq 'Found it!'
            # 'Crazy, Stupid, Love.', 'Face/Off'
        end

        it 'Three degrees - Looks for Kevin Bacon and Carlos Valdes connection' do
            expect(graph.traversal(kevin_bacon, kevin_bacon, carlos_valdes, filmHash)).to eq 'Found it!'
            # 'The Fastest Man Alive', 'Affluenza', 'Diner'
        end

        it 'Three degrees - Looks for connection between Carlos Valdes and Gary Guenat' do
            expect(graph.traversal(carlos_valdes, carlos_valdes, gary_guenat, filmHash)).to eq 'Found it!'
            # 'No Such Road', 'No Relation', 'Chester'
        end

        it 'Seven degrees - Looks for Kevin Bacon and Joan Cole connection' do
            expect(graph.traversal(kevin_bacon, kevin_bacon, joan_cole, filmHash)).to eq 'Found it!'
            # 'Diner', 'Affluenza', 'The Fastest Man Alive', 'No Such Road', 'No Relation', 'Chester', 'Opposites'
        end

        it 'Eight degrees - Looks for Kevin Bacon and Colleen Uphus connection' do
            expect(graph.traversal(kevin_bacon, kevin_bacon, colleen_uphus, filmHash)).to eq 'Not found!'
        end
    end
end
