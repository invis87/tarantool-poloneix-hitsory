---
--- Migration "1530903329_init_object"
--- Date: 1530903329 - 07/06/18 21:55:29
---


return {
    up = function()
        box.schema.create_space("object", nil)
        box.space.object:format({ {
            name = "id",
            type = "unsigned"
          }, {
            is_nullable = true,
            name = "name",
            type = "string"
          } })
        box.space.object:create_index("primary", {
          parts = { { 1, "unsigned",
              is_nullable = false
            } },
          sequence = true,
          type = "tree",
          unique = true
        })
        box.space.object:create_index("name", {
          parts = { { 2, "string",
              is_nullable = true
            }, { 1, "unsigned",
              is_nullable = false
            } },
          type = "tree",
          unique = false
        })
        box.space._spacer_models:replace({"object"})
    end,

    down = function()
        box.space.object:drop()
        box.space._spacer_models:delete({"object"})
    end,
}
