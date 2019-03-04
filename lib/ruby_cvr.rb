module RubyCvr
  extend self

  def company_scroll(options = {})
    Fetcher::CompaniesQuery.new(options).execute
  end

  def financial_scroll(options = {})
    Fetcher::FinancialsQuery.new(options).execute
  end

  def scroll(scroll_id)
    Fetcher::ScrollQuery.new(scroll_id).execute
  end

  def xbrl_fetch(url)
    Fetcher::XbrlsQuery.new(url).execute
  end

  def company_parse(payload)
    CompaniesParser::Company.new(payload)
  end

  def financial_parse(payload)
    FinancialsParser::Report.new(payload)
  end

  def xbrl_parse(payload, start_date, end_date)
    XbrlsParser::Report.new(payload, start_date, end_date)
  end
end
