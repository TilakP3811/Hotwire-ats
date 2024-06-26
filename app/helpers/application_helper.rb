module ApplicationHelper
  def flash_class(level)
    case level.to_sym
    when :notice
      'bg-blue-900 border-blue-900'
    when :success
      'bg-green-900 border-green-900'
    when :alert
      'bg-red-900 border-red-900'
    when :error
      'bg-red-900 border-red-900'
    else
      'bg-blue-900 border-blue-900'
    end
  end

  def applicant_sort_options_for_select
    [
      ['Application Date Ascending', 'created_at-asc'],
      ['Application Date Descending', 'created_at-desc']
    ]
  end

  def job_options_for_select(account_id)
    Job.where(account_id: account_id).order(:title).pluck(:title, :id)
  end

  def fetch_filter_key(resource, user_id, key)
    Kredis.hash("#{resource}_filters:#{user_id}")[key]
  end

  def job_sort_options_for_select
    [
      ['Posting Date Ascending', 'created_at-asc'],
      ['Posting Date Descending', 'created_at-desc'],
      ['Title Ascending', 'title-asc'],
      ['Title Descending', 'title-desc']
    ]
  end

  def status_options_for_select
    Job.statuses.map{|key, _value| [key.humanize, key]}
  end
end
