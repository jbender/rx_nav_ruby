require 'spec_helper'

describe RxNav::Concept do
  context 'new concept' do
    subject { RxNav::Concept.new }
    it { is_expected.to be_kind_of(OpenStruct) }
    it { is_expected.to respond_to(:name) }
    it { is_expected.to respond_to(:kind) }
    it { is_expected.to respond_to(:nui) }
    it { is_expected.to respond_to(:to_s) }
    it { is_expected.to respond_to(:get_terms_info) }
    it { is_expected.to respond_to(:get_ndfrt_info) }
    it { is_expected.to respond_to(:get_norm_info) }
  end

  context 'NDF-RT concept "N0000152900"' do
    let(:nui) { "N0000152900" }
    let(:concept) { RxNav::NDFRT.get_info nui }
    subject { concept }

    context "#name" do
      subject { concept.name }
      it { is_expected.to be_kind_of(String) }
      it { is_expected.to eq("Acetic Acid 2%/Hydrocortisone 1% Soln,Otic") }
    end

    context "#kind" do
      subject { concept.kind }
      it { is_expected.to be_kind_of(String) }
      it { is_expected.to eq("Drug") }
    end

    context "#nui" do
      subject { concept.nui }
      it { is_expected.to be_kind_of(String) }
      it { is_expected.to eq(nui) }
    end

    context "#to_s" do
      subject { concept.to_s }
      it { is_expected.to be_kind_of(String) }
      it { is_expected.to eq(concept.name) }
    end

    context "#get_terms_info" do
      let(:original) { concept }
      subject { concept.get_terms_info }
      it { is_expected.to be_kind_of(RxNav::Concept) }
    end

    context "#get_ndfrt_info" do
      let(:original) { concept }
      subject { concept.get_ndfrt_info }
      it { is_expected.to be_kind_of(RxNav::Concept) }
    end

    context "#get_norm_info" do
      let(:original) { concept }
      subject { concept.get_norm_info }
      it { is_expected.to be_kind_of(RxNav::Concept) }
    end

  end
end
