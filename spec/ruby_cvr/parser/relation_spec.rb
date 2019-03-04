require 'rails_helper'
require 'ruby_cvr'

RSpec.describe RubyCvr::CompaniesParser::Relation, type: :lib do
  let(:payload) do
    {
      "deltager" => {
        "enhedsNummer" => 4000101650,
        "enhedstype" => "PERSON",
        "forretningsnoegle" => nil,
        "organisationstype" => nil,
        "sidstIndlaest" => "2017-01-30T14:36:16.866+01:00",
        "sidstOpdateret" => "2016-05-23T20:02:00.000+02:00",
        "navne" => [{
          "navn" => "Henning Munch Larsen",
          "periode" => {
            "gyldigFra" => nil,
            "gyldigTil" => nil
          },
          "sidstOpdateret" => nil
        }],
        "beliggenhedsadresse" => [{
          "adresseId" => nil,
          "conavn" => nil,
          "sidstOpdateret" => "2000-04-10T23:24:38.000+02:00",
          "sidstValideret" => nil,
          "postboks" => nil,
          "vejnavn" => "Østergade",
          "periode" => {
            "gyldigFra" => "2000-04-10",
            "gyldigTil" => "2000-10-22"
          },
          "postnummer" => 3200,
          "bogstavTil" => nil,
          "landekode" => "DK",
          "bogstavFra" => nil,
          "vejkode" => 9691,
          "bynavn" => nil,
          "kommune" => {
            "kommuneKode" => 215,
            "kommuneNavn" => "HELSINGE",
            "periode" => {
              "gyldigFra" => nil,
              "gyldigTil" => "2006-12-31"
            },
            "sidstOpdateret" => "1999-10-15T00:00:00.000+02:00"
          },
          "husnummerTil" => nil,
          "sidedoer" => nil,
          "husnummerFra" => 42,
          "postdistrikt" => "Helsinge",
          "etage" => nil,
          "fritekst" => nil
        }, {
          "adresseId" => nil,
          "conavn" => nil,
          "sidstOpdateret" => "2000-10-23T19:51:30.000+02:00",
          "sidstValideret" => nil,
          "postboks" => nil,
          "vejnavn" => "Stubbedamsvej",
          "periode" => {
            "gyldigFra" => "2000-10-23",
            "gyldigTil" => "2003-08-25"
          },
          "postnummer" => 3000,
          "bogstavTil" => nil,
          "landekode" => "DK",
          "bogstavFra" => "B",
          "vejkode" => 8326,
          "bynavn" => nil,
          "kommune" => {
            "kommuneKode" => 217,
            "kommuneNavn" => "HELSINGØR",
            "periode" => {
              "gyldigFra" => nil,
              "gyldigTil" => "2006-12-31"
            },
            "sidstOpdateret" => "1999-10-15T00:00:00.000+02:00"
          },
          "husnummerTil" => nil,
          "sidedoer" => nil,
          "husnummerFra" => 57,
          "postdistrikt" => "Helsingør",
          "etage" => nil,
          "fritekst" => nil
        }, {
          "adresseId" => nil,
          "conavn" => nil,
          "sidstOpdateret" => "2003-09-03T19:32:39.000+02:00",
          "sidstValideret" => nil,
          "postboks" => nil,
          "vejnavn" => "Stubbedamsvej",
          "periode" => {
            "gyldigFra" => "2003-08-26",
            "gyldigTil" => "2011-10-17"
          },
          "postnummer" => 3000,
          "bogstavTil" => nil,
          "landekode" => "DK",
          "bogstavFra" => "A",
          "vejkode" => 8326,
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
          "husnummerFra" => 57,
          "postdistrikt" => "Helsingør",
          "etage" => nil,
          "fritekst" => nil
        }, {
          "adresseId" => nil,
          "conavn" => nil,
          "sidstOpdateret" => "2011-10-19T19:30:54.000+02:00",
          "sidstValideret" => nil,
          "postboks" => nil,
          "vejnavn" => "Ukendt Adresse",
          "periode" => {
            "gyldigFra" => "2011-10-18",
            "gyldigTil" => "2013-01-02"
          },
          "postnummer" => 9999,
          "bogstavTil" => nil,
          "landekode" => "DK",
          "bogstavFra" => nil,
          "vejkode" => 9903,
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
          "husnummerFra" => nil,
          "postdistrikt" => "Ukendt",
          "etage" => nil,
          "fritekst" => nil
        }, {
          "adresseId" => nil,
          "conavn" => nil,
          "sidstOpdateret" => "2016-05-23T20:02:00.000+02:00",
          "sidstValideret" => nil,
          "postboks" => nil,
          "vejnavn" => "H P Christensens Vej",
          "periode" => {
            "gyldigFra" => "2013-01-03",
            "gyldigTil" => "2016-04-30"
          },
          "postnummer" => 3000,
          "bogstavTil" => nil,
          "landekode" => "DK",
          "bogstavFra" => nil,
          "vejkode" => 2805,
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
          "husnummerFra" => 36,
          "postdistrikt" => "Helsingør",
          "etage" => nil,
          "fritekst" => nil
        }, {
          "adresseId" => nil,
          "conavn" => nil,
          "sidstOpdateret" => "2016-05-23T20:02:00.000+02:00",
          "sidstValideret" => nil,
          "postboks" => nil,
          "vejnavn" => "Harreshøjvej",
          "periode" => {
            "gyldigFra" => "2016-05-01",
            "gyldigTil" => nil
          },
          "postnummer" => 3080,
          "bogstavTil" => nil,
          "landekode" => "DK",
          "bogstavFra" => "A",
          "vejkode" => 2921,
          "bynavn" => "Harreshøj",
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
          "husnummerFra" => 46,
          "postdistrikt" => "Tikøb",
          "etage" => nil,
          "fritekst" => nil
        }]
      },
      "kontorsteder" => [],
      "organisationer" => [{
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
      }]
    }
  end

  subject { RubyCvr::CompaniesParser::Relation.new(payload) }

  it '#founder?' do
    expect(subject.founder?).to eq(false)
  end

  it '#name' do
    expect(subject.name).to eq('Henning Munch Larsen')
  end

  it '#address' do
    expect(subject.address).to eq('Harreshøjvej 46, 3080 Tikøb')
  end
end
