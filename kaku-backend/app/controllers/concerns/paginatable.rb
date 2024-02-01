module Paginatable
  extend ActiveSupport::Concern

  private

  def page_params(data)
    {
      current_page: data.current_page,
      next_page: data.next_page,
      prev_page: data.prev_page,
      total_pages: data.total_pages,
      total_count: data.total_count
    }
  end
end
