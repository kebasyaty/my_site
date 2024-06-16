# Service composition for menu structure of admin panel.
module Vizbor::Services::Home
  struct HomePage < Vizbor::MenuComposition
    def self.composition : Vizbor::MenuCompositionType?
      # For example, see at 'composition:.cr' in Vizbor::Services::Admin.
    end
  end
end
