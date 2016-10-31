every :weekend do
  rake "book_store:delete_empty_orders", output: {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}
end
