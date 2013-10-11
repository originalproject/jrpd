require_relative 'libpd'
JavaPdReceiver = Java::OrgPuredataCore::PdReceiver

module JRPD
    module JavaApi
        class PdReceiver

            include JavaPdReceiver

            def initialize(&block)
                @block = block
            end

            def receiveBang(source)
                @block.call(source, :bang)
            end

            def receiveFloat(source, value)
                @block.call(source, :float, value)
            end

            def receiveSymbol(source, value)
                @block.call(source, :symbol, value)
            end

            def receiveList(source, values)
                @block.call(source, :list, values)
            end

            def receiveMessage(source, message_name, values)
                @block.call(source, :list, message_name, values)
            end

            def print(s)
                puts "PD: #{s}"
            end

        end
    end
end
