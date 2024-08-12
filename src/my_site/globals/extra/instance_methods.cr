# Additional methods for instance model.
module Globals::Extra::InstanceMethods
  # Generete a filter by categories (сategory - selection type fields).
  def admin_filter : Globals::Extra::Tools::AdminFilter
    filter = Globals::Extra::Tools::AdminFilter.new
    {% for var in @type.instance_vars %}
      if !@{{ var }}.ignored? && @{{ var }}.field_type.includes?("Choice")
        filter << {
          label: @{{ var }}.label,
          field: @{{ var }}.name,
          negation: false,
          multiple: @{{ var }}.multiple?,
          items: @{{ var }}.choices.map {|item| {value: item[0], title: item[1]}},
        }
      end
    {% end %}
    filter
  end
end
