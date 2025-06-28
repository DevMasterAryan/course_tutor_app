class PaginationService
  DEFAULT_PAGE = 1
  DEFAULT_PER_PAGE = 10
  MAX_PER_PAGE = 100

  def initialize(collection, page: nil, per_page: nil)
    @collection = collection
    @page = (page || DEFAULT_PAGE).to_i
    @per_page = [(per_page || DEFAULT_PER_PAGE).to_i, MAX_PER_PAGE].min
  end

  def paginate
    offset = (@page - 1) * @per_page
    paginated_collection = @collection.offset(offset).limit(@per_page)

    {
      data: paginated_collection,
      pagination: {
        page: @page,
        per_page: @per_page,
        total_count: @collection.count,
        total_pages: total_pages,
        has_next: next?,
        has_prev: prev?
      }
    }
  end

  private

  def total_pages
    (@collection.count.to_f / @per_page).ceil
  end

  def next?
    @page < total_pages
  end

  def prev?
    @page > 1
  end
end
