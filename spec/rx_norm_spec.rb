require 'spec_helper'

describe RxNav::RxNorm do

  describe "Remote endpoints" do
    before :all do
      @url      = "http://rxnav.nlm.nih.gov/REST"
      @response = Net::HTTP.get(URI("#{@url}/json"))
      @json     = JSON.parse(@response)
      @resource_list = @json["resourceList"]["resource"]
    end

    it "should contain #{@url}/approximateTerm?term=value&maxEntries=value&option=value" do
      expect(@resource_list).to include("#{@url}/approximateTerm?term=value&maxEntries=value&option=value")
    end

    it "should contain #{@url}/rxcui?idtype=yourIdtype&id=yourId&allsrc=0or1" do
      expect(@resource_list).to include("#{@url}/rxcui?idtype=yourIdtype&id=yourId&allsrc=0or1")
    end

    it "should contain #{@url}/rxcui?name=yourName&srclist=yourSources&allsrc=0or1&search=0or1or2" do
      expect(@resource_list).to include("#{@url}/rxcui?name=yourName&srclist=yourSources&allsrc=0or1&search=0or1or2")
    end

    it "should contain #{@url}/drugs?name=yourName" do
      expect(@resource_list).to include("#{@url}/drugs?name=yourName")
    end

    it "should contain #{@url}/spellingsuggestions?name=yourName" do
      expect(@resource_list).to include("#{@url}/spellingsuggestions?name=yourName")
    end

    it "should contain #{@url}/rxcui/{rxcui}/status" do
      expect(@resource_list).to include("#{@url}/rxcui/{rxcui}/status")
    end

    it "should contain #{@url}/rxcui/{rxcui}/properties" do
      expect(@resource_list).to include("#{@url}/rxcui/{rxcui}/properties")
    end

    it "should contain #{@url}/rxcui/{rxcui}/property?propName=propName" do
      expect(@resource_list).to include("#{@url}/rxcui/{rxcui}/property?propName=propName")
    end
  end
end
