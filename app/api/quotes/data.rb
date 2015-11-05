module Quotes

  class Data < Grape::API

    helpers do
      def current_user
        @current_user = params[:userid]
      end
    end

    resource :quotes do

      desc "List all quotes"

      get do

        if current_user

          @quotes = User.find_by_id(@current_user).quotes

        else

          @quotes = Quote.all

        end

        response = {
          total: @quotes.size,
          quotes: @quotes
        }

      end

    end

    resource :quote do

      desc "Show one quote by id or get a random one for the day"

      params do
        optional :id, type: Integer, default: nil, desc: "Quote ID"
      end

      get do

        if params[:id]

          Quote.find_by_id(params[:id])

        else

          @today = Date.today.to_s
          @today_quote = Day.where(date: @today).first

          if @today_quote

            return Quote.find_by_id(@today_quote.quote_id)

          else

            @random_id = Random.rand(Quote.all.size) + 1

            Day.create(date: @today, quote_id: @random_id)

            return Quote.find_by_id(@random_id);

          end

        end

      end

    end

  end
end
