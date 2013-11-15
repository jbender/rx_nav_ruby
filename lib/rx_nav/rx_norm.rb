module RxNav
  class RxNorm
    class << self
      def search_by_name name, max_results = 20, option = 0
        query = "/approximateTerm?term=#{name}&maxEntries=#{max_results}"
        # The API spec includes an option parameter, but doesn't specify options
        # other than the default
        # query += "&option=#{option}" if option
        data = get_response_hash(query)[:approximate_group][:candidate]
        data = [data] if (data && !data.is_a?(Array))
        return data.nil? ? nil : data.map { |c| RxNav::Concept.new(c) }
      end

      def find_rxcui_by_id type, id
        type  = type.upcase
        id    = id.to_s
        query = "/rxcui?idtype=#{type}&id=#{id}"
        return extract_rxcui query
      end

      def find_rxcui_by_name name
        query = "/rxcui?name=#{name}"
        return extract_rxcui query
      end

      def properties id
        query = "/rxcui/#{id}/properties"
        return OpenStruct.new get_response_hash(query)[:properties]
      end

      def quantity id
        query = "/rxcui/#{id}/quantity"
        return OpenStruct.new get_response_hash(query)[:quantity_group]
      end

      def strength id
        query = "/rxcui/#{id}/strength"
        return OpenStruct.new get_response_hash(query)[:strength_group]
      end

      def complete_info id
        result = self.properties(id)
        result.strength = self.strength(id).strength
        result.quantity = self.quantity(id).quantity
        return result
      end

      private

      def get_response_hash query
        RxNav.make_request(query)[:rxnormdata]
      end
      
      def extract_rxcui query
        data = get_response_hash(query)
        if data[:id_group]
          data = [data] unless data.is_a?(Array)
          return data.map { |c| c[:rxnorm_id] }
        else
          return nil
        end
      end

    end
  end
end
