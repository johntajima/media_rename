$LOAD_PATH.unshift File.dirname(__FILE__)

require 'yaml'
require 'liquid'
require 'logger'
require 'active_support'
require "media_rename/version"
require "media_rename/templates"
require "media_rename/tmdb"
require "media_rename/movie"
require "media_rename/tv"
require 'media_rename/file_parser'
require "media_rename/mediafile"
require "media_rename/utils"

module MediaRename

  USER_CONFIG    = File.expand_path("~/.media_rename.yml")
  DEFAULT_CONFIG = File.join(File.dirname(__FILE__), "../config/media_rename.yml")
  SETTINGS ||= begin
    default_config = YAML.load(File.open(DEFAULT_CONFIG).read)
    custom_config  = File.exist?(USER_CONFIG) ? YAML.load(File.open(USER_CONFIG).read) : {}
    default_config.merge(custom_config)
  end

  extend self

  def logger
    @logger ||= begin
      logger = Logger.new(STDOUT)
      logger.formatter = proc do |severity, datetime, progname, msg|
        "#{datetime.strftime("%H:%M:%S")}: #{msg}\n"
      end
      logger
    end
  end

  class InvalidFileError < StandardError; end

end
