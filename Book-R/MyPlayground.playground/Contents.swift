import UIKit

struct Astruct {
	let a = "a"
	let b = "b"
	let c = "c"
}

let a = Astruct()

let mirror = Mirror(reflecting: a)

for child in mirror.children {
	print(child.label!, child.value)
}

