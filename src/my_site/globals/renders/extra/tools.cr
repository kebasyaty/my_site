# Additional external tools for models.
module Globals::Extra::Tools
  extend self

  # Get target model
  def target_model(model_key : String)
    DynFork::Model.subclasses.find { |model_class|
      model_class.full_model_name == model_key
    }.new
  end
end
