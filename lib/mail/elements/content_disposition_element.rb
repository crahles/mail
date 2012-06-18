# encoding: utf-8
require 'active_support/core_ext'
module Mail
  class ContentDispositionElement # :nodoc:

    include Mail::Utilities

    def initialize( string )
      parser = Mail::ContentDispositionParser.new
      if tree = parser.parse(cleaned(string))
        @disposition_type = tree.disposition_type.text_value.downcase
        @parameters = tree.parameters
      else
        raise Mail::Field::ParseError.new(ContentDispositionElement, string, parser.failure_reason)
      end
    end

    def disposition_type
      @disposition_type
    end

    def parameters
      @parameters
    end

    def cleaned(string)
      string =~ /(.+);\s*$/ ? $1 : string
      string.mb_chars.gsub(/[^x00-\x7F,\s,\.]/n, '').to_s
    end

  end
end
