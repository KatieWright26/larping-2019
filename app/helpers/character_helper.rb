# frozen_string_literal: true

module CharacterHelper
  RACES = %i[human non-human].freeze

  def apply_or_edit_character_button(larp, character, current_user)
    return if current_user.nil?

    if current_user.id == larp.user_id
      link_to 'Manage Character',
              edit_character_path(character),
              class: 'button primary expanded'
    else
      link_to 'Apply', '#', class: 'button primary expanded'
    end
  end
end
