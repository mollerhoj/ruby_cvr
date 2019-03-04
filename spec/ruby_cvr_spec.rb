require 'rails_helper'
require 'ruby_cvr'

RSpec.describe RubyCvr, type: :lib do
  describe "fetching" do
    let(:scroll_id) { 'c2Nhbjs2OzY0NzY5Mz' }
    let(:scroll_response) { { "_scroll_id" => scroll_id, "hits" => { "total" => 10, "hits" => [{}] } } }

    let(:xbrl_response) do
      obj = double
      allow(obj).to receive_messages(body: '<xbrl></xbrl>')
      obj
    end

    it '#company_scroll' do
      allow_any_instance_of(RubyCvr::Fetcher::Request).to receive(:execute).and_return({ '_scroll_id' => scroll_id })
      expect(RubyCvr.company_scroll).to eq(scroll_id)
    end

    it '#financial_scroll' do
      allow_any_instance_of(RubyCvr::Fetcher::Request).to receive(:execute).and_return({ '_scroll_id' => scroll_id })
      expect(RubyCvr.financial_scroll).to eq(scroll_id)
    end

    it '#scroll' do
      allow_any_instance_of(RubyCvr::Fetcher::Request).to receive(:execute).and_return(scroll_response)
      expect(RubyCvr.scroll(scroll_id)).to eq({:payload=>[{}], :scroll_id=>"c2Nhbjs2OzY0NzY5Mz", :retrieved_data=>1, :total_data=>10})
    end

    it '#xbrl_fetch' do
      allow_any_instance_of(RubyCvr::Fetcher::XbrlsQuery).to receive(:fetch).and_return(xbrl_response)
      expect(RubyCvr.xbrl_fetch('').children.size).to eq(1)
    end
  end

  describe "parsing" do
    it '#company_parse' do
      check_all('company_parse')
    end

    it '#financial_parse' do
      check_all('financial_parse')
    end

    it '#xbrl_parse' do
      #TODO
    end

    def check_all(method)
      files = Rake::FileList.new(Rails.root.join('spec', 'fixtures', method, '*_payload.json' ))
      files.each do |file|
        payload = JSON.parse(File.read(file))

        puts JSON.pretty_generate(RubyCvr.send(method, payload).serialize)

        #expected = JSON.parse(File.read(file.gsub('payload','expected')))
        #expect(RubyCvr.send(method, payload).to_json).to eq(expected)
      end
    end
  end
end
