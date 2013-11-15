module RxNav
  class RxTerms
    class << self
      def all_concepts
        query = "/allconcepts"
        data = get_response_hash(query)[:min_concept_group]
        return data.map{ |c| OpenStruct.new(c) }
      end

      def all_info id
        query = "/rxcui/#{id}/allinfo"
        data = get_response_hash(query)[:rxterms_properties]
        return OpenStruct.new(data)
      end

      private

      def get_response_hash query
        RxNav.make_request('/RxTerms', query)[:rxtermsdata]
      end
    end
  end
end