require_relative 'java_api/pd_base'

module JRPD
	class Destination

		def initialize(name)
			@name = name
		end

		def send_bang
			JavaApi::PdBase.send_bang(@name)
		end

		def send_float(value)
			JavaApi::PdBase.send_float(@name, value)
		end

		def send_symbol(value)
			JavaApi::PdBase.send_symbol(@name, value)
		end

		def send_list(values)
			JavaApi::PdBase.send_list(@name, values.to_java)
		end

		def send_message(message_type, args)
			# jRuby converts Fixnum to long by default
			# but PD only wants ints and floats
			# so we explicitly convert Fixnums to ints
			args.flatten!
			args.map! do |value|
				if value.is_a?(Fixnum)
					value.to_java(:int)
				elsif value.is_a?(String) || value.is_a?(Float)
					value
				else
					value.to_s
				end
			end
			JavaApi::PdBase.send_message(@name, message_type, args.to_java)
		end

  end
end
