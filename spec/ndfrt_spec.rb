require_relative '../lib/rx_nav'

describe RxNav::NDFRT do
  describe "#api_version" do
    it "returns a string" do
      expect(RxNav::NDFRT.api_version.class).to eq(String)
    end
  end

  describe "#possible_associations" do
    before :all do
      @associations = RxNav::NDFRT.possible_associations
    end

    it "returns an array" do
      expect(@associations.class).to eq(Array)
    end

    it "returns an array of strings" do
      expect(@associations.first.class).to eq(String)
    end
  end

  describe "#find_by_id for type RXCUI and id 161" do
    before :all do
      @asprin = RxNav::NDFRT.find_by_id 'RXCUI', '161'
    end

    it "returns an array of objects" do
      expect(@asprin.class).to eq(Array)
    end

    it "returns Acetaminophen for first object name" do
      expect(@asprin.first.name).to eq('Acetaminophen')
    end

    it "returns N0000145898 for first object nui" do
      expect(@asprin.first.nui).to eq('N0000145898')
    end

    it "returns Drug for first object kind" do
      expect(@asprin.first.kind).to eq('Drug')
    end
  end

  describe "#find_by_name morphine without kind" do
    before :all do
      @morphine = RxNav::NDFRT.find_by_name 'morphine'
    end

    it "returns an array of objects" do
      expect(@morphine.class).to eq(Array)
    end

    it "returns Morphine for first object name" do
      expect(@morphine.first.name).to eq('Morphine')
    end

    it "returns N0000145914 for first object nui" do
      expect(@morphine.first.nui).to eq('N0000145914')
    end

    it "returns Drug for first object kind" do
      expect(@morphine.first.kind).to eq('Drug')
    end
  end

  describe "#find_by_name morphine with kind ingredient" do
    before :all do
      @morphine = RxNav::NDFRT.find_by_name 'morphine', 'ingredient'
    end

    it "returns an array of objects" do
      expect(@morphine.class).to eq(Array)
    end

    it "returns Morphine for first object name" do
      expect(@morphine.first.name).to eq('Morphine')
    end

    it "returns N0000007070 for first object nui" do
      expect(@morphine.first.nui).to eq('N0000007070')
    end

    it "returns Ingredient for first object kind" do
      expect(@morphine.first.kind).to eq('Ingredient')
    end
  end

  describe "#find_by with hash of name" do
    it "should return the same as find_by_name" do
      @generic_find = RxNav::NDFRT.find_by name: 'morphine'
      @specific_find = RxNav::NDFRT.find_by_name 'morphine'
      expect(@generic_find == @specific_find).to eq(true)
    end
  end

  describe "#find_by with hash of name and kind" do
    it "should return the same as find_by_name" do
      @generic_find = RxNav::NDFRT.find_by name: 'morphine', kind: 'ingredient'
      @specific_find = RxNav::NDFRT.find_by_name 'morphine', 'ingredient'
      expect(@generic_find == @specific_find).to eq(true)
    end
  end

  describe "#find_by with hash of type and id" do
    it "should return the same as find_by_name" do
      @generic_find = RxNav::NDFRT.find_by type: 'RXCUI', id: '161'
      @specific_find = RxNav::NDFRT.find_by_id 'RXCUI', '161'
      expect(@generic_find == @specific_find).to eq(true)
    end
  end

end
