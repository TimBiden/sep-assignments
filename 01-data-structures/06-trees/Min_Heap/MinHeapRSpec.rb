include RSpec

require_relative 'MinHeapSort'

RSpec.describe MinBinaryHeap, type: Class do
  let (:root) { Node.new('The Matrix', 87) }

  let (:tree) { MinBinaryHeap.new(root) }
  let (:pacific_rim) { Node.new('Pacific Rim', 72) }
  let (:braveheart) { Node.new('Braveheart', 78) }
  let (:jedi) { Node.new('Star Wars: Return of the Jedi', 80) }
  let (:donnie) { Node.new('Donnie Darko', 85) }
  let (:inception) { Node.new('Inception', 86) }
  let (:district) { Node.new('District 9', 90) }
  let (:shawshank) { Node.new('The Shawshank Redemption', 91) }
  let (:martian) { Node.new('The Martian', 92) }
  let (:hope) { Node.new('Star Wars: A New Hope', 93) }
  let (:empire) { Node.new('Star Wars: The Empire Strikes Back', 94) }
  let (:mad_max_2) { Node.new('Mad Max 2: The Road Warrior', 98) }

  describe '#insert(data)' do
    it 'properly inserts a new node as a left child in the correct position' do
      tree.insert(root, pacific_rim)

      expect(root.left.title).to eq 'The Matrix'
      expect(root.title).to eq 'Pacific Rim'
    end

    it 'properly inserts a new node as a left-right child' do
      tree.insert(root, jedi)
      tree.insert(root, inception)

      expect(root.title).to eq 'Star Wars: Return of the Jedi'
      expect(root.left.title).to eq 'Inception'
      expect(root.right.title).to eq 'The Matrix'
    end

    it 'properly inserts a new node as a left-left child' do
      tree.insert(root, braveheart)
      tree.insert(root, pacific_rim)

      expect(root.left.left.title).to eq 'The Matrix'
      expect(root.left.title).to eq 'Braveheart'
      expect(root.title).to eq 'Pacific Rim'
    end
  end

  describe '#find(data)' do
    it 'fails NIL gracefully' do
      tree.insert(root, pacific_rim)
      tree.insert(root, braveheart)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, inception)
      tree.insert(root, district)
      tree.insert(root, shawshank)
      tree.insert(root, martian)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(tree.find(root, nil)).to eq nil
    end

    it 'finds root node' do
      tree.insert(root, pacific_rim)
      tree.insert(root, braveheart)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, inception)
      tree.insert(root, district)
      tree.insert(root, shawshank)
      tree.insert(root, martian)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(tree.find(root, 'Pacific Rim').title).to eq 'Pacific Rim'
    end

    it 'finds left-right node' do
      tree.insert(root, pacific_rim)
      tree.insert(root, braveheart)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, inception)
      tree.insert(root, district)
      tree.insert(root, shawshank)
      tree.insert(root, martian)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(tree.find(root, 'District 9').title).to eq 'District 9'
    end

    it 'finds triple-left node' do
      tree.insert(root, pacific_rim)
      tree.insert(root, braveheart)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, inception)
      tree.insert(root, district)
      tree.insert(root, shawshank)
      tree.insert(root, martian)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(tree.find(root, 'The Martian').title).to eq 'The Martian'
    end

    it 'finds left-double-right node' do
      tree.insert(root, pacific_rim)
      tree.insert(root, braveheart)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, inception)
      tree.insert(root, district)
      tree.insert(root, shawshank)
      tree.insert(root, martian)
      tree.insert(root, hope)
      tree.insert(root, empire)
      tree.insert(root, mad_max_2)
      expect(tree.find(root, 'Mad Max 2: The Road Warrior').title).to eq 'Mad Max 2: The Road Warrior'
    end
  end

  describe "#delete(data)" do
    it "handles nil gracefully" do
      expect(tree.delete(root, nil)).to eq nil
    end

    it "properly deletes a left node" do
      tree.insert(root, hope)
      tree.delete(root, hope.title)
      expect(tree.find(root, hope.title)).to be_nil
    end

    it "properly deletes a right node" do
      tree.insert(root, hope)
      tree.insert(root, mad_max_2)
      tree.delete(root, mad_max_2.title)
      expect(tree.find(root, mad_max_2.title)).to be_nil
    end

    it "properly deletes a left node" do
      tree.insert(root, hope)
      tree.insert(root, pacific_rim)
      tree.insert(root, mad_max_2)
      tree.insert(root, inception)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, empire)
      tree.delete(root, inception.title)
      expect(tree.find(root, inception.title)).to be_nil
    end

    it "properly deletes a right node" do
      tree.insert(root, hope)
      tree.insert(root, pacific_rim)
      tree.insert(root, mad_max_2)
      tree.insert(root, inception)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, empire)
      tree.delete(root, jedi.title)
      expect(tree.find(root, jedi.title)).to be_nil
    end

    it "properly deletes a right node" do
      tree.insert(root, hope)
      tree.insert(root, pacific_rim)
      tree.insert(root, mad_max_2)
      tree.insert(root, inception)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, empire)
      tree.delete(root, hope.title)
      expect(tree.find(root, hope.title)).to be_nil
    end

    it "properly deletes a left-left node" do
      tree.insert(root, hope)
      tree.insert(root, pacific_rim)
      tree.insert(root, mad_max_2)
      tree.insert(root, inception)
      tree.insert(root, jedi)
      tree.insert(root, donnie)
      tree.insert(root, empire)
      tree.delete(root, mad_max_2.title)
      expect(tree.find(root, mad_max_2.title)).to be_nil
    end
  end

  describe "#print(data)" do
     specify {
       expected_output = "Pacific Rim: 72\nStar Wars: Return of the Jedi: 80\nInception: 86\nDistrict 9: 90\nThe Matrix: 87\nDonnie Darko: 85\nBraveheart: 78\n"
       tree.insert(root, pacific_rim)
       tree.insert(root, braveheart)
       tree.insert(root, jedi)
       tree.insert(root, donnie)
       tree.insert(root, inception)
       tree.insert(root, district)
       expect { tree.print }.to output(expected_output).to_stdout
     }
  end
end
