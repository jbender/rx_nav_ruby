shared_examples 'should be an array of' do |klass|
  it { is_expected.to be_kind_of(Array) }
  it { is_expected.to_not be_empty }
  it { is_expected.to all( be_a klass ) }
end
