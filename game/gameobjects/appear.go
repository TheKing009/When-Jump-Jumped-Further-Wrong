components {
  id: "playonce"
  component: "/game/scripts/playonce.script"
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
  properties {
    id: "anim"
    value: "appear"
    type: PROPERTY_TYPE_HASH
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "tile_set: \"/assets/atlases/extras.atlas\"\n"
  "default_animation: \"appear\"\n"
  "material: \"/builtins/materials/sprite.material\"\n"
  "blend_mode: BLEND_MODE_ALPHA\n"
  ""
  position {
    x: 0.0
    y: 0.0
    z: 0.0
  }
  rotation {
    x: 0.0
    y: 0.0
    z: 0.0
    w: 1.0
  }
}
