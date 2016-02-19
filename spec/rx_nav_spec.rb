require 'spec_helper'

describe "https://rxnav.nlm.nih.gov/REST" do
  before :all do
    @url      = URI "https://rxnav.nlm.nih.gov/REST/json"
    @response = Net::HTTP.get(@url)
    @json     = JSON.parse(@response)
  end

  it "should be online" do
    expect(@json).to_not be_empty
  end

end
