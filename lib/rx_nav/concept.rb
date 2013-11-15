require 'ostruct'

module RxNav
  class Concept < OpenStruct

    def name
      name = self.concept_name
      name ? name.capitalize : nil
    end

    def kind
      kind = self.concept_kind
      kind ? titleize_kind(self.concept_kind) : nil
    end

    def to_s
      display_name || full_name || full_generic_name || name
    end

    def get_terms_info
      if self.rxcui.nil?
        if self.nui.nil?
          raise "This concept doesn't have a nui or rxcui"
        else
          rxcui = RxNav::RxNorm.find_rxcui_by_id('nui', self.nui)
        end
      end
      rxcui = rxcui ? rxcui : self.rxcui
      rxcui ? merge_concept(RxNav::RxTerms.get_info(rxcui)) : self
    end

    def get_ndfrt_info
      if self.nui.nil?
        if self.rxcui.nil?
          raise "This concept doesn't have a nui or rxcui"
        else
          concept = RxNav::NDFRT.find_by_id('rxcui', self.rxcui)
        end
      end
      nui = concept ? concept.nui : self.nui
      nui ? merge_concept(RxNav::NDFRT.get_info(nui)) : self
    end

    private

    def titleize_kind str
      str.split("_")[0...-1].map(&:capitalize).join(" ") if str.is_a? String
    end

    def merge_concept concept
      return self if concept.attributes.nil?
      concept.attributes.each do |k,v|
        self.k = v if self.k.nil?
      end
    end

  end
end