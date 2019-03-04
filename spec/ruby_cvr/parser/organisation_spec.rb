require 'rails_helper'
require 'ruby_cvr'

RSpec.describe RubyCvr::CompaniesParser::Organisation, type: :lib do
  let(:payload) do
    {
      "enhedsNummerOrganisation" => 0,
      "hovedtype" => "FULDT_ANSVARLIG_DELTAGERE",
      "organisationsNavn" => [{
        "navn" => "Interessenter",
        "periode" => {
          "gyldigFra" => nil,
          "gyldigTil" => nil
        },
        "sidstOpdateret" => nil
      }],
      "attributter" => [{
        "sekvensnr" => 0,
        "type" => "FUNKTION",
        "vaerditype" => "string",
        "vaerdier" => [{
          "vaerdi" => "Interessenter",
          "periode" => {
            "gyldigFra" => "1989-04-01",
            "gyldigTil" => nil
          },
          "sidstOpdateret" => nil
        }]
      }],
      "medlemsData" => [{
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
      }]
    }
  end

  subject { RubyCvr::CompaniesParser::Organisation.new(payload) }

  it '#main_kind' do
    expect(subject.main_kind).to eq('FULDT_ANSVARLIG_DELTAGERE')
  end

  it '#founder?' do
    expect(subject.founder?).to eq(false)
  end
end
