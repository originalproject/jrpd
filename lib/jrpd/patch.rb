require 'pathname'
require 'forwardable'
require_relative 'java_api/pd_base'
require_relative 'destination'

module JRPD
	class Patch

    extend Forwardable
    def_delegators :@destination, :send_unstructured_message, :send_message

    attr_reader :name

		def initialize(path)
			@id = JavaApi::PdBase.open_patch(path)
      @name = Pathname.new(path).basename.to_s
      @destination = Destination.new("pd-#{@name}")
		end

		def close
			JavaApi::PdBase.close_patch(@id)
		end

	end
end
