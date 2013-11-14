module RxNav
  module PrescribableRxNorm

    def search_by_name name, max_results = 20, option = 0
      query = "/approximateTerm?term=#{name}&maxEntries=#{max_results}"
      # The API spec includes an option parameter, but doesn't specify options
      # other than the default
      # query += "&option=#{option}" if option
      get_response_hash(query)[:approximate_group][:candidate]
    end

    def complete_info id
      result = self.properties(id)
      result.strength = self.strength(id).strength
      result.quantity = self.quantity(id).quantity
      return result
    end

    def properties id
      query = "/rxcui/#{id}/properties"
      OpenStruct.new(get_response_hash(query)[:properties])
    end

    def quantity id
      query = "/rxcui/#{id}/quantity"
      OpenStruct.new(get_response_hash(query)[:quantity_group])
    end

    def strength id
      query = "/rxcui/#{id}/strength"
      OpenStruct.new(get_response_hash(query)[:strength_group])
    end

    private

    def get_response_hash query
      request = URI.parse(RxNav::BASE_URL + '/Prescribe' + query)
      return RxNav.nori.parse(Net::HTTP.get request)[:rxnormdata]
    end

  end
end
