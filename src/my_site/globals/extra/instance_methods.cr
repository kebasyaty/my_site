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

  # Update state of  Model, from web form of  document of administrator panel.
  def admin_refrash_fields(data_form : Hash(String, String)) : Nil
    name : String = ""
    {% for field in @type.instance_vars %}
      name = @{{ field }}.name
      if !@{{ field }}.ignored? && data_form[name] != "null" {
        # ???
      }
    {% end %}
  end
end
