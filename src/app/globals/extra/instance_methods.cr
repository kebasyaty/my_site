# Additional methods for instance model.
module Globals::Extra::InstanceMethods
  # Generete a filter by categories (сategory - selection type field).
  def admin_filter_2 : Globals::Extra::Tools::AdminFilter
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

  # Update state of  Model, from web form of administrator panel.
  def admin_refrash_fields(data_form : Hash(String, String)) : Nil
    name : String = ""
    field_type : String = ""
    input_type : String? = nil
    file_data : Globals::Extra::Tools::AdminFileData? = nil
    {% for field in @type.instance_vars %}
      name = @{{ field }}.name
      if data_form[name] != "null"
        field_type = @{{ field }}.field_type
        input_type = @{{ field }}.input_type?
        if field_type.includes?("Choice")
          if field_type.includes?("Text")
            if field_type.includes?("Mult")
              @{{ field }}.refrash_val_arr_str(
                Array(String).from_json(data_form[name]))
            else
              @{{ field }}.refrash_val_str(data_form[name])
            end
          elsif field_type.includes?("I64")
            if field_type.includes?("Mult")
              @{{ field }}.refrash_val_arr_i64(
                Array(Int64).from_json(data_form[name]))
            else
              @{{ field }}.refrash_val_i64(Int64.from_json(data_form[name]))
            end
          elsif field_type.includes?("F64")
            if field_type.includes?("Mult")
              @{{ field }}.refrash_val_arr_f64(
                Array(Float64).from_json(data_form[name]))
            else
              @{{ field }}.refrash_val_f64(Float64.from_json(data_form[name]))
            end
          end
        elsif Globals::Extra::Tools::NUMBER_INPUT_TYPES.includes?(input_type)
          if field_type.includes?("I64")
            @{{ field }}.refrash_val_i64(Int64.from_json(data_form[name]))
          elsif field_type.includes?("F64")
            @{{ field }}.refrash_val_f64(Float64.from_json(data_form[name]))
          end
        elsif input_type == "checkbox"
          @{{ field }}.refrash_val_bool(
            Bool.from_json(data_form[name]))
        elsif input_type == "file"
          file_data = Globals::Extra::Tools::AdminFileData.from_json(data_form[name])
          @{{ field }}.from_base64(
            base64: file_data[:base64],
            filename: file_data[:filename],
            delete: file_data[:delete],
          )
        else
          @{{ field }}.refrash_val_str(data_form[name])
        end
      end
    {% end %}
  end
end
