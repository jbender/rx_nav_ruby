require 'net/http'
require 'nori'
require 'nokogiri'
require 'ostruct'

require 'rx_nav/version'

# Core of the API responses
require 'rx_nav/concept'
require 'rx_nav/interaction'

# Individual APIs
require 'rx_nav/ndfrt'
require 'rx_nav/prescribable_rx_norm'
require 'rx_nav/rx_terms'

module RxNav

  BASE_URL = 'http://rxnav.nlm.nih.gov/REST'

  def self.nori
    Nori.new(convert_tags_to: -> tag { tag.snakecase.to_sym })
  end

end
