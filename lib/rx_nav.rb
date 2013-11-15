require 'net/http'
require 'nori'
require 'nokogiri'
require 'ostruct'

# Core of the API responses
require 'rx_nav/concept'
require 'rx_nav/interaction'

# Individual APIs
require 'rx_nav/ndfrt'
require 'rx_nav/rx_norm'
require 'rx_nav/rx_terms'

module RxNav

  def self.nori
    Nori.new(convert_tags_to: -> tag { tag.snakecase.to_sym })
  end

  def self.make_request query
    encoded_query = URI.encode(query)
    request = URI.parse('http://rxnav.nlm.nih.gov/REST' + encoded_query)
    return RxNav.nori.parse(Net::HTTP.get request)
  end

end
