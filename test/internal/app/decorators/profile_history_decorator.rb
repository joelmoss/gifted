module ProfileHistoryDecorator
  def update_date
    updated_on.strftime('%Y/%m/%d')
  end
end
