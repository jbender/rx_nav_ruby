module RxNav
  class Concept
    attr_accessor :name, :nui, :kind

    def initialize concept_hash
      unless [:concept_name, :concept_nui, :concept_kind].all? { |k| concept_hash.has_key? k }
        raise ArgumentError, "You must supply a hash with the conecept's name, nui and kind"
      end
      @name = concept_hash[:concept_name].capitalize
      @nui  = concept_hash[:concept_nui]
      @kind = titleize_kind concept_hash[:concept_kind]
    end

    def to_s
      name
    end

    def == concept
      self.instance_variables.each do |i|
        equal = (self.instance_variable_get(i) == concept.instance_variable_get(i))
        return equal if !equal
      end
      true
    end

    def extended_information
      NDFRT.new.get_info self.nui
    end
    alias_method :extended_info, :extended_information

    private

    def titleize_kind str
      str.split("_")[0...-1].map(&:capitalize).join(" ") if str.is_a? String
    end

  end
end