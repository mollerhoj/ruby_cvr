require 'rails_helper'
require 'ruby_cvr'

RSpec.describe RubyCvr::CompaniesParser::MemberDatum, type: :lib do
  let(:payload) do
    {
      "attributter" => [{
        "sekvensnr" => 0,
        "type" => "FUNKTION",
        "vaerditype" => "string",
        "vaerdier" => [{
          "vaerdi" => "INTERESSENTER",
          "periode" => {
            "gyldigFra" => "1989-04-01",
            "gyldigTil" => "2010-08-27"
          },
          "sidstOpdateret" => "2017-01-30T14:34:50.000+01:00"
        }]
      }]
    }
  end

  subject { RubyCvr::CompaniesParser::MemberDatum.new(payload) }

  it '#founder?' do
    expect(subject.founder?).to eq(false)
  end
end
