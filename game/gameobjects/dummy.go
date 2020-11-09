components {
  id: "dummycharacter"
  component: "/game/scripts/dummycharacter.script"
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
    id: "zoom"
    value: "1.0"
    type: PROPERTY_TYPE_NUMBER
  }
}
embedded_components {
  id: "sprite"
  type: "sprite"
  data: "tile_set: \"/assets/atlases/Characters.atlas\"\n"
  "default_animation: \"pumpkin_idle\"\n"
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
