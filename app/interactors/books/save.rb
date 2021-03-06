# frozen_string_literal: true

module Books
  class Save
    include Interactor

    delegate :book, to: :context
    delegate :params, to: :context

    def call
      context.fail!(errors: 'Запись не сохранена') unless form.validate(form_params)
      form.save do |hash|
        form.model.assign_attributes(hash)

        form.save!
      end
    end

    def form_params
      {
        name: params[:name],
        author: params[:author],
        date: params[:date]
      }
    end

    def form
      @form ||= Books::BookForm.new(book)
    end
  end
end
