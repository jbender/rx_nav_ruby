require 'spec_helper'
require 'support/api'
require 'support/array_type'

describe RxNav::RxNorm do

  describe "remote endpoints" do
    url      = "https://rxnav.nlm.nih.gov/REST"
    response = Net::HTTP.get(URI("#{url}/json"))
    subject  { JSON.parse(response)["resourceList"]["resource"] }

    include_examples 'uses valid endpoints', [
      "#{url}/approximateTerm?term=value&maxEntries=value&option=value",
      "#{url}/rxcui?idtype=yourIdtype&id=yourId&allsrc=0or1",
      "#{url}/rxcui?name=yourName&srclist=yourSources&allsrc=0or1&search=0or1or2",
      "#{url}/drugs?name=yourName",
      "#{url}/spellingsuggestions?name=yourName",
      "#{url}/rxcui/{rxcui}/status",
      "#{url}/rxcui/{rxcui}/properties",
      "#{url}/rxcui/{rxcui}/property?propName=propName",
      "#{url}/displaynames",
    ]
  end

  describe "#search_by_name" do
    subject { RxNav::RxNorm.search_by_name "zocor" }

    include_examples 'should be an array of', RxNav::Concept
  end

  describe "#find_rxcui_by_id" do
    describe "NUI search" do
      subject { RxNav::RxNorm.find_rxcui_by_id "NUI", "N0000148200" }
      include_examples 'should be an array of', String
    end

    describe "NDC search" do
      subject { RxNav::RxNorm.find_rxcui_by_id "NDC", "0781-1506-10" }
      include_examples 'should be an array of', String
    end
  end

  describe "#find_rxcui_by_name" do
    subject { RxNav::RxNorm.find_rxcui_by_name "lipitor" }
    include_examples 'should be an array of', String
  end

  describe "#find_drugs_by_name" do
    let(:results) { RxNav::RxNorm.find_drugs_by_name "cymbalta" }

    context "at the top level" do
      subject { results }
      include_examples 'should be an array of', Hash
    end

    context "first result" do
      subject { results.first }
      it { is_expected.to include(:name) }
      it { is_expected.to include(:concepts) }

      context 'name' do
        subject { results.first[:name] }
        it { is_expected.to be_kind_of(String) }
      end

      context 'concepts' do
        subject { results.first[:concepts] }
        include_examples 'should be an array of', RxNav::Concept
      end
    end
  end

  describe '#spelling_suggestions' do
    subject { RxNav::RxNorm.spelling_suggestions "ambienn" }

    include_examples 'should be an array of', String
  end

  describe "#status" do
    subject { RxNav::RxNorm.status "105048" }

    it { is_expected.to be_kind_of(OpenStruct) }
    it { is_expected.to respond_to(:active?) }
    it { is_expected.to respond_to(:remapped?) }
  end

  describe "#properties" do
    subject { RxNav::RxNorm.properties "131725" }

    it { is_expected.to be_kind_of(OpenStruct) }
  end

  describe "#displaynames" do
    subject { RxNav::RxNorm.displaynames }

    include_examples "should be an array of", String
    it { is_expected.to include("acetaminophen") }
  end
end
