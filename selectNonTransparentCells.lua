--selects all the non-transparent pixels in a selecting layer or folder

local sprite = app.activeSprite

if not sprite then 
	return app.alert("There is no active sprite")
end

sprite.selection = Selection()

function makeSelectionFromLayer(layer)

    local cel = layer:cel(app.activeFrame)
    local img = cel.image:clone()
    local transparent = img.spec.transparentColor

    local selection = Selection()

    for it in img:pixels() do
        if it() ~= transparent then
            selection:add(it.x, it.y, 1, 1)
        end
    end
    selection.origin = Point(cel.bounds.x, cel.bounds.y)

    sprite.selection:add(selection)
end

function recursiveSelect(layer)
    if layer.isVisible then
        if layer.isGroup then
            for index, it in ipairs(layer.layers) do
                if it:cel(app.activeFrame) ~= nil then
                    recursiveSelect(it)
                end
            end
        else
            makeSelectionFromLayer(layer)
        end
    end
end

layer = app.activeLayer
recursiveSelect(layer)

app.refresh()