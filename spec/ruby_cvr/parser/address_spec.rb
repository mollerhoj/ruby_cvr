require 'rails_helper'
require 'ruby_cvr'

RSpec.describe RubyCvr::CompaniesParser::Address, type: :lib do
  let(:payload) do
    {
      "adresseId" => nil,
      "conavn" => "Advokat Anders Drachmann",
      "sidstOpdateret" => "2017-01-30T14:34:50.000+01:00",
      "sidstValideret" => "2017-01-30T14:36:16.459+01:00",
      "postboks" => nil,
      "vejnavn" => "Nordhavnsvej",
      "periode" => {
        "gyldigFra" => "2010-08-27",
        "gyldigTil" => "2010-08-27"
      },
      "postnummer" => 3000,
      "bogstavTil" => nil,
      "landekode" => "DK",
      "bogstavFra" => nil,
      "vejkode" => 5717,
      "bynavn" => nil,
      "kommune" => {
        "kommuneKode" => 217,
        "kommuneNavn" => "HELSINGØR",
        "periode" => {
          "gyldigFra" => "2007-01-01",
          "gyldigTil" => nil
        },
        "sidstOpdateret" => "2006-11-13T00:00:00.000+01:00"
      },
      "husnummerTil" => nil,
      "sidedoer" => nil,
      "husnummerFra" => 1,
      "postdistrikt" => "Helsingør",
      "etage" => "2",
      "fritekst" => nil
    }
  end

  subject { RubyCvr::CompaniesParser::Address.new(payload) }

  it 'works' do
    expect(subject.execute).to eq('Nordhavnsvej 1, 3000 Helsingør')
  end
end
