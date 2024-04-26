# frozen_string_literal: true

require "open3"

module ShellUtils
  class ShellExcutionError < StandardError; end
  module_function

  def execute!(cmd)
    stdout, stderr, status = Open3.capture3(cmd)
    raise(ShellExcutionError, stderr) unless status.success?

    stdout
  end
end
