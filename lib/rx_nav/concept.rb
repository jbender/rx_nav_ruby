require 'ostruct'

module RxNav
  class Concept < OpenStruct

    def name
      name = self.display_name ||
             self.full_name ||
             self.full_generic_name ||
             self.concept_name
      name ? name.capitalize : nil
    end

    def kind
      kind = self.concept_kind
      kind ? titleize_kind(self.concept_kind) : nil
    end

    def to_s
      name
    end

    # A call to fetch the relevant information and add it to the model
    # Note: returns false if no information was found
    def get_terms_info
      # Terms use the rxcui for the lookup
      if self.rxcui.nil?
        # Fail if we have a concept without any IDs (that are written so far)
        if self.nui.nil?
          raise "This concept doesn't have a nui or rxcui"
        else
          rxcui = RxNav::RxNorm.find_rxcui_by_id('nui', self.nui)
        end
      end
      # If we had to look it up, use that, otherwise use the model's
      rxcui = rxcui || self.rxcui
      info = RxNav::RxTerms.get_info(rxcui)
      # Check to make sure there are attributes to merge, otherwise note failure
      info.attributes.nil? ? false : merge_concept(info)
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
      return merge_concept RxNav::NDFRT.get_info(nui)
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