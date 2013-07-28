class Desiccator < Sinatra::Base
  helpers do
    include ActionView::Helpers::DateHelper
    include Sinatra::ContentFor
    
    def title(page_title, options={})
      content_for :title do
        page_title
      end
    end

    def due_date_text(due_at)
      return nil unless due_at
      if due_at < DateTime.now
        distance_of_time_in_words_to_now(due_at) + " ago"
      else
        "in " + distance_of_time_in_words_to_now(due_at)
      end
    end
  end
end