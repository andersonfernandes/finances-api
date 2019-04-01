class Iso8601DateValidator < Apipie::Validator::BaseValidator
  def initialize(param_description, argument)
    super(param_description)
    @type = argument
  end

  def validate(value)
    return false if value.nil?
    value.to_s.match(/(\d{4})-(\d{2})-(\d{2})T(\d{2})\:(\d{2})\:(\d{2})[+-](\d{2})\:(\d{2})/)
  end

  def self.build(param_description, argument, options, block)
    if options.any? {|k,v| k == :base_class && v == Date }
      self.new(param_description, argument)
    end
  end

  def description
    "Must be #{@type}."
  end
end
