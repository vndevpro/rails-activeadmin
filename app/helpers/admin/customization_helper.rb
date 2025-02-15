module Admin::CustomizationHelper
  GROUP_BY_DAY = 'day'.freeze
  GROUP_BY_WEEK = 'week'.freeze
  GROUP_BY_MONTH = 'month'.freeze
  GROUP_BY_YEAR = 'year'.freeze

  FORMAT_DAY = "%Y-%m-%d".freeze
  FORMAT_WEEK = "W%V/%y".freeze
  FORMAT_MONTH = "%m/%y".freeze
  FORMAT_YEAR = "%Y".freeze
  
  def self.filter_by_date(data, from = nil, to = nil)
    data = data.where('created_at >= ?', from) if from.present? && from.is_a?(Date)
    data = data.where('created_at <= ?', to) if to.present? && to.is_a?(Date)
    return data
  end

  def self.group_data_by_created_at(data, group)
    return data.group_by_week(:created_at, format: FORMAT_WEEK).count if group == GROUP_BY_WEEK
    return data.group_by_month(:created_at, format: FORMAT_MONTH).count if group == GROUP_BY_MONTH
    return data.group_by_year(:created_at, format: FORMAT_YEAR).count if group == GROUP_BY_YEAR
    return data.group_by_day(:created_at, format: FORMAT_DAY).count
  end

  def self.parse_date(date_string, default = nil)
    begin
        return default unless date_string.present? 
        return Date.strptime(date_string, FORMAT_DAY)
    rescue ArgumentError
        return default
    end
  end

  def self.parse_group(group_source)
    return [GROUP_BY_DAY, GROUP_BY_WEEK, GROUP_BY_MONTH, GROUP_BY_YEAR].include?(group_source) ? group_source : GROUP_BY_WEEK
  end

  def self.is_bar_chart(chart_type)
    return chart_type == 'bar'
  end
end