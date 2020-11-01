--selects all the non-transparent pixels in a selecting layer or folder

local sprite = app.activeSprite

if not sprite then 
	return app.alert("There is no active sprite")
end

local cel = app.activeCel
if not cel then	
	return app.alert("There is no active image")
end

function makeSelectionFromLayer()

    local cel = app.activeCel
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

makeSelectionFromLayer()
print(app.activeLayer)


app.refresh()