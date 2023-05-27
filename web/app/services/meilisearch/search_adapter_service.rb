# frozen_string_literal: true

# SearchAdapterService
class Meilisearch::SearchAdapterService
  def initialize(query:, filter: nil, model_name:, page: 1, per_page: WillPaginate.per_page)
    @query = query
    @filter = filter
    @model = Object.const_get(model_name)
    @page = page || 1
    @limit = per_page || WillPaginate.per_page
  end

  def call
    preprocess!
    process!
  end

  private

  def preprocess!
    @offset = @limit * (@page - 1)
  end

  def process!
    results = @model.index.search(@query, filter: @filter, limit: @limit, offset: @offset)
    ids = results['hits'].map do |result|
      result['id']
    end
    @model.where(id: ids).paginate(page: @page, per_page: @limit)
  end
end
