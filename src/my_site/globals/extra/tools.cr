# Additional external tools for working with models.
module Globals::Extra::Tools
  extend self

  # Types of input for numerical data - I64Field, F64Field.
  NUMBER_INPUT_TYPES = ["number", "range"]

  # Data for file types - FileField, ImageField.
  alias AdminFileData = NamedTuple(
    filename: String?,
    base64: String?,
    delete: Bool,
  )

  # Filter by categories.
  alias AdminFilter = Array(NamedTuple(
    label: String,
    field: String,
    negation: Bool,
    multiple: Bool,
    items: Array(NamedTuple(
      value: String,
      title: String,
    )) | Array(NamedTuple(
      value: Int64,
      title: String,
    )) | Array(NamedTuple(
      value: Float64,
      title: String,
    )),
  ))

  # Data types in dynamic fields.
  alias DataDynamicType = String | Int64 | Float64 | Array(String) | Array(Int64) | Array(Float64)

  class_getter text_field_list : Array(String) = [
    "ColorField", "EmailField", "PhoneField", "TextField", "HashField", "URLField", "IPField",
  ]

  # Get target model class.
  def model_class(model_key : String) : DynFork::Model.class
    if model = DynFork::Model.subclasses.find { |model_class|
         model_class.full_model_name == model_key
       }
      return model.not_nil!
    end
    raise Vizbor::Errors::Panic.new("There is no Model for `model_key`.")
  end

  # Get target model instance.
  def model_instance(model_key : String)
    model = self.model_class(model_key)
    model.new
  end
end
