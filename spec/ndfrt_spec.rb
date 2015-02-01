require 'spec_helper'

describe RxNav::NDFRT do

  describe "Remote endpoints" do
    before :all do
      @url      = "http://rxnav.nlm.nih.gov/REST/Ndfrt"
      @response = Net::HTTP.get(URI("#{@url}/json"))
      @json     = JSON.parse(@response)
      @resource_list = @json["resourceList"]["resource"]
    end

    it "should contain #{@url}/version" do
      expect(@resource_list).to include("#{@url}/version")
    end

    it "should contain #{@url}/associationList" do
      expect(@resource_list).to include("#{@url}/associationList")
    end

    it "should contain #{@url}/typeList" do
      expect(@resource_list).to include("#{@url}/typeList")
    end

    it "should contain #{@url}/kindList" do
      expect(@resource_list).to include("#{@url}/kindList")
    end

    it "should contain #{@url}/propertyList" do
      expect(@resource_list).to include("#{@url}/propertyList")
    end

    it "should contain #{@url}/roleList" do
      expect(@resource_list).to include("#{@url}/roleList")
    end

    it "should contain #{@url}/idType={idType}&idString={idString}" do
      expect(@resource_list).to include("#{@url}/idType={idType}&idString={idString}")
    end

    it "should contain #{@url}/search?conceptName={conceptName}&kindName={kindName}" do
      expect(@resource_list).to include("#{@url}/search?conceptName={conceptName}&kindName={kindName}")
    end

    it "should contain #{@url}/allInfo/{nui}" do
      expect(@resource_list).to include("#{@url}/allInfo/{nui}")
    end

    it "should contain #{@url}/allconcepts?kind=yourKinds" do
      expect(@resource_list).to include("#{@url}/allconcepts?kind=yourKinds")
    end
  end

  describe "#api_version" do
    it "returns a string" do
      expect(RxNav::NDFRT.api_version).to be_kind_of(String)
    end
  end

  describe "#possible_associations" do
    before :all do
      @result = RxNav::NDFRT.possible_associations
    end

    it "returns an array" do
      expect(@result).to be_kind_of(Array)
    end

    it "returns an array of strings" do
      expect(@result.first).to be_kind_of(String)
    end
  end

  describe "#possible_types" do
    before :all do
      @result = RxNav::NDFRT.possible_types
    end

    it "returns an array" do
      expect(@result).to be_kind_of(Array)
    end

    it "returns an array of strings" do
      expect(@result.first).to be_kind_of(String)
    end
  end

  describe "#possible_kinds" do
    before :all do
      @result = RxNav::NDFRT.possible_kinds
    end

    it "returns an array" do
      expect(@result).to be_kind_of(Array)
    end

    it "returns an array of strings" do
      expect(@result.first).to be_kind_of(String)
    end
  end

  describe "#possible_properties" do
    before :all do
      @result = RxNav::NDFRT.possible_properties
    end

    it "returns an array" do
      expect(@result).to be_kind_of(Array)
    end

    it "returns an array of strings" do
      expect(@result.first).to be_kind_of(String)
    end
  end

  describe "#possible_roles" do
    before :all do
      @result = RxNav::NDFRT.possible_roles
    end

    it "returns an array" do
      expect(@result).to be_kind_of(Array)
    end

    it "returns an array of strings" do
      expect(@result.first).to be_kind_of(String)
    end
  end

  describe "#find_by_id for type RXCUI and id 161" do
    before :all do
      @result = RxNav::NDFRT.find_by_id 'RXCUI', '161'
    end

    it "returns an array of objects" do
      expect(@result).to be_kind_of(Array)
    end

    it "should not be empty" do
      expect(@result).to_not be_empty
    end

    it "should contain concepts" do
      expect(@result.first).to be_kind_of(RxNav::Concept)
    end
  end

  describe "#find_by_name morphine without kind" do
    before :all do
      @result = RxNav::NDFRT.find_by_name 'morphine'
    end

    it "returns an array of objects" do
      expect(@result).to be_kind_of(Array)
    end

    it "should not be empty" do
      expect(@result).to_not be_empty
    end

    it "should contain concepts" do
      expect(@result.first).to be_kind_of(RxNav::Concept)
    end
  end

  describe "#find_by_name morphine with kind ingredient" do
    before :all do
      @result = RxNav::NDFRT.find_by_name 'morphine', 'ingredient'
    end

    it "returns an array of objects" do
      expect(@result).to be_kind_of(Array)
    end

    it "should not be empty" do
      expect(@result).to_not be_empty
    end

    it "should contain concepts" do
      expect(@result.first).to be_kind_of(RxNav::Concept)
    end
  end

  describe "#find_by with hash of name" do
    it "should return the same as find_by_name" do
      @generic_find = RxNav::NDFRT.find_by name: 'morphine'
      @specific_find = RxNav::NDFRT.find_by_name 'morphine'
      expect(@generic_find).to eq(@specific_find)
    end
  end

  describe "#find_by with hash of name and kind" do
    it "should return the same as find_by_name" do
      @generic_find = RxNav::NDFRT.find_by name: 'morphine', kind: 'ingredient'
      @specific_find = RxNav::NDFRT.find_by_name 'morphine', 'ingredient'
      expect(@generic_find).to eq(@specific_find)
    end
  end

  describe "#find_by with hash of type and id" do
    it "should return the same as find_by_name" do
      @generic_find = RxNav::NDFRT.find_by type: 'RXCUI', id: '161'
      @specific_find = RxNav::NDFRT.find_by_id 'RXCUI', '161'
      expect(@generic_find).to eq(@specific_find)
    end
  end

  describe "#all_records_by_kind" do
    before :all do
      @result = RxNav::NDFRT.all_records_by_kind "pharmacokinetics"
    end

    it "should return an array" do
      expect(@result).to be_kind_of(Array)
    end

    it "should not be empty" do
      expect(@result).to_not be_empty
    end

    it "should contain concepts" do
      expect(@result.first).to be_kind_of(RxNav::Concept)
    end
  end

end
