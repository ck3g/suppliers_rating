# Automatic Code Reloading in Rails Console
# http://jkfill.com/2012/12/08/automatic-code-reloading-in-rails-console
#
# WARNING: do not work with pry
# TODO: adapt to work with pry

if defined?(IRB::Context) && !defined?(Rails::Server) && Rails.env.development?
  class IRB::Context
    def evaluate_with_reloading(line, line_no)
      reload!(true)

      evaluate_without_reloading(line, line_no)
    end
    alias_method_chain :evaluate, :reloading
  end

  puts "=> IRB code reloading enabled"
end
