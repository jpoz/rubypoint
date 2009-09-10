class RubyPoint
  class Element
    
    attr_accessor :parent, :objects, :presentation
    
    class << self    
      def class_attributes(*args)
        args.each do |attribute|
          script = <<EOF
          attr_accessor :#{attribute}
          def self.#{attribute}(value=false, &action)
            value ? @#{attribute} = value : @#{attribute}_block = action
          end
          def self.#{attribute}_value_for(inst)
            return @#{attribute} if @#{attribute}
            @#{attribute}_block.call(inst)
          end
          def #{attribute}
            return @#{attribute} if @#{attribute}
            @#{attribute} = self.class.#{attribute}_value_for(self)
          end
EOF
          class_eval(script)
        end
      end
    end

    def objects
      @objects ||= []
    end
    
  end
end