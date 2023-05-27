# frozen_string_literal: true

MeiliSearch::Rails.configuration = {
  meilisearch_url: ENV.fetch('MEILISEARCH_HOST'),
  meilisearch_api_key: ENV.fetch('MEILI_MASTER_KEY'),
  timeout: 60,
  max_retries: 3
}
