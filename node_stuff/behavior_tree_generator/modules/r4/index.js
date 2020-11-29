const {add_nodes, add_child} = require("../mutator");

let nodes = []

const r4_a = {
	id: "r4_a",
	_id: "4a",
	title: "Door [Open]",
	parent_node: null,
	children: []
}

const r4_b = {
	id: "r4_b",
	_id: "4b",
	title: "Light [On]",
	parent_node: null,
	children: []
}

const r4_c = {
	id: "r4_c",
	_id: "4c",
	title: "Oven [Cooking]",
	parent_node: null,
	children: []
}


const r4_d = {
	id: "r4_d",
	_id: "4d",
	title: "Light [On]",
	parent_node: null,
	children: []
}

add_child(r4_a, r4_b);
add_child(r4_c, r4_d);

module.exports = {
    root: [
		r4_a,
		r4_c,
	],
    nodes: [
        r4_a,
        r4_b,
        r4_c,
        r4_d,
    ],
        r4_a,
        r4_b,
        r4_c,
        r4_d,
}