# Additional external tools for working with models.
module Globals::Extra::Tools
  extend self

  alias AdminDynItems = Array(NamedTuple(
    value: String | Int64 | Float64,
    title: String,
  ))

  alias AdminDataFilters = Array(NamedTuple(
    label: String,
    field: String,
    negation: Bool,
    multiple: Bool,
    items: AdminDynItems,
  ))

  # Get target model.
  def target_model(model_key : String) : DynFork::Model.class | Nil
    DynFork::Model.subclasses.find { |model_class|
      model_class.full_model_name == model_key
    }
  end
end
