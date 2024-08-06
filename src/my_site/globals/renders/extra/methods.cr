# Additional methods for models.
module Globals::Extra::Methods
  # Get data to filter by category (сategory - selection type fields).
  def data_filters : Globals::Extra::Tools::AdminDataFilters
    filter = [] of Globals::Extra::Tools::AdminDataFilters
    {% for var in @type.instance_vars %}
      if !@{{ var }}.ignored? && @{{ var }}.field_type.includes?("Choice")
        filter << {
          label: @{{ var }}.label,
          field: @{{ var }}.name,
          negation: false,
          multiple: @{{ var }}.multiple,
          items: @{{ var }}.choices.map {|item| {value: item[0], title: item[1]}},
        }
      end
    {% end %}
    filter
  end
end
