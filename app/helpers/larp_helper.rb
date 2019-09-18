# frozen_string_literal: true

module LarpHelper
  def display_new_badge(larp)
    return unless larp.larp_created_within_a_week?

    content_tag(:i, content_tag(:span, 'new'), class: 'badge--new')
  end

  def display_ownership_badge(larp)
    return unless larp.belongs_to_current_user?(current_user)

    content_tag(:i, nil, class: 'badge--owner')
  end
end
