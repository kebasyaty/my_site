# Additional methods for models.
module Globals::Extra::Methods
  # Get data to filter by category (сategory - selection type fields).
  def data_filters : Globals::Extra::Tools::AdminDataFilters
    {% for var in @type.instance_vars %}
      if !@{{ var }}.ignored? && @{{ var }}.field_type.includes?("Choice")
        # ...
      end
    {% end %}
  end
end
