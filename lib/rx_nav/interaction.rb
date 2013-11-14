module RxNav
  class Interaction
    attr_accessor :drugs, :nui, :severity

    def initialize interaction_hash
      concepts = interaction_hash[:group_concepts][:concept]

      @drugs    = extract_drugs concepts
      @nui      = extract_interaction_id concepts
      @severity = interaction_hash[:severity]
    end

    private

    def extract_drugs concepts
      concepts.select { |c| c[:concept_kind] != 'DRUG_INTERACTION_KIND' }.map{ |c| NDFRT::Concept.new(c) }
    end

    def extract_interaction_id concepts
      concepts.select { |c| c[:concept_kind] == 'DRUG_INTERACTION_KIND' }.first[:concept_nui]
    end

  end
end