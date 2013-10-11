require_relative 'java_api/pd_receiver'
require_relative 'java_api/pd_base'

module JRPD
    class Source

        # class initialization:
        # set up global receiver & remotes directory
        @sources = {}
        @sources.default_proc = proc do |hash, key|
            hash[key] = []
        end
        @receiver = JavaApi::PdReceiver.new do |source_name, message_type, *args|
            @sources[source_name].each do |source|
                source.dispatch(message_type, args)
            end
        end
        JavaApi::PdBase.set_receiver(@receiver)

        def self.register(source)
            @sources[source.name] << source
        end

        attr_reader :name

        def initialize(name)
            @name = name
            @routes = {}
            @routes.default_proc = proc do |hash, key|
                hash[key] = []
            end
            self.class.register(self)
        end

        def subscribe_to_bang(&block)
            subscribe(:bang, block)
        end

        def subscribe_to_float(&block)
            subscribe(:float, block)
        end

        def subscribe_to_symbol(&block)
            subscribe(:symbol, block)
        end

        def dispatch(message_type, args)
            @routes[message_type].each do |route|
                route.call(*args)
            end
        end

        private

        def subscribe(message_type, block)
            JavaApi::PdBase.subscribe(@name) unless JavaApi::PdBase.exists(@name)
            @routes[message_type] << block
        end

    end
end
