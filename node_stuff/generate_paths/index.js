const addChild = (parent, child) => {
	parent.children.push(child)
}

const createNode = (id, name) => ({
	id,
	actions: name,
	children: []
});

const generateUniquePaths = (node, path = "") => {
	const log = []

	path += node.id

	if(node.children.length === 0)
		return path

	path += "."


	node.children.forEach(child => {
		const newPaths = generateUniquePaths(child, path)
		log.push(newPaths)
	})

	return log.flat()
}

const generateAllPaths = (node, path = "") => {
	const log = []

	path += node.id

	log.push(path)

	path += "."


	node.children.forEach(child => {
		const newPaths = generateAllPaths(child, path)
		log.push(newPaths)
	})

	return log.flat()
}

const getAllPaths = (node, path = "", actions = []) => {
	let log = []

	actions = actions.concat(node.actions)
	path += node.id

	log = log.concat([path, actions])

	path += "."

	node.children.forEach(child => {
		const newActions = getAllPaths(child, path, actions)
		log = log.concat(newActions)
	})

	return log
}

const allPaths = (node) => {
	const items = getAllPaths(node)
	const history = []

	for(var i = 0; i < items.length; i+=2)
	{
		history.push({
			path: items[i],
			actions: items[i+1]
		})
	}

	return history
}

const getUniquePaths = (node, path = "", actions = []) => {
	let log = []

	actions = actions.concat(node.actions)
	path += node.id

	if(node.children.length === 0)
		return [ path, actions ]

	path += "."

	node.children.forEach(child => {
		const newPaths = getUniquePaths(child, path, actions)
		log = log.concat(newPaths)
	})

	return log
}

const uniquePaths = (node) => {
	const items = getUniquePaths(node)
	const history = []

	for(var i = 0; i < items.length; i+=2)
	{
		history.push({
			path: items[i],
			actions: items[i+1]
		})
	}

	return history
}

const A = createNode("A", ["1"]);
const B = createNode("B", ["2", "10", "11"]);
const C = createNode("C", ["3"]);
const D = createNode("D", ["4"]);
const E = createNode("E", ["5", "12"]);
const F = createNode("F", ["6"]);
const G = createNode("G", ["7"]);
const H = createNode("H", ["8"]);
const I = createNode("I", ["9"]);
const J = createNode("J", ["0", "13", "14"]);


addChild(A, B)
addChild(A, C)
addChild(C, D)
addChild(B, E)
addChild(A, F)
addChild(F, G)
addChild(G, H)
addChild(H, I)
addChild(A, J)

//console.log(generateUniquePaths(A))
//console.log(getUniquePaths(A))
//console.log(generateAllPaths(A))
console.log(uniquePaths(A))
console.log(allPaths(A))


