const {add_nodes, add_child} = require("../mutator");

let nodes = []

const r3_a = {
	id: "r3_a",
	_id: "3a",
	title: "Door [Closed]",
	parent_node: null,
	children: []
}

const r3_b = {
	id: "r3_b",
	_id: "3b",
	title: "Button [Enabled]",
	parent_node: null,
	children: []
}

const r3_c = {
	id: "r3_c",
	_id: "3c",
	title: "Door [Open]",
	parent_node: null,
	children: []
}


const r3_d = {
	id: "r3_d",
	_id: "3d",
	title: "Button [Disabled]",
	parent_node: null,
	children: []
}

add_child(r3_a, r3_b);
add_child(r3_c, r3_d);

module.exports = {
    root: [
		r3_a,
		r3_c,
	],
    nodes: [
        r3_a,
        r3_b,
        r3_c,
        r3_d,
    ],
        r3_a,
        r3_b,
        r3_c,
        r3_d,
}