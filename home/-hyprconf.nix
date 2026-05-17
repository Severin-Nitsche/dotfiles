lib: let
  _toLua = lib.generators.toLua {};

  # Convert to lua: arg1, arg2, ...
  _toLuaArgs = value: if builtins.isList value then
    lib.concatMapStringsSep ", " _toLua value
  else _toLua value;

  _mkHlCall = f: args: "hl.${f}(${_toLuaArgs args})";

  # Convert to dispatcher
  # everything is treated as dispatcher EXCEPT
  # lua - luaify w/ mkLuaInline
  # config - hl.config...
  _toDsp = dsp: let
    _lua = if dsp ? lua then dsp.lua else "";
    _conf = if dsp ? config then
      _mkHlCall "config" dsp.config
    else "";
    __dsp = lib.removeAttrs dsp [ "lua" "config" ];
    _dsp = lib.mapAttrsToList (dsp: args: _mkHlCall "dsp.${dsp}" args) __dsp;
  in lib.generators.mkLuaInline ''
    function()
      ${_lua}
      ${_conf}
      ${lib.concatMapStringsSep "\n" (x: "hl.dispatch(${x})") _dsp}
    end
  '';

  _toBind = attrs: [
    (if builtins.isString attrs.keys then attrs.keys
    else lib.concatStringsSep " + " attrs.keys)
    (_toDsp (lib.removeAttrs attrs ["keys" "flags"]))
  ] ++ (if attrs ? flags then [attrs.flags] else []);

  # Convert settings
  # Lists generate multiple hl.* calls, within that lists are for multiple
  # arguments, so to call hl.foo([bar]) write settings.foo = [[[bar]]]
  # Format: { submap = { <settings> }; ... }
  # extraConfig = toSettings {
  #   bind = [
  #     {
  #       keys = [string] | string;
  #       * = *;
  #       flags.* = boolean;
  #     }
  #   ];
  #   submap.<name> = { <settings> };
  #   extraConfig = "";
  #   * = *; # hl.*
  # };
  toSettings = lib.concatMapAttrsStringSep "\n" (
    name: value: if name == "bind" then
      if builtins.isList value then
        lib.concatMapStringsSep "\n" (val: _mkHlCall name (_toBind val)) value
      else _mkHlCall name (_toBind value)
    else if name == "submaps" then
      lib.concatMapAttrsStringSep "\n" (
        submap: settings: ''
          hl.define_submap("${submap}", function()
            ${toSettings settings}
          end)
        ''
      ) value
    else if name == "extraConfig" then
      value
    else if builtins.isList value then
      lib.concatMapStringsSep "\n" (_mkHlCall name) value
    else _mkHlCall name value
  ); in toSettings
