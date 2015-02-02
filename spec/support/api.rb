shared_examples 'uses valid endpoints' do |endpoints|
  endpoints.each do |endpoint|
    it { should include(endpoint) }
  end
end
