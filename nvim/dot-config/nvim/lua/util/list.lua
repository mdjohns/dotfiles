local M = {}

--- Append items to a list, skipping duplicates.
---@param list string[]
---@param items string[]
---@param seen table<string, boolean>
function M.extend_unique(list, items, seen)
	for _, item in ipairs(items) do
		if not seen[item] then
			seen[item] = true
			table.insert(list, item)
		end
	end
end

return M
