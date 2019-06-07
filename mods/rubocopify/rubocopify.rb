# frozen_string_literal: true

require 'pathname'
require 'gotta/version'

require_relative 'lib/watcher'

mod 'rubocopify' do
  version '0.1.0'
  description "This is a mod for Gotta projects that runs Rubocop's autocorrect command when Ruby files are added or modified"

  watch('*.rb') do
    # When any ruby file is added or modified
    on :added, :modified do |event|
      key = "#{event.path}#{event.type}"

      if Watcher.is_ignoring?(key)
        Watcher.consider(key)
      else
        puts "Cleaning up #{event.path}"
        `rubocop -a #{event.path}`

        Watcher.ignore(key)
      end
    end
  end
end
