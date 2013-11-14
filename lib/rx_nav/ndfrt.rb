module RxNav
  class NDFRT
    class << self
      def api_version
        get_response_hash("/version")[:version][:version_name].to_s
      end

      def possible_options_for type
        get_options type.to_s.downcase
      end

      def possible_associations
        get_options "association"
      end

      def possible_types
        get_options "type"
      end

      def possible_kinds
        get_options("kind").map { |k| k.split('_')[0...-1].join('_').downcase }
      end

      def possible_properties
        get_options "property"
      end

      def possible_roles
        get_options "role"
      end

      def find_by hash
        return find_by_id(hash[:type], hash[:id]) if hash.has_key? :id
        return find_by_name(hash[:name], hash[:kind]) if hash.has_key? :name
      end

      def find_by_id type, id
        type = type.upcase
        query = "/idType=#{type}&idString=#{id}"
        return get_concepts query
      end

      def find_by_name name, kind = nil
        query = "/search?conceptName=#{name}"
        unless kind.nil?
          kind = kind.upcase + '_KIND'
          query += "&kindName=#{kind}"
        end
        return get_concepts query
      end

      def find_interacting_drugs nui, scope = 3
        query = "/interaction/nui=#{nui}&scope=#{scope}"
        response = get_response_hash query
        data = response[:group_interactions][:interactions][:group_interacting_drugs][:interacting_drug]
        data = [data] unless data.is_a? Array
        return data.map { |i| RxNav::Concept.new i[:concept] }
      end

      def find_interactions_between nuis, scope = 3
        query = "/interaction?nuis=#{nuis.join('+')}&scope=#{scope}"
        data = get_response_hash query
        return data[:full_interaction_group][:full_interaction].map do |fi|
          RxNav::Interaction.new fi[:interaction_triple_group][:interaction_triple]
        end
      end

      def get_info nui
        query = "/allInfo/#{nui}"
        return OpenStruct.new get_response_hash(query)[:full_concept]
      end

      def all_records_by_kind kind
        kind = kind.upcase + "_KIND"
        query = "/allconcepts?kind=#{kind}"
        data = get_response_hash(query)[:group_concepts][:concept]
        return data.map { |i| RxNav::Concept.new i }
      end
  
      private

      def get_response_hash query
        request = URI.parse(RxNav::BASE_URL + '/Ndfrt' + query)
        return RxNav.nori.parse(Net::HTTP.get request)[:ndfrtdata]
      end

      def get_options type
        data = get_response_hash "/#{type}List"
        return data["#{type}_list".to_sym]["#{type}_name".to_sym].map { |a| a.to_s }
      end

      def get_concepts query
        response = get_response_hash query
        data = response[:group_concepts][:concept]
        data = [data] unless data.is_a?(Array)
        return data.map { |c| RxNav::Concept.new(c) }
      end

    end

    self.singleton_class.send(:alias_method, :version, :api_version)

    self.singleton_class.send(:alias_method, :available_options_for, :possible_options_for)

    self.singleton_class.send(:alias_method, :all_concepts_by_kind, :all_records_by_kind)

  end
end
