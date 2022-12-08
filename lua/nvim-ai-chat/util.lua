local util = {}
local function dumpRaw(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dumpRaw(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function util.dump(o)
	print(dumpRaw(o))
end

return util
