# Additional methods for models.
module Globals::Extra::Methods
  # Get data to filter by category (сategory - selection type fields).
  def data_filters : Globals::Extra::Tools::AdminDataFilters
    items = [] of Globals::Extra::Tools::AdminDynItems
    filter = [] of Globals::Extra::Tools::AdminDataFilters
    {% for var in @type.instance_vars %}
      if !@{{ var }}.ignored? && @{{ var }}.field_type.includes?("Choice")
        filter << {
          label: @{{ var }}.label,
          field: @{{ var }}.name,
          negation: false,
          multiple: @{{ var }}.multiple,
          items: @{{ var }}.choices,
        }
      end
    {% end %}
    filter
  end
end
