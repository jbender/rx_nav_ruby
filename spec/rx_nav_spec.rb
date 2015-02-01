require 'spec_helper'

describe "http://rxnav.nlm.nih.gov/REST" do
  before :all do
    @url      = URI "http://rxnav.nlm.nih.gov/REST/json"
    @response = Net::HTTP.get(@url)
    @json     = JSON.parse(@response)
  end

  it "should be online" do
    expect(@json).to_not be_empty
  end

end
