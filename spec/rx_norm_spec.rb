require 'spec_helper'
require 'support/api'

describe RxNav::RxNorm do

  describe "remote endpoints" do
    url      = "http://rxnav.nlm.nih.gov/REST"
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
      "#{url}/rxcui/{rxcui}/property?propName=propName"
    ]
  end

end
