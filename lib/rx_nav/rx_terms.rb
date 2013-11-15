module RxNav
  class RxTerms
    class << self
      def all_concepts
        query = "/allconcepts"
        data = get_response_hash(query)[:min_concept_group]
        return data.map{ |c| RxNav::Concept.new(c) }
      end

      def all_info id
        query = "/rxcui/#{id}/allinfo"
        data = get_response_hash(query)[:rxterms_properties]
        return RxNav::Concept.new(data)
      end

      private

      def get_response_hash query
        RxNav.make_request('/RxTerms' + query)[:rxtermsdata]
      end
    end
    
    self.singleton_class.send(:alias_method, :get_info, :all_info)

  end
end