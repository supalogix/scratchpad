const {add_nodes, add_child} = require("../mutator");

const r8_a = {
	id: "r8_a",
	_id: "8a",
	title: "User ???DoorOpen???",
	parent_node: null,
	children: []
};

const r8_b = {
	id: "r8_b",
	_id: "8b",
	title: "Door [Open]",
	parent_node: null,
	children: []
};

const r8_c = {
	id: "r8_c",
	_id: "8c",
	title: "Button [Disabled]",
	parent_node: null,
	children: []
};

const r8_d = {
	id: "r8_d",
	_id: "8d",
	title: "Oven ^[Open]",
	parent_node: null,
	children: []
};

add_child(r8_a, r8_b);
add_child(r8_b, r8_c);
add_child(r8_c, r8_d);

module.exports = {
    root: [
		r8_a
	],
    nodes: [
        r8_a,
        r8_b,
        r8_c,
        r8_d,
    ],
        r8_a,
        r8_b,
        r8_c,
        r8_d,
}