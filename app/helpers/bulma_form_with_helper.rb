# frozen_string_literal: true

class BulmaFormBuilder < ActionView::Helpers::FormBuilder
  def errors(property)
    object.errors.full_messages_for(property).map do |message|
      @template.tag.p message, class: "help is-danger"
    end.join.html_safe # rubocop:disable Rails/OutputSafety
  end
end

module BulmaFormWithHelper
  # rubocop:disable Metrics/ParameterLists
  def bulma_form_with(model: nil, scope: nil, url: nil, format: nil, **options, &block)
    opts = { builder: BulmaFormBuilder }.merge(options)

    form_with(model: model, scope: scope, url: url, format: format, **opts, &block)
  end
  # rubocop:enable Metrics/ParameterLists
end
