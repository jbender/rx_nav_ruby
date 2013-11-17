module RxNav
  class RxNorm
    class << self
      
      def search_by_name name, options = {}
        options = {max_results: 20, options: 0}.merge(options)
        
        query = %Q(/approximateTerm?term=#{name}&maxEntries=#{options[:max_results]}&options=#{options[:options]})

        # Get the data we care about in the right form
        data = get_response_hash(query)[:approximate_group][:candidate]
        data = [data] if (data && !data.is_a?(Array))

        # If we didn't get anything, say so
        return nil if data.nil?
        
        return data.map { |c| RxNav::Concept.new(c) }
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

      def status id
        query = "/rxcui/#{id}/status"
        status = OpenStruct.new get_response_hash(query)[:rxcui_status]
        status.send("active?=", status.status == 'Active')
        return status
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
