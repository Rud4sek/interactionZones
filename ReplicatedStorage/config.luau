local config = {
	["Test"] = {
		position = Vector3.new(15, 0, 0),
		distance = 10,
		text = "PRESS [E] TO SEARCH A BIN",
		markerPosition = Vector3.new(15, 0, 0),
		markerHeight = 1,
		markerType = Instance.new("Part"),
		onKeyPressed = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("print"),
		onMarkerExit = game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("printExit"),
		debugSphere = false
	}
}

return config