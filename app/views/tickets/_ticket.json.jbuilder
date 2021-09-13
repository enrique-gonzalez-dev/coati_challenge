json.extract! ticket, :id, :total_items, :transtaction_amount, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)
