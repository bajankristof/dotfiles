local modules = {
  "tabs",
}

for _, name in ipairs(modules) do
  local ok, mod = pcall(require, "modules." .. name)
  if not ok then
    print(("hammerspoon: failed to load %s: %s"):format(name, mod))
  elseif type(mod) == "table" and mod.start then
    mod.start()
  end
end
