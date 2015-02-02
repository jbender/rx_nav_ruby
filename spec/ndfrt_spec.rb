require 'spec_helper'
require 'support/api'
require 'support/array_type'

describe RxNav::NDFRT do

  describe "remote endpoints" do
    url      = "http://rxnav.nlm.nih.gov/REST/Ndfrt"
    response = Net::HTTP.get(URI("#{url}/json"))
    subject  { JSON.parse(response)["resourceList"]["resource"] }

    include_examples 'uses valid endpoints', [
      "#{url}/version",
      "#{url}/associationList",
      "#{url}/typeList",
      "#{url}/kindList",
      "#{url}/propertyList",
      "#{url}/roleList",
      "#{url}/idType={idType}&idString={idString}",
      "#{url}/search?conceptName={conceptName}&kindName={kindName}",
      "#{url}/allInfo/{nui}",
      "#{url}/allconcepts?kind=yourKinds"
    ]
  end

  describe "#api_version" do
    subject { RxNav::NDFRT.api_version }

    it { is_expected.to be_kind_of(String) }
  end

  describe "#possible_associations" do
    subject { RxNav::NDFRT.possible_associations }

    include_examples 'should be an array of', String
  end

  describe "#possible_types" do
    subject { RxNav::NDFRT.possible_types }

    include_examples 'should be an array of', String
  end

  describe "#possible_kinds" do
    subject { RxNav::NDFRT.possible_kinds }

    include_examples 'should be an array of', String
  end

  describe "#possible_properties" do
    subject { RxNav::NDFRT.possible_properties }

    include_examples 'should be an array of', String
  end

  describe "#possible_roles" do
    subject { RxNav::NDFRT.possible_roles }

    include_examples 'should be an array of', String
  end

  describe "#find_by_id for type RXCUI and id 161" do
    subject { RxNav::NDFRT.find_by_id 'RXCUI', '161' }

    include_examples 'should be an array of', RxNav::Concept
  end

  describe "#find_by_name morphine without kind" do
    subject { RxNav::NDFRT.find_by_name 'morphine' }

    include_examples 'should be an array of', RxNav::Concept
  end

  describe "#find_by_name morphine with kind ingredient" do
    subject { RxNav::NDFRT.find_by_name 'morphine', 'ingredient' }

    include_examples 'should be an array of', RxNav::Concept
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
    subject { RxNav::NDFRT.all_records_by_kind "pharmacokinetics" }

    include_examples 'should be an array of', RxNav::Concept
  end

  describe "#get_info" do
    subject { RxNav::NDFRT.get_info "N0000152900" }

    it { is_expected.to be_kind_of(RxNav::Concept) }
  end

end
