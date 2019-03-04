require 'rails_helper'
require 'ruby_cvr'

RSpec.describe RubyCvr::XbrlsParser::Context, type: :lib do
  let(:payload) do
    Nokogiri::XML.parse('
    <xbrl xmlns="http://www.xbrl.org/2003/instance">
       <context id="Per01102011_30092012_1">
          <entity>
             <identifier scheme="http://www.dcca.dk/cvr">59837117</identifier>
          </entity>
          <period>
             <startDate>2011-10-01</startDate>
             <endDate>2012-09-30</endDate>
          </period>
          <scenario>
             <xbrldi:typedMember dimension="cmn:IdentificationOfMemberOfExecutiveBoardDimension">
                <cmn:memberOfBoardIdentifier>1</cmn:memberOfBoardIdentifier>
             </xbrldi:typedMember>
          </scenario>
       </context>
    </xbrl>
    ').xpath(".//xmlns:context")
  end

  let(:kontext) { RubyCvr::XbrlsParser::Context.new(payload) }

  it "#id" do
    expect(kontext.id).to eq('Per01102011_30092012_1')
  end

  it "#kind" do
    expect(kontext.kind).to eq(:duration)
  end

  it "#start_date" do
    expect(kontext.start_date).to eq(Date.parse('2011-10-01'))
  end

  it "#end_date" do
    expect(kontext.end_date).to eq(Date.parse('2012-09-30'))
  end

  it "#scenario?" do
    expect(kontext.scenario?).to eq(true)
  end
end
