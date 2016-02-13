module RxNav
  class RxNorm
    class << self

      def search_by_name name, options = {}
        options = {max_results: 20, options: 0}.merge(options)

        query = "/approximateTerm?term=#{name}"\
                "&maxEntries=#{options[:max_results]}"\
                "&options=#{options[:options]}"

        # Get the data we care about in the right form
        data = get_response_hash(query)[:approximate_group][:candidate]

        # If we didn't get anything, say so
        return nil if data.nil?

        # Put it in the right form
        data = RxNav.ensure_array data

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

      def find_drugs_by_name name
        query = "/drugs?name=#{name}"
        drugs = []
        dg = get_response_hash(query)[:drug_group]
        return nil if dg[:concept_group].nil?
        dg[:concept_group].each do |cg|
          props = cg[:concept_properties]
          if props.nil?
            next
          else
            concepts = props.kind_of?(Array) ? props.map { |c| RxNav::Concept.new(c) } : RxNav::Concept.new(props)
            drugs << {
              name: dg[:name],
              concepts: concepts
            }
          end
        end
        return drugs
      end

      def spelling_suggestions name
        query = "/spellingsuggestions?name=#{name}"
        data = get_response_hash(query)[:suggestion_group][:suggestion_list]
        data ? data[:suggestion] : nil
      end

      def status id
        query           = "/rxcui/#{id}/status"
        data            = get_response_hash(query)[:rxcui_status]
        status          = OpenStruct.new
        reported_status = data[:status].downcase

        status.send("remapped?=", reported_status == 'remapped')
        status.send("active?=", reported_status == 'active')

        if status.remapped?
          concepts = RxNav.ensure_array data[:min_concept_group][:min_concept]
          status.remapped_to = concepts.map { |c| c[:rxcui] }
        end

        return status
      end

      def properties id
        query = "/rxcui/#{id}/properties"
        return OpenStruct.new get_response_hash(query)[:properties]
      end

      def property id, name
        query    = "/rxcui/#{id}/property?propName=#{name.upcase}"
        response = get_response_hash(query)

        concept_group = response[:property_concept_group]
        return nil unless concept_group

        concepts = concept_group[:property_concept]
        return concepts ? concepts[:prop_value] : nil
      end

      def quantity id
        property id, "quantity"
      end

      def strength id
        property id, "strength"
      end

      def available_strength id
        property id, "available_strength"
      end

      def displaynames
        query = "/displaynames"
        get_response_hash(query)[:display_terms_list][:term]
      end

      private

      def get_response_hash query
        RxNav.make_request(query)[:rxnormdata]
      end

      def extract_rxcui query
        data = get_response_hash(query)
        if data[:id_group]
          data = RxNav.ensure_array data
          return data.map { |c| c[:id_group][:rxnorm_id] }
        else
          return nil
        end
      end
    end

    self.singleton_class.send(:alias_method, :find_by_name, :search_by_name)

  end
end
