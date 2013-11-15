require 'httparty'
require 'uri'
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
  include HTTParty
  base_uri 'http://rxnav.nlm.nih.gov/REST'

  def self.nori
    Nori.new(convert_tags_to: -> tag { tag.snakecase.to_sym })
  end

  def self.make_request query, api_root = '', root_node
    encoded_query = URI.encode(query) # Sanitize the query
    return self.nori.parse(self.class.get(api_root + encoded_query)) # Make the request
  end

end
