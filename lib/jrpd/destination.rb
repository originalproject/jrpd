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

		def send_unstructured_message(u_msg)
			head, *tail = u_msg
				.scan(/([^\s"']+)|"([^"]*)"|'([^']*)'/)
				.flatten
				.compact
				.map { |s| int_or_float_from_string(s) }
			send_message(head, tail)
		end

		private

		def int_or_float_from_string(s)
			if int?(s)
				s.to_i
			elsif float?(s)
				s.to_f
			else
				s
			end
		end

		def int?(s)
			!!(s =~ /^[-+]?[0-9]+$/)
		end

		def float?(s)
			# matches 0.0 or .0 or 0.
			!!(s =~ /^[-+]?([0-9]+\.[0-9]*)|(\.[0-9]+)$/)
		end

  end
end
