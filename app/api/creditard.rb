module Bank
  class CreditCard
    version 'v1'
    format :json

    resources :creditcards do
      desc 'Get info about a creditcard'
      params do
        requires :number, type: String, desc: "The creditcard number."
      end

      get ':id' do
        Creditcard.find_by_number(params[:number])
      end
    end
  end
end
