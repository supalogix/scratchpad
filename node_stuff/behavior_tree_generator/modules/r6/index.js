const {add_nodes, add_child} = require("../mutator");

const r6_a = {
	id: "r6_a",
	_id: "6a",
	title: `Oven [Open]`,
	parent_node: null,
	children: []
};

const r6_b = {
	id: "r6_b",
	_id: "6b",
	title: "User ???DoorClosed???",
	parent_node: null,
	children: []
};

const r6_c = {
	id: "r6_c",
	_id: "6c",
	title: "Door [Closed]",
	parent_node: null,
	children: []
};

const r6_d = {
	id: "r6_d",
	_id: "6d",
	title: "Light [Off]",
	parent_node: null,
	children: []
};

const r6_e = {
	id: "r6_e",
	_id: "6e",
	title: "Oven [Idle]",
	parent_node: null,
	children: []
};

add_child(r6_a, r6_b);
add_child(r6_b, r6_c);
add_child(r6_c, r6_d);
add_child(r6_d, r6_e);

module.exports = {
    root: [
		r6_a
	],
    nodes: [
        r6_a,
        r6_b,
        r6_c,
        r6_d,
        r6_e,
    ],
        r6_a,
        r6_b,
        r6_c,
        r6_d,
        r6_e,
}