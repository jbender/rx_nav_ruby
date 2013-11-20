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

    def nui
      self.concept_nui
    end

    def to_s
      name
    end

    # Supplementary calls to fetch info from other DBs
    # Note: these methods return false if no information was found
    
    def get_terms_info
      rxcui = get_rxcui
      info = RxNav::RxTerms.get_info(rxcui)
      merge_concept info
    end

    def get_ndfrt_info
      nui = get_nui
      info = RxNav::NDFRT.get_info(nui)
      merge_concept info
    end

    def get_norm_info
      rxcui = get_rxcui
      info = RxNav::RxNorm.properties rxcui
      info.quantity = RxNav::RxNorm.quantity rxcui
      info.strength = RxNav::RxNorm.strength rxcui
      merge_concept info
    end

    private

    def get_rxcui
      # Terms use the rxcui for the lookup
      if self.rxcui.nil?
        # Fail if we have a concept without any IDs (that are written so far)
        if self.nui.nil?
          raise "This concept doesn't have a nui or rxcui"
        else
          self.rxcui = RxNav::RxNorm.find_rxcui_by_id('nui', self.nui)
        end
      end
      # If we had to look it up, use that, otherwise use the model's
      return self.rxcui
    end

    def get_nui
      if self.nui.nil?
        if self.rxcui.nil?
          raise "This concept doesn't have a nui or rxcui"
        else
          record = RxNav::NDFRT.find_by_id('rxcui', self.rxcui).first
          self.concept_nui = record.nui
        end
      end
      return self.nui
    end

    def titleize_kind str
      str.split("_")[0...-1].map(&:capitalize).join(" ") if str.is_a? String
    end

    def merge_concept concept
      if concept_hash.empty?
        return false
      else
        concept_hash.each do |k,v|
          puts self.k
          self.k = v if self.k.nil?
          puts self.k
        end
      end
      return self
    end

  end
end