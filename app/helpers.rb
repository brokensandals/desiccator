class Desiccator < Sinatra::Base
  helpers do
    include ActionView::Helpers::DateHelper

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