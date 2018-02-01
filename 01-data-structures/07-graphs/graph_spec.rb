include RSpec

require_relative 'graph'
require_relative 'node'

RSpec.describe Graph, type: Class do
    let(:graph) { Graph.new }

    # Actor nodes
    let(:kevin_bacon) { Node.new('Kevin Bacon', 'actor') }
    let(:marisa_tomei) { Node.new('Marisa Tomei', 'actor') }
    let(:john_carroll_lynch) { Node.new('John Carroll Lynch', 'actor') }
    let(:joey_king) { Node.new('Joey King', 'actor') }
    let(:john_travolta) { Node.new('John Travolta', 'actor') }
    let(:nicolas_cage) { Node.new('Nicolas Cage', 'actor') }
    let(:gina_gershon) { Node.new('Gina Gershon', 'actor') }
    let(:shabba_ranks) { Node.new('Shabba Ranks', 'actor') }
    let(:carlos_valdes) { Node.new('Carlos Valdes', 'actor') }
    let(:carla_quevedo) { Node.new('Carla Quevedo', 'actor') }
    let(:danielle_panabaker) { Node.new('Danielle Panabaker', 'actor') }
    let(:grant_gustin) { Node.new('Grant Gustin', 'actor') }
    let(:steve_guttenberg) { Node.new('Steve Guttenberg', 'actor') }
    let(:daniel_stern) { Node.new('Daniel Stern', 'actor') }
    let(:mickey_rourke) { Node.new('Mickey Rourke', 'actor') }
    let(:brian_emery) { Node.new('Brian Emery', 'actor') }
    let(:jose_pena) { Node.new('Jose Pena', 'actor') }
    let(:gary_guenat) { Node.new('Gary Guenat', 'actor') }
    let(:joan_cole) { Node.new('Joan Cole', 'actor') }
    let(:colleen_uphus) { Node.new('Colleen Uphus', 'actor') }

    # Movie nodes
    let(:crazy_stupid_love) { Node.new('Crazy, Stupid, Love.', 'movie') }
    let(:face_off) { Node.new('Face/Off', 'movie') }
    let(:ting_a_ling) { Node.new('Ting-A-Ling', 'movie') }
    let(:the_fastest_man_alive) { Node.new('The Fastest Man Alive', 'movie') }
    let(:affluenza) { Node.new('Affluenza', 'movie') }
    let(:diner) { Node.new('Diner', 'movie') }
    let(:no_such_road) { Node.new('No Such Road', 'movie') }
    let(:no_relation) { Node.new('No Relation', 'movie') }
    let(:chester) { Node.new('Chester', 'movie') }
    let(:opposites) { Node.new('Opposites', 'movie') }
    let(:return_to_sender) { Node.new('Return To Sender', 'movie') }

    let(:filmHash) { Hash.new }
    let(:actorHash) { Hash.new }

    before do
        actorHash['Kevin Bacon'] = [crazy_stupid_love, diner]
        actorHash['Marisa Tomei'] = [crazy_stupid_love]
        actorHash['John Carroll Lynch'] = [crazy_stupid_love, face_off]
        actorHash['Joey King'] = [crazy_stupid_love]
        actorHash['John Travolta'] = [face_off]
        actorHash['Nicolas Cage'] = [face_off]
        actorHash['Gina Gershon'] = [face_off]
        actorHash['Shabba Ranks'] = [ting_a_ling]
        actorHash['Carlos Valdes'] = [the_fastest_man_alive, no_such_road]
        actorHash['Danielle Panabaker'] = [the_fastest_man_alive]
        actorHash['Grant Gustin'] = [the_fastest_man_alive, affluenza]
        actorHash['Steve Guttenberg'] = [affluenza, diner]
        actorHash['Daniel Stern'] = [diner]
        actorHash['Mickey Rourke'] = [diner]
        actorHash['Brian Emery'] = [no_such_road, no_relation]
        actorHash['Jose Pena'] = [no_relation, chester]
        actorHash['Gary Guenat'] = [chester, opposites]
        actorHash['Joan Cole'] = [opposites, return_to_sender]
        actorHash['Colleen Uphus'] = [return_to_sender]

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
            expect(graph.traversal(kevin_bacon, shabba_ranks, filmHash, actorHash)).to eq 'Not found!'
        end

        it "One degree - Looks for Kevin Bacon and Marisa Tomei to be in 'Crazy, Stupid, Love.'" do
            expect(graph.traversal(kevin_bacon, marisa_tomei, filmHash, actorHash)).to eq 'Crazy, Stupid, Love.'
        end

        it "Two degrees - Looks for Kevin Bacon and John Travolta via John Carroll Lynch with the movies 'Crazy, Stupid, Love.' and 'Face/Off'" do
            expect(graph.traversal(kevin_bacon, john_travolta, filmHash, actorHash)).to eq 'Face/Off, Crazy, Stupid, Love.'
        end

        it 'Three degrees - Looks for Kevin Bacon and Carlos Valdes connection' do
            expect(graph.traversal(kevin_bacon, carlos_valdes, filmHash, actorHash)).to eq 'The Fastest Man Alive, Affluenza, Diner'
        end

        it 'Three degrees - Looks for connection between Carlos Valdes and Gary Guenat' do
            expect(graph.traversal(carlos_valdes, gary_guenat, filmHash, actorHash)).to eq 'Chester, No Relation, No Such Road'
        end

        it 'Seven degrees - Looks for Kevin Bacon and Joan Cole connection' do
            expect(graph.traversal(kevin_bacon, joan_cole, filmHash, actorHash)).to eq 'Opposites, Chester, No Relation, No Such Road, The Fastest Man Alive, Affluenza, Diner'
        end

        it 'Eight degrees - Looks for Kevin Bacon and Colleen Uphus connection' do
            expect(graph.traversal(kevin_bacon, colleen_uphus, filmHash, actorHash)).to eq 'Not found!'
        end
    end
end
