module BugsHelper

end
  def status_class(status)
    case status.to_s
    when "pending"
      "bg-secondary"
    when "in_progress"
      "bg-info"
    when "resolved"
      "bg-success"
    when "rejected"
      "bg-danger"
    else
      "bg-dark"
    end
  end
