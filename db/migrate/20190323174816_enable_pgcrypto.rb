# frozen_string_literal: true

class EnablePgcrypto < ActiveRecord::Migration[5.2]
  def change
    enable_extension "pgcrypto"
  end
end
